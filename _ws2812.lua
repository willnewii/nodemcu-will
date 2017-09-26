local ledCounts = 5

function startWS2812()
    ws2812.init()
    local i, buffer = 0, ws2812.newBuffer(ledCounts, 3)
    buffer:fill(61, 133, 247)

    tmr.create():alarm(
        50,
        1,
        function()
            i = i + 1
            buffer:fade(2)
            buffer:set(i % buffer:size() + 1, 0, 0, 0)
            ws2812.write(buffer)
        end
    )
end
