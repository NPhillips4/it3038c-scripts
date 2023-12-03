# Final Project

These are instructions/documentation on my script using the Powershell module Carbon. <br>
Start by installing Carbon from the Powershell Gallery. This requires Nuget, which will be prompted to install if it isn't already.
```powershell
 Install-Module -Name 'Carbon' -AllowClobber
```
To run the script, run PowerShell as administrator and execute the file
```powershell
Path\to\file\Project3.ps1
```
If you want to use PowerShell ISE, run it as administrator and open the file within the program.<br> 
First, the module is added to the script 
```powershell
Import-Module 'Carbon'
```
When running the script, the user is prompted to select one of the eight functions of the script: Create user, add member to group, delete user, install basic programs, join a domain, open uc.edu at login, set File Explorer to view hidden files and file name extensions, add a network printer, and exit program. This script has error handling, if your prompt is invalid it should tell you why, then return to the main menu.
```powershell
Write-Host "What would you like to do? `n1) Create a new user `n2) Add a user to a group `n3) Delete a user `n4) Install basic programs on this computer`n5) Join a Domain and restart the machine `n6) Open uc.edu on login `n7) Set File Explorer to view hidden items and file name extensions `n8) Add a network printer `n9) Exit the program"
$optionSelect = Read-Host "Enter a number (1-9)"
```
For the "Create user" function, enter "1". Then answer the prompts for a username, password, and user description. The username and password are used to create a credential. The credential and description are then used to create a local user. 
```powershell
$userName = Read-Host "Username"
$pass = Read-Host "Password"
$desc = Read-Host "User Description"
$cred = New-CCredential -User $userName -Password $pass
Install-CUser -Credential $cred -Description $desc
Write-Host "User $userName has been created `n------------------------------------------------"  
```
Option "2" will allow for adding a member to a local group. Answering the prompts for the desired user and existing group name will add the member.
```powershell
$userName = Read-Host "Enter the username you would like to add to a group"
$groupName = Read-Host "Enter the Group you would like to add the member to"
Add-CGroupMember -Name $groupName -Member $userName
Write-Host "User $userName has been added to $groupName `n------------------------------------------------"
```
Option "3" will allow a user to be deleted from the system. After prompting for a username, the user will then be removed as a local user.
```powershell
$userName = Read-Host "Enter Username to delete from the system"
Uninstall-CUser -Username $userName
Write-Host "User $userName has been deleted `n------------------------------------------------"
```
Option "4" will run an .exe file to install basic programs on your computer. The script is set up for my personal network, where I have a bundled .exe file that installs Firefox, 7zip, Java Runtime, and Microsoft.NET 4.8. This file is on a network share so I can run it from any machine on my network. If you are using this script for yourself, the path needs to be changed to your desired file(s).
```powershell
\\DESKTOP-PKHN0QU\InstallationSoftware\ninite.exe
Write-Host "------------------------------------------------"
```
Option "5" will prompt the user for a domain to add their local computer to. When the correct credentials are entered, the machine is then restarted to apply the changes. This option is difficult to test without access to a domain.
```powershell
$domainName = Read-Host "Enter the name of the Domain you would like to join"
Add-Computer -DomainName $domainName -restart
```
Option "6" will schedule a task to open Firefox and navigate to uc.edu when a user logs in to the system. Strings are used to define the different parameters of the task: New-ScheduledTaskAction, New-ScheduledTaskTrigger, etc. These strings are then used to create and register the task with the name "UCedu"
```powershell
$action = New-ScheduledTaskAction -Execute "C:\Program Files\Mozilla Firefox\firefox.exe" -Argument "https://www.uc.edu/"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet
$task = New-ScheduledTask -Action $action -Trigger $trigger -Settings $settings
Register-ScheduledTask UCedu -InputObject $task
Write-Host "The task has been created. uc.edu will now automatically open at login `n------------------------------------------------"

```
Option "7" will change registry keys for File Explorer. The updated keys will allow the user to see file name extensions and hidden files. File Explorer is then restarted to apply the changes.
```powershell
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Value 1
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Value 0
Stop-Process -Name explorer -Force
Write-Host "Your Settings Have Been Changed `n------------------------------------------------"
```
Option "8" will add a network printer from the prompted location
```powershell
$printerLocation = Read-Host "What is your printer's location? (ex: \\Server\Printer)"
Add-Printer -ConnectionName $printerLocation
Write-Host "------------------------------------------------`nYour printer has been added. `n------------------------------------------------"
```
Option "9" will end the while loop and exit the script.
### How is this script useful?
This script is intended to aid in the process of setting up new computers by adding many potentially useful functions all in one place. It could be used in the home to speed up a new machine's setup, or for companies setting up computers for employees. This script can be easily customized to fit the needs of a person or company. Functions can be added and removed at will.

### Sources:<br>
I used Carbon's documentation to help with options 1-3 https://get-carbon.org/documentation.html<br>
I also used Microsoft's resource to learn the syntax and parameters for task scheduling https://learn.microsoft.com/en-us/powershell/module/scheduledtasks/new-scheduledtask?view=windowsserver2022-ps<br>
Learned about the Add-Computer command here https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-computer?view=powershell-5.1




