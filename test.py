import subprocess
import requests
import os
import socket

header = {'User-Agent': 'Mozilla/5.0'}
ip=socket.gethostbyname('config01.homepc.it')
sites = ["paner.altervista.org"]#, mainsite.text]
mainsite = requests.get("http://"+ip+"/site.txt", headers=header)
for mysite in mainsite.text.split(","):
    print socket.gethostbyname(mysite)
    sites.append(socket.gethostbyname(mysite))
for site in sites:
    print site
