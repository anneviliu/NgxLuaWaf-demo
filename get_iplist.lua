local config = require("waf.config")
local redis = require "resty.redis"
local cjson = require "cjson"
type = ngx.req.get_post_args()["type"]

local red = redis:new()
red:set_timeouts(2000) -- 2 sec
local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    red:close()
end

    if type == "get_iplist" then 
        local ip_blacklist_table, err = red:SMEMBERS("ip_blacklist_set")
        return_json_black_array = {
            ["time"] = os.date("%Y-%m-%d %H:%M:%S"),
            ["ip"] = ip_blacklist_table,
            ["type"] = "ip_blacklist"
        }
        ngx.say(cjson.encode(return_json_black_array))
        
        -- for key, value in pairs(ip_blackarray)
        --     ngx.say(value)
        -- end
    end