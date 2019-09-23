local config = require("waf.config")
local cjson = require "cjson"
json = cjson.new()
local redis = require "resty.redis"

local ip = ngx.req.get_post_args()["ip"]
local type = ngx.req.get_post_args()["type"]

local red = redis:new()
    red:set_timeouts(2000) -- 2 sec
    local ok, err = red:connect("127.0.0.1", 6379)
    if not ok then
        ngx.say("failed to connect: ", err)
        red:close()
    end
flag = 0
flag_white = 0
can_remove = 0
can_remove_white = 0

msg_success_obj = {
    ["ip"]=ip,
    ["message"]="success",
    ["type"] = type
}

msg_failed_obj = {
    ["ip"] = ip,
    ["message"]="failed",
    ["type"] = type
}

msg_empty_obj = {
    ["ip"] = ip,
    ["message"] = "empty",
    ["type"] = type
}

msg_exist_obj = {
    ["ip"] = ip,
    ["message"] = "ipAlreadyExist",
    ["type"] = type
}

msg_noexist_obj = {
    ["ip"] = ip,
    ["message"] = "noexist",
    ["type"] = type
}



if ip == nil then
    ngx.say(cjson.encode(msg_empty_obj))

elseif ip and type == "ip_blacklist" then
    ifexist, err = red:SMEMBERS("ip_blacklist")
    for key,value in ipairs(ifexist) do
        if ip == value then
            flag = 1
            break
        end
    end

    if flag == 1 then 
        ngx.say(cjson.encode(msg_exist_obj))
    else
        add_ip_blacklist, err = red:SADD("ip_blacklist",ip)
        if not err then
            ngx.say(cjson.encode(msg_success_obj))
        end
    end

elseif ip and type == "ip_blacklist_remove" then 
    ifexist, err = red:SMEMBERS("ip_blacklist")
    for key,value in ipairs(ifexist) do 
        if ip == value then
            can_remove = 1
            break
        end
    end

    if can_remove == 1 then 
        is_remove, err = red:SREM("ip_blacklist",ip)
        if not err then
            ngx.say(cjson.encode(msg_success_obj))
        else
            ngx.say(cjson.encode(msg_failed_obj))
        end
    else 
        ngx.say(cjson.encode(msg_noexist_obj))
    end

elseif ip and type == "ip_whitelist" then 
    ifexist, err = red:SMEMBERS("ip_whitelist")
    for key,value in ipairs(ifexist) do
        if ip == value then
            flag_white = 1
            break
        end
    end

    if flag_white == 1 then 
        ngx.say(cjson.encode(msg_exist_obj))
    else
        add_ip_whitelist, err = red:SADD("ip_whitelist",ip)
        if not err then
            ngx.say(cjson.encode(msg_success_obj))
        end
    end
elseif ip and type == "ip_whitelist_remove" then 
    ifexist, err = red:SMEMBERS("ip_whitelist")
    for key,value in ipairs(ifexist) do 
        if ip == value then
            can_remove_white = 1
            break
        end
    end

    if can_remove_white == 1 then 
        is_remove, err = red:SREM("ip_whitelist",ip)
        if not err then
            ngx.say(cjson.encode(msg_success_obj))
        else
            ngx.say(cjson.encode(msg_failed_obj))
        end
    else
        ngx.say(cjson.encode(msg_noexist_obj))
    end
end