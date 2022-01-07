<?php

define('HOST','localhost');
define('USERNAME','root');
define('PASS','');
define('DB','db_bukuperpus');

$con = mysqli_connect(HOST,USERNAME,PASS,DB) or die('Tidak Terhubung'); 

?>