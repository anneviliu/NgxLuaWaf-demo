local config = require("waf.config")
local redis = require "resty.redis"
local cjson = require "cjson"

ip = ngx.req.get_post_args()["ip"]
type = ngx.req.get_post_args()["type"]

local red = redis:new()
red:set_timeouts(2000) -- 2 sec
local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    red:close()
end

local msg_success_obj = {["ip"] = ip, ["message"] = "success", ["type"] = type}

local msg_failed_obj = {["ip"] = ip, ["message"] = "failed", ["type"] = type}

local msg_empty_obj = {["ip"] = ip, ["message"] = "empty", ["type"] = type}

local msg_exist_obj = {
    ["ip"] = ip,
    ["message"] = "ipAlreadyExist",
    ["type"] = type
}

local msg_noexist_obj = {["ip"] = ip, ["message"] = "noexist", ["type"] = type}

function op_ip_blacklist()
    local flag = 0
    local flag_white = 0
    local can_remove = 0
    local can_remove_white = 0

    if ip == nil then
        ngx.say(cjson.encode(msg_empty_obj))
    elseif ip and type == "ip_blacklist" then
        ifexist, err = red:SMEMBERS("ip_blacklist_set")
        for key, value in ipairs(ifexist) do
            if ip == value then
                flag = 1
                break
            end
        end

        if flag == 1 then
            ngx.say(cjson.encode(msg_exist_obj))
        else
            add_ip_blacklist, err = red:SADD("ip_blacklist_set", ip)
            if not err then ngx.say(cjson.encode(msg_success_obj)) end
        end

    elseif ip and type == "ip_blacklist_remove" then
        ifexist, err = red:SMEMBERS("ip_blacklist_set")
        for key, value in ipairs(ifexist) do
            if ip == value then
                can_remove = 1
                break
            end
        end

        if can_remove == 1 then
            is_remove, err = red:SREM("ip_blacklist_set", ip)
            if not err then
                ngx.say(cjson.encode(msg_success_obj))
            else
                ngx.say(cjson.encode(msg_failed_obj))
            end
        else
            ngx.say(cjson.encode(msg_noexist_obj))
        end
    end
end

function op_ip_whitelist()
    local flag = 0
    local flag_white = 0
    local can_remove = 0
    local can_remove_white = 0

    if ip and type == "ip_whitelist" then
        ifexist, err = red:SMEMBERS("ip_whitelist_set")
        for key, value in ipairs(ifexist) do
            if ip == value then
                flag_white = 1
                break
            end
        end

        if flag_white == 1 then
            ngx.say(cjson.encode(msg_exist_obj))
        else
            add_ip_whitelist, err = red:SADD("ip_whitelist_set", ip)
            if not err then ngx.say(cjson.encode(msg_success_obj)) end
        end
    elseif ip and type == "ip_whitelist_remove" then
        ifexist, err = red:SMEMBERS("ip_whitelist_set")
        for key, value in ipairs(ifexist) do
            if ip == value then
                can_remove_white = 1
                break
            end
        end

        if can_remove_white == 1 then
            is_remove, err = red:SREM("ip_whitelist_set", ip)
            if not err then
                ngx.say(cjson.encode(msg_success_obj))
            else
                ngx.say(cjson.encode(msg_failed_obj))
            end
        else
            ngx.say(cjson.encode(msg_noexist_obj))
        end
    end
end



if red:get("ip_blacklist") == "true" then
    op_ip_blacklist()
elseif type == "ip_blacklist" or type == "ip_blacklist_remove" then
    ngx.say(cjson.encode(msg_failed_obj))
end

if red:get("ip_whitelist") == "true" then
    op_ip_whitelist()
elseif type == "ip_whitelist" or type == "ip_whitelist_remove" then
    ngx.say(cjson.encode(msg_failed_obj))
end

