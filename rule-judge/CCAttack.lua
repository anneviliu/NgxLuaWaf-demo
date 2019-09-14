local cjson = require("cjson")  

local redis = require "resty.redis"

--local log_socket = require("socket")
--package.path("/usr/local/openresty/lua_moudle/lua-resty-logger-socket/?.lua;")
--local logger = require ("resty.logger.socket")

local redis_key = "ip_blacklist"

--禁封ip时间
local ip_block_time = 30

--在 10 秒内监控访问
local ip_time_out = 10

--最大访问次数
local ip_max_times = 30

--读取nginx 变量 username 
--local USERNAME = ngx.var.username


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



--连接redis
local red = redis:new()
red:set_timeouts(2000) -- 1 sec
local ok, err = red:connect("127.0.0.1", 6379)

if not ok then
    ngx.say("failed to connect: ", err)
    red:close()
end


--查询redis中是否已经存在该ip ,存在即证明被ban
is_ban, err = red:get("BANNED-"..getIp())

if is_ban == "1" then 
    ngx.exit(ngx.HTTP_FORBIDDEN)
    red:close()
end

--查询数据库中是否已经有该ip访问
 ip_count, err = red:get("COUNT-"..getIp())  
 --如果ip 不存在redis中 
if ip_count == ngx.null then 
    ngx.say("Your ip: "..getIp())
    res, err = red:set("COUNT-"..getIp(),1) 
    res2, err2 = red:expire("COUNT-"..getIp(),ip_time_out) --单个ip检测时长
else
    ip_count = ip_count + 1
    if ip_count >= ip_max_times then
        res, err = red:set("BANNED-"..getIp(),1)
        res2, err2 = red:expire("BANNED-"..getIp(),ip_block_time)

        --危险流量 ，日志记录开启，准备发送到日志服务器

    else
        res, err = red:set("COUNT-"..getIp(),ip_count)
        res2, err2 = red:expire("COUNT-"..getIp(),ip_time_out)
    end
end