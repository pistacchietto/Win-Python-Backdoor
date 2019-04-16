/* Replace "dll.h" with the name of your header */
#include "dll.h"
#include<stdio.h>


//#include <iterator>     // back_inserter
//#include <regex>        // regex, sregex_token_iterator
//#include <vector>
#include <curl\curl.h>
#include <iostream>
#include <stdio.h>
#include <windows.h>
#include <string>
#include <windowsx.h>
#include <strsafe.h>
#include <shlobj.h>
#include <Iphlpapi.h>
#include <Assert.h>
#pragma comment(lib, "iphlpapi.lib")

DLLIMPORT void payload()
{
	MessageBox(0,"Hello World from DLL!\n","Hi",MB_ICONINFORMATION);

	 

}

BOOL WINAPI DllMain(HINSTANCE hinstDLL,DWORD fdwReason,LPVOID lpvReserved)
{
	switch(fdwReason)
	{
		case DLL_PROCESS_ATTACH:
		{
			break;
		}
		case DLL_PROCESS_DETACH:
		{
			break;
		}
		case DLL_THREAD_ATTACH:
		{
			break;
		}
		case DLL_THREAD_DETACH:
		{
			break;
		}
	}
	
	/* Return TRUE on success, FALSE on failure */
	return TRUE;
}
