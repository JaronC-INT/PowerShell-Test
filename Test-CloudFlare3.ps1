<#
.SYNOPSIS
Invoke-Command makes it so you can run a command on a remote computer
.DESCRIPTION
Invoke-Command uses a local host to connect to a remote host and runs the command on it and the output comes back to the local host.
.PARAMETER -Command
specifies which commands to run in the invoke-command
.PARAMETER -asjob
Makes it run as a background job
.PARAMETER -Session
Goes into the remote session
.EXAMPLE
Invoke-Command -Command {Test-NetConnection -ComputerName 1.1.1.1 -InformationLevel Detailed} -AsJob -JobName Net -Session $Session

.SYNOPSIS
test-NetConnection Tests your connection to the Network
.DESCRIPTION
Using a ping test in order to see if you can connect to the specific network
.PARAMETER -Computername
Specifies what computer/ipaddress we are pinging
.PARAMETER -InformationLevel
Says what level of informatin you want, Detailed or quiet
.EXAMPLE
Test-NetConnection -ComputerName one.one.one.one -InformationLevel Detailed
#>

param (
    $Path = 'c:\PowerShell Test\'
)
Clear-Host
Set-Location $Path
$Computername = Read-Host "Please enter the Name or IP Address of the remote computer you wish the test"
<#Getting the IP address of your computer/Receiving the computers Name#>
$Sessions = New-PSSession -ComputerName $Computername
Invoke-Command -Command {Test-NetConnection -ComputerName one.one.one.one -InformationLevel Detailed} -AsJob -JobName NetJob -Session $Sessions
<#Starting a command on a remote computer and testing the connection to it by pinging the session to 1.1.1.1 and making it as a job and making sure we receives detailed Information.#>
Start-Sleep -Seconds 10
Receive-Job -Name NetJob | Out-File ReceiveNetJob.txt
Start-Process notepad -FilePath "C:\PowerShell Test\ReceiveNetJob.txt"
Remove-PSSession -Session $Sessions
