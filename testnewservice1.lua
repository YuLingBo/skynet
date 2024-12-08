local skynet = require "skynet"

skynet.start( function()

    skynet.error("newtest service")
    skynet.newservice("test")
end

)