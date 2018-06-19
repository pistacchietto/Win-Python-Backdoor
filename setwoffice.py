from distutils.core import setup
import calendar
import py2exe,os,sys,subprocess
from subprocess import Popen

includes = []
excludes = ['_gtkagg', '_tkagg', 'bsddb', 'curses', 'email', 'pywin.debugger',
            'pywin.debugger.dbgcon', 'pywin.dialogs', 'tcl',
            'Tkconstants', 'Tkinter',   # Exclude _ssl
            'pyreadline', 'doctest', 'locale', 
            'optparse', 'pickle', 'calendar']
packages = []
dll_excludes = ['libgdk-win32-2.0-0.dll', 'libgobject-2.0-0.dll', 'tcl84.dll', 
                'tk84.dll']#,'mpr.dll','crypt32']
 
setup(
    options = {"py2exe": {"compressed": True, 
                          "includes": "win32com,win32service,win32serviceutil,win32event",
                          "excludes": excludes,
                          "packages": packages,                          
                          "dll_excludes": dll_excludes,
                          "bundle_files": 1,
                          #"ascii": True,
                          "optimize": '2',
                          "compressed": 1
                         }
              },
    zipfile = None,
    #windows=['up.py']
    windows = [{
    'script': "woffice.py",
    #'uac_info': "requireAdministrator"
}]
)
