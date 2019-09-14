local limit_count = require "resty.limit.count"
local lim, err = limit_count.new("my_limit_count_store",3,10)


if not lim then
  ngx.log(ngx.ERR, "failed to instantiate a resty.limit.count object: ", err)
  return ngx.exit(403)
end



local key = ngx.var.binary_remote_addr


local delay, err = lim:incoming(key, true)
                
if not delay then
  if err == "rejected" then
    return ngx.exit(403)
  end
  ngx.log(ngx.ERR, "failed to limit count: ", err)
  return ngx.exit(403)
end