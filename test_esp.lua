-- startup httpServer
--require("util_httpServer.lua")
require("util")
require("util_gpio")
require("util_websocket")
require("util_uart")

--print(util.readConfig());

function pms5003ST()
    util_websocket.init(
        util.readConfig(),
        function()
            print("websocket.star")
        end
    )

    util_uart.init(
        function(airInfo)
            util_gpio.blink(0, 1)
            util_websocket.send(airInfo, "plantower")
        end
    )
end

if wifi.sta.getip() then
    print("true")
    --pms5003ST()
else
    print("false")
end
