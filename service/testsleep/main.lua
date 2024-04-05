local skynet = require "skynet"

-- skynet.sleep 会阻塞单个节点的初始化 ，只有等待sleep 休眠完成，之后其他服务才能继续运行


skynet.start(function ()
    skynet.error("begin sleep")
    skynet.sleep(500)
    skynet.error("end sleep")

    
end)