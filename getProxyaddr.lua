local config = require("waf.config")
local redis = require "resty.redis"
local cjson = require "cjson"

local red = redis:new()
red:set_timeouts(2000) -- 2 sec
local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    red:close()
end

local add = red:get("proxy_addr")

ngx.var.proxy_addr = add
