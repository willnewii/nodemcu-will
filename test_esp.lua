require("_util")
require("_websocket")
require("_wifi")

function init_websocket()
    util_websocket.init(
        util.getConfig().socketServer,
        function()
            util_websocket.send("nodemcu online")
            print("websocket.star")
        end,
        function(data)
            util.printTable(data)
            print("websocket.receive")
        end
    )
end

-- connection network
util_wifi.setupWifi("ivan_office", "1234567899")
--util_wifi.setupWifi("CU_KszY","r5d5757q");

-- setup socketServer
--util.setSocketServer('ws://192.168.1.2:5555/websocket');
util.setSocketServer("ws://192.168.11.63:5555/websocket")

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
            init_websocket()
            tmr.stop(1)
        end
    end
)

--[[
require("LightStrip")


local lightStrip = LightStrip:new(60);
lightStrip.buffer:fade(2, ws2812.FADE_IN);
lightStrip:setColor(120, 206, 253);
--lightStrip:getColorFromFile();
lightStrip:wirte();


ws2812.init()
i, buffer = 0, ws2812.newBuffer(60, 3); 
buffer:fill(0, 128, 0);
tmr.alarm(0, 50, 1, function()
        i = i + 1
        buffer:fade(2,1)
        buffer:set(i%buffer:size() + 1, 0, 0, 0)
        ws2812.write(buffer)
end)
]]
--
