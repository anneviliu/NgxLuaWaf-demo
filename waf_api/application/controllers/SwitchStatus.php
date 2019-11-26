<?php

Class SwitchStatus extends CI_Controller {
    public $module;
    public $status;
    public $module_list = array();
    public $status_list = array();

    public function __construct() {
        parent::__construct();
        $this->module = @$_POST['module'];
        $this->status = @$_POST['status'];
        $this->module_list = array(
            'waf_status',
            'url_whitelist',
            'url_filter',
            'ip_blacklist',
            'ip_whitelist',
            'pass_proxy',
            'get_args_check',
            'post_args_check',
            'cookie_safe_check',
            'ua_safe_check',
            'cc_defense',
            'waf_output',
            'redirect_url',
            'safe_log',
            'dangerous_log'
        );
    }

    public function change_status () {
        $flag = 0;
        if (isset($this->module) && isset($this->status)) {
            foreach ($this->module_list as $value) {
                if($value === $this->module) {
                    $a = $this->redis->set($this->module,$this->status);
                    if ($a) {
                        $flag = 1;
                        break;
                    }
                }
                else {
                    $flag = 0;
                }
            }
            if ($flag === 1) {
                echo(json_encode(array('msg'=>'Success','module'=>$this->module,'now_status'=>$this->redis->get($this->module))));
            }
            else {
                    echo(json_encode(array('msg'=>'Failed','module'=>$this->module,'now_status'=>$this->redis->get($this->module))));
            }
        }
        else {
            exit();
        }
    }

    public function get_status () {
        foreach ($this->module_list as $value) {
            $return_value = $this->redis->get($value);
            $this->status_list[$value] = $return_value;
        }
        echo (json_encode(array($this->status_list)));
    }
}