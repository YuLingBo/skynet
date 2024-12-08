local skynet = require "skynet"
local snax = require "skynet.snax"

-- 注意 snax 启动的服务，需要在config 中配置snax的服务路径 
--       snax = root.."service/?/init.lua;"    simpleSnax（skynet.start ） 需要在路径中找到

function init()
    skynet.error(" start init snax test service ")
end


-- 全局的 snax 服务
local function uniqueServiceSnax()

    local gObj = snax.globalservice("simpleSnax",300,"uuu",false)
    gobj = snax.queryglobal("simpleSnax") --查询全节点全局唯一服  ,为什么查询不到呢 ，服务名写成小写了
    skynet.error("snax service globalservice : ",gObj)
    -- snax.kill(gobj,300,"uuu")


    local uObj = snax.uniqueservice("simpleSnax",200,"yyy",false)
    uObj = snax.queryservice("simpleSnax") --查询全局唯一服
    skynet.error("snax servie uniqueservie : ",uObj)
    --  snax.kill(uObj,200,"yyy")

end



local function snaxCall()
     -- 启动 simplesnax 服务
     local obj = snax.newservice("simpleSnax",123,"abc",false)
     if not obj then
         skynet.error("snax service ",obj,"startup")
     end
     
     
     -- 调用有回调的
     local retstr = obj.post.echo("object func ")
     skynet.error("call snax service echo return  ",retstr)

     local callhello = obj.post.hello(100,"www")
     skynet.error("call snax service hello func :",callhello)
 
     obj.post.quit("exit snax")
end 



local function snaxCallTest()
    local obj = snax.newservice("test")
    skynet.error("call snax service test func",obj)

end

skynet.start(function()
    -- snaxCall()

    -- test uniqueService 
    uniqueServiceSnax()
end)