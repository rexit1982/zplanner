#!/usr/bin/pwsh
# Step one script

$Key = (3,4,2,3,56,34,254,222,1,1,2,23,42,54,33,233,1,34,2,7,6,5,35,43)

#Get Site vCenter Information
$vcenter = read-host -Prompt 'Enter vCenter IP Address'
$user = read-host -Prompt 'Enter vCenter Username'
$pass = read-host -assecurestring -Prompt 'Enter vCenter password' | convertfrom-securestring -Key $Key

$vcenter = "vcenter="+$vcenter
$vcenter | out-file /home/zerto/include/config.txt

$user = "username="+$user
$user | out-file /home/zerto/include/config.txt -Append

$pass = "password="+$pass
$pass | out-file /home/zerto/include/config.txt -Append

$reply = Read-Host -Prompt "Would you like to automatically monitor VMs based on a tag?[y/n]"
if ( $reply -match "[yY]" ) {
    $tag = "tag="+$tag
	$tag | out-file /home/zerto/include/config.txt -Append
	Write-Host "Changes made to the monitored VM list will be overwritten based on the tag $tag"
}

Write-Host "Information Written to Configuration files"
