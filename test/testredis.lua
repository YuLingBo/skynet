local skynet = require "skynet"
local redis = require "skynet.db.redis"

local conf = {
	host = "127.0.0.1" ,
	port = 6379 ,
	db = 0
}

local function watching()
	local w = redis.watch(conf)
	w:subscribe "foo"
	w:psubscribe "hello.*"
	while true do
		skynet.error("Watch", w:message())
	end
end

skynet.start(function()
	skynet.error("ylb-----------")
	skynet.fork(watching)
	local db = redis.connect(conf)

	db:del "C"
	db:set("A", "hello")
	db:set("B", "world")
	db:sadd("C", "one")

	skynet.error(db:get("A"))
	skynet.error(db:get("B"))

	db:del "D"
	for i=1,10 do
		db:hset("D",i,i)
	end
	local r = db:hvals "D"
	for k,v in pairs(r) do
		skynet.error(k,v)
	end

	db:multi()
	db:get "A"
	db:get "B"
	local t = db:exec()
	for k,v in ipairs(t) do
		skynet.error("Exec", v)
	end

	skynet.error(db:exists "A")
	skynet.error(db:get "A")
	skynet.error(db:set("A","hello world"))
	skynet.error(db:get("A"))
	skynet.error(db:sismember("C","one"))
	skynet.error(db:sismember("C","two"))

	skynet.error("===========publish============")

	for i=1,10 do
		db:publish("foo", i)
	end
	for i=11,20 do
		db:publish("hello.foo", i)
	end

	db:disconnect()
--	skynet.exit()
end)

