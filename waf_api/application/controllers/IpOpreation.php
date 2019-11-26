<?php

Class IpOpreation extends CI_Controller {
    public $ip;

    public function __construct() {
        parent::__construct();
        $this->ip = @$_POST['ip'];
    }

    public function ip_blacklist() {
        $flag = 0;
        if ($this->redis->get('ip_blacklist') == "true") {
            if (filter_var($this->ip, FILTER_VALIDATE_IP)) {
                $blacklist_arr = $this->redis->SMEMBERS('ip_blacklist_set');
                var_dump($blacklist_arr);
                foreach ($blacklist_arr as $key => $value) {
                    if ($this->ip === $value) {
                        $flag = 1;
                        break;
                    }
                }
                if($flag === 1) {
                    echo (json_encode(array('msg'=>'ip already exist','status'=>'0')));
                }
                else {
                    $a = $this->redis->SADD('ip_blacklist_set',$this->ip);
                    if ($a) echo(json_encode(array('msg'=>'Success','status'=>'1')));
                }
            }
            else {
                echo(json_encode(array('msg'=>'invalid ip','status'=>0)));
            }
        }
        else {
            echo (json_encode(array('msg'=>'ip_blacklist is closed','status' => '0')));
        }
    }

    public function ip_whitelist () {
        $flag1 = 0;
        if ($this->redis->get('ip_whitelist') == "true") {
            if (filter_var($this->ip, FILTER_VALIDATE_IP)) {
                $whitelist_arr = $this->redis->SMEMBERS('ip_whitelist_set');
                foreach ($whitelist_arr as $key => $value) {
                    if ($this->ip === $value) {
                        $flag1 = 1;
                        break;
                    }
                }
                if ($flag1 === 1) {
                    echo (json_encode(array('msg'=>'ip already exist','status'=>'0')));
                }
                else {
                    $a = $this->redis->SADD('ip_whitelist_set',$this->ip);
                    if ($a) echo(json_encode(array('msg'=>'Success','status'=>'1')));
                }
            }
            else {
                echo(json_encode(array('msg'=>'invalid ip','status'=>'0')));
            }
        }
        else {
            echo (json_encode(array('msg'=>'ip_whitelist is not allow','status' => '0')));
        }
    }

    public function get_blacklist () {
        echo(json_encode($this->redis->SMEMBERS('ip_black list_set')));
    }

    public function get_whitelist () {
        echo(json_encode($this->redis->SMEMBERS('ip_whitelist_set')));
    }
}