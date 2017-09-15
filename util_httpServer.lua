require("httpServer");
require("util_wifi");

util_wifi.setupAP();
 
httpServer:listen(80);

httpServer:use('/', function(req, res)
    br = '<br><br>'
    str = 'i am nodemcu'..br;
    if wifi.sta.getip() ~= nil then
        str = str..wifi.sta.getip()..br;
    else
        str = str..'no connection'..br;
    end
    str = str..'<a href="/setupwifi">setup wifi(ssid/pwd)</a>'
    res:send(str)
end)

httpServer:use('/test', function(req, res)
	res:send('Hello ' .. req.query.name) -- /welcome?name=doge
end);

httpServer:use('/setupwifi', function(req, res)
    if req.query.ssid ~= nil and req.query.pwd ~= nil then
        str = 'ssid ' .. req.query.ssid..'\r\n';
        str = str .. 'pwd ' .. req.query.pwd..'\r\n';
        util_wifi.setupWifi(req.query.ssid,req.query.pwd);
	    res:send(str) -- /welcome?name=doge
    else
        res:send('query nil')
    end
end);