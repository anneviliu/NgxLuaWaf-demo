<form action="" method="post">

ip：<input type="text" name="ip">
type: <input type="text" name="type">
<input type="submit" value="提交">

</form>

<?php
$ch = curl_init();
$ip = $_POST['ip'];
$type = $_POST['type'];
$post_data = "ip=$ip&type=$type";
curl_setopt($ch, CURLOPT_URL, "192.168.2.219/api");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_HEADER, FALSE);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_TIMEOUT, 50);
curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
$output = curl_exec($ch);
curl_close($ch);
$output_json = json_decode($output,true)['message'];

print_r($output_json);