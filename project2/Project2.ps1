Import-Module 'Carbon'

Write-Host "What would you like to do? `n1) Create a new user `n2) Add a user to a group `n3) Delete a user `n4) Install basic msi files on this computer `n5) Open uc.edu on login `n6) Exit the program"
$optionSelect = Read-Host "Enter a number (1-6)"

while($optionSelect -ne 6)
{
    if ($optionSelect -eq 1)
    {
        $userName = Read-Host "Username"
        $pass = Read-Host "Password"
        $desc = Read-Host "User Description"
        $cred = New-CCredential -User $userName -Password $pass
        Install-CUser -Credential $cred -Description $desc
        Write-Host "User $userName has been created `n------------------------------------------------"  

    }

    elseif ($optionSelect -eq 2)
    {
        $userName = Read-Host "Enter the username you would like to add to a group"
        $groupName = Read-Host "Enter the Group you would like to add the member to"
        Add-CGroupMember -Name $groupName -Member $userName
        Write-Host "User $userName has been added to $groupName `n------------------------------------------------"
    }

    elseif ($optionSelect -eq 3)
    {
        $userName = Read-Host "Enter Username to delete from the system"
        Uninstall-CUser -Username $userName
        Write-Host "User $userName has been deleted `n------------------------------------------------"
    }

    elseif ($optionSelect -eq 4)
    {
        \\DESKTOP-PKHN0QU\InstallationSoftware\ninite.exe
        Write-Host "------------------------------------------------"
    }
    
    elseif ($optionSelect -eq 5)
    {
        $action = New-ScheduledTaskAction -Execute "C:\Program Files\Mozilla Firefox\firefox.exe" -Argument "https://www.uc.edu/"
        $trigger = New-ScheduledTaskTrigger -AtLogOn
        $settings = New-ScheduledTaskSettingsSet
        $task = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings
        Register-ScheduledTask UCedu -InputObject $task

        Write-Host "The task has been created. uc.edu will now automatically open at login `n------------------------------------------------"
    }
    
    Write-Host "What would you like to do? `n1) Create a new user `n2) Add a user to a group `n3) Delete a user `n4) Install basic msi files on this computer `n5) Open uc.edu on login `n6) Exit the program"
    $optionSelect = Read-Host "Enter a number (1-6)"
}

