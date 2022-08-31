$script={
    $enumerateUsers = Get-LocalUser
    $countOfUsers = Get-LocalUser | measure

    For($i=0; $i -lt $countOfUsers.Count; $i++){
        if($enumerateUsers[$i].Description -eq "Added by JumpCloud" -and $enumerateUsers[$i].Enabled -eq $false){
            Remove-LocalUser -Name $enumerateUsers[$i].Name
        }
    }
}

$installed64 = @(& "$env:SystemRoot\sysnative\WindowsPowerShell\v1.0\powershell.exe" -ExecutionPolicy Bypass -NoProfile -NonInteractive -Command $script)
