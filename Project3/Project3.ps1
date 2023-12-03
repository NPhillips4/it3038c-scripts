Import-Module 'Carbon'

#numbered list of functions for the script. Users can select a function with the cooresponding number
Write-Host "What would you like to do? `n1) Create a new user `n2) Add a user to a group `n3) Delete a user `n4) Install basic programs on this computer `n5) Join a Domain and restart the machine `n6) Open uc.edu on login `n7) Set File Explorer to view hidden items and file name extensions `n8) Add a network printer `n9) Exit the program"
$optionSelect = Read-Host "Enter a number (1-9)"

while($optionSelect -ne 9)
{
    if ($optionSelect -eq 1)
    {
        try {
        #prompts for username, password, and user description for user creation
            $userName = Read-Host "Username"
            $pass = Read-Host "Password"
            $desc = Read-Host "User Description"
            $cred = New-CCredential -User $userName -Password $pass
            Install-CUser -Credential $cred -Description $desc
            Write-Host "------------------------------------------------`nUser $userName has been created `n------------------------------------------------"  
            }
        catch {
            Write-Host $_.Exception.Message -ForegroundColor Red
        }
    }

    elseif ($optionSelect -eq 2)
    {
        try {
        #adds existing user to a specified group
            $userName = Read-Host "Enter the username you would like to add to a group"
            $groupName = Read-Host "Enter the Group you would like to add the member to"
            Add-CGroupMember -Name $groupName -Member $userName
            Write-Host "------------------------------------------------`nUser $userName has been added to $groupName `n------------------------------------------------"
            }
        catch {
            Write-Host $_.Exception.Message -ForegroundColor Red
            }
    }

    elseif ($optionSelect -eq 3)
    {
        try {
        #deletes specified user from system, use with caution
            $userName = Read-Host "Enter Username to delete from the system"
            Uninstall-CUser -Username $userName
            Write-Host "------------------------------------------------`nUser $userName has been deleted `n------------------------------------------------"
            }
        catch {
            Write-Host $_.Exception.Message -ForegroundColor Red
            }
    }

    elseif ($optionSelect -eq 4)
    {
        try {
        #Installs custom software package from shared drive, Change the path to the location of your file
            \\DESKTOP-PKHN0QU\InstallationSoftware\ninite.exe
            Write-Host "------------------------------------------------"
            }
        catch {
            Write-Host $_.Exception.Message -ForegroundColor Red
            }
    }

    elseif ($optionSelect -eq 5)
    {
        try {
        #joins a domain with the local computer, then restarts machine to apply changes
            $domainName = Read-Host "Enter the name of the Domain you would like to join"
            Add-Computer -DomainName $domainName -restart
            }
        catch {
            Write-Host $_.Exception.Message -ForegroundColor Red
            }
    }
    
    elseif ($optionSelect -eq 6)
    {
        try {
        #creates a task to launch www.uc.edu at login via firefox
            $action = New-ScheduledTaskAction -Execute "C:\Program Files\Mozilla Firefox\firefox.exe" -Argument "https://www.uc.edu/"
            $trigger = New-ScheduledTaskTrigger -AtLogOn
            $settings = New-ScheduledTaskSettingsSet
            $task = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings
            Register-ScheduledTask UCedu -InputObject $task

            Write-Host "------------------------------------------------`nThe task has been created. uc.edu will now automatically open at login `n------------------------------------------------"
            }
        catch {
            Write-Host $_.Exception.Message -ForegroundColor Red
            }
    }

    elseif ($optionSelect -eq 7)
    {
        try {
        #Changes registry keys for hidden files and file extensions, then restarts File Explorer
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value 1
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 0
            Stop-Process -Name explorer -Force
            Write-Host "------------------------------------------------`nYour File Explorer Settings Have Been Changed `n------------------------------------------------"
            }
        catch {
            Write-Host $_.Exception.Message -ForegroundColor Red
            }
    }

    elseif ($optionSelect -eq 8)
    {
        try {
        #input a printer location to add a network printer
            $printerLocation = Read-Host "What is your printer's location? (ex: \\Server\Printer)"
            Add-Printer -ConnectionName $printerLocation
            Write-Host "------------------------------------------------`nYour printer has been added. `n------------------------------------------------"
            }
        catch {
            Write-Host $_.Exception.Message -ForegroundColor Red
            }
    }
    
    Write-Host "What would you like to do? `n1) Create a new user `n2) Add a user to a group `n3) Delete a user `n4) Install basic programs on this computer `n5) Join a Domain and restart the machine `n6) Open uc.edu on login `n7) Set File Explorer to view hidden items and file name extensions `n8) Add a network printer `n9) Exit the program"
    $optionSelect = Read-Host "Enter a number (1-9)"
}

Write-Host "Exiting the program"

