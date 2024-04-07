local skynet = require "skynet"
local print_tab = require "print_tab"
require "skynet.manager"


local function dosomething(session,address,...)
    skynet.error("session",session)
    skynet.error("address",skynet.address(address))
    local args = {...}
    skynet.error("#args:",#args)
    print_tab.my_print_table_recursive(args," args tttttt",{_in={}})
    
    for i,v in pairs(args) do
        skynet.error("args ["..i.."]:",v)
    end
end

skynet.start(function ()

    skynet.register(".luamsg")
    -- 注册 “lua”类型的 回调函数
    skynet.dispatch("lua",function (session,address,...)
        dosomething(session,address)
    end)
    
end)