$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session

$Search=New-ComplianceSearch -Name "Remove Phishing Message - XXX" -ExchangeLocation All -ContentMatchQuery '(Received:8/9/2021..8/11/2021) AND (Subject:"XXX")'
Start-ComplianceSearch -Identity $Search.Identity

New-ComplianceSearchAction -SearchName "Remove Phishing Message - XXX" -Purge -PurgeType SoftDelete
