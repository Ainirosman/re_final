<?php
	
	if(!isset($_POST)) {
		$response = array('status' => 'failed', 'data' => null);
		sendJsonResponse($response);
		die();
	}
	
	include_once("dbconnect.php");
	$userid = $_POST['userid'];
	$prname = $_POST['prname'];
	$prdesc = $_POST['prdesc'];
	$prprice = $_POST['prprice'];
	$praddress = $_POST['praddress'];
	$state = $_POST['state'];
	$loc = $_POST['loc'];
	$lat = $_POST['lat'];
	$lng = $_POST['lng'];
	$image1 = $_POST['image1'];
	$image2 = $_POST['image2'];
	$image3 = $_POST['image3'];
	
	$sqlinsert = "INSERT INTO `tbl_products`(`user_id`, `prname`, `prdesc`, `prprice`, `praddress`, `prstate`, `prloc`, `prlat`, `prlong`) 
	VALUES ('$userid','$prname','$prdesc','$prprice','$praddress','$state','$loc','$lat','$lng')";
	
	try{
		if ($conn->query($sqlinsert) === TRUE) {
			$response = array('status' => 'success', 'data' => null);
			$decoded_string1 = base64_decode($image1);
			$decoded_string2 = base64_decode($image2);
			$decoded_string3 = base64_decode($image3);
			$filename = mysqli_insert_id($conn);
			$path1 = '../server/productimages/'.$filename.'-1.png';
			$path2 = '../server/productimages/'.$filename.'-2.png';
			$path3 = '../server/productimages/'.$filename.'-3.png';
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