-- service/worker/init.lua  worker的服务初始化脚本

local skynet = require "skynet"

-- 消息相应函数
local CMD = {}
-- 服务名
local worker_name = ""
-- 服务id
local worker_id = ""
-- 工钱
local money = 0 
-- 是否在工作
local isworking = false

-- 每帧调用，一帧时间是0.2秒

local function update(frame)
    if isworking then 
        money = money+1
        skynet.error(worker_name .. tostring(worker_id) .. ", money: " .. tostring(money))
    end
end

-- 定时器，每隔0.2秒调用 一次update 函数
local function timer()
    local stime = skynet.now()
    local frame = 0 

    while true do 
        frame = frame + 1
        
        -- 调用update 函数，并且传入参数 frame
        local isok,err = pcall(update,frame)
        if not isok then 
            skynet.error(err)
        end
        local etime = skynet.now()
        -- 保证0.2秒

        --[[
            注：这里对代码说明一下，timer定时器函数中，waittime代表每次循环等待的时间，
            由于程序有可能会卡住，我们很难保证 “每隔0.2秒调用一次update” 是精确的，update函数本身执行也需要时间，
            所以等待时间是0.2减去执行时间，执行时间就是etime - stime。
        ]]--
        
        
        local waittime = frame*20 - (etime - stime)
        if waittime <= 0 then 
            waittime = 2 
        end 
        skynet.sleep(waittime)

    end 
end


-- 初始化, 等待启动服务，传入参数
local function init(name,id)
    worker_name = name 
    worker_id = id 
    skynet.error(" worker init doing")
end

-- 开始工作
function CMD.startWorker(source)
    isworking = true
    
end

-- 停止工作
function CMD.stopWorker(source)
    isworking = false
end

-- 调用初始化函数, ...是不定参数
-- 会从skynet.newservice 的第二个参数开始 传递过来
skynet.error(" worker init before")
init(...)
skynet.error(" worker init after")


skynet.start(function ()
    -- 消息分发
    skynet.dispatch("lua",function (session,source,cmd,...)
    
        -- 从CMD 这个表中查找是否有定义响应函数，如果有，则触发响应函数
        local func = CMD[cmd]
        if func then
            func(source,...)
        end

        -- 启动定时器
        skynet.fork(timer)
    end)
    
end)