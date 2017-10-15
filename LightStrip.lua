LightStrip = {ledCount = 0, mode = 0, buffer = nil}

function LightStrip:new(ledCount, mode)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    self.ledCount = ledCount or 0
    self.mode = mode or 0

    if ledCount == 0 then
    -- error
    end

    ws2812.init()
    self.buffer = ws2812.newBuffer(self.ledCount, 3)

    return obj
end

function LightStrip:init()
    --print("init-" .. self.mode)
end

function LightStrip:setMode(mode)
    self.mode = mode
end

function LightStrip:setColor(r, g, b)
    self.buffer:fill(g, r, b)
    ws2812.write(self.buffer)
end

function LightStrip:getColorFromFile()
    file.open("colors", "r")
    local flag, count = true, 0

    while flag do
        count = count + 1
        local s = file.readline()
        if s ~= nil and count <= self.ledCount then
            local rgb = {}
            for word in string.gmatch(s, "%d+") do
                table.insert(rgb, #rgb + 1, word)
            end
            --print(count..'-'..rgb[2] .. "-" .. rgb[1] .. "-" .. rgb[3])
            self.buffer:set(count, string.char(rgb[2], rgb[1], rgb[3]))
        else
            flag = false
        end
    end
    file.close()
end

function LightStrip:wirte()
    ws2812.write(self.buffer)
end

return LightStrip
