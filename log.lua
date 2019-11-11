local cjson = require "cjson"

local time = ngx.localtime() 
local ip = ngx.var.remote_addr
local request_uri = ngx.var.request_uri
local post_string = ""

if ngx.var.request_method == "POST" then 
    local post_body_table = ngx.req.get_post_args()
    post_string = cjson.encode(post_body_table)
end


local log_table = {
    ['time'] = time,
    ['ip'] = ip,
    ['uri'] = request_uri,
    ['POST'] = post_string
}

local log_json = cjson.encode(log_table)

ngx.var.test_log = string.format("%s", log_json)
