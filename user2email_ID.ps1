# Function to check if email that user entered is valid email
function IsValidEmail($EmailAddress) { 

    $EmailDomain = "@nestorlee.com" # Change accordingly

    if($EmailAddress.EndsWith($EmailDomain)){
        return $true
    }
    else{
        return $false
    }
}

# Checks if the user runs the executable as an Admin, otherwise exit
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator).Equals($false)){
    Invoke-WmiMethod -Path Win32_Process -Name Create -ArgumentList "msg * Please restart this application as admin."
    Exit
}

else{
    [void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

    $title = 'Email'
    $msg   = 'Please enter your corporate Email Address:'
    $EmailAddress = "null" # Initiate variable

    while(!(IsValidEmail($EmailAddress))){
        $EmailAddress = [Microsoft.VisualBasic.Interaction]::InputBox($msg, $title)
    }

    # Strips everything after the @ sign
    $EmailID = $EmailAddress.Substring(0, $EmailAddress.IndexOf('@'))

    # WMIC to change useraccount name
    wmic useraccount where name="'$env:UserName'" rename "'$EmailID'"
}