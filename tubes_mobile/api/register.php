<?php
require "../config/connect.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST'){
    $response = array();
    $email = $_POST['email'];
    $password = md5($_POST['password']);
    $nama = $_POST['nama'];

    $cek = "SELECT * FROM users WHERE email='$email'";
    $result = mysqli_fetch_array(mysqli_query($con, $cek));

    if (isset($result)){
        $response['value']=1;
        $response['message']="Email telah digunakan";
        echo json_encode($response);
    }else{
        $insert = "INSERT INTO users VALUE(NULL, '$email', '$password', '$nama', NOW())";
        if(mysqli_query($con, $insert)){
            $response['value']=1;
            $response['message']="Berhasil di daftarkan";
            echo json_encode($response);
        }else{
            $response['value']=0;
            $response['message']="Gagal di daftarkan";
            echo json_encode($response);
        }
    }
}
