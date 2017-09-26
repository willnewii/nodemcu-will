--------------------
-- helper
--------------------
function urlDecode(url)
    return url:gsub(
        "%%(%x%x)",
        function(x)
            return string.char(tonumber(x, 16))
        end
    )
end

--------------------
-- Response
--------------------
Res = {
    _skt = nil,
    _type = nil,
    _status = nil,
    _redirectUrl = nil
}

function Res:new(skt)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o._skt = skt
    return o
end

function Res:redirect(url, status)
    status = status or 302

    self:status(status)
    self._redirectUrl = url
    self:send(status)
end

function Res:type(type)
    self._type = type
end

function Res:status(status)
    self._status = status
end

function Res:send(body)
    self._status = self._status or 200
    self._type = self._type or "text/html"

    local buf =
        "HTTP/1.1 " ..
        self._status ..
            "\r\n" .. "Content-Type: " .. self._type .. "\r\n" .. "Content-Length:" .. string.len(body) .. "\r\n"
    if self._redirectUrl ~= nil then
        buf = buf .. "Location: " .. self._redirectUrl .. "\r\n"
    end
    buf = buf .. "\r\n" .. body

    local function doSend()
        if buf == "" then
            self:close()
        else
            self._skt:send(string.sub(buf, 1, 512))
            buf = string.sub(buf, 513)
        end
    end
    self._skt:on("sent", doSend)

    doSend()
end

function Res:close()
    self._skt:on(
        "sent",
        function()
        end
    ) -- release closures context
    self._skt:on(
        "receive",
        function()
        end
    )
    self._skt:close()
    self._skt = nil
end

--------------------
-- Middleware
--------------------
function parseHeader(req, res)
    local _, _, method, path, vars = string.find(req.source, "([A-Z]+) (.+)?(.+) HTTP")
    if method == nil then
        _, _, method, path = string.find(req.source, "([A-Z]+) (.+) HTTP")
    end
    local _GET = {}
    if vars ~= nil then
        vars = urlDecode(vars)
        for k, v in string.gmatch(vars, "([^&]+)=([^&]*)&*") do
            _GET[k] = v
        end
    end

    req.method = method
    req.query = _GET
    req.path = path

    return true
end

--------------------
-- HttpServer
--------------------
httpServer = {
    _srv = nil,
    _mids = {
        {
            url = ".*",
            cb = parseHeader
        },
        {
            url = ".*",
            cb = parseHeader
        }
    }
}

function httpServer:use(url, cb)
    table.insert(
        self._mids,
        #self._mids,
        {
            url = url,
            cb = cb
        }
    )
end

function httpServer:close()
    self._srv:close()
    self._srv = nil
end

function httpServer:listen(port)
    self._srv = net.createServer(net.TCP)
    self._srv:listen(
        port,
        function(conn)
            conn:on(
                "receive",
                function(skt, msg)
                    local req = {source = msg, path = "", ip = skt:getpeer()}
                    local res = Res:new(skt)

                    for i = 1, #self._mids do
                        if string.find(req.path, "^" .. self._mids[i].url .. "$") and not self._mids[i].cb(req, res) then
                            break
                        end
                    end
                    collectgarbage()
                end
            )
        end
    )
end
