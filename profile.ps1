(& "C:\Users\elias\anaconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression

(@(& 'C:/Users/elias/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init pwsh --config='C:\Users\elias\AppData\Local\Programs\oh-my-posh\themes\pure.omp.json' --print) -join "`n") | Invoke-Expression

Remove-Item "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt"
