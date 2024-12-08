-- 学习网址 https://zhuanlan.zhihu.com/p/661868672

local skynet = require "skynet"
local redis = require "skynet.db.redis"
--local cjson = require "cjson"


local function work_service()
    skynet.error("[start main ylb] hello world")

    -- todo 启动其他服务
    --[[
        1. 启动打工服务
        2. 其中第二个参数和第三个参数会传递给 。/service/worker/init.lua
            脚本的init() 函数
    ]]

    skynet.newservice("test")
    local worker1 = skynet.newservice("worker","wk",1)
     -- 开始工作
    -- skynet.send("worker","lua","startWorker")
    skynet.send(worker1,"lua","startWorker")
    return worker1
end


local function connectRedis()
    
    local db = redis.connect({
        host = "127.0.0.1",
        port = 6379,
    })

    -- 设置键值对
    db:set("key", "value111")

    -- 获取键值对
    local value = db:get("key")
    skynet.error("Value:", value)

    -- 将 Lua 表转换为 JSON 字符串
    --local data = {name = "John", age = 30}
    --local json_data = cjson.encode(data)

    -- 存储 JSON 数据
    --db:set("json_data", json_data)

    -- 获取 JSON 数据
    --local retrieved_json_data = db:get("json_data")
    --skynet.error("Retrieved JSON data:", retrieved_json_data)
    -- 关闭 Redis 连接
    db:disconnect()
    --[[
        主服务给子服务发送消息
    ]]
   
end




local function createunique()
    skynet.error("create unique service")
    skynet.newservice("testunique")
    
end

skynet.start(function ()
    skynet.error("[start main ylb] hello world")
    local worker1 = createWorkService()
    -- connectRedis()

    -- 主服务休息2s
    -- 主服务休息不回影响worker服务
    -- 在实际项目中不要这么调用，可能会造成服务 进入睡眠状态（以前同事这么调用过）
    skynet.sleep(200)
    -- 停止工作
    skynet.send(worker1,"lua","stopWorker")

end

local args = {...}
-- 测试  testunique 唯一服务
local function unique_service()
    
    skynet.error("[start main ylb] hello world")
    --skynet.newservice("testnewservice")

    if #args == 0 then 
        table.insert(args,"testunique")
    elseif #args == 1 then
        table.insert(args,1,"true")
    end

    local us
    skynet.error("test uniques service ")

    if #args == 2 and args[1]=="true" then 
        us = skynet.uniqueservice("true",args[2])
    else
        us = skynet.uniqueservice(args[1])
    end

    skynet.error("testunique address : ",skynet.address(us))


end



skynet.start(function ()
   
    -- work_service()
    -- unique_service()

    -- skynet.newservice("lua_test_assert")
    skynet.newservice("testSimpleSnax")
    --skynet.newservice("test")
end)