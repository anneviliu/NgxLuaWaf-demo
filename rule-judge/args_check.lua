function cookie_check()
    cookies =  ngx.var.http_cookie
    file = io.open("/home/annevi/Documents/So_FK_Vgtb/rule-judge/xss.txt","r")
    for line in file:lines() do
        if ngx.re.find(cookies,line,"jo") ~= nil then
            ngx.exit(403)
        end
    end
        file:close()
end

function get_check()
    get_args = ngx.req.get_uri_args()
    file = io.open("/home/annevi/Documents/So_FK_Vgtb/rule-judge/xss.txt","r")
    for line in file:lines() do
        for key, value in pairs(get_args) do 
            if ngx.re.find(value,line,"jo") ~= nil then
                ngx.exit(403)
            end
        end
    end
        file:close()
end

function post_check()
    post_args = ngx.req.get_post_args()
    file = io.open("/home/annevi/Documents/So_FK_Vgtb/rule-judge/xss.txt","r")
    for line in file:lines() do
        for key, value in pairs(post_args) do 
            if ngx.re.find(value,line,"jo") ~= nil then
                ngx.exit(403)
            end
        end
    end
        file:close()
end

function header_check()
    post_args = ngx.req.get_headers()
    file = io.open("/home/annevi/Documents/So_FK_Vgtb/rule-judge/xss.txt","r")
    for line in file:lines() do
        for key, value in pairs(post_args) do 
            if ngx.re.find(value,line,"jo") ~= nil then 
                ngx.exit(403)
            end
        end
    end
        file:close()
end
