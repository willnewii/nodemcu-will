util = {}

function util.printFSInfo()
    remaining, used, total=file.fsinfo()
    print("\nFile system info:\nTotal : "..total.." (k)Bytes\nUsed : "..used.." (k)Bytes\nRemain: "..remaining.." (k)Bytes\n")
end

function util.printFSInfo()
    remaining, used, total=file.fsinfo()
    print("\nFile system info:\nTotal : "..total.." (k)Bytes\nUsed : "..used.." (k)Bytes\nRemain: "..remaining.." (k)Bytes\n")
end

function util.printFiles()
    l = file.list();
    for k,v in pairs(l) do
        print(k..", size:"..v)
    end
end

function util.printInfo()
    util.printFiles();
    util.printIP();
end

function util.jsondecode(_str)
    data = nil;
    pcall(function(str)
        data = sjson.decode(str)
    end,_str);
    return data ;
end

function util.test()
    print('test')
end

return util;
