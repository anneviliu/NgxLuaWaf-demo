local server = require "resty.websocket.server"
local wb, err = server:new{
    timeout = 5000,  -- in milliseconds
    max_payload_len = 65535,
}

if not wb then
    ngx.say(err)
end