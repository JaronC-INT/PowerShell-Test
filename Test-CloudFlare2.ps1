<#
.SYNOPSIS
Invoke-Command makes it so you can run a command on a remote computer
.DESCRIPTION
Invoke-Command uses a local host to connect to a remote host and runs the command on it and the output comes back to the local host.
.PARAMETER computername
says the name or ip address of the computer
.PARAMETER Output
has you say how you want the files to be outputted
.EXAMPLE
Invoke-Command -Command {Test-NetConnection -ComputerName 1.1.1.1 -InformationLevel Detailed} -AsJob -JobName Net -Session $Session
#>

[CmdletBinding()]
param( [Parameter(Mandatory=$True)]
    $Output = 'Host',
 [Parameter(Mandatory=$True)]
    [string]$Computername,
 [Parameter(Mandatory=$False)]
    [string] $Env:USERPROFILE
)
        Write-Verbose "Connecting to $Computername"
$DateTime = Get-Date
Clear-Host
Set-Location  "C:\PowerShell Test"
<#Getting the IP address of your computer/Receiving the computers Name#>
$Session = New-PSSession -ComputerName $Computername
Invoke-Command -Command {Test-NetConnection -ComputerName one.one.one.one -InformationLevel Detailed} -AsJob -JobName -NetJob -Session $Session
        Write-Verbose "Running the test on $Computername"
<#Starting a command on a remote computer and testing the connection to it by pinging the session to 1.1.1.1 and making it as a job and making sure we receives detailed Information.#>
Start-Sleep -Seconds 10
        Write-Verbose "Receiving test results"     
switch ($Output) {
    "Host" { Receive-Job -Name -NetJob | Out-Host }
    "Text" {
        Write-Verbose "Generating results file"
        Receive-Job -Name -NetJob | Out-File .\JobResults.txt
        Out-File JobResults.txt
        Write-Verbose "Opening results"
        Start-Process notepad -FilePath "C:\PowerShell Test\JobResults.txt" 
        Add-Content -Path .\RemTestNet.txt -Value ($DateTime, $Computername)
        Add-Content -Path .\RemTestNet.txt -Value (Get-Content -Path .\JobResults.txt) 
        Remove-Item .\JobResults.txt
    }
    "CSV"  {
        Write-Verbose "Generating results file"
        Write-Verbose "Opening results"
        Receive-job -Name -NetJob | Export-Csv -Path .\JobResults.csv
    }
    Default {"Not a right output"}
}
Write-Verbose "Finished running tests"
Remove-PSSession -Session $Session