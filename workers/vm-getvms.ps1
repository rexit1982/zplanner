#!/usr/bin/pwsh

$Config = "/home/zerto/include/config.txt"
$Key = (3,4,2,3,56,34,254,222,1,1,2,23,42,54,33,233,1,34,2,7,6,5,35,43)
$env = get-content $Config | out-string | convertFrom-StringData
$env.password = $env.password | convertto-securestring -Key $Key
$mycreds = New-Object System.Management.Automation.PSCredential ($env.username, $env.password)
$session = Connect-VIServer -Server $env.vcenter -Credential $mycreds

Write-Host "Generating list of all VMs in vCenter."
Get-VM -Name * | Select Name | ConvertTo-Csv | Select -Skip 1 | Out-File /home/zerto/data/all-vms.csv
Write-Host "All-VM List Generation Compeleted"

Write-Host "Updating VM list in Database"
/usr/bin/php /home/zerto/zplanner/loaders/loadvms.php

if ( $env.tag){
$tag = get-tag $env.tag
Write-Host "Tag based targeting defined, fetching list of tagged VMs"
Get-VM -Name * -Tag $tag | Select Name | ConvertTo-Csv | Select -Skip 1 | Out-File /home/zerto/data/tagged-vms.csv
Write-Host "Tagged VM List Generation Compeleted"
Write-Host "Re-writing monitored flag on VMs with tag"
/usr/bin/php /home/zerto/zplanner/loaders/loadtagmonitoredvms.php
}