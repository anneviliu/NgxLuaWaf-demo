function waf_modle_status_init()
    local cjson = require "cjson"
    local config = require("waf.config")
    local redis = require "resty.redis"

    local red = redis:new()

    red:set_timeouts(2000) -- 2 sec
    local ok, err = red:connect("127.0.0.1", 6379)
    if not ok then
        ngx.say("failed to connect: ", err)
        red:close()
    end

    local flag = 0

    local moudle_status = {
        ["waf_status"] = config_waf_status,
        ["pass_proxy"] = config_pass_proxy,
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

    local status_table_now = {}
    for key, value in pairs(moudle_status) do
        local status_value_now, err = red:get(key)
        status_table_now[key] = status_value_now
    end

    if status_table_now["waf_status"] == "true" then
        if status_table_now["cc_defense"] == "true" then
            require("waf.rule-judge.CCAttack")
            CCAttack()
        end

        if status_table_now["ip_blacklist"] == "true" then
            require("waf.ip_blacklist")
            ip_blacklist_func()
        end

        if status_table_now["ip_whitelist"] == "true" then
            require("waf.ip_whitelist")
            ip_whitelist_func()
        end

        if status_table_now["get_args_check"] == "true" then
            require("waf.rule-judge.args_check")
            get_check()
        end
        
        if status_table_now["post_args_check"] == "true" then 
            require("waf.rule-judge.args_check")
            post_check()
        end

        if status_table_now["cookie_safe_check"] == "true" then 
            require("waf.rule-judge.args_check")
            cookie_check()
        end
    end
end

waf_modle_status_init()
