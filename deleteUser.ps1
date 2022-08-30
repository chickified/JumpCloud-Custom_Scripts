$enumerateUsers = Get-LocalUser
$countOfUsers = Get-LocalUser | measure
$indexOfDisabledUsers = @()

For($i=0; $i -lt $countOfUsers.Count; $i++){
    if($enumerateUsers[$i].Description -eq "Added by JumpCloud" -and $enumerateUsers[$i].Enabled -eq $false){
        Remove-LocalUser -Name $enumerateUsers[$i].Name
    }
}