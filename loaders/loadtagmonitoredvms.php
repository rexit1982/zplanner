<?php
$data = [];
$csvfile = "/home/zerto/data/tagged-vms.csv";

//connect to the database
$connect = mysqli_connect("localhost","root","Zertodata1!");
mysqli_select_db($connect,"zerto"); //select the table


if (file_exists($csvfile) && filesize($csvfile) > 0) {
	
		//get the csv file
		$handle = fopen($csvfile,"r");
	
		//loop through the csv file and insert into database
	echo "Row Data \n";
	
	mysqli_query($connect, "UPDATE `vms` SET `monitor` = 'N' WHERE `monitor` = 'Y'") or die(mysqli_error($connect));
	
	while ($data = fgetcsv($handle,1000, ",", '"')) {
		echo $data[0] . "\n";
		mysqli_query($connect, "UPDATE `vms` set `monitor` = 'Y' where `name` = '$data[0]'");
	}
}
?>
