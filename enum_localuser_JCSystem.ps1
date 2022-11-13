Write-Output ""
Write-Output "Generating list of users on managed devices..."
Write-Output ""

$userDeviceDetails = Get-JCSystemInsights -Table User | Select-Object username, SystemId | Where-Object type -ne "special" | Where-Object username -notlike _* | Where-Object username -notin $("daemon","root","nobody") | Where-Object username -notlike "*SERVICE*" | Where-Object username -notlike "*system*" | Where-Object username -ne "Guest" | Where-Object username -ne "Administrator" | Where-Object username -ne "WDAGUtilityAccount" | Where-Object username -ne "DefaultAccount" | Where-Object username -ne ""

Write-Output ""
Write-Output "Done."
Write-Output ""

$onlyWindows = @()

Write-Output ""
Write-Output "Removing all other OS platforms..."
Write-Output ""

For($i=0; $i -lt $userDeviceDetails.Count; $i++){

    $currentIteration = Get-JCSystem -SystemID $userDeviceDetails.SystemID[$i] | Select-Object os

    if($currentIteration.os -eq "Windows"){
        $onlyWindows += $userDeviceDetails[$i]
    } 
}

Write-Output ""
Write-Output "Done."
Write-Output ""

Write-Output ""
Write-Output "Here are the Windows devices and their user accounts."
Write-Output ""
