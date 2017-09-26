function util.printFSInfo()
    remaining, used, total = file.fsinfo()
    print(
        "\nFile system info:\nTotal : " ..
            total .. " (k)Bytes\nUsed : " .. used .. " (k)Bytes\nRemain: " .. remaining .. " (k)Bytes\n"
    )
end

function util.printFiles()
    l = file.list()
    for k, v in pairs(l) do
        print(k .. ", size:" .. v)
    end
end

local ledCounts = 60

function startWS2812()
    ws2812.init()
    local i, buffer = 0, ws2812.newBuffer(ledCounts, 3)
    buffer:fill(61, 133, 247)
ws2812.write(buffer)
    tmr.create():alarm(
        500,
        1,
        function()
            i = i + 1
            buffer:fade(2)
            buffer:set(i % buffer:size() + 1, 0, 0, 0)
            ws2812.write(buffer)
        end
    )
end

startWS2812();