require("util_httpServer")

if wifi.sta.getip() then
    print("true")
else
    print("false")
end