dofile("util.lua")
dofile("util_wifi.lua")
 
local LED0 = 0;
local LED1 = 4; 
      
--util.printInfo(LED0);   
--util.printFSInfo(); 
--util_wifi.setupWifi("ivan_office","1234567899");
util.printFiles(); 
util_wifi.getIP();

uart.setup( 0, 9600, 8, 0, 1, 0 );
uart.on("data",
  function(data)
    print(data)
    --if(string.len(data)==32 and string.byte(data)==66) then
        --
    --end
end, 0)
