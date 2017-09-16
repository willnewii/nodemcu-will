-- 0 low 1 high
util_gpio = {}

local LED0 = 0
local LED1 = 4
local second = 1000000

function util_gpio.setgpio(pin, value)
    gpio.mode(pin, gpio.OUTPUT)
    if (value == 0) then
        gpio.write(pin, gpio.LOW)
    else
        gpio.write(pin, gpio.HIGH)
    end
end

function util_gpio.blink(pin, times)
    for i = 1, times, 1 do
        util_gpio.setgpio(pin, 0)
        tmr.delay(second * 0.5)
        util_gpio.setgpio(pin, 1)
        tmr.delay(second * 0.5)
    end
end

function util_gpio.printgpio(str)
    if str == nil then
        str = "gpio%s : %s"
    end
    for i = 1, 12, 1 do
        print(string.format(str, i, gpio.read(i)))
    end
end

function util_gpio.test()
    print("test")
end

return util_gpio
