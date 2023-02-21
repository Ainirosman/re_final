<?php

	if(!isset($_POST)){
	$response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
	die();
	}
    include_once("dbconnect.php");
	$userid = $_POST['user_id'];
	$prname = $_POST['prname'];
	$prdesc = $_POST['prdesc'];
	$prprice = $_POST['prprice'];
	$praddress = $_POST['praddress'];
	$prstate = $_POST['prstate'];
	$prloc = $_POST['prloc'];
	$prlat = $_POST['prlat'];
	$prlong = $_POST['prlong'];
	$image1 = $_POST['image1'];
	$image2 = $_POST['image2'];
	$image3 = $_POST['image3'];	

	$sqlinsert = "INSERT INTO tbl_products('user_id','prname','prdesc','prprice','praddress','prstate','prloc','prlat','prlong')
	VALUES('$userid','$prname','$prdesc','$prprice','$praddress','$prstate','$prloc','$prlat','$prlong')";
	
try{

	if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
	$decoded_string1 = base64_decode($image1);
	$decoded_string2 = base64_decode($image2);
	$decoded_string3 = base64_decode($image3);
    $filename = mysqli_insert_id($conn);
	$path1 = '../assets/homestayImage/'.$filename.'-1.jpg';
	$path2 = '../assets/homestayImage/'.$filename.'-2.jpg';
	$path3 = '../assets/homestayImage/'.$filename.'-3.jpg';
	file_put_contents($path1, $decoded_string1);
	file_put_contents($path2, $decoded_string2);
	file_put_contents($path3, $decoded_string3);
	sendJsonResponse($response);
	}else{
	$response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
	}
}
catch(Exception $e){
$response = array('status' => 'failed', 'data' => null);
sendJsonResponse($response);
}

$conn->close();

function sendJsonResponse($sentArray)
{
header('Content-Type: application/json');
echo json_encode($sentArray);
}
?>