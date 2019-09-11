local redis = require "resty.redis"
local black = redis.new()

black:set_timeouts(60000) -- 1 sec

-- or connect to a unix domain socket file listened
-- by a redis server:
--     local ok, err = red:connect("unix:/path/to/redis.sock")

local ok, err = black.connect(black,"127.0.0.1"," 6379")
if not ok then
    ngx.say("failed to connect: ", err)
    return
end


ip_bind_time = 10  --封禁IP多长时间
ip_time_out = 6    --指定统计ip访问频率时间范围
connect_count = 10 --指定ip访问频率计数最大值

is_bind , err = black:get("bind_"..ngx.var.remote_addr)

if is_bind == '1' then
  ngx.exit(403)
  goto Lastend
end

start_time , err = black:get("time_"..ngx.var.remote_addr)
ip_count , err = black:get("count_"..ngx.var.remote_addr)

if start_time == ngx.null or ngx.time() - start_time > ip_time_out then
    res , err = black:set("time_"..ngx.var.remote_addr , os.time())
    res , err = black:set("count_"..ngx.var.remote_addr , 1)
    res , err = black:expire("count_"..ngx.var.remote_addr,ip_bind_time) --fix keys
    res , err = black:expire("time_"..ngx.var.remote_addr,ip_bind_time) --fix keys


  else
    ip_count = ip_count + 1
    res , err = black:incr("count_"..ngx.var.remote_addr)
    if ip_count >= connect_count then
      res , err = black:set("bind_"..ngx.var.remote_addr,1)
      res , err = black:expire("bind_"..ngx.var.remote_addr,ip_bind_time) --fix keys
    end
  end

  ::Lastend::
local ok, err = black:close()




















