'This code clip gets the OS ver.
'Code by Alyce Watson

  struct OSVERSIONINFO,_
        dwOSVersionInfoSize as ulong,_
        dwMajorVersion      as ulong,_
        dwMinorVersion      as ulong,_
        dwBuildNumber       as ulong,_
        dwPlatformId        as ulong,_
        szCSDVersion        as char[128]

    L=len(OSVERSIONINFO.struct)
    OSVERSIONINFO.dwOSVersionInfoSize.struct=L

    calldll #kernel32, "GetVersionExA",_
        OSVERSIONINFO as struct,_
        result as boolean

' Determine wich SubKey to use
    PlatformID = OSVERSIONINFO.dwPlatformId.struct

    select case PlatformID
'Running Win9x,ME
        case _VER_PLATFORM_WIN32_WINDOWS
            OSVersionKey$ = "Windows"
            OS$ = "Windows 9X"
'Running WinNT,2k,XP
        case _VER_PLATFORM_WIN32_NT
            OSVersionKey$ = "Windows NT"
            OS$ = "Windows NT"
'Win3.x or whatever
    case else
       notice "Application Error";chr$(13);"Unsupported Operating system!"
       end
end select


open "os.txt" for output AS #1
print #1, OS$
close #1
end
