util_wifi = {}

function util_wifi.setupAP()
    wifi.setmode(wifi.STATIONAP)

    station_cfg = {}
    station_cfg.ssid = "nodemcu_1203"
    station_cfg.pwd = "123456789"

    wifi.ap.config(station_cfg)
end

function util_wifi.setupWifi(SSID, PASS)
    wifi.setmode(wifi.STATION);
    station_cfg = {}
    station_cfg.ssid = SSID
    station_cfg.pwd = PASS
    station_cfg.save = true
    station_cfg.auto = true
    wifi.sta.config(station_cfg)
    
    print(wifi.sta.getip())
end

function util_wifi.scanAP()
    function listap(t)
        for k, v in pairs(t) do
            print(k .. " : " .. v)
        end
    end
    wifi.sta.getap(listap)
end

function util_wifi.getIP()
    print(wifi.sta.getip())
end

function util_wifi.test()
    print("test")
end

return util_wifi
