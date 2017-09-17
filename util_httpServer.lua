require("httpServer")
require("util_wifi")
require("util")

util_wifi.setupAP()

httpServer:listen(80)

httpServer:use(
    "/",
    function(req, res)
        br = "<br><br>"
        str = "i am nodemcu" .. br
        if wifi.sta.getip() ~= nil then
            str = str .. 'ip: '..wifi.sta.getip() .. br
        else
            str = str .. "no connection" .. br
        end
        str = str .. "config-websocket:" .. util.readConfig() .. br
        for i = 1, 12, 1 do
            str = str .. string.format("<li>gpio%s : %s </li>", i, gpio.read(i))
        end
        str = str .. '<a href="/setupwifi">setup wifi(ssid/pwd)</a>' .. br
        str = str .. '<a href="/setupwebsocket">setup websocket(url)</a>' .. br
        res:send(str)
    end
)

httpServer:use(
    "/test",
    function(req, res)
        res:send("Hello " .. req.query.name) -- /welcome?name=doge
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
            util.writeConfig(req.query.url)
            res:send(str) -- /welcome?name=doge
        else
            res:send("query nil")
        end
    end
)
