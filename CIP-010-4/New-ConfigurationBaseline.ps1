<#
Author: https://github.com/Suriyawong
Source Code: https://github.com/Suriyawong/CIP/CIP-010-4/New-ConfigurationBaseline.ps1
Revision: 2024.02.22.0019
Description: This cmdlet is intended to generate an HTML report for a Windows-based CIP asset.  The report will include the necessary items required by CIP-010-4 Part 1.1.

DISCLAIMER: This source code is offered free of charge and with no guarantee of accuracy for production use.  Using this code is done at your own risk and liability.

#>

# Require the script to run as administrator to accuratly captcure logical port processes.
#Requires -RunAsAdministrator

[CmdletBinding()]
param (
    # Specifies a path to a directory where the CIP report will be created.
    [Parameter(Mandatory = $false,
        Position = 0,
        #ParameterSetName="ParameterSetName",  # Uncomment if Parameter Sets are implemented.
        ValueFromPipeline = $true,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Path to the report output directory.")]
    [Alias("PSPath")]
    [ValidateNotNullOrEmpty()]
    [string[]]
    $OutputDirectory = "$($PWD | Select-Object -ExpandProperty Path)"
)

begin {
    # Capture date and time at beginning of script execution.
    $datetime = Get-Date
        
    # HTML added in-line to avoid dependency on additional files.
    $html = "<!DOCTYPE html>
        <html>
        <!-- 
                Author: https://github.com/Suriyawong
                Source code: https://github.com/Suriyawong/CIP
                Revision: 2024.02.10.0158
            -->
        
        <head>
            <meta charset='utf-8'>
            <meta http-equiv='X-UA-Compatible' content='IE=edge'>
            <title>REPLACEME_HOSTNAME CIP-010 R1.1</title>
            <meta name='viewport' content='width=device-width, initial-scale=1'>
            <!-- <link rel='stylesheet' type='text/css' media='screen' href='main.css'> -->
            <!-- <script src='main.js'></script> -->
        
            <style>
                header {
                    background-color: darkred;
                    color: whitesmoke;
                    text-align: center;
                    height: auto;
                    width: 100%;
                    margin-top: 5px;
                    margin-bottom: 5px;
                }
        
                h1 {
                    background-color: rgb(13, 68, 70);
                    color: whitesmoke;
                }
        
                body {
                    margin: 3%;
                }
        
                tr,
                td {
                    padding: 3px;
                }
        
                tbody tr:nth-child(even) {
                    background-color: #858585;
                }
        
                tr:hover,
                tbody tr:nth-child(even):hover {
                    background-color: rgb(0, 187, 59);
                }
        
                * {
                    font-family: 'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
                }
            </style>
        
            <header>
                This report was generated automatically using source code from <a href='https://github.com/Suriyawong/CIP'
                    style='color:aquamarine'>https://github.com/Suriyawong/CIP</a>. This source code is offered free of charge
                and with no guarantee of accuracy for production use. Using this code is done at your own risk and liability.
            </header>
        </head>
        
        <body>
            <h1>CIP-010-4 Part 1.1 - Configuration Baseline for REPLACEME_HOSTNAME</h1>
        
            <p>
                Report generated REPLACEME_DATETIME by REPLACEME_USERNAME.
            </p>
        
            <p>
            <h2>Introduction</h2>
            This report is a configuration baseline for CIP-010-4 Part 1.1. It was automatically generated using PowerShell and
            replacing text in a default HTML template. As noted in the header, this source code is offered free of charge and
            with no guarantee of accuracy for production use. Using this code is done at your own risk and liability.
            </p>
        
            <p>
                Per the requirements, this baseline must contain:
            <ul>
                <li>1.1.1. Operating system(s) (including version) or firmware where no independent operating system exists</li>
                <li>1.1.2. Any commercially available or open-source application software (including version) intentionally
                    installed</li>
                <li>1.1.3. Any custom software installed</li>
                <li>1.1.4. Any logical network accessible ports</li>
                <li>1.1.5. Any security patches applied</li>
            </ul>
            </p>
        
            <h2>Requirements</h2>
            <p>
            <h3>1.1.1. Operating system(s) (including version) or firmware where no independent operating system exists</h3>
            REPLACEME_OPERATINGSYSTEM
            </p>
        
            <p>
            <h3>1.1.2 and 1.1.3 - Any commercially available or open-source application software (including version)
                intentionally installed AND any custom software installed</h3>
            REPLACEME_SOFTWARE
            </p>
        
            <p>
            <h3>1.1.4. Any logical network accessible ports</h3>
            REPLACEME_LOGICALPORTS
            </p>
        
            <p>
            <h3>1.1.5. Any security patches applied</h3>
            REPLACEME_HOTFIXES
            </p>
        
            <p>
                This concludes the report for REPLACEME_HOSTNAME.
            </p>
        </body>
        
        </html>"
}
    
process {
    # Replace REPLACEME_DATETIME with current date and time (Get-Date)
    $html = $html.Replace("REPLACEME_DATETIME", "$datetime")

    # Replace REPLACEME_HOSTNAME with $env:COMPUTERNAME
    $html = $html.Replace("REPLACEME_HOSTNAME", "$($env:COMPUTERNAME)")

    ## Replace REPLACEME_USERNAME with username info
    # If the machine is domain-joined and the ActiveDirectory module is installed, include DisplayName
    if ((Get-CimInstance Win32_ComputerSystem | Select-Object -ExpandProperty PartOfDomain) -eq $true -and (Get-Module ActiveDirectory)) {
        $userDisplayName = Get-ADUser -Identity ((whoami.exe).Split("\"))[-1] | Select-Object -ExpandProperty DisplayName
        $html = $html.Replace("REPLACEME_USERNAME", "$(whoami.exe) ($userDisplayName)")
    }
        
    # Else, use $env:USERNAME
    else {
        $html = $html.Replace("REPLACEME_USERNAME", "$($env:USERNAME)")
    }


    ## Get OS name and version and replace REPLACEME_OPERATINGSYSTEM
    $html = $html.Replace("REPLACEME_OPERATINGSYSTEM", "$(Get-CimInstance Win32_OperatingSystem | Select-Object Caption,Version | ConvertTo-Html -Fragment)")

    ## Get all installed software and replace REPLACEME_SOFTWARE.  NOTE: This does not capture standalone executables, only installed software
    $html = $html.Replace("REPLACEME_SOFTWARE", "$(Get-CimInstance Win32_Product | Select-Object Vendor, Name, Version, InstallDate | Sort-Object Vendor, Name, Version, InstallDate | ConvertTo-Html -Fragment)")


    ## Get all listening TCP and UDP ports and replace REPLACEME_LOGICALPORTS
    $ports = @()

    # Get TCP ports and add to collection
    $tcpports = Get-NetTCPConnection -State Listen | Select-Object LocalAddress, LocalPort, OwningProcess
    foreach ($port in $tcpports) { 
        $port | Add-Member -MemberType NoteProperty -Name "Protocol" -Value "TCP" 
        $port | Add-Member -MemberType NoteProperty -Name "Process" -Value "$(Get-Process -Id $port.OwningProcess | Select-Object -ExpandProperty Path)"
        $ports += $port
    }

    # Get UDP ports and add to collection
    $udpports = Get-NetUDPEndpoint | Select-Object LocalAddress, LocalPort, OwningProcess
    foreach ($port in $udpports) { 
        $port | Add-Member -MemberType NoteProperty -Name "Protocol" -Value "UDP"
        $port | Add-Member -MemberType NoteProperty -Name "Process" -Value "$(Get-Process -Id $port.OwningProcess | Select-Object -ExpandProperty Path)"
        $ports += $port
    }

    # Replace the REPLACEME_LOGICALPORTS placeholder with the collection
    $html = $html.Replace("REPLACEME_LOGICALPORTS", "$($ports | Sort-Object LocalPort, Protocol | ConvertTo-Html -Fragment)")


    ## Get all Windows hotfixes and replace REPLACEME_HOTFIXES
    $html = $html.Replace("REPLACEME_HOTFIXES", "$(Get-HotFix | Select-Object HotFixID, Description, InstalledOn | Sort-Object InstalledOn, Description, HotfixID | ConvertTo-Html -Fragment )")

}
    
end {
    ## Output html to a new HTML report file in the supplied target.
    $html | Out-File "$OutputDirectory\CIP-010-4.$($env:COMPUTERNAME).$($datetime | Get-Date -UFormat "%Y.%m.%d.%H%M").html"

    if (Test-Path "$OutputDirectory\CIP-010-4.$($env:COMPUTERNAME).$($datetime | Get-Date -UFormat "%Y.%m.%d.%H%M").html") {
        Write-Host "Report successfully created. Open $OutputDirectory\CIP-010-4.$($env:COMPUTERNAME).$($datetime | Get-Date -UFormat '%Y.%m.%d.%H%M').html in your browser." -ForegroundColor Green
    }
}