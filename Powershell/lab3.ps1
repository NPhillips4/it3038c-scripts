function getIP{
    (get-netipaddress).ipv4address | Select-String "192*" 
} 
$IP = getIP 

$USER = $env:USERNAME

$HOSTNAME = hostname

$SHELLVERSION = $HOST.Version.Major

function getDate{
    Get-Date -Format "dddd, MMMM dd, yyyy"
    }
$DATE = getDate

$BODY = "This machine's IP is $IP. User is $USER. Hostname is $HOSTNAME. PowerShell Version $SHELLVERSION. Today's date is $DATE"

$BODY | out-file C:\lab3.txt