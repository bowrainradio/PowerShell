#encryptString function takes string, path where the encrypted string will be stored and a name of the txt file. It converts plain string to secure strings and saves it into a custome name txt file.
function encryptString {
    param(
    [string]$UnsecuredString,
    [string]$Path,
    [string]$FileName
    )
    $UnsecuredString | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString | Out-File "$($Path)\$($FileName).txt"
    Write-Output "Your String is secured now!"
}

#As I use it to store my API key, I need to invert it back to normal string to use it for Invoke-RestMethod function for API POST method (at least the simple way I'm doing it). This fucntion will simple take your secure string and using your Credential from PSCredential object will convert it back to normal string. It's not the greatest but I prefer doing this so unless you know what your looking for in the code, there's no hard coded api webhook or token in the script and the txt file that stores the securestring is encrypted. Simple and easy solution that helps me keep some more sensetive data NOT that easy to find.
function decryptString{
    param(
        [string]$Path
    )
    $SecuredKey = Get-Content  -Path $Path | ConvertTo-SecureString
    return (New-Object PSCredential 0, $SecuredKey).GetNetworkCredential().Password
}


encryptString "your_Mama@!#" "C:\Filip\Documents\TopSecret" "password" #you can use it one time to encrypt whatever string/password/token you want and after that remove this function call since it will be already encrypted on you drive in txt file
$password = decryptString "C:\Filip\Documents\TopSecret\password.txt" #I use it inside my api call function so it's harded to find and only converts the secure string when i make an api call and after that this variable no longer exist so you can't read it. Of course it doesn't stop you to call this function outside when you know the txt file path but it's better then nothing :)
Write-Output $password
