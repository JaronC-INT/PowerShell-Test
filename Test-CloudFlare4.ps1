<#

.SYNOPSIS

Testes the connection to one.one.one.ome
.DESCRIPTION

TestNetConnection will test to see if you can access one.one.one.one.
.PARAMETER computername

says the name or ip address of the computer
.PARAMETER Path

goes to where the output will be saved
.PARAMETER Output

has you say how you want the files to be outputted

.NOTES

Author: Jaron Cowley
Last Modified: 11/11/2020
Verison:3

.EXAMPLE

Test-NetConnection -ComputerName 1.1.1.1 -InformationLevel Detailed | Out-File .txt or .csv
.EXAMPLE

Test-NetConnection -ComputerName 172.16.1.95 -InformationLevel Detailed
#>

[CmdletBinding()]  
param ([Parameter(Mandatory=$True)]
    [string]$Computername,
[Parameter(Mandatory=$False)]
    [string] $Path = "$Env:USERPROFILE",
  [Parameter(Mandatory=$True)]
    [string]$Output = 'host'
)

$DateTime = Get-Date
Clear-Host
Set-Location  "C:\PowerShell Test"

#Getting the IP address of your computer/Receiving the computers Name
$Session = New-PSSession -ComputerName $Computername
        Write-Verbose "Connecting to $Computername"

#Starting a command on a remote computer and testing the connection to it by pinging the session to 1.1.1.1 and making it as a job and making sure we receives detailed Information.
Invoke-Command -Command {Test-NetConnection -ComputerName one.one.one.one -InformationLevel Detailed} -AsJob -JobName NetJob -Session $Session
        Write-Verbose "Running the test on $Computername"

Start-Sleep -Seconds 10
        Write-Verbose "Receiving test results"    

switch ($Output) {
    'Host' {
        #writes it to the terminal
        Receive-Job NetJob }
    'Text' {
        #Writes to a text file
        Write-Verbose "Generating results file"
        Receive-Job  NetJob | Out-File .\JobResults.txt
        Write-Verbose "Opening results" 
        Add-Content  .\RemTestNet.txt -Value ($DateTime, $Computername)
        Add-Content  .\RemTestNet.txt -Value (Get-Content -Path .\JobResults.txt) 
        notepad .\RemTestNet.txt
    }
    'CSV'  {
        #Writes to a csv file
        Write-Verbose "Generating results file"
        Write-Verbose "Opening results"
        Receive-job -Name NetJob | Export-Csv -Path .\RemTestNet.txt
    }
    Default {"$Output isn't a valid option"}
}
Write-Verbose "Finished running tests"
Remove-Item .\JobResults.txt
Remove-PSSession -Session $Session
