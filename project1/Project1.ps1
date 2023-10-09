Get-WmiObject Win32_LogicalDisk | select DeviceID, @{N="Space Remaining (GB)";E={[math]::round($_.FreeSpace / 1GB)}}

# The purpose of this script is to display remaining disk space 
# I ran the script with the command "powershell .\Project1.ps1" from the file location
# This script outputs a table with each drive on the local computer, and the space remaining on each drive
# For the disk space, I used a byte conversion to display the output in GB. To clean up the long decimal, I rounded the output which i learned about here:
# https://devblogs.microsoft.com/scripting/powertip-use-powershell-to-round-to-specific-decimal-place/
# I used a calculated property to name the column "Space Remaining (GB)" for clarity in the output