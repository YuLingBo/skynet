local skynet = require "skynet"
local harbor = require "skynet.harbor"
require "skynet.manager"	-- import skynet.launch, ...
local memory = require "skynet.memory"


-- 这段脚本通常会根据 standalone 配置项判断你启动的是一个 master 节点还是 slave 节点。
-- 如果是 master 节点还会进一步的通过 harbor 是否配置为 0 来判断你是否启动的是一个单节点 skynet 网络。

skynet.start(function()
	local sharestring = tonumber(skynet.getenv "sharestring" or 4096)
	memory.ssexpand(sharestring)

	local standalone = skynet.getenv "standalone"

	local launcher = assert(skynet.launch("snlua","launcher"))
	skynet.name(".launcher", launcher)

	local harbor_id = tonumber(skynet.getenv "harbor" or 0)
	-- 0 是单节点 1 是多节点模式
	if harbor_id == 0 then
		assert(standalone ==  nil)
		standalone = true
		skynet.setenv("standalone", "true")


		-- 单节点模式下，是不需要通过内置的 harbor 机制做节点间通讯的。
		-- 但为了兼容（因为你还是有可能注册全局名字），需要启动一个叫做 cdummy 的服务，它负责拦截对外广播的全局名字变更。
		local ok, slave = pcall(skynet.newservice, "cdummy")
		if not ok then
			skynet.abort()
		end
		skynet.name(".cslave", slave)

	else
		-- 如果是多节点模式，对于 master 节点，需要启动 cmaster 服务作节点调度用。
		-- 此外，每个节点（包括 master 节点自己）都需要启动 cslave 服务，用于节点间的消息转发，以及同步全局名字。
		if standalone then
			if not pcall(skynet.newservice,"cmaster") then
				skynet.abort()
			end
		end

		local ok, slave = pcall(skynet.newservice, "cslave")
		if not ok then
			skynet.abort()
		end
		skynet.name(".cslave", slave)
	end

	-- 需要启动 DataCenter 服务。
	if standalone then
		local datacenter = skynet.newservice "datacenterd"
		skynet.name("DATACENTER", datacenter)
	end
	-- 启动用于 UniqueService 管理的 service_mgr 。
	skynet.newservice "service_mgr"
	-- 它从 config 中读取 start 这个配置项，作为用户定义的服务启动入口脚本运行。成功后，把自己退出。
	pcall(skynet.newservice,skynet.getenv "start" or "main")
	skynet.exit()
end)
