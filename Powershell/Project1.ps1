﻿Get-WmiObject Win32_LogicalDisk | select DeviceID, @{N="Space Remaining (GB)";E={[int]($_.FreeSpace /1GB)}}