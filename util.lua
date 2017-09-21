util = {}

function util.printTable(table)
    for k, v in pairs(table) do
        print(k, v)
    end
end

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

-- socketServer
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

function util.test()
    print("test")
    local config = util.getConfig() ;
    print(util.printTable(config));
    config.socketServer = 'ws://192.168.4.123:5555';
    util.setConfig(config);
    print(util.getConfig().socketServer);
end

util.test()

return util
