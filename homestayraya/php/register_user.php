<?php 
  if (!isset($_POST)){
	  $response = array('status' => 'failed', 'data' => null);
	  sendJsonResponse($response);
	  die();
  } else{
	
	$response = array('status' => 'success', 'data' => null);
	sendJsonResponse($response);
}
 
 include_once ("dbconnect.php");
 
 $email= $_POST['email'];
 $name= $_POST['name'];
 $password= sha1($_POST['password']);
 $phone= $_POST['phone'];
 $address= "na";
 $otp= rand(10000,99999);
 $credit = 20;

 
 $sqlregister = "INSERT INTO `tbl_users`(`user_email`, `user_name`, `user_password`, `user_phone`, `user_address`, `otp`,'user_credit')
 VALUES ('$email','$name','$password','$phone','$address','$otp','$credit')";
 
 try{
 if($conn->query($sqlregister) === TRUE){
	 $response = array ('status' => 'success', 'data' => null);
	 sendJsonResponse($response);
 }else{
	 $response = array('status' => 'failed', 'data' => null);
	 sendJsonResponse($response);
  }
 }
 catch(Exception $e){
	 $response = array('status' => 'failed', 'data' => null);
	 sendJsonResponse ($response);
 }
$conn->close();
  
function sendJsonResponse($sentArray)
{
	  header('Content-Type: application/json');
	  echo json_encode($sentArray);
}

?>