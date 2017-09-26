require("_gpio")
util_websocket = {}

local ws = websocket.createClient()
local msg = {device = "esp8266", data = nil}

function util_websocket.init(url, callback)
    ws:on(
        "connection",
        function(ws)
            print("got ws connection")
            if (callback ~= nil) then
                callback()
            end
        end
    )
    ws:on(
        "receive",
        function(_, msg, opcode) -- opcode is 1 for text message, 2 for binary
            print("got message:", msg)
            data = nil
            pcall(
                function(str)
                    data = sjson.decode(str)
                end,
                msg
            )
            if (data ~= nil) then
                if (data.action == "gpio") then
                    handleGPIO(data.data.pin, data.data.value)
                else
                    print("action no match")
                end
            end
        end
    )
    ws:on(
        "close",
        function(_, status)
            print("connection closed", status)
            ws = nil -- required to lua gc the websocket client
        end
    )
    ws:connect(url)
end

function util_websocket.send(data, type)
    msg.data = data
    msg.type = type
    ws:send(sjson.encode(msg))
end

function util_websocket.close()
    ws:close();
end

function handleGPIO(pin, value)
    if (value == "low") then
        util_gpio.setgpio(pin, 0)
    else
        util_gpio.setgpio(pin, 1)
    end
end

return util_websocket
