util = {}

function util.printFSInfo()
    remaining, used, total=file.fsinfo()
    print("\nFile system info:\nTotal : "..total.." (k)Bytes\nUsed : "..used.." (k)Bytes\nRemain: "..remaining.." (k)Bytes\n")
end

function util.printIP()
    print(wifi.sta.getip())
end

function util.printFiles()
    l = file.list();
    for k,v in pairs(l) do
        print(k..", size:"..v)
    end
end

function util.gpio_low(pin)
    gpio.mode(pin,gpio.OUTPUT)  
    gpio.write(pin, gpio.LOW)
end
 
function util.gpio_high(pin)
    gpio.mode(pin,gpio.OUTPUT)  
    gpio.write(pin, gpio.HIGH)
end

function util.printInfo()
    util.printFiles();
    util.printIP();
end

function util.test()
    print('test')
end

return util;
