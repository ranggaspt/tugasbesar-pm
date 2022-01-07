<?php

require "../config/connect.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $judulBuku = $_POST['judulBuku'];
    $totalBuku = $_POST['totalBuku'];
    $tahun = $_POST['tahun'];
    $idUsers = $_POST['idUsers'];

    $insert = "INSERT INTO buku VALUE(NULL, '$judulBuku','$totalBuku', '$tahun', NOW(),'$idUsers')";
    if (mysqli_query($con, $insert)) {
        $response['value'] = 1;
        $response['message'] = "Berhasil ditambahkan";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal ditambahkan";
        echo json_encode($response);
    }
}
