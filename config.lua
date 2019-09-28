-- waf config file, to setting moudle enable='on'  disable='off'
---------------------------------------------------------------------
-- waf status
config_waf_status = false
---------------------------------------------------------------------
-- url_whitelist status
config_url_whitelist = false

-- url_filter
config_url_filter = false

-- ip_blacklist status
config_ip_blacklist = false

-- ip_whitelist status
config_ip_whitelist = false

-- get_args_check status
config_get_args_check = false

-- post_args_check status
config_post_args_check = false

-- Cookie_safe_check status
config_cookie_safe_check = false

-- UA safe Check status
config_ua_safe_check = false

-- CC Attack Defense status
config_cc_defense = false

config_waf_output = "html"

-- If waf detect dangerous request, redirect utl.
config_redirect_url = "/warning.html"

-- safe_access log file position
config_safe_log = "../logs/safe_access.log"

-- dangerous log file position
config_dangerous_log = "../logs/dangerous.log"

