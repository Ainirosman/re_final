<?php

if(!isset($_GET)){
	$response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
	die();
}
	include_once("dbconnect.php");
	$user_id = $_GET['user_id'];
	
	$sqlloadproduct = "SELECT * FROM tbl_products WHERE user_id = '$user_Id' 
	ORDER BY prdate DESC";
	$result = $conn->query($sqlloadproduct);
	
	if ($result->num_rows > 0) {
    $homestaysarray["products"] = array();
	while ($row = $result->fetch_assoc()) {
        $prlist = array();
        $prlist['prid'] = $row['prid'];
        $prlist['user_id'] = $row['user_id'];
        $prlist['prname'] = $row['prname'];
        $prlist['prdesc'] = $row['prdesc'];
        $prlist['prprice'] = $row['prprice'];
        $prlist['praddress'] = $row['praddress'];
        $prlist['prstate'] = $row['prstate'];
        $prlist['prloc'] = $row['prloc'];
        $prlist['prlat'] = $row['prlat'];
        $prlist['prlong'] = $row['prlong'];
        $prlist['prdate'] = $row['prdate'];
        array_push($homestaysarray["products"],$prlist);
    }
    $response = array('status' => 'success', 'data' => $homestaysarray);
    sendJsonResponse($response);
}else{
     $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>