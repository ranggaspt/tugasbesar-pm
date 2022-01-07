<?php

require "../config/connect.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $response = array();
    $judulBuku = $_POST['judulBuku'];
    $totalBuku = $_POST['totalBuku'];
    $tahun = $_POST['tahun'];
    $idBuku = $_POST['idBuku'];

    $insert = "DELETE FROM buku WHERE id='$idBuku'";
    if (mysqli_query($con, $insert)) {
        $response['value'] = 1;
        $response['message'] = "Berhasil dihapus";
        echo json_encode($response);
    } else {
        $response['value'] = 0;
        $response['message'] = "Gagal dihapus";
        echo json_encode($response);
    }
}
