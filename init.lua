tmr.alarm(
    1,
    1000,
    tmr.ALARM_AUTO,
    function()
        if wifi.sta.getip() == nil then
            print("Waiting for IP ...")
        else
            print("IP is " .. wifi.sta.getip())
            tmr.stop(1)
        end
    end
)

dofile("httpServer.lua")
httpServer:listen(80)

httpServer:use(
    "/",
    function(req, res)
        res:send("hello nodemcu") --
    end
)

httpServer:use(
    "/welcome",
    function(req, res)
        res:send("Hello " .. req.query.name) -- /welcome?name=doge
    end
)
