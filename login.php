<?php
include("config.php");
header('Access-Control-Allow-Origin:*'); // *代表允许任何网址请求

$conn = new mysqli($db_servername,$db_username,$db_password,"waf_admin");

if($conn)
{
    if (isset($_POST['sub']) && $_POST['sub'] === "submit")
    {
        $username = $_POST['username'];
        $password = $_POST['password'];
        if(!isset($username) || !isset($password))
    {
        $json_array = array(
            'username'=> $username,
            'message' => "用户名或密码为空",
            'token'=> base64_encode($username)
    );
        echo json_encode($json_array);
        exit;
    }
    else
    {
        $sql="SELECT * from `Users` where username='$username' and passowrd='$password'";
        $result=$conn->query($sql);
        //var_dump($result);
        $row=mysqli_num_rows($result);
        //var_dump($row);
        if(!$row)
        {
            $json_array = array(
                'username'=> $username,
                'message' => "用户名或密码错误",
                'token'=> base64_encode($username)
            );
            echo json_encode($json_array);
            exit;
        }
        else
        {
            $json_array = array(
                'username'=> $username,
                'message' => "登录成功",
                'token'=> base64_encode($username)
            );
            echo json_encode($json_array);
            exit;
        }
    }
}
}
?>