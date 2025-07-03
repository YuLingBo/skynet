local skynet = require "skynet"
local websocket = require "http.websocket"
local json = require "cjson"

local users = {}

local function handle_message(ws_id, msg)
    local ok, data = pcall(json.decode, msg)
    if not ok then
        websocket.write(ws_id, json.encode({code=400, msg="json parse error"}))
        return
    end
    if data.cmd == "login" and data.openid then
        users[data.openid] = true
        websocket.write(ws_id, json.encode({code=0, msg="login success", openid=data.openid}))
    else
        websocket.write(ws_id, json.encode({code=401, msg="invalid login"}))
    end
end

skynet.start(function()
    skynet.error("[login] websocket login service start")
    local ws_port = 8001
    local ws_server = websocket.listen({
        port = ws_port,
        protocol = "ws",
        handler = function(ws_id)
            skynet.error("[login] client connected", ws_id)
            while true do
                local msg = websocket.read(ws_id)
                if not msg then
                    skynet.error("[login] client disconnected", ws_id)
                    break
                end
                handle_message(ws_id, msg)
            end
        end
    })
    skynet.error("[login] websocket listen on port " .. ws_port)
end) 