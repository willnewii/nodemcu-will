local ledCounts = 10

function startWS2812()
    ws2812.init()
    local i, buffer = 0, ws2812.newBuffer(ledCounts, 3)
    local j = 0
    buffer:fill(61, 133, 247)

    tmr.create():alarm(
        1,
        200,
        1,
        function()
            i = i + 1
            buffer:fade(2, 1)
            buffer:set(i % (buffer:size() - j) + 1, 0, 0, 0)

            if i % (buffer:size() - j) == 0 then
                j = j + 1
            end

            if j == ledCounts then
                j = 0
            end
            ws2812.write(buffer)
        end
    )
end

startWS2812()
tmr.stop()

