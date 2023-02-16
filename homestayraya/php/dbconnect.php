<?php

$servername = "localhost";
$username = "root";
$dbpassword = "";
$dbname = "homestay";

$conn = new mysqli($servername, $username, $dbpassword, $dbname);

if($conn->connect_error){
	die("Connection refused:" . $conn->connect_error);
}

?>