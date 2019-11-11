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

res, err = red:get("pass_proxy")
if res == ngx.null then 
    red:set("pass_proxy","false")
elseif red:get("pass_proxy") == "true" then
    ngx.req.read_body()
    local dynamic_target = ngx.req.get_post_args()["dynamic_target"]
    red:set("proxy_addr",dynamic_target)
end

local add = red:get("proxy_addr")
ngx.say(add)