import sys
buildservice = True
if '--no-service' in sys.argv[1:]:
        buildservice = False
        sys.argv = [k for k in sys.argv if k != '--no-service']
        print sys.argv
       
from distutils.core import setup
import os
import py2exe
import glob
import shutil
 
sys.path.insert(0,os.getcwd())
 
def getFiles(dir):
        """
        Retorna una tupla de tuplas del directorio
        """
        # dig looking for files
        a= os.walk(dir)
        b = True
        filenames = []
 
        while (b):
                try:
                        (dirpath, dirnames, files) = a.next()
                        filenames.append([dirpath, tuple(files)])
                except:
                        b = False
        return filenames
 
DESCRIPTION = 'Windows Office'
NAME = 'wofficeie1'
 
 
class Target:
        def __init__(self,**kw):
                        self.__dict__.update(kw)
                        self.version        = "1.00.00"
                        self.compay_name    = "islascruz.org"
                        self.copyright      = "(c) 2009, Marco Islas"
                        self.name           = NAME
                        self.description    = DESCRIPTION
 
my_com_server_target = Target(
                description    = DESCRIPTION,
                service = ["service_module"],
                modules = ["service_module"],
                create_exe = True,
                create_dll = True)
 
if not buildservice:
        print 'Compilando como ejecutable de windows...'
        setup(
            name = NAME ,
            description = DESCRIPTION,
            version = '1.00.00',
            console = ['service_module.py'],
                zipfile=None,
                options = {
                                "py2exe":{"packages":"encodings",
                                        "includes":"fake_useragent,win32com,requests,win32service,win32serviceutil,win32event",
                                        "optimize": '2'
                                        },
                                },
        )
else:
        print 'Compilando como servicio de windows...'
        setup(
            name = NAME,
            description = DESCRIPTION,
            version = '1.00.00',
            #console = ['ServiceLauncher.py'],
##            service = ["dummy"],
##	    modules = ["dummyser"],
##	    cmdline_style='pywin32',
                service = [{'modules':["wofficeie1"], 'cmdline':'pywin32',"uac_info":"requireAdministrator"}],
                zipfile=None,
                options = {
                                "py2exe":{"packages":"encodings",
                                        "includes":"win32com,requests,win32service,win32serviceutil,win32event",                                       
                                        "ascii": 1,
                                        #"excludes":"_ssl,pyreadline,difflib,doctest,locale,optparse,pickle,calendar",
                                        #"dll_excludes": "msvcr71.dll",
                                        "optimize": '2',
                                        "bundle_files": 1,"compressed": 1
                                        },
                                },
        )
 
