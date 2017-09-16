require("util")
require("util_wifi")

--util.test();
--util_wifi.test();

airInfo = {pm2 = 10, temperature = "25"}
print(airInfo.temperature)
print("hahah" .. airInfo.a)
print(sjson.encode(airInfo))

tempData = nil
print(type(tempData) ~= "nil")

pcall(
    function(str)
        data = sjson.decode(str)
    end,
    "1231231"
)

--[[
require("util.lua")
require("util_wifi.lua")

util.printInfo(LED0);
util.printFSInfo();
util_wifi.setupWifi("ivan_office","1234567899");
util.printFiles();
util_wifi.getIP();
]] --

--[[
require("util_gpio.lua")
require("util_websocket.lua")
require("util_uart.lua")
 
util_websocket.init('ws://10.1.101.184:5555/websocket',function()
    print('websocket.star');
end); 

util_uart.init(function(airInfo)
    util_gpio.blink(0,1);
    util_websocket.send(airInfo,'plantower');
end);
]] --
