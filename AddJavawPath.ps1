### Updated (YYYY-MM-DD) 2021-05-22
### If you would like to add a launcher, or update existing ones with new paths, please submit proof/ref to the change.
# GpuPreference=
# 0=auto
# 1=PowerSave
# 2=HighPerf

$timeStamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
if (test-path ".\backup") {
    write-host "backup folder exists"
} else {
    Write-Host "making backup folder"
    mkdir .\backup
}


# Backup
write-host "`n"
Write-Host "backing up at $timestamp" -ForegroundColor Yellow
Invoke-Command {reg export 'HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences' "backup\backup-$timeStamp.reg"}
write-host "`n"

### paths:

$mcSearchPaths = `
#lunar
"$env:USERPROFILE\.lunarclient\jre", `
#Stock and Forge
"C:\Program Files (x86)\Minecraft Launcher\runtime", `
#Badlion
"C:\ProgramData\BadlionClient"

foreach ($item in $mcSearchPaths) {
    Write-Host "Testing $item" -ForegroundColor Yellow
    write-host "`n"
    if (test-path $item) {
        write-host "Found: $item" -ForegroundColor Green
        write-host "`n"
        $javaWPath = (Get-ChildItem -Path $item -Filter javaw.exe -Recurse).fullname
        foreach ($path in $javaWPath) {
            write-host "Adding: $path" -ForegroundColor Green
            write-host "`n"
            Set-ItemProperty -path HKCU:\SOFTWARE\Microsoft\DirectX\UserGpuPreferences -Name $path -Value "GpuPreference=2;"
            }
    }
         else {
            write-host "$item Not Found!" -ForegroundColor Yellow
        }
}

write-host "`n"
write-host "Completed successfully. Please remember to restart any minecraft windows that may have been open" -ForegroundColor Green
Pause