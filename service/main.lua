-- 学习网址 https://zhuanlan.zhihu.com/p/661868672

local skynet = require "skynet"


skynet.start(function ()
    skynet.error("[start main ylb] hello world")

    -- todo 启动其他服务
    --[[
        1. 启动打工服务
        2. 其中第二个参数和第三个参数会传递给 。/service/worker/init.lua
            脚本的init() 函数
    ]]
    local worker1 = skynet.newservice("worker","wk",1)

    --[[
        主服务给子服务发送消息
    ]]
    -- 开始工作
    skynet.send(worker1,"lua","startWorker")

    -- 主服务休息2s
    -- 主服务休息不回影响worker服务
    -- 在实际项目中不要这么调用，可能会造成服务 进入睡眠状态（以前同事这么调用过）
    skynet.sleep(200)
    -- 停止工作
    skynet.send(worker1,"lua","stopWorker")

    skynet.exit()
end)