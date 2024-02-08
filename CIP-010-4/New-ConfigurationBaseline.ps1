<#
Author: Matthew Dunbar
Script source: https://github.com/Suriyawong/CIP/CIP-010-4/New-ConfigurationBaseline.ps1
Version: 2024.02.07.2319
Description: This cmdlet is intended to generate an HTML report for a Windows-based CIP asset.  The report will include the necessary items required by CIP-010-4 Part 1.1.

DISCLAIMER: This source code is offered free of charge and with no guarantee of accuracy for production use.  Using this code is done at your own risk and liability.

#>

function New-ConfigurationBaseline {
    [CmdletBinding()]
    param (
        # Specifies a path to a directory where the CIP report will be created.
        [Parameter(Mandatory=$false,
                   Position=0,
                   #ParameterSetName="ParameterSetName",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   HelpMessage="Path to the report output directory.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $OutputDirectory = "$PWD"
    )
    
    begin {
        $datetime = Get-Date
        $html = Get-Content .\CIP-010-4.template.html
    }
    
    process {
        #TODO: Replace REPLACEME_DATETIME with current date and time (Get-Date)
        #TODO: Replace REPLACEME_USERNAME with logged on user
        #TODO: Replace REPLACEME_HOSTNAME in CIP-010-4/CIP-010-4.template.html with $env:COMPUTERNAME
        #TODO: Get OS name and version and replace REPLACME_OPERATINGSYSTEM in CIP-010-4/CIP-010-4.template.html
        #TODO: Get all installed software (commercial, open source, or custom) and replace REPLACEME_SOFTWARE in CIP-010-4/CIP-010-4.template.html
        #TODO: Get all listening TCP and UDP ports and replace REPLACEME_LOGICALPORTS in CIP-010-4/CIP-010-4.template.html
        #TODO: Get all Windows hotfixes and replace REPLACEME_HOTFIXES in CIP-010-4/CIP-010-4.template.html
        }
    
    end {
        #TODO: Output html to a new HTML report file in the supplied target.
    }
}