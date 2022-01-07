<?php

require "../config/connect.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $judulBuku = $_POST['judulBuku'];
    $totalBuku = $_POST['totalBuku'];
    $tahun = $_POST['tahun'];
    $idBuku = $_POST['idBuku'];

    $insert = "UPDATE buku SET judulBuku='$judulBuku', totalBuku='$totalBuku', tahun='$tahun'  WHERE id='$idBuku'";
    if (mysqli_query($con, $insert)) {
        $response['value'] = 1;
        $response['message'] = "Berhasil terubah";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal terubah";
        echo json_encode($response);
    }
}
