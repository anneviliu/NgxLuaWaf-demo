--waf config file, to setting moudle enable='on'  disable='off'
---------------------------------------------------------------------
--waf status

config_waf_status = "on"
---------------------------------------------------------------------
--url_whitelist status
config_url_whitelist = "on"

--url_filter
config_url_filter = "on"

--ip_blacklist status
config_ip_blacklist = "on"

--get_args_check status
config_get_args_check = "on"

--post_args_check status
config_post_args_check = "on"

--Cookie_safe_check status
config_cookie_safe_check = "on"

--UA safe Check status
config_ua_safe_check = "on"

--CC Attack Defense status
config_cc_defense = "on"

config_waf_output = "html"

-- If waf detect dangerous request, redirect utl.
config_redirect_url = "/warning.html"

--safe_access log file position
config_safe_log = "../logs/safe_access.log"

--dangerous log file position
config_dangerous_log = "../logs/dangerous.log"


