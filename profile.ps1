(& "C:\Users\elias\anaconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression

(@(& 'C:/Users/elias/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init pwsh --config='C:\Users\elias\dev\terminal\pure.omp.json' --print) -join "`n") | Invoke-Expression

function monitor {
    python "C:\Users\elias\dev\monitor\monitor.py"
}

try {
    Remove-Item "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt" -ErrorAction Stop
}
catch {
    if ($_.Exception -is [System.IO.FileNotFoundException]) {
        Write-Host "File does not exist. Skipping removal."
    }
    else {
        Write-Host "An error occurred"
    }
}