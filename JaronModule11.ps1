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
         $Session = New-PSSession -ComputerName $Computername
         Enter-PSSession $Session
         $DateTime = Get-Date
         $TestCF = Test-NetConnection -ComputerName one.one.one.one -InformationLevel Detailed 
         $Props = @{
             'ComputerName' = $Computer
             'PingSuccess' = $TestCF.TcpTestSucceeded
             'NameResolve' = $TestCF.NameResolutionSucceeded
             'ResolvedAddresses' = $TestCF.ResolvedAddresses}
         $OBJ = New-Object -TypeName PSObject -Property $Props
         Exit-PSSession
         Remove-PSSession -Session $Session
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
