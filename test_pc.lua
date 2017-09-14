require("util")
require("util_wifi")

util.test();
util_wifi.test();

tempData = nil ;

print(type(tempData)~='nil')

print(241/10)

print('a'..'b')

airInfo = {pm2=10,temperature='25'};
print(airInfo.temperature);

--util.printInfo(LED0);    
--util.printFSInfo();  
--util_wifi.setupWifi("ivan_office","1234567899");
--util.printFiles();  
--util_wifi.getIP();   



--[[
tempData = nil;   
util.gpio_high(9);
uart.setup( 0, 9600, 8, 0, 1, 0 )
uart.on("data", 0, 
function(data) 
    --util.gpio_low(LED0)
    --util.gpio_high(LED0)
    if(string.byte(data,1)==0x42) 
    then
        tempData = data ;
    elseif(type(tempData)~='nil') then
        tempData = tempData..data ;
    end
 
    if(type(tempData)~='nil') then
        if((string.len(tempData)>36) and (string.byte(tempData,1)==0x42) and (string.byte(tempData,2)==0x4d))  then
        ----------------------------------------------------------
            pm25 = (string.byte(tempData,13)*256+string.byte(tempData,14));
            print("pm25 = "..pm25);
            temperature = (string.byte(tempData,31)*256+string.byte(tempData,32)) 
            print("temperature = "..temperature/10);
            humidity = (string.byte(tempData,33)*256+string.byte(tempData,34)) 
            print("humidity = "..humidity/10);
            tempData = nil ;
        ----------------------------------------------------------
        -- uploaddata
        end
    end
end, 0)
]]--