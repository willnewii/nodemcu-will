util_uart = {}

local tempData = nil
local airInfo = {pm25 = 0, temperature = 0, humidity = 0}
local count = 14

function util_uart.init(callback)
    uart.setup(0, 9600, 8, 0, 1, 0)
    uart.on(
        "data",
        0,
        function(data)
            print("--readdata--")
            if (string.byte(data, 1) == 0x42) then
                tempData = data
            elseif (type(tempData) ~= "nil") then
                tempData = tempData .. data
            end

            if (type(tempData) ~= "nil") then
                if
                    ((string.len(tempData) > 36) and (string.byte(tempData, 1) == 0x42) and
                        (string.byte(tempData, 2) == 0x4d))
                 then
                    ----------------------------------------------------------
                    handlePMS5003ST(tempData)
                    ----------------------------------------------------------
                    -- uploaddata
                    count = count + 1
                    if count > 15 then
                        if (callback ~= nil) then
                            callback(airInfo)
                        end
                        count = 0
                    end
                end
            end
        end,
        0
    )
end

--uart.on("data")

function handlePMS5003ST(data)
    airInfo.pm25 = (string.byte(data, 13) * 256 + string.byte(data, 14))
    airInfo.temperature = (string.byte(data, 31) * 256 + string.byte(data, 32))
    airInfo.humidity = (string.byte(data, 33) * 256 + string.byte(data, 34))
end

return util_uart
