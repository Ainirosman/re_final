<?php
	if (!isset($_POST)) {
		$response = array('status' => 'failed', 'data' => null);
		sendJsonResponse($response);
		die();
	}
	include_once("dbconnect.php");
	$userid = $_POST['userid'];
	$prid = $_POST['prid'];
	$prname = ucwords(addslashes($_POST['prname']));
	$prdesc = ucfirst(addslashes($_POST['prdesc']));
	$prprice = $_POST['prprice'];
	$praddress = $_POST['praddress'];
	
	$sqlupdate = "UPDATE `tbl_products` SET `prname`='$prname',`prdesc`='$prdesc',`prprice`='$prprice',`praddress`='$praddress' WHERE `prid` = '$prid' AND `user_id` = '$userid'";
	
	try {
		if ($conn->query($sqlupdate) === TRUE) {
			$response = array('status' => 'success', 'data' => null);
			sendJsonResponse($response);
		}
		else{
			$response = array('status' => 'failed', 'data' => null);
			sendJsonResponse($response);
		}
	}
	catch(Exception $e) {
		$response = array('status' => 'failed', 'data' => null);
		sendJsonResponse($response);
	}
	$conn->close();
	
	function sendJsonResponse($sentArray)
	{
		header('Content-Type = application/json');
		echo json_encode($sentArray);
	}
?>