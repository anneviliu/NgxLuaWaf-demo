-- ip_blacklist ip黑名单 结合redis 实现
-- author : Annevi 
-- date: 2019-9-16
local redis = require "resty.redis"

local IP_NEED_TO_BAN = "10.10.10.10"
--获取用户真实ip
local function getIp()
    local client_IP = ngx.req.get_headers()["X-Real-IP"]
    if client_IP == nil then
        client_IP = ngx.req.get_headers()["x_forwarded_for"]
    end
    if client_IP == nil then
        client_IP = ngx.var.remote_addr
    end
    return client_IP
end

-- 连接redis 
local red = redis:new()
red:set_timeouts(2000) -- 2 sec
local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    red:close()
end


set, err = red:SMEMBERS('ip_blacklist')

for key, value in ipairs(set) do 
    if getIp() == value then
        ngx.exit(ngx.HTTP_FORBIDDEN)
    end
end

-- 预留接口 
-- 获取管理后台post的请求  

-- is_banned, err = red:get('ADD-BANNED-'..IP_NEED_TO_BAN)

-- if is_banned == "1" then
--     ngx.exit(ngx.HTTP_FORBIDDEN)
--     red:close()
-- else
--     local add_blacklist_res, err = red:set("ADD-BANNED-"..IP_NEED_TO_BAN,1)
-- end






