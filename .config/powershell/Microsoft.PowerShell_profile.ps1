function Start-Komorebic { & 'komorebic' 'start' '--whkd' }

function Stop-Komorebic { & 'komorebic' 'stop' }

function godot {
 nvim --listen 127.0.0.1:55432
}

New-Alias -Name vim -Value nvim
New-Alias -Name TileManagerStart -Value Start-Komorebic
New-Alias -Name TileManagerStop -Value Stop-Komorebic
oh-my-posh init pwsh --config "C:\Users\mjcev\AppData\Local\Programs\oh-my-posh\themes\powerlevel10k_classic.omp.json" | Invoke-Expression

Write-Host "`e[5 q"
