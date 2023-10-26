# Project 2

These are instructions/documentation on my script using the Powershell module Carbon.
Start by installing Carbon from the Powershell Gallery. This requires Nuget, which will be prompted to install if it isn't already.
```powershell
 Install-Module -Name 'Carbon' -AllowClobber
```
To run the script, run PowerShell as administrator and execute the file
```powershell
Path\to\file\Project2.ps1
```
First, the module is added to the script 
```powershell
Import-Module 'Carbon'
```
When running the script, the user is prompted to select one of the six functions of the script: Create user, add member to group, delete user, Install basic programs, open uc.edu at login, and exit program.
```powershell
Write-Host "What would you like to do? `n1) Create a new user `n2) Add a user to a group `n3) Delete a user `n4) Install basic programs on this computer `n5) Open uc.edu on login `n6) Exit the program"
$optionSelect = Read-Host "Enter a number (1-6)"
```
For the "Create user" function, enter "1". Then answer the prompts for a username, password, and user description. The username and password are used to create a credential. The credential and description are then used to create a local user. 
```powershell
if ($optionSelect -eq 1)
{
    $userName = Read-Host "Username"
    $pass = Read-Host "Password"
    $desc = Read-Host "User Description"
    $cred = New-CCredential -User $userName -Password $pass
    Install-CUser -Credential $cred -Description $desc
    Write-Host "User $userName has been created `n------------------------------------------------"
}
```
Entering "2" will allow for adding a member to a local group. Answering the prompts for the desired user and existing group name will add the member.
```powershell
elseif ($optionSelect -eq 2)
{
    $userName = Read-Host "Enter the username you would like to add to a group"
    $groupName = Read-Host "Enter the Group you would like to add the member to"
    Add-CGroupMember -Name $groupName -Member $userName
    Write-Host "User $userName has been added to $groupName `n------------------------------------------------"
}
```
Entering "3" will allow a user to be deleted from the system. After prompting for a username, the user will then be removed as a local user.
```powershell
elseif ($optionSelect -eq 3)
{
    $userName = Read-Host "Enter Username to delete from the system"
    Uninstall-CUser -Username $userName
    Write-Host "User $userName has been deleted `n------------------------------------------------"
}
```
Entering "4" will run an .exe file to install basic programs on your computer. The script is set up for my personal network, where I have a bundled .exe file that installs Firefox, 7zip, Java Runtime, and Microsoft.NET 4.8. This file is on a network share so I can run it from any machine on my network. If you are using this script for yourself, the path needs to be changed to your desired file(s).
```powershell
elseif ($optionSelect -eq 4)
    {
        \\DESKTOP-PKHN0QU\InstallationSoftware\ninite.exe
        Write-Host "------------------------------------------------"
    }
```
Entering "5" will schedule a task to open Firefox and navigate to uc.edu when a user logs in to the system. Strings are used to define the different parameters of the task: New-ScheduledTaskAction, New-ScheduledTaskTrigger, etc. These strings are then used to create and register the task with the name "UCedu"
```powershell
elseif ($optionSelect -eq 5)
    {
        $action = New-ScheduledTaskAction -Execute "C:\Program Files\Mozilla Firefox\firefox.exe" -Argument "https://www.uc.edu/"
        $trigger = New-ScheduledTaskTrigger -AtLogOn
        $settings = New-ScheduledTaskSettingsSet
        $task = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings
        Register-ScheduledTask UCedu -InputObject $task

        Write-Host "The task has been created. uc.edu will now automatically open at login `n------------------------------------------------"
    }
```
Entering "6" will end the while loop and exit the script.

Sources:
I used Carbon's documentation to help with options 1-3 https://get-carbon.org/documentation.html
I also used Microsoft's resource to learn the syntax and parameters for task scheduling https://learn.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtask?view=windowsserver2022-ps




