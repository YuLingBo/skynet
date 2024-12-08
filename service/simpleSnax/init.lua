local skynet = require "skynet"
local snax = require "skynet.snax"


local i = 50
gametg = "li li"

function accept.callPatch()
    skynet.error("simpleSnax i= ",i," gametg = ",gametg)
end

function accept.hello(...)
    skynet.error("simple snax service hello func",...)
end


function accept.quit(...)
    skynet.error("simple snax service hello func",...)
    skynet.exit()
end


-- 处理有响应的函数
function accept.echo(str)
    skynet.error("simple snax :",str)
    return str.upper
end

function init(...)
    skynet.error("start snax server init ",...)
end

function exit()
    skynet.error(" exit snax server")
end