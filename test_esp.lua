function divideColor(str)
    local tempRGB = {}
    for word in string.gmatch(str, "%d+") do
        table.insert(tempRGB, #tempRGB + 1, word)
    end
    return tempRGB
end

function readColorFile(buffer)
    file.open("colors", "r")
    local flag, count = true, 0
    
    while flag do
        count = count + 1
        local s = file.readline()
        if s ~= nil then
            local rgb = divideColor(s)
            --print(count..'-'..rgb[2] .. "-" .. rgb[1] .. "-" .. rgb[3])
            buffer:set(count, rgb[2], rgb[1], rgb[3])
        else
            flag = false
        end
    end
    file.close()
end

local i, buffer = 0, ws2812.newBuffer(60, 3)
--buffer:set(1,0,255,0);

ws2812.init()
--readColorFile(buffer)

buffer:fill(255,0,0)

print(buffer:get(1))
print(buffer:get(2))
print(buffer:get(3))

ws2812.write(buffer)
