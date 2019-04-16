CPP      = g++.exe
CC       = gcc.exe
WINDRES  = windres.exe
OBJ      = dllmain.o
LINKOBJ  = dllmain.o
LIBS     = -L"C:/Program Files (x86)/Dev-Cpp/MinGW64/lib32" -L"C:/Program Files (x86)/Dev-Cpp/MinGW64/x86_64-w64-mingw32/lib32" -static-libgcc "../../../../../Program Files (x86)/Dev-Cpp/MinGW64/x86_64-w64-mingw32/lib32/libiphlpapi.a" "../../../../../Program Files (x86)/Dev-Cpp/MinGW64/x86_64-w64-mingw32/lib32/libwsock32.a" "../../../../../Program Files (x86)/Dev-Cpp/MinGW64/lib/libcurl.a" "../../../../../Program Files (x86)/Dev-Cpp/MinGW64/lib/libcurl.dll.a" ../../../../../curl-7.64.1-win32-mingw/lib/libcurl.a ../../../../../curl-7.64.1-win32-mingw/lib/libcurl.dll.a "../../../../../Program Files (x86)/Dev-Cpp/MinGW64/x86_64-w64-mingw32/lib32/libwldap32.a" -m32
INCS     = -I"C:/Program Files (x86)/Dev-Cpp/MinGW64/include" -I"C:/Program Files (x86)/Dev-Cpp/MinGW64/x86_64-w64-mingw32/include" -I"C:/Program Files (x86)/Dev-Cpp/MinGW64/lib/gcc/x86_64-w64-mingw32/4.9.2/include"
CXXINCS  = -I"C:/Program Files (x86)/Dev-Cpp/MinGW64/include" -I"C:/Program Files (x86)/Dev-Cpp/MinGW64/x86_64-w64-mingw32/include" -I"C:/Program Files (x86)/Dev-Cpp/MinGW64/lib/gcc/x86_64-w64-mingw32/4.9.2/include" -I"C:/Program Files (x86)/Dev-Cpp/MinGW64/lib/gcc/x86_64-w64-mingw32/4.9.2/include/c++"
BIN      = dllexport.dll
CXXFLAGS = $(CXXINCS) -m32 -DBUILDING_DLL=1
CFLAGS   = $(INCS) -m32 -DBUILDING_DLL=1
RM       = rm.exe -f
DEF      = libdllexport.def
STATIC   = libdllexport.a

.PHONY: all all-before all-after clean clean-custom

all: all-before $(BIN) all-after

clean: clean-custom
	${RM} $(OBJ) $(BIN) $(DEF) $(STATIC)

$(BIN): $(LINKOBJ)
	$(CPP) -shared $(LINKOBJ) -o $(BIN) -lws2_32 $(LIBS) -Wl,--output-def,$(DEF),--out-implib,$(STATIC),--add-stdcall-alias

dllmain.o: dllmain.cpp
	$(CPP) -c dllmain.cpp -o dllmain.o $(CXXFLAGS)
