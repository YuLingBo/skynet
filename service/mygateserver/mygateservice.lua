loacl skynet = require "skynet"
local gateserver = require "skynet.gateserver"

local handle = {}


-- 当一个客户端链接过来之后， 调用这个函数，gateserver 自动调用
function handle.connect(fd,ipaddr)

    skynet.error("ipaddr :",ipaddr," fd: ",fd," connect")

    -- 链接成功 并不代表能马上读取数据
    -- 使用openclient  打开fd 套接字，来读取客户端发来的消息 
    gateserver.openclient(fd)
end


-- 当一个客户端断开链接之后， 调用这个函数
function handle.disconnect(fd)
    skynet.error(" client disconnect ",fd)
end


function handle.message(fd,msg,sz)
    skynet.error("client recived msg ",fd )
end

-- 只是一个gateserver 模块
 gateserver.start(handle)