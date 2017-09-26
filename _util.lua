util = {}

function util.printTable(table)
    for k, v in pairs(table) do
        print(k, v)
    end
end

function util.jsondecode(str)
    local result, data = pcall(sjson.decode, str)
    if result == false then
        print("failed to decode!--"..data);
        data = nil ;
    end
    return data
end

function util.jsonencode(tab)
    local result, json = pcall(sjson.encode, tab)
    if result == false then
        print("failed to encode!--"..json);
        json = nil ;
    end
    return json ;
end

function util.setConfig(config)
    local fd = file.open("device.config", "w+")
    if fd then
        fd:write(util.jsonencode(config));
        fd:close()
        fd = nil
    end
end

function util.getConfig()
    local fd = file.open("device.config", "r")
    config = nil
    if fd then
        local str = fd:readline()
        config = util.jsondecode(str)
        fd:close()
        fd = nil
    end
    return config
end

function util.setSocketServer(url)
    local config = util.getConfig() ;
    if config == nil then
        config = {};
    end
    config.socketServer = url;
    util.setConfig(config);
    print(util.getConfig().socketServer);
end

return util
