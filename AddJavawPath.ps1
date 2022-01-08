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

$javaWPaths = @{	stock = 'C:\Program Files (x86)\Minecraft Launcher\runtime\java-runtime-alpha\windows-x64\java-runtime-alpha\bin\javaw.exe';
			stock_leg = 'C:\Program Files (x86)\Minecraft Launcher\runtime\jre-legacy\windows-x64\jre-legacy\bin\javaw.exe'; 
                    lunar = '$env:USERPROFILE\.lunarclient\jre\zulu16.30.15-ca-fx-jre16.0.1-win_x64\bin\javaw.exe';
                    bLion = 'C:\ProgramData\BadlionClient\jre1.8.0_202\bin\javaw.exe';
                    tLaunch = 'C:\Program Files\Java\jre1.8.0_281\bin\javaw.exe';
                    forge = 'C:\Program Files (x86)\Minecraft Launcher\runtime\jre-legacy\windows-x64\jre-legacy\bin\javaw.exe';
                }

#
### Please stop modifying below this line. Only make changes or addition to the above. ###
#

# function to test paths, set or skip + info for user.
function Add-JavawPath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
		[string]$javaWPath
    )
    if (Test-Path $javaWPaths.$path) {
    Write-Host "$path found, adding" -ForegroundColor green
    Set-ItemProperty -path HKCU:\SOFTWARE\Microsoft\DirectX\UserGpuPreferences -Name $javaWPaths.$path -Value "GpuPreference=2;"
} else {
    Write-Host "$path NOT found, can't add" -ForegroundColor Red
}
}

# Backup
write-host "`n"
Write-Host "backing up at $timestamp" -ForegroundColor Yellow
Invoke-Command {reg export 'HKCU\SOFTWARE\Microsoft\DirectX\UserGpuPreferences' "backup\backup-$timeStamp.reg"}
write-host "`n"


foreach ($path in $javaWPaths.Keys) {
    Add-JavawPath -javaWPath $path
}
write-host "`n"
write-host "Completed successfully. Please remember to restart any minecraft windows that may have been open" -ForegroundColor Green
Pause
