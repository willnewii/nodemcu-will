-- startup httpServer
--require("util_httpServer.lua")

require("_util")
require("_gpio")
require("_websocket")
require("_uart")
require("_wifi")

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
--util_wifi.setupWifi("CU_KszY","r5d5757q");

-- setup socketServer   
--util.setSocketServer('ws://192.168.1.2:5555/websocket');
util.setSocketServer('ws://192.168.11.63:5555/websocket');

-- listener net
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

-- print(util.getConfig().socketServer)