local config = require("waf.config")

if config_waf_status == "on" then 
    require("waf.rule-judge.CCAttack")
    CCAttack()
    ngx.say("hello world")
end