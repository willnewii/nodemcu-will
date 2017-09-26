require("__httpServer")
require("_wifi")
require("_util")

util_wifi.setupAP()

httpServer:listen(80)

httpServer:use(
    "/",
    function(req, res)
        br = "<br><br>"
        str = "<h1>nodemcu</h1>" .. br

        -- print ip
        if wifi.sta.getip() ~= nil then
            str = str .. "ip: " .. wifi.sta.getip() .. br
        else
            str = str .. "no connection" .. br
        end

        -- print config
        if util.getConfig() == nil then
            str = str .. "config-websocket:nil" .. br
        else
            str = str .. "config-websocket:" .. util.getConfig() .. br
        end

        -- print gpio
        for i = 1, 12, 1 do
            str = str .. string.format("<li>gpio%s : %s </li>", i, gpio.read(i))
        end
        str = str .. br

        -- print api
        str = str .. '<a href="/getheap">getheap</a>' .. br
        str = str .. '<a href="/setupwifi">setup wifi(ssid/pwd)</a>' .. br
        str = str .. '<a href="/setupwebsocket">setup websocket(url)</a>' .. br
        res:send(str)
    end
)

httpServer:use(
    "/getheap",
    function(req, res)
        res:send("heap " .. node.heap()) -- /welcome?name=doge
    end
)

httpServer:use(
    "/setupwifi",
    function(req, res)
        if req.query.ssid ~= nil and req.query.pwd ~= nil then
            str = "ssid " .. req.query.ssid .. "\r\n"
            str = str .. "pwd " .. req.query.pwd .. "\r\n"
            util_wifi.setupWifi(req.query.ssid, req.query.pwd)
            res:send(str) -- /welcome?name=doge
        else
            res:send("query nil")
        end
    end
)

httpServer:use(
    "/setupwebsocket",
    function(req, res)
        if req.query.url ~= nil then
            str = "url " .. req.query.url .. "\r\n"
            local config = util.getConfig()
            config.socketServer = req.query.url
            util.setConfig(config)
            res:send(str) -- /welcome?name=doge
        else
            res:send("query nil")
        end
    end
)
