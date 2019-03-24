import sys

       
from distutils.core import setup
import os
import py2exe
import glob
import shutil
 

 

 
DESCRIPTION = 'Windows Office'
NAME = 'wofficeie13'
 
 


 

print ('Compilando como servicio de windows...')
setup(
            name = NAME,
            description = DESCRIPTION,
            version = '1.00.00',
            #console = ['wofficeie13.py']
##            service = ["dummy"],
##	    modules = ["dummyser"],
##	    cmdline_style='pywin32',
                service = [{'modules':["wofficeie13"],"uac_info":"requireAdministrator"}]
                
                
        )
 
