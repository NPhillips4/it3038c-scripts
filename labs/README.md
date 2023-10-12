# Lab 7

These are instructions on how to run my script using the Powershell module Carbon.
Start by installing Carbon from the Powershell Gallery. This requires Nuget, which will be prompted to install if it isn't already.
```powershell
 Install-Module -Name 'Carbon' -AllowClobber
```
First, the module is added to the script 
```powershell
Import-Module 'Carbon'
```
When running the script, the user is prompted to select one of the three functions of the script: Create user, add member to group, and delete user.
```powershell
Write-Host "What would you like to do? `n1) Create a new user `n2) Add a user to a group `n3) Delete a user"
$optionSelect = Read-Host "Enter a number (1-3)"
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

}
```
Entering "2" will allow for adding a member to a local group. Answering the prompts for the desired user and existing group name will add the member.
```powershell
elseif ($optionSelect -eq 2)
{
    $userName = Read-Host "Enter the username you would like to add to a group"
    $groupName = Read-Host "Enter the Group you would like to add the member to"
    Add-CGroupMember -Name $groupName -Member $userName
}
```
Entering "3" will allow a user to be deleted from the system. After prompting for a username, the user will then be removed as a local user.
```powershell
elseif ($optionSelect -eq 3)
{
    $userName = Read-Host "Enter Username to delete from the system"
    Uninstall-CUser -Username $userName
}
```



