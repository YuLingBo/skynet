local skynet = require "skynet" 
​
--调用skynet.start接口，并定义传入回调函数
skynet.start(function()
    skynet.error("My new service")
    skynet.newservice("test")
    skynet.error("new test service")
end)
