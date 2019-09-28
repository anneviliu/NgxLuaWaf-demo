<?php
// header("Cache-Control: no-cache");
// header('Content-Type: text/html;charset=utf-8');
header('Access-Control-Allow-Origin:*'); // *代表允许任何网址请求
// header('Access-Control-Allow-Methods:POST,GET,OPTIONS,DELETE'); // 允许请求的类型
// header('Access-Control-Allow-Headers: Content-Type,Content-Length,Accept,X-Requested-with, Origin'); // 设置允许自定义请求头的字段 
include("config.php");
$conn = new mysqli($db_servername,$db_username,$db_password,"waf_admin");
//mysqli_query($conn,"DELETE FROM users WHERE username='tt21t'");

if (isset($_POST['sub']) && $_POST['sub'] === "submit")
{   
    if($invite_code === $_POST['inviteCode'])
    {
        $username = $_POST['username'];
        $password1 = $_POST['password1'];
        $password2 = $_POST['password2'];
        if(!isset($username) || !isset($password1) || !isset($password2))
        {
            $json_array = array(
                'username'=> $username,
                'message' => "输入不能为空"
            );
            echo json_encode($json_array);
          exit;
          if($password1 !== $password2)
          {
            $json_array = array(
                'username'=> $username,
                'message' => "两次密码输入不一致"
            );
              echo json_encode($json_array);
              exit;
          }
        }
       
        if($password1 === $password2)
        {
            $sql = "select * from `Users` where username='$username'";
            $result = mysqli_query($conn,$sql);
            if(mysqli_num_rows($result)>0)
            {  
                $json_array = array(
                    'username'=> $username,
                    'message' => "用户名已存在"
                );
                echo json_encode($json_array);
                exit;  
            }
            else
            {   
                $insert_sql = "INSERT INTO Users (`username`, `passowrd`) VALUES ('$username', '$password1')";
                if ($conn->query($insert_sql)) 
                {
                    $json_array = array(
                        'username'=> $username,
                        'message' => "注册成功"
                    );
                    echo json_encode($json_array);
                } 
                else
                {
                    $json_array = array(
                        'username'=> $username,
                        'message' => "注册失败"
                    );
                    echo json_encode($json_array);
                }
            }
        }
    }
    else
    {
        $json_array = array(
            'username'=> $username,
            'message' => "邀请码错误"
        );
        echo json_encode($json_array);
    }
}
?>