<<<<<<< HEAD
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
-Text
-Host
-CSV
has you say how you want the files to be outputted

.NOTES
Author: Jaron Cowley
Last Modified: 11/13/2020
Verison:3   -Computername can now handle pipeline input
            -Added a set validation 
            -Added a for loop
            -Changed the Output switch

.EXAMPLE

Test-CloudFlare -ComputerName $ComputerName | Outfile .txt/.csv/host
.EXAMPLE

Test-NetConnection -ComputerName 172.16.1.95 -InformationLevel Detailed
.EXAMPLE

Test-CloudFlare -Computername '192.168.1.203' -output Text
#>
function Test-CloudFlare {
    param (
        [Parameter(ValueFromPipeline=$True,
               Mandatory=$True) ]
               [Alias('CN','Name')]
               [string[]]$Computername,
        [Parameter(Mandatory=$false)]
               [ValidateSet('Text', 'Host', 'CSV')]
               [string]$Output = 'Host',
        [Parameter(Mandatory=$False)]
               [string]$Path = "$Env:USERPROFILE"    
    ) #Param
    foreach ($Computer in $Computername) {
         $DateTime = Get-Date
         $TestCF = Test-NetConnection -ComputerName one.one.one.one -InformationLevel Detailed 
    try {
       $Params = @{
           'ComputerName'=$Computer
           'ErrorAction'='Stop'
       }
       $Session = New-PSSession -ComputerName @Params
        Enter-PSSession $Session
        Exit-PSSession
        Remove-PSSession -Session $Session
       $OBJ = [PSCustomObject]@{
        'ComputerName' = $Computer
        'PingSuccess' = $TestCF.TcpTestSucceeded
        'NameResolve' = $TestCF.NameResolutionSucceeded
        'ResolvedAddresses' = $TestCF.ResolvedAddress
        }
    }#try
    catch {
        Write-Host "Remote connection to $ComputerName failed." -ForegroundColor Red
    }#Catch
}
#Foreach
switch ($Output) {
    "Host" { 
        #Displays it into the terminal
        $OBJ }
    "Text" {
        #Displays it into a text file
        Write-Verbose "Generating results file"
        $OBJ| Out-File .\JobResults.txt
        Write-Verbose "Opening results"
        Add-Content -Path "$Path.\RemTestNet.txt" -Value "Date/Time Tested: $DateTime"
        Add-Content -Path "$Path.\RemTestNet.txt" -Value "Computer Tested: $Computername"
        Add-Content -Path "$Path.\RemTestNet.txt" -Value (Get-Content -Path .\JobResults.txt) 
        notepad "$Path.\RemTestNet.txt"
        Remove-Item .\JobResults.txt
    }
    "CSV"  {
        #Displays it in a CSV file
        Write-Verbose "Generating results file"
        Write-Verbose "Opening results"
         $OBJ | Export-Csv -Path .\TestResults.csv
        }
    }#Switch
}#Function
=======
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
-Text
-Host
-CSV
has you say how you want the files to be outputted

.NOTES
Author: Jaron Cowley
Last Modified: 11/13/2020
Verison:3   -Computername can now handle pipeline input
            -Added a set validation 
            -Added a for loop
            -Changed the Output switch

.EXAMPLE

Test-CloudFlare -ComputerName $ComputerName | Outfile .txt/.csv/host
.EXAMPLE

Test-NetConnection -ComputerName 172.16.1.95 -InformationLevel Detailed
.EXAMPLE

Test-CloudFlare -Computername '192.168.1.203' -output Text
#>
function Test-CloudFlare {
    param (
        [Parameter(ValueFromPipeline=$True,
               Mandatory=$True) ]
               [Alias('CN','Name')]
               [string[]]$Computername,
        [Parameter(Mandatory=$false)]
               [ValidateSet('Text', 'Host', 'CSV')]
               [string]$Output = 'Host',
        [Parameter(Mandatory=$False)]
               [string]$Path = "$Env:USERPROFILE"    
    ) #Param
    foreach ($Computer in $Computername) {
         $DateTime = Get-Date
         $TestCF = Test-NetConnection -ComputerName one.one.one.one -InformationLevel Detailed 
    try {
       $Params = @{
           'ComputerName'=$Computer
           'ErrorAction'='Stop'
       }
       $Session = New-PSSession -ComputerName @Params
        Enter-PSSession $Session
        Exit-PSSession
        Remove-PSSession -Session $Session
       $OBJ = [PSCustomObject]@{
        'ComputerName' = $Computer
        'PingSuccess' = $TestCF.TcpTestSucceeded
        'NameResolve' = $TestCF.NameResolutionSucceeded
        'ResolvedAddresses' = $TestCF.ResolvedAddress
        }
    }#try
    catch {
        Write-Host "Remote connection to $ComputerName failed." -ForegroundColor Red
    }#Catch
}
#Foreach
switch ($Output) {
    "Host" { 
        #Displays it into the terminal
        $OBJ }
    "Text" {
        #Displays it into a text file
        Write-Verbose "Generating results file"
        $OBJ| Out-File .\JobResults.txt
        Write-Verbose "Opening results"
        Add-Content -Path "$Path.\RemTestNet.txt" -Value "Date/Time Tested: $DateTime"
        Add-Content -Path "$Path.\RemTestNet.txt" -Value "Computer Tested: $Computername"
        Add-Content -Path "$Path.\RemTestNet.txt" -Value (Get-Content -Path .\JobResults.txt) 
        notepad "$Path.\RemTestNet.txt"
        Remove-Item .\JobResults.txt
    }
    "CSV"  {
        #Displays it in a CSV file
        Write-Verbose "Generating results file"
        Write-Verbose "Opening results"
         $OBJ | Export-Csv -Path .\TestResults.csv
        }
    }#Switch
}#Function
>>>>>>> d1cefd762f3a7c9052ff651bdc3e44cec50c7009
