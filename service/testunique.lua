local skynet = require "skynet"


--  创建一个 testunique 服务，使用testunique 来创建 节点唯一服务createunique
local args = {...}

if (#args == 0) then
    table.insert(args,"createunique")
else 
    table.insert(args,"true")
    table.insert(args,"createunique")
end

-- 打印表的内容
for k, v in pairs(args) do
    print(k, v)
end

skynet.start(function ()
    local us ,us2 
    skynet.error("test unique service args = ")

    if(#args == 2 and args[1] == "true") then
        us = skynet.uniqueservice(true,args[2])
    else
        skynet.error("args[1] = "..args[1])
        us = skynet.uniqueservice(args[1])
       us2 =  skynet.uniqueservice(true,args[1])
    end
    skynet.error("uniqueservice handler ",skynet.address(us),skynet.address(us2))
end)