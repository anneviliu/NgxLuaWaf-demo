-- ip_whitelist ip白名单 结合redis set 实现
-- author : Annevi 
-- date: 2019-9-16
-- 获取用户真实ip
function getIp()
    local client_IP = ngx.req.get_headers()["X-Real-IP"]
    if client_IP == nil then
        client_IP = ngx.req.get_headers()["x_forwarded_for"]
    end
    if client_IP == nil then client_IP = ngx.var.remote_addr end
    return client_IP
end

function ip_whitelist_func()
    local redis = require "resty.redis"
    -- 连接redis 
    local red = redis:new()
    red:set_timeouts(2000) -- 2 sec
    local ok, err = red:connect("127.0.0.1", 6379)
    if not ok then
        ngx.say("failed to connect: ", err)
        red:close()
    end
    set, err = red:SMEMBERS('ip_whitelist_set')
    for key, value in ipairs(set) do
        if getIp() == value then
            ngx.say("You can access it !")
        else
            ngx.exit(403)
        end
    end
end

