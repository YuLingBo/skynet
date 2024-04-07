-- skynet.start 服务启动函数中，就是启动了一个skynet.timeout 为0s的定时器
-- 来执行通过skynet.start 函数传参得到的初始化函数，

-- 目的
-- 为了让skynet 工作线程调度一次新服务。这一次服务调度最重要的意义在于
-- 把fork 队列中的全部执行一次

local skynet = require "skynet"


--[[
    skynet.time()
            获取当前时间

    skynet.now()
            当前节点运行的时间

]]--


-- 永久的 5s 定时器
function  task()
    skynet.error("task ",coroutine.running() , " curtime |", skynet.time())
    skynet.timeout(500,task)
end

skynet.start( function ()
    skynet.error("start",coroutine.running()," curtime |",skynet.time())
    skynet.timeout(500,task)
end)