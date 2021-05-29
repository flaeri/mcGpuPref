# mcGpuPref
Powershell Scipts To Auto Add Minecraft Java Executables To Gpu Preferences, and set them to run on the "high performance" GPU.

## How to

You can choose between the shortcut/oneliner (1st one), or the normal method (2nd option).
Choose *either* you do not need to do both. They do the same thing, just different methods.

### 1. Shortcut

**This may require PowerShell v3+ and .net4+ due to TLS1.2.**

1. Start "powershell" (search for it in the start menu)
2. Copy the next line, and paste it into the powershell window 
```
Set-ExecutionPolicy Bypass -Scope Process -Force;iex(iwr 'https://raw.githubusercontent.com/flaeri/mcGpuPref/main/AddJavawPath.ps1')
```

### 2. Normal Method
1. Close any and all of your Minecraft windows
2. Download the latest release (zip): https://github.com/flaeri/mcGpuPref/releases
3. Unzip all the files anywhere you would like.
4. double click / run the "runMe.cmd"

Thats it. Feel free to check that you have them added in the Graphics settings. 
You can copy this link and paste into wherever (run, explorer, chrome):

*ms-settings:display-advancedgraphics*

## What it do

Runme.cmd (batchfile) is just to trigger the powershell script without you having to set a powershell execution policy.


The actual powershell script (ps1) will check for known paths of javaw.exe from different launchers, and add them to your "graphics settings" and select "high performance".
This is done by adding a couple of items to your current user registry hive (HKCU:\SOFTWARE\Microsoft\DirectX\UserGpuPreferences).


It will create a folder called "backup" next to the script, and produce a backup .reg file before it does any modifications. Shouldnt be nescescary, but why not.

## What launchers/MC software are supported?

* Stock / standard / default Launcher (C:\Program Files (x86)\Minecraft Launcher\runtime\jre-x64\bin\javaw.exe)
* Lunar (<userprofile>\.lunarclient\jre\zulu8.50.0.53-ca-fx-jre8.0.275-win_x64\bin\javaw.exe)
* Bad Lion (C:\ProgramData\BadlionClient\jre1.8.0_202\bin\javaw.exe)
* TLauncher (C:\Program Files\Java\jre1.8.0_281\bin\javaw.exe)
* Forge (C:\Program Files (x86)\Minecraft Launcher\runtime\jre-legacy\windows-x64\jre-legacy\bin\javaw.exe)

If you can think of any more common ones, feel free to submit name, path and proof. :blush:
