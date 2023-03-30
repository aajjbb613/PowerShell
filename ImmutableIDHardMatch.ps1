Import-Module ActiveDirectory

#local Users on AD
$List = "user1" , "user2" , "user3" , "user4" , "user5"

#Cloud Users on Azure AD
$ListAzure = "user1@email.com" , "user2@email.com" , "user3@email.com" , "user4@email.com" , "user5@email.com"

#Local AD server
$AD = DC-SRV

$data = @()

Foreach($User in $List){
$data += Invoke-Command -ComputerName $AD -ScriptBlock{
    $Info = Get-ADUser -Identity $using:User
    #$Info.SamAccountName
    $Info.ObjectGUID.ToString()
}
}

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Install-Module Microsoft.Graph

Connect-Graph -scopes "User.ReadWrite.All"

$ListAzure = "Chantal@estatelawboutique.com" , "jessica@estatelawboutique.com" , "kelsea@personalawgroup.com" , "Natalie@estatelawboutique.com" , "zoe@estatelawboutique.com" 

$Step = 0

ForEach($UserAzure in $ListAzure){
    $ID = [Convert]::ToBase64String([guid]::New($data[$step]).ToByteArray())
    Get-MgUser -UserID $UserAzure | Select OnPremisesImmutableId, Displayname,Mail,UserPrincipalName
    Update-MgUser -UserID $UserAzure -OnPremisesImmutableId $ID -WhatIf
    $step++
}
Start-ADSyncSyncCycle
