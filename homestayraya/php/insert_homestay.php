<?php

	if(!isset($_POST)){
	$response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
	die();
	
    include_once("dbconnect.php");
	$pridowner = $_POST['pridowner'];
	$prname = $_POST['prname'];
	$prdesc = $_POST['prdesc'];
	$prprice = $_POST['prprice'];
	$prqty = $_POST['prqty'];
	$prdel = $_POST['prdel'];
	$prstate = $_POST['prstate'];
	$prloc = $_POST['prloc'];
	$prlat = $_POST['prlat'];
	$encoded_string = $_POST['image'];

	$sqlinsert = "INSERT INTO tbl_products(pridowner,prname,prdesc,prprice,prqty,prdel,prstate,prloc,prlat)
	VALUES('$pridowner','$prname','$prdesc','$prprice','$prqty','$prdel','$prstate','$prloc','$prlat')";
	
	if ($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $decoded_string = base64_decode($encoded_string);
    $filename = mysqli_insert_id($conn);
    $path = '../images/products/'.$filename.'.png';
    $is_written = file_put_contents($path, $decoded_string);
	  sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>