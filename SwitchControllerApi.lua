local cjson = require "cjson"
local config = require("waf.config")
local redis = require "resty.redis"
local red = redis:new()

red:set_timeouts(1000) -- 2 sec
local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    red:close()
end

local flag = 0

local moudle_status = {
    ["waf_status"] = config_waf_status,
    ["url_whitelist"] = config_url_whitelist,
    ["url_filter"] = config_url_filter,
    ["ip_blacklist"] = config_ip_blacklist,
    ["get_args_check"] = config_get_args_check,
    ["post_args_check"] = config_post_args_check,
    ["cookie_safe_check"] = config_cookie_safe_check,
    ["ua_safe_check"] = config_ua_safe_check,
    ["cc_defense"] = config_cc_defense,
    ["waf_output"] = config_waf_output,
    ["redirect_url"] = config_redirect_url,
    ["safe_log"] = config_safe_log,
    ["dangerous_log"] = config_dangerous_log
}

-- 接收前端post请求，将各功能状态存入redis
if ngx.var.request_method == "POST" then
    local moudle = ngx.req.get_post_args()["moudle"]
    local status = ngx.req.get_post_args()["status"]

    msg_success_obj = {["ip"] = ip, ["message"] = "success", ["type"] = moudle}

    msg_failed_obj = {["ip"] = ip, ["message"] = "failed", ["type"] = moudle}

    msg_empty_obj = {["ip"] = ip, ["message"] = "empty", ["type"] = moudle}

    if moudle and status then
        for key in pairs(moudle_status) do
            if key == moudle then
                insert, err = red:set(moudle, status)
                flag = 1
                break
            else
                flag = 0
            end
        end
    end

    if flag == 1 then
        ngx.say(cjson.encode(msg_success_obj))
    else
        ngx.say(cjson.encode(msg_failed_obj))
    end
end

-- 从数据库中返回当前状态
local moudle_status_table = {}
if ngx.var.request_method == "GET" then
    for key in pairs(moudle_status) do
        local return_value, err = red:get(key)
        moudle_status_table[key] = return_value
    end
    ngx.say(cjson.encode(moudle_status_table))
end

