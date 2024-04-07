local skynet  = require "skynet"
require "skynet.manager"

skynet.start( function ()

    -- 给当前服务 定一个  「本地」 别名
    skynet.register(".testsendmsg")

    -- 查找本地 有没有一个luamsg 的服务
    local testluamsg = skynet.localname(".luamsg")

    -- 向服务名为 luamsg 发送一个lua 消息， 参数为（1，“nengzhong”,true）
    local r = skynet.send(testluamsg,"lua",1,"nengzhong",true)
    skynet.error("skynet.send return value:",r)

    -- 通过skynet.pack 来打包发送
    r = skynet.rawsend(testluamsg,"lua",skynet.pack(2,"nengzhong",false))
    skynet.error("skynet.rawsend return value:",r)
end

)