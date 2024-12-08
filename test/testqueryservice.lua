local skynet = require "skynet" 
​
local args = { ... }
if(#args == 0) then
    table.insert(args, "uniqueservice")
end

skynet.error("test queryservice config ")
skynet.start(function()
    local us
    skynet.error("start query service")
    --如果test服务未被创建，该接口将会阻塞，后面的代码将不会执行
    if ( #args == 2 and args[1] == "true" )  then
        us = skynet.queryservice(true, args[2])
    else
        us = skynet.queryservice(args[1])  
    end
    skynet.error("end query service handler:", skynet.address(us))
end)
