function getIP{
(get-netipaddress).ipv4address | select-string "192*"
}
$IP = getIP
Write-Host("This machine's IP is $IP")