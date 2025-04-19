function Start-Komorebic { & 'komorebic' 'start' '--whkd' }

function Stop-Komorebic { & 'komorebic' 'stop' }

function godot {
 nvim --listen 127.0.0.1:55432
}

function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

New-Alias -Name vim -Value nvim
New-Alias -Name v -Value nvim
New-Alias -Name TileManagerStart -Value Start-Komorebic
New-Alias -Name TileManagerStop -Value Stop-Komorebic
oh-my-posh init pwsh --config "C:\Users\mjcev\AppData\Local\Programs\oh-my-posh\themes\powerlevel10k_classic.omp.json" | Invoke-Expression

Write-Host "`e[5 q"
