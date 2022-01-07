<?php
require "../config/connect.php";

$response = array();

$sql = mysqli_query($con, "SELECT a.*, b.nama FROM buku a left JOIN users b ON a.idUsers = b.id");
while ($a = mysqli_fetch_array($sql)) {
    $b['id'] =$a['id'];
    $b['judulBuku'] =$a['judulBuku'];
    $b['totalBuku'] =$a['totalBuku'];
    $b['tahun'] =$a['tahun'];
    $b['createDate'] =$a['createDate'];
    $b['idUsers'] =$a['idUsers'];
    $b['nama'] =$a['nama'];

    array_push($response, $b);
}

echo json_encode($response);