<?php
	# below does all the cookie managment for the session
        session_start(); # must be at the start of the script

	# if 'count' is not in the session, it will be after this
        if(!isset($_SESSION['count'])){
		$_SESSION['count']=0;
	}

	$_SESSION['count']=$_SESSION['count']+1;
?>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>Count</title>
	</head>
	<body>
		<h1>Count</h1>
		You have been here <?php echo($_SESSION["count"]); ?> times.
	</body>
</html>
