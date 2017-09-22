-- startup httpServer
--require("util_httpServer.lua")

require("util")
require("util_gpio")
require("util_websocket")
require("util_uart")
require("util_wifi")

function pms5003ST()
    util_websocket.init(
        util.getConfig().socketServer,
        function()
            util_websocket.send("nodemcu online")
            print("websocket.star")
        end
    )
    util_uart.init(
        function(airInfo)
            util_websocket.send(airInfo, "plantower")
        end
    )
end

-- device startup
util_gpio.blink(0, 3)

-- connection network 
util_wifi.setupWifi("ivan_office","1234567899");

-- setup socketServer   
util.setSocketServer('ws://192.168.11.63:5555/websocket');

print(util.getConfig().socketServer)

tmr.alarm(
    1,
    1000,
    tmr.ALARM_AUTO,
    function()
        if wifi.sta.getip() == nil then
            --util_gpio.blink(4, 1)
        else
            util_gpio.blink(0, 1)
            pms5003ST()
            tmr.stop(1)
        end
    end
)
