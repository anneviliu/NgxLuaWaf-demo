<?php

Class Proxy extends CI_Controller {
    public $dynamic_target;

    public function __construct() {
        parent::__construct();
        $this->dynamic_target = @$_POST['dynamic_target'];

    }

    public function add_addr() {
        $check_status_exist = $this->redis->get('pass_proxy');
        if($check_status_exist == null) {
            $this->redis->set('pass_proxy','false');
        }
        elseif ($check_status_exist === "true") {
            $res = $this->redis->set('proxy_addr',$this->dynamic_target);
            if ($res) {
                echo(json_encode(array('msg'=>'Success','status'=>'1')));
            }
            else {
                echo(json_encode(array('msg'=>'Failed','status'=>'0')));
            }
        }
    }

    public function get_addr() {
        $addr_list = $this->redis->get('proxy_addr');
        echo(json_encode(array('addr'=>$addr_list)));
    }
}