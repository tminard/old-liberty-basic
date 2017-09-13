'This is a Function file
'Most code by Alyce Watson

struct Point,x As Long, y As Long
struct Rect, x1 As Long, y1 As Long, x2 As Long, y2 As Long
struct JOYINFO,x As Long,y As Long,z As Long,buttons As Long

'*******************************************
'WINMM
'*******************************************
Function mciSendString$(s$)
    buffer$=Space$(1024)+Chr$(0)
    CallDLL #winmm,"mciSendStringA",s$ As Ptr,buffer$ As Ptr,_
        1028 As Long, 0 As Long, r As Long

    buffer$=Left$(buffer$, Instr(buffer$, Chr$(0)) - 1)
        If r>0 Then
            mciSendString$="error"
        Else
            mciSendString$=buffer$

        End If
    End Function

Function sndPlaySound(file$,mode)
    CallDLL #winmm, "sndPlaySoundA",file$ As Ptr,_
    mode As Long, sndPlaySound As Long
    End Function

Sub joyGetPos stick
    'stick=0 or stick=1
    CallDLL #winmm,  "joyGetPos", stick As Long,JOYINFO As struct ,result As Long
    End Sub

'*******************************************
'URLMON
'*******************************************
Function URLDownloadToFile(urlfile$,localfile$)
    'urlfile$=url name, localfile$=desired filename to save to disk
    calldll #url, "URLDownloadToFileA",0 as long,_
    urlfile$ as ptr,localfile$ as ptr, 0 as long,0 as long,_
    URLDownloadToFile as long
    End Function

'*******************************************
'KERNEL AND SHELL
'*******************************************
Sub Sleep value
    CallDLL #kernel32, "Sleep",value As Long,r As Void
    End Sub

Function GetShortPathName$(lPath$)
    lPath$=lPath$+Chr$(0)
    sPath$=Space$(256)
    lenPath=Len(sPath$)
    CallDLL #kernel32, "GetShortPathNameA",lPath$ As Ptr,_
    sPath$ As Ptr,lenPath As Long,r As Long
    GetShortPathName$=Left$(sPath$,r)
    End Function

Function lstrcmpi(s1$,s2$)
    CallDLL #kernel32,  "lstrcmpA",_    'case sensitive
    s1$ As Ptr,s2$ As Ptr,lstrcmpi As Long
    's1$<s2$, r<0
    's1$=s2$, r=0
    's1$>s2$, r>0
    'calldll #kernel32, "lstrcmpiA",_     'case insensitive
    's1$ as PTR,s2$ as PTR,result As long
    End Function

Function GetProfileString$(appName$,keyName$)
    default$ = "":size = 250
    result$ = Space$(size)+Chr$(0)
    CallDLL #kernel32, "GetProfileStringA",appName$ As Ptr, keyName$ As Ptr,_
    default$ As Ptr, result$ As Ptr, size As Long,result As Long
    GetProfileString$=Left$(result$, Instr(result$, Chr$(0)) - 1)
    End Function

Function GetModuleFileName$(hMod)
    'hModule = LoadLibrary("notepad.exe")
    'print trim$(GetModuleFileName$(hModule))
    file$=Space$(256)
    nSize=Len(file$)
    CallDLL #kernel32, "GetModuleFileNameA",_
    hMod as uLong, file$ As Ptr, nSize As Long,re As Long
    GetModuleFileName$=file$
    End Function

Function LoadLibrary(file$)
    'hModule = LoadLibrary("notepad.exe")
    CallDLL #kernel32, "LoadLibraryA",file$ As Ptr, LoadLibrary As uLong
    End Function

Sub FreeLibrary hLib
    CallDLL #kernel32, "FreeLibrary",hLib As uLong, re As Long
    End Sub

Function GetModuleHandle(file$)
    'print GetModuleHandle("c:\windows\notepad.exe")
    CallDLL #kernel32, "GetModuleHandleA", file$ As Ptr, GetModuleHandle as uLong
    '0 = not running, greater than 0 = running
    End Function

Function GlobalMemoryStatus()
    struct M, dwLength As Long, dwMemoryLoad As Long,_
    dwTotalPhys As Long,dwAvailPhys As Long, dwTotalPageFile As Long,_
    dwAvailPageFile As Long,dwTotalVirtual As Long,dwAvailVirtual As Long
    length=Len(M.struct):M.dwLength.struct=length
    CallDLL #kernel32, "GlobalMemoryStatus", M As struct, r As Void
    GlobalMemoryStatus=M.dwTotalPhys.struct
    End Function

Function GetDriveType(dir$)
    'print GetDriveType("c:\")
    CallDLL #kernel32, "GetDriveTypeA",dir$ As Ptr,GetDriveType As Long
    ' dType = 0 (No Drive)
    ' dType = 1 (Unknown Drive Type)
    ' dType = 2 (Floppy Drive)
    ' dType = 3 (Hard Drive)
    ' dType = 4 (Remote Drive)
    ' dType = 5 (CDROM)
    ' dType = 6 (RAMDISK)
    End Function

Function ExtractIcon(hW, file$)
    hInst=GetWindowLong(hW, _GWL_HINSTANCE)
    CallDLL #shell32, "ExtractIconA",hInst as uLong,_
    file$ As Ptr, 0 As Long, ExtractIcon as uLong
    End Function

Function DrawIcon(hdc,hIcon,x,y)
    CallDLL #user32, "DrawIcon",hdc as uLong, x As Long,_
    y As Long, hIcon as uLong, DrawIcon As Long
    End Function

Sub WinExec exec$, flag
    'SW_HIDE = 0
    'SW_NORMAL = 1
    'SW_SHOWMINIMIZED = 2
    'SW_MAXIMIZE = 3
    'SW_SHOWNOACTIVATE = 4
    'SW_SHOW = 5
    'SW_MINIMIZE = 6
    'SW_SHOWMINNOACTIVE = 7
    'SW_SHOWNA = 8
    'SW_RESTORE = 9
    CallDLL #kernel32, "WinExec",exec$ As Ptr, flag As Long, result As Long
    End Sub

Function GetWindowsDirectory$()
    WindowsDir$=Space$(200)+Chr$(0)
    CallDLL #kernel32, "GetWindowsDirectoryA", WindowsDir$ As Ptr, 200 As Long, result As Long
    GetWindowsDirectory$=Trim$(WindowsDir$)
    End Function

Function GetSystemDirectory$()
    WindowsSys$=Space$(200)+Chr$(0)
    CallDLL #kernel32, "GetSystemDirectoryA", WindowsSys$ As Ptr, 200 As Long, result As Long
    GetSystemDirectory$=Trim$(WindowsSys$)
    End Function

Sub ShellExecute hWnd, file$
    parameter = _SW_SHOWNORMAL    ' set up for viewing
    lpszOp$ = "open" + Chr$(0)    ' "open" or "print"
    lpszFile$ = file$ + Chr$(0)
    lpszDir$ = DefaultDir$ + Chr$(0)
    lpszParams$="" + Chr$(0)
    CallDLL #shell32, "ShellExecuteA", hWnd as uLong,lpszOp$ As Ptr,lpszFile$ As Ptr,_
    lpszParams$ As Ptr,lpszDir$ As Ptr,parameter As Long, result As Long
    End Sub

Function FindExecutable$(file$)
    'file$ should be full path and filename
    'such as c:\mydir\readme.txt
    lpFile$ = file$ + Chr$(0)
    lpDirectory$ = Space$(255)+Chr$(0)
    lpResult$ = Space$(255) + Chr$(0)
    CallDLL #shell32,  "FindExecutableA", _
        lpFile$ As Ptr, lpDirectory$ As Ptr, lpResult$ As Ptr, result As Long
    FindExecutable$=Trim$(lpResult$)
    End Function

Function QueryPerformanceFrequency()
    struct res, tm as long
    calldll #kernel32, "QueryPerformanceFrequency",_
    res as struct, result as boolean
    QueryPerformanceFrequency=res.tm.struct
    End Function

Function QueryPerformanceCounter()
    struct res, tm as long
    calldll #kernel32, "QueryPerformanceCounter",_
    res as struct, result as boolean
    QueryPerformanceCounter=res.tm.struct
    End Function

Function GetSpecialfolder$(CSIDL)
    CSIDL.DESKTOP = 0:CSIDL.PROGRAMS = 2
    CSIDL.CONTROLS = 3:CSIDL.PRINTERS = 4
    CSIDL.PERSONAL = 5:CSIDL.FAVORITES = 6
    CSIDL.STARTUP = 7:CSIDL.RECENT = 8
    CSIDL.SENDTO = 9:CSIDL.BITBUCKET = 10
    CSIDL.STARTMENU = 11:CSIDL.DESKTOPDIRECTORY = 16
    CSIDL.DRIVES = 17:CSIDL.NETWORK = 18
    CSIDL.NETHOOD = 19:CSIDL.FONTS = 20
    CSIDL.TEMPLATES = 21
    struct IDL,cb As Long, abID As short
    calldll #shell32, "SHGetSpecialFolderLocation",_
        0 as long, CSIDL as long, IDL as struct, ret as long
    if ret=0 then
        Path$ = Space$(512)
        id=IDL.cb.struct
        calldll #shell32, "SHGetPathFromIDListA",id as long, Path$ as ptr, ret as long
        GetSpecialfolder$ = Left$(Path$, InStr(Path$, Chr$(0)) - 1)
    else
        GetSpecialfolder$ = "Error"
    end if
    End Function

Function SHBrowseForFolder$(txt$)
    BIF.RETURNONLYFSDIRS = 1:BIF.USENEWUI = hexdec("40")
    MAX.PATH = 260   'txt$ will appear on dialog
    STRUCT BrowseInfo,hWndOwner as uLong,pIDLRoot As Long,pszDisplayName As Long,_
    lpszTitle$ As ptr,ulFlags As Long,lpfnCallback As Long,lParam As Long,iImage As Long
    BrowseInfo.hWndOwner.struct = 0
    BrowseInfo.lpszTitle$.struct = txt$
    BrowseInfo.ulFlags.struct = BIF.RETURNONLYFSDIRS or BIF.USENEWUI
    calldll #shell32, "SHBrowseForFolder",BrowseInfo as struct,lpIDList as long

    If lpIDList>0 Then
        sPath$ = space$(MAX.PATH) + chr$(0)
        calldll #shell32, "SHGetPathFromIDList",_
            lpIDList as long,sPath$ as ptr,r as long
        open "ole32" for dll as #ole
        calldll #ole, "CoTaskMemFree",lpIDList as long,r as long
        close #ole
        iNull = InStr(sPath$, chr$(0))
        If iNull Then sPath$ = Left$(sPath$, iNull - 1)
    End If
    if sPath$="" then sPath$="Cancelled"
    SHBrowseForFolder$=sPath$
    End Function

Sub ShellAbout caption$,msg$,iconHandle
    'iconHandle can be 0
    calldll #shell32, "ShellAboutA",0 as long,caption$ as ptr,_
    msg$ as ptr,iconHandle as uLong,ret as long
    End Sub

'*******************************************
'WINDOW & USER STUFF
'*******************************************
Function MessageBox(hW,msg$,title$,wType)
    CallDLL #user32, "MessageBoxA",hW as uLong,_
    msg$ As Ptr, title$ As Ptr, wType As Long,MessageBox As Long
    End Function

Function MessageBoxEx(hW,msg$,title$,wType)
    CallDLL #user32, "MessageBoxExA",hW as uLong,_
    msg$ As Ptr, title$ As Ptr, wType As Long,language As Word, MessageBoxEx As Long
    End Function

Function MessageBeep(wType)
    CallDLL #user32,"MessageBeep",wType As Long, MessageBeep As Boolean
    End Function

Function SystemParametersInfo(filename$)
    Action = 20  'value for _SETDESKWALLPAPER
    flags = 1
    CallDLL #user32, "SystemParametersInfoA",Action As Long,0 As Long,filename$ As Ptr, _
    flags As Long,SystemParametersInfo As Long
    ' Const SPIF_UPDATEINIFILE = &H1
    ' Const SPI_SETDESKWALLPAPER = 20 'value for Action
    ' Const SPIF_SENDWININICHANGE = &H2
    End Function

Function SwapMouseButton(Switch)
    '0=Normal Mouse Buttons 1=Swap Mouse Buttons
    CallDLL #user32, "SwapMouseButton", Switch As Boolean, SwapMouseButton As Boolean
    End Function

Function IsZoomed(hW)
    CallDLL #user32, "IsZoomed",hW as uLong, IsZoomed As Boolean
    End Function

Function IsWindowVisible(hW)
    CallDLL #user32, "IsWindowVisible",hW as uLong, IsWindowVisible As Boolean
    End Function

Function IsWindowEnabled(hW)
    CallDLL #user32, "IsWindowEnabled",hW as uLong, IsWindowEnabled As Boolean
    End Function

Function IsIconic(hW)
    CallDLL #user32, "IsIconic",hW as uLong, IsIconic As Boolean
    End Function

Function GetWindowTextLength(hW)
    CallDLL #user32, "GetWindowTextLengthA",hW as uLong, GetWindowTextLength As Long
    End Function

Function GetSysColor(nIndex)
    CallDLL #user32,  "GetSysColor",nIndex As Long,GetSysColor As Long
    End Function

Function GetWindow(hW, wFlag)
    'GW_HWNDFIRST = 0
    'GW_HWNDLAST = 1
    'GW_HWNDNEXT = 2
    'GW_HWNDPREV = 3
    'GW_OWNER = 4
    'GW_CHILD = 5
    'GW_MAX = 5
    CallDLL #user32, "GetWindow", hW as uLong, wFlag As Long, GetWindow As uLong
    End Function

Function GetDesktopWindow()
    CallDLL #user32, "GetDesktopWindow",GetDesktopWindow As uLong
    End Function

Function GetClassName$(hControl)
    class$=Space$(255)+Chr$(0)
    length = Len(class$)
    CallDLL #user32,"GetClassNameA",hControl as uLong, class$ As Ptr,_
    length As Long, returnLength As Long
    GetClassName$=Left$(class$, returnLength)
    End Function

Function GetAsyncKeyState(key)
    CallDLL #user32, "GetAsyncKeyState",key As Long, GetAsyncKeyState As Long
    End Function

Sub ExitWindows
    'can also use _EWX_SHUTDOWN
    CallDLL #user32, "ExitWindowsEx", _EWX_REBOOT As Long, 0 As Long,r As Boolean
    End Sub

Sub CloseWindow hW
    'minimizes window, doesn't actually close it
    CallDLL #user32, "CloseWindow",hW as uLong, r As Boolean
    End Sub

Sub GetClientRect hW
    CallDLL #user32, "GetClientRect",hW as uLong, Rect As struct,r As Long
    End Sub

Sub GetWindowRect hW
    CallDLL #user32, "GetWindowRect",hW as uLong,Rect As struct, result As Long
    End Sub

Sub ShowScrollBar hW, lFlag, bShow
    'hW=handle of graphicbox
    'flags=_SB_BOTH,_SB_HORZ,_SB_VERT
    'bShow, 1=show, 0=hide
    CallDLL #user32, "ShowScrollBar",hW as uLong,lFlag As Long,bShow As Boolean,re As Boolean
    End Sub

Sub ClientToScreen hW,x,y
    Point.x.struct=x
    Point.y.struct=y
    CallDLL #user32, "ClientToScreen",hW as uLong,Point As struct,r As Long
    End Sub

Sub ScreenToClient hW,x,y
    Point.x.struct=x : Point.y.struct=y
    CallDLL #user32, "ScreenToClient",hW as uLong,Point As struct,r As Long
    End Sub

Function GetWindowWord(hW)
    nIndex=-6
    CallDLL #user32, "GetWindowWord",hW as uLong,nIndex As Long,GetWindowWord As Word
    End Function

Function GetWindowLong(hW, type)
    CallDLL #user32, "GetWindowLongA",hW as uLong, type As Long,GetWindowLong As Long
    End Function

Function SetWindowLong(hW,index,newVal)
    CallDLL #user32, "SetWindowLongA",hW as uLong,index As Long,_
    newVal As Long,SetWindowLong As Long
    End Function

Sub SendMessagePtr hWnd,msg,w,p$
    CallDLL #user32, "SendMessageA", hWnd as uLong, _
    msg As Long, w As Long, p$ As Ptr, re As Long
    End Sub

Sub SendMessageLong hWnd,msg,w,l
    CallDLL #user32, "SendMessageA", hWnd as uLong, _
    msg As Long, w As Long, l As Long, re As Long
    End Sub

Sub SetFocus hWnd
    CallDLL #user32, "SetFocus", hWnd as uLong, result As Long
    End Sub

Function GetWindowText$(hWnd)
    Title$=Space$(100)+Chr$(0):l= Len(Title$)
    CallDLL #user32, "GetWindowTextA", hWnd as uLong,_
    Title$ As Ptr, l As Long, result As Long
    GetWindowText$=Trim$(Title$)
    End Function

Sub SetParent hWnd,hWndChild
    'hWndChild must be a dialog window or control for this to work properly
    CallDLL #user32, "SetParent", hWndChild as uLong, hWnd as uLong, result As Long
    End Sub

Function GetParent(hWnd)
    CallDLL #user32, "GetParent",hWnd as uLong, GetParent as uLong
    End Function

Sub ClipCursor xstart, ystart, xend, yend
    Rect.x1.struct=xstart : Rect.y1.struct=ystart
    Rect.x2.struct=xend :   Rect.y2.struct=yend
    CallDLL #user, "ClipCursor",Rect As struct, r As Boolean
    End Sub

Function ShowCursor(flag)
    '0=hide, 1=show
    CallDLL #user32, "ShowCursor", flag As Boolean,  ShowCursor As Long
    End Function

Sub SetCursorPos x,y
    CallDLL #user32, "SetCursorPos", x As Long, y As Long, result As Void
    End Sub

Function GetCursorPosX()
    CallDLL #user32, "GetCursorPos", Point As struct, result As Long
    GetCursorPosX = Point.x.struct
    End Function

Function GetCursorPosY()
    CallDLL #user32, "GetCursorPos", Point As struct, result As Long
    GetCursorPosY = Point.y.struct
    End Function

Function GetActiveWindow()
    CallDLL #user32, "GetActiveWindow",GetActiveWindow as uLong
    End Function

Sub FlashWindow hWnd, flag
    'flag=0 is normal color titlebar
    'flag=1 is inactive color
    CallDLL #user32, "FlashWindow", hWnd as uLong, flag As Boolean, result As Boolean
    End Sub

Sub MoveWindow hWnd,x,y,w,h
    CallDLL #user32, "MoveWindow",hWnd as uLong, x As Long, y As Long,_
        w As Long, h As Long, 1 As Boolean, r As Boolean
    End Sub

Sub ShowWindow hWnd, flag
    'SW_HIDE = 0
    'SW_NORMAL = 1
    'SW_SHOWMINIMIZED = 2
    'SW_MAXIMIZE = 3
    'SW_SHOWNOACTIVATE = 4
    'SW_SHOW = 5
    'SW_MINIMIZE = 6
    'SW_SHOWMINNOACTIVE = 7
    'SW_SHOWNA = 8
    'SW_RESTORE = 9
    CallDLL #user32, "ShowWindow",hWnd as uLong, flag As Long, r As Boolean
    End Sub

Sub AlwaysOnTop hWnd,x,y,w,h
    toTop = (-1 or 0)
    flags = _SWP_NOMOVE or _SWP_NOSIZE
    CallDLL #user32, "SetWindowPos", hWnd as uLong, toTop As Long, _
    x As Long, y As Long, w As Long, h As Long, flags As Long, result As Void
    End Sub

Sub SetWindowText hWnd, txt$
    CallDLL #user32, "SetWindowTextA", hWnd as uLong, txt$ As Ptr, result As Void
    End Sub

Sub BringWindowToTop hWnd
    CallDLL #user32, "BringWindowToTop",hWnd as uLong, result As Boolean
    End Sub

Sub EnableWindow hWnd, flag
    'Enable=1 Disable=0
    CallDLL #user32, "EnableWindow", hWnd as uLong, flag As Boolean, result As Boolean
    End Sub

Function SetButtonState(hButton, state)
    'state 0=up, 1=down
    CallDLL #user32, "SendMessageA",hButton as uLong,_
    _BM_SETSTATE As Long,state As Long,0 As Long,SetButtonState As Long
    End Function

Sub WinHelp hW,Help$
    'run a windows help file, hWnd can be 0
    'Help$ is filename of help file
    calldll #user32, "WinHelpA",hWnd as uLong,Help$ as ptr,_
    3 as long,dwData as long,re as long
    end sub

Sub LeftMouseClick
    'simulate left button mouse click
    dwFlags=_MOUSEEVENTF_ABSOLUTE or _MOUSEEVENTF_LEFTDOWN
    calldll #user32, "mouse_event",_
    dwFlags as ulong,dx as ulong,dy as ulong,_
    dwData as ulong,dwExtraInfo as ulong, re as void
    End Sub

'*******************************************
'MENU STUFF:
'*******************************************
Function TrackPopupMenu(hSubMenu,hWnd,mx,my)
    CallDLL #user32, "TrackPopupMenu",hSubMenu as uLong,_
    0 As Long, mx As Long, my As Long, 0 As Long,_
    hWnd as uLong, 0 As Long, TrackPopupMenu As Long
    End Function

Function AddCascadeMenu(hSubMenu,nPos,hCascade,MenuName$)
    menuflags=_MF_STRING or _MF_BYPOSITION or _MF_POPUP
    CallDLL #user32, "ModifyMenuA", hSubMenu as uLong,_
    nPos As Long, menuflags As Long, hCascade  As Long,_
    MenuName$ As Ptr, AddCascadeMenu As Boolean
    End Function

Function RemoveMenu(hMenu,hSubMenu)
    CallDLL #user32, "RemoveMenu", hMenu as uLong,_
    hSubMenu as uLong, _MF_BYCOMMAND As Long, RemoveMenu As Boolean
    End Function

Function InsertMenu(hSubMenu,menuid,Caption$)
    CallDLL #user32, "InsertMenuA",hSubMenu as uLong,_
    menuid As Long, flags As Long, menuid As Long,_
    Caption$ As Ptr, InsertMenu As Boolean
    End Function

Function DeleteMenu(hSubMenu,menuid)
    CallDLL #user32, "DeleteMenu", hSubMenu as uLong,_
    menuid As Long, _MF_BYCOMMAND As Long,DeleteMenu As Boolean
    End Function

Function ModifyMenuBitmap(hSubMenu,menuid,hPicture)
    FLAGS = _MF_BYCOMMAND OR _MF_BITMAP
    CallDLL #user32, "ModifyMenuA",hSubMenu as uLong,_
    menuid As Long, FLAGS As Long, menuid As Long,_
    hPicture as uLong, ModifyMenuBitmap As Boolean
    End Function

Function SetMenuItemBitmaps(hSubMenu,menuid,hCheckBMP,hUnCheckBMP)
    CallDLL #user32,"SetMenuItemBitmaps",hSubMenu as uLong,menuid As Long,_MF_BYCOMMAND As Long,_
    hCheckBMP as uLong ,hUnCheckBMP as uLong,SetMenuItemBitmaps As Boolean
    End Function

Function CheckMenuRadioItem(hSubMenu,first,last,menuid)
    CallDLL #user32,"CheckMenuRadioItem",_
    hSubMenu as uLong, first As Long,last As Long,_
    menuid As Long, 8 As Long,CheckMenuRadioItem As Boolean
    End Function

Function CheckMenuItem(hSubMenu,menuid,wCheck)
    'wCheck 0=unchecked,8=checked
    CallDLL #user32,"CheckMenuItem", hSubMenu as uLong,_
    menuid As Long, wCheck As Long, CheckMenuItem As Long
    End Function

Function EnableMenuItem(hSubMenu,menuid,menuflag)
    'menuflag 0=enabled,1=gray,2=disabled
    CallDLL #user32, "EnableMenuItem", _
    hSubMenu as uLong, menuid As Long,menuflag As Long, EnableMenu As Boolean
    End Function

Sub ModifyMenu hSubMenu, menuid, MenuName$
    menuflags=_MF_STRING or _MF_BYCOMMAND
    CallDLL #user32, "ModifyMenuA", hSubMenu as uLong,_
    menuid  As Long, menuflags As Long, menuid  As Long,_
    MenuName$ As Ptr, result As Boolean
    End Sub

Sub DrawMenuBar hWnd
    CallDLL #user32, "DrawMenuBar",hWnd as uLong, r As Boolean
    End Sub

Sub SetMenu hWnd,hMenu
    'if hMenu is valid menu handle, sets it to window
    'if hMenu is 0, removed menu
    CallDLL #user32, "SetMenu",hWnd as uLong,hMenu as uLong, results As Boolean
    End Sub

Function GetMenuItemID(hSubMenu,nPos)
    CallDLL #user32, "GetMenuItemID", hSubMenu as uLong, _
    nPos As Long, GetMenuItemID  As Long
    End Function

Function GetSubMenu(hMenuBar,nPos)
    CallDLL #user32, "GetSubMenu",_
    hMenuBar as uLong, nPos As Long, GetSubMenu as uLong
    End Function

Function GetMenu(hWnd)
    CallDLL #user32, "GetMenu",hWnd as uLong,GetMenu as uLong
    End Function

'*******************************************
'CONTROL CREATION STUFF
'*******************************************
Function CreateRiched(hW, x, y, w, h, style, text$)
    'suggested style = _WS_CHILD or _WS_VISIBLE or _ES_MULTILINE or _
    '_ES_AUTOVSCROLL or ESSUNKEN or _ES_NOHIDESEL or _WS_VSCROLL
    'IMPORTANT, BE SURE TO OPEN RICHED DLL IN PROGRAM BEFORE
    'MAKING THIS CALL!  CLOSE IT AT EXIT
    'open "riched32.dll" for dll as #riched 'in program body
    'close #riched  'at exit
    hInst=GetWindowLong(hW, _GWL_HINSTANCE)
    CallDLL #user32, "CreateWindowExA",0 As Long,"RICHEDIT" As Ptr,_
        text$ As Ptr, style As Long,x As Long,y As Long,w As Long,h As Long,_
        hW as uLong, 0 As Long, hInst as uLong, 0 As Long,CreateRiched as uLong
    End Function

Function CreateStatusWindow(hWnd,text$, id)
    CallDLL #comctl32, "InitCommonControls", re As Void
    style = _WS_VISIBLE or _WS_CHILD
    CallDLL #comctl32, "CreateStatusWindow", style As Long, _
    text$ As Ptr, hWnd as uLong, id As Long, CreateStatusWindow as uLong
    End Function

Function CreateProgressBar(hW, x, y, w, h)
    CallDLL #comctl32, "InitCommonControls", re As Void
    style = _WS_VISIBLE or _WS_CHILD
    hInst=GetWindowLong(hW, _GWL_HINSTANCE)
    CallDLL #user32, "CreateWindowExA",0 As Long,"msctls_progress32" As Ptr,_
        "" As Ptr, style As Long,x As Long,y As Long,w As Long,h As Long,_
        hW as uLong, 0 As Long, hInst as uLong, 0 As Long,CreateProgressBar as uLong
    End Function

Function CreateToolTips(hW,hControl,tip$)
    CallDLL #comctl32, "InitCommonControls", re As Void
    TTF.IDISHWND    = 1
    TTF.CENTERTIP   = 2
    TTF.SUBCLASS    = 16
    TTM.ADDTOOL     = 1028
    TTM.DELTOOL     = 1029
    TTS.ALWAYSTIP   = 1
    TTS.NOPREFIX    = 2
    style = _WS_POPUP or TTS.NOPREFIX or TTS.ALWAYSTIP
    hInstance=GetWindowLong(hW,_GWL_HINSTANCE )
    CallDLL #user32, "CreateWindowExA",_
    _WS_EX_TOPMOST As Long,"TOOLTIPS_CLASS32" As Ptr,"" As Ptr, style As Long,_
    _CW_USEDEFAULT As Long,_CW_USEDEFAULT As Long,_CW_USEDEFAULT As Long,_CW_USEDEFAULT As Long,_
    hW as uLong, 0 As Long, hInstance as uLong,0 As Long,hwndTT as uLong

    flags=_SWP_NOMOVE or _SWP_NOSIZE or _SWP_NOACTIVATE
    CallDLL #user32, "SetWindowPos", hwndTT as uLong,_HWND_TOPMOST As Long,_
    0 As Long, 0 As Long,0 As Long, 0 As Long,flags As Long, r As Long

    struct toolinfo1, cbSize As Long, uFlags As Long, hWnd as uLong, uId As Long, _
        left As Long, top As Long, right As Long, bottom As Long, hInst as uLong, lpstrText$ As Ptr

    toolinfo1.cbSize.struct = Len(toolinfo1.struct)
    toolinfo1.uFlags.struct = TTF.IDISHWND or TTF.SUBCLASS
    toolinfo1.hWnd.struct = hW
    toolinfo1.uId.struct = hControl
    toolinfo1.lpstrText$.struct = tip$

    CallDLL #user32, "SendMessageA", hwndTT as uLong, TTM.ADDTOOL As Long, _
    0 As Long, toolinfo1 As struct, re As Long
    CreateToolTips=hwndTT
    End Function

Function CreateCheckbox(hW, x, y, w, h, text$)
    style = _WS_CHILDWINDOW OR _WS_VISIBLE OR _BS_AUTOCHECKBOX
    hInst=GetWindowLong(hW, _GWL_HINSTANCE)
    CallDLL #user32, "CreateWindowExA",0 As Long,"BUTTON" As Ptr,_
        text$ As Ptr, style As Long,x As Long,y As Long,w As Long,h As Long,_
        hW as uLong, 0 As Long, hInst as uLong, 0 As Long,CreateCheckbox as uLong
    End Function

Function CreateRadiobutton(hW, x, y, w, h, text$)
    style = _WS_CHILDWINDOW OR _WS_VISIBLE OR _BS_AUTORADIOBUTTON
    hInst=GetWindowLong(hW, _GWL_HINSTANCE)
    CallDLL #user32, "CreateWindowExA",0 As Long,"BUTTON" As Ptr,_
        text$ As Ptr, style As Long,x As Long,y As Long,w As Long,h As Long,_
        hW as uLong, 0 As Long, hInst as uLong, 0 As Long,CreateRadiobutton as uLong
    End Function

Function CreateStaticText(hW, x, y, w, h, text$)
    style = _WS_CHILDWINDOW OR _WS_VISIBLE OR _SS_SIMPLE
    hInst=GetWindowLong(hW, _GWL_HINSTANCE)
    CallDLL #user32, "CreateWindowExA",0 As Long,"STATIC" As Ptr,_
        text$ As Ptr, style As Long,x As Long,y As Long,w As Long,h As Long,_
        hW as uLong, 0 As Long, hInst as uLong, 0 As Long,CreateStaticText as uLong
    End Function

Function CreateTextEdit(hW, x, y, w, h)
    style = _WS_CHILDWINDOW OR _WS_BORDER OR _WS_VISIBLE or _ES_MULTILINE or _WS_VSCROLL
    hInst=GetWindowLong(hW, _GWL_HINSTANCE)
    CallDLL #user32, "CreateWindowExA",0 As Long,"EDIT" As Ptr,_
        "" As Ptr, style As Long,x As Long,y As Long,w As Long,h As Long,_
        hW as uLong, 0 As Long, hInst as uLong, 0 As Long,CreateTextEdit as uLong
    End Function

Function CreateTextBox(hW, x, y, w, h)
    style = _WS_CHILDWINDOW OR _WS_BORDER OR _WS_VISIBLE
    hInst=GetWindowLong(hW, _GWL_HINSTANCE)
    CallDLL #user32, "CreateWindowExA",0 As Long,"EDIT" As Ptr,_
        "" As Ptr, style As Long, x As Long,y As Long,w As Long,h As Long,_
        hW as uLong, 0 As Long, hInst as uLong, 0 As Long,CreateTextBox as uLong
    End Function

Function CreateButton(hW, x, y, w, h, text$)
    style = _WS_CHILDWINDOW OR _WS_VISIBLE
    hInst=GetWindowLong(hW, _GWL_HINSTANCE)
    CallDLL #user32, "CreateWindowExA",0 As Long,"BUTTON" As Ptr,_
        text$ As Ptr, style As Long,x As Long,y As Long,w As Long,h As Long,_
        hW as uLong, 0 As Long, hInst as uLong, 0 As Long,CreateButton as uLong
    End Function

'*******************************************
'GRAPHICS STUFF
'
'IMPORTANT!  THE DEVICE CONTEXT MUST BE TO
'A GRAPHICBOX, AND THE GRAPHICBOX MUST
'RECEIVE A print #1.gbox, "down" COMMAND,
'OR THE GRAPHICS WON'T SHOW!
'*******************************************
Function GetDC(hWnd)
    CallDLL #user32, "GetDC",hWnd as uLong,GetDC as uLong
    End Function

Sub ReleaseDC hWnd, hDC
    CallDLL#user32,"ReleaseDC",hWnd as uLong,hDC as uLong,result As Long
    End Sub

Function GetWindowDC(hW)
    CallDLL #user32, "GetWindowDC", hW as uLong, GetWindowDC as uLong
    End Function

Function CreateCompatibleDC(hDC)
    CallDLL #gdi32,"CreateCompatibleDC", hDC as uLong, CreateCompatibleDC as uLong
    End Function

Sub DeleteDC hDC
    CallDLL #gdi32, "DeleteDC",hDC as uLong, r As Boolean
    End Sub

Sub Arc hDC,x1,y1,x2,y2,x3,y3,x4,y4
    CallDLL #gdi32, "Arc",hDC as uLong,x1 As Long,y1 As Long,x2 As Long,y2 As Long,_
        x3 As Long,y3 As Long,x4 As Long,y4 As Long,results As Boolean
    End Sub

Sub Chord hDC,x1,y1,x2,y2,x3,y3,x4,y4
    CallDLL #gdi32, "Chord",hDC as uLong,x1 As Long,y1 As Long,x2 As Long,y2 As Long,_
        x3 As Long,y3 As Long,x4 As Long,y4 As Long,results As Boolean
    End Sub

Sub Pie hDC,x1,y1,x2,y2,x3,y3,x4,y4
    CallDLL #gdi32, "Pie",hDC as uLong,x1 As Long,y1 As Long,x2 As Long,y2 As Long,_
        x3 As Long,y3 As Long,x4 As Long,y4 As Long,results As Boolean
    End Sub

Sub Rectangle hDC,x1,y1,x2,y2
    CallDLL #gdi32, "Rectangle",hDC as uLong, x1 As Long, y1 As Long,_
    x2 As Long, y2 As Long, r As Boolean
    End Sub

Sub RoundRect hDC,x1,y1,x2,y2
    x3=Int(Abs(x1-x2)/3):y3=Int(Abs(y1-y2)/3)
    CallDLL #gdi32, "RoundRect",hDC as uLong, x1 As Long, y1 As Long,_
    x2 As Long, y2 As Long, x3 As Long, y3 As Long,r As Boolean
    End Sub

Sub Ellipse hDC,x1,y1,x2,y2
    CallDLL #gdi32, "Ellipse",hDC as uLong, x1 As Long, y1 As Long,_
    x2 As Long, y2 As Long, r As Boolean
    End Sub

Sub DrawLine hDC,x1,y1,x2,y2
    CallDLL #gdi32, "MoveToEx",hDC as uLong,x1 As Long,y1 As Long,Point As struct,r As Boolean
    CallDLL #gdi32, "LineTo",hDC As Long,x2 As Long,y2 As Long,r As Boolean
    End Sub

Sub TextOut hDC,x,y,t$,red,green,blue
    crColor=red+(green*256)+(blue*256*256)
    CallDLL #gdi32, "SetTextColor",hDC as uLong,crColor As Long,result As Long
    ln=Len(t$)
    CallDLL #gdi32, "TextOutA",hDC as uLong,x As Long,y As Long,t$ As Ptr,ln As Long, r As Long
    End Sub

Sub DrawText hdc,text$,x,y,w,h
    length=Len(text$)
    style=_DT_WORDBREAK  OR _DT_CENTER
    Rect.x1.struct=x : Rect.y1.struct=y
    Rect.x2.struct=w : Rect.y2.struct=h

    CallDLL #user32,"DrawTextA", hdc as uLong,text$ As Ptr,length As Long,_
    Rect As struct, style As Long,result As Long
    End Sub

Sub SetTextColor hDC,red,green,blue
    crColor=red+(green*256)+(blue*256*256)
    CallDLL #gdi32, "SetTextColor",hDC as uLong,crColor As Long,result As Long
    End Sub

Function GetTextColor(hdc)
    CallDLL #gdi32, "GetTextColor",hdc as uLong,GetTextColor As Long
    End Function

Function GetTextExtentPoint32(hdc,text$)
    nCount=Len(text$)
    CallDLL #gdi32, "GetTextExtentPoint32A", hdc as uLong, _
    text$ As Ptr, nCount As Long, Point As struct, r As Boolean
    GetTextExtentPoint32=Point.x.struct
    End Function

Function GetTextExtentPoint(hdc,text$)
    nCount=Len(text$)
    CallDLL #gdi32, "GetTextExtentPointA", hdc As uLong, _
    text$ As Ptr, nCount As Long, Point As struct, GetTextExtentPoint As Boolean
    End Function

Function GetTextFace$(hdc)
    nNumChar=50
    lpFacename$=Space$(50)+Chr$(0)
    CallDLL #gdi32, "GetTextFaceA",hdc as uLong,_
    nNumChar As Long,lpFacename$ As Ptr,result As Long
    GetTextFace$=Left$(lpFacename$,result)
    End Function

Sub PatBlt hDC,x,y,w,h,flag
    '_BLACKNESS = 66
    '_DSTINVERT = 5570569
    '_PATCOPY   = 15728673
    '_PATINVERT = 5898313
    '_WHITENESS = 16711778
    CallDLL #gdi32, "PatBlt",hDC as uLong,x As Long,y As Long,w As Long,h As Long, flag As Ulong,r As Boolean
    End Sub

Sub StretchBlt hDCdest,x,y,w,h,hDCsrc,x2,y2,w2,h2
    CallDLL #gdi32, "SetStretchBltMode",hDCdest As Long,_COLORONCOLOR As Long,RESULT As Long
    CallDLL #gdi32, "StretchBlt",hDCdest as uLong,x As Long,y As Long,w As Long,h As Long,_
    hDCsrc as uLong,x2 As Long,y2 As Long,w2 As Long, h2 As Long, _SRCCOPY As Ulong,RESULT As Boolean
    End Sub

Sub BitBlt hDCdest,x,y,w,h,hDCsrc,x2,y2
    CallDLL #gdi32, "BitBlt",hDCdest As uLong,x As Long,y As Long,w As Long,h As Long,_
    hDCsrc As Long,x2 As Long,y2 As Long,_SRCCOPY As Ulong,RESULT As Boolean
    End Sub

Sub SetStretchBltMode hdc, nMode
    CallDLL #gdi32, "SetStretchBltMode",hdc as uLong,nMode As Long,RESULT As Long
    End Sub

Function GetStretchBltMode(hdc)
    CallDLL #gdi32, "GetStretchBltMode",hdc as uLong,GetStretchBltMode As long
    End Function

Function SelectObject(hDC,hObject)
    CallDLL #gdi32,"SelectObject",hDC as uLong,hObject as uLong,SelectObject as uLong
    'returns previously selected object
    End Function

Sub DeleteObject hObject
    CallDLL #gdi32,"DeleteObject",hObject as uLong,r As Boolean
    End Sub

Function CreateCompatibleBitmap(hDC,w,h )
    CallDLL #gdi32, "CreateCompatibleBitmap", hDC as uLong,w As Long,h As Long, CreateCompatibleBitmap as uLong
    End Function

Function CreateSolidBrush(red,green,blue)
    crColor=red+(green*256)+(blue*256*256)
    CallDLL #gdi32, "CreateSolidBrush",crColor As Long,CreateSolidBrush as uLong
    End Function

Function CreateHatchBrush(red,green,blue,style)
    '_HS_BDIAGONAL
    '_HS_CROSS
    '_HS_DIAGCROSS
    '_HS_FDIAGONAL
    '_HS_HORIZONTAL
    '_HS_VERTICAL
    crColor=red+(green*256)+(blue*256*256)
    CallDLL #gdi32, "CreateHatchBrush",_
    style  As Long, crColor As Long, CreateHatchBrush as uLong
    End Function

Function CreatePen(red,green,blue,style,width)
    'style:
    '_PS_SOLID
    '_PS_DASH
    '_PS_DOT
    '_PS_DASHDOT
    '_PS_DASHDOTDOT
    '_PS_NULL
    '_PS_INSIDEFRAME
    crColor = blue*65536 + green*256 + red
    CallDLL #gdi32, "CreatePen",style As Long,width As Long,crColor As Long,CreatePen as uLong
    End Function

Sub SetBkMode hDC, flag
    '1=transparent
    '2=opaque
    CallDLL #gdi32, "SetBkMode",hDC as uLong,flag As Long, RESULT As Long
    End Sub

Sub SetPixel hDC,x,y,color
    CallDLL#gdi32,"SetPixel",hDC as uLong,x As Long,y As Long,color As Long,result As Long
    End Sub

Function GetPixel(hDC,x,y)
    CallDLL #gdi32, "GetPixel", hDC as uLong,x As Long,y As Long, GetPixel As Long
    End Function

Function GetRed(color)
    blue=Int(color/(256*256))
    green=Int((color-blue*256*256)/256)
    GetRed=color-blue*256*256-green*256
    End Function

Function GetGreen(color)
    blue=Int(color/(256*256))
    GetGreen=Int((color-blue*256*256)/256)
    End Function

Function GetBlue(color)
    GetBlue=Int(color/(256*256))
    End Function

Function CreateEllipticRgn(x1,y1,x2,y2)
    CallDLL #gdi32, "CreateEllipticRgn",x1 As Long,y1 As Long,_
    x2 As Long,y2 As Long,CreateEllipticRgn as uLong
    End Function

Function CreateRectRgn(x1,y1,x2,y2)
    CallDLL #gdi32, "CreateRectRgn",x1 As Long,y1 As Long,x2 As Long,y2 As Long, CreateRectRgn as uLong
    End Function

Function CreateRoundRectRgn(x1,y1,x2,y2)
    x3=Int(Abs(x1-x2)/3) : y3=Int(Abs(y1-y2)/3)
    CallDLL #gdi32, "CreateRoundRectRgn",x1 As Long,y1 As Long,_
    x2 As Long,y2 As Long,x3 As Long,y3 As Long,CreateRoundRectRgn as uLong
    End Function

Sub FillRegn hDC,hRegn,red,green,blue
    crColor=red+(green*256)+(blue*256*256)
    CallDLL #gdi32, "CreateSolidBrush",crColor As Long,hNewBrush as uLong
    CallDLL #gdi32, "FillRgn",hDC as uLong,hRegn as uLong,hNewBrush as uLong,result As Boolean
    CallDLL #gdi32,"DeleteObject",hNewBrush as uLong,r As Boolean
    End Sub

Sub FrameRegn hDC,hRegn,red,green,blue,size
    crColor=red+(green*256)+(blue*256*256)
    CallDLL #gdi32, "CreateSolidBrush",crColor As Long,hNewBrush as uLong
    CallDLL #gdi32, "FrameRgn",hDC as uLong,hRegn as uLong,hNewBrush as uLong,size As Long, size As Long,result As Boolean
    CallDLL #gdi32,"DeleteObject",hNewBrush as uLong,r As Boolean
    End Sub

Sub PaintRegn hDC,hRegion
    CallDLL #gdi32, "PaintRgn",hDC as uLong,hRegion as uLong,result As Boolean
    End Sub

Sub InvertRegn hdc, hRegion
    CallDLL #gdi32, "InvertRgn",hdc as uLong,hRegion as uLong,result As Boolean
    End Sub

Function PtInRegn(hRegion, x, y)
    CallDLL #gdi32, "PtInRegion",_
    hRegion as uLong, x As Long,y As Long,PtInRegn As Boolean
    End Function

Function CreateFont(face$,width,height,bold,italic,underline,strikeout)
'bold, italic, underline strikeout = 1 for yes, 0 for no
'width can be 0 for default width
    If bold>0 Then bold=700
    CallDLL #gdi32, "CreateFontA", height As Long, _
    width As Long,escapement As Long,0 As Long, _
    weight As Long,italic As Long, _
    underline As Long,strikeout As Long, _
    0 As Long,0 As Long,0 As Long,0 As Long,0 As Long, _
    face$ As Ptr, CreateFont as uLong
    End Function

Function BitmapWidth(Hbmp)
    struct BITMAP,_
    bmType As Long,_
    bmWidth As Long,_
    bmHeight As Long,_
    bmWidthBytes As Long,_
    bmPlanes As Word,_
    bmBitsPixel As Word,_
    bmBits As Long

    nSize=Len(BITMAP.struct)
    CallDLL #gdi32, "GetObjectA", Hbmp As uLong,_
       nSize As Long,BITMAP As struct,_
       results as uLong

    BitmapWidth=BITMAP.bmWidth.struct
End Function

Function BitmapHeight(Hbmp)
    struct BITMAP,_
    bmType As Long,_
    bmWidth As Long,_
    bmHeight As Long,_
    bmWidthBytes As Long,_
    bmPlanes As Word,_
    bmBitsPixel As Word,_
    bmBits As Long

    nSize=Len(BITMAP.struct)
    CallDLL #gdi32, "GetObjectA", Hbmp as uLong,_
       nSize As Long,BITMAP As struct,_
       results as uLong

    BitmapHeight=BITMAP.bmHeight.struct
End Function

Function GetCurrentPositionX(hdc)
    CallDLL #gdi32, "GetCurrentPositionEx",_
    hdc as uLong, Point As struct,re As Boolean
    GetCurrentPositionX=Point.x.struct
    End Function

Function GetCurrentPositionY(hdc)
    CallDLL #gdi32, "GetCurrentPositionEx",_
    hdc as uLong, Point As struct,re As Boolean
    GetCurrentPositionY=Point.y.struct
    End Function

Function GetStockObject(obj)
    CallDLL #gdi32, "GetStockObject",obj as Long,_
    GetStockObject as uLong
    End Function

Sub SetBkColor hdc,rgbColor
    CallDLL #gdi32, "SetBkColor", hdc as uLong,_
    rgbColor As Long, result As Long
    End Sub

Function GetBkColor(hdc)
    CallDLL #gdi32, "GetBkColor", hdc as uLong,_
    GetBkColor As Long
    End Function

Function GetBkMode(hdc)
    '1=transparent,2=opaque
    CallDLL #gdi32, "GetBkMode",hdc as uLong,GetBkMode As Long
    End Function

Sub PolyLine hdc,X1,Y1,X2,Y2,X3,Y3
    struct PolyPoints,_
    x1 As Long, y1 As Long,_
    x2 As Long, y2 As Long,_
    x3 As Long, y3 As Long,_

    PolyPoints.x1.struct = X1
    PolyPoints.y1.struct = Y1
    PolyPoints.x2.struct = X2
    PolyPoints.y2.struct = Y2
    PolyPoints.x3.struct = X3
    PolyPoints.y3.struct = Y3
    nCount=3
    CallDLL #gdi32, "Polyline", hdc As Long,_
    PolyPoints As struct,nCount As Long,_
    result As Boolean
    End Sub

Sub Polygon hdc, X1,Y1,X2,Y2,X3,Y3,X4,Y4
    'a triangle, for test purposes - add points
    'for more sides on polygon
    'X1 must = X4, Y1 must = Y4
    struct PolyPoints,x1 As Long,y1 As Long,_
    x2 As Long,y2 As Long,x3 As Long,y3 As Long,_
    x4 As Long, y4 As Long

    nCount=4
    PolyPoints.x1.struct = X1
    PolyPoints.y1.struct = Y1
    PolyPoints.x2.struct = X2
    PolyPoints.y2.struct = Y2
    PolyPoints.x3.struct = X3
    PolyPoints.y3.struct = Y3
    PolyPoints.x4.struct = X4
    PolyPoints.y4.struct = Y4

    CallDLL #gdi32, "Polygon",hdc As uLong,_
    PolyPoints As struct,nCount As Long,result As Boolean
    End Sub

Sub PolyPolygon hdc,X1,Y1,X2,Y2,X3,Y3,X4,Y4,X5,Y5,X6,Y6,X7,Y7,X8,Y8,X9,Y9
    'nine points as example - can add as needed
    'requires struct of structs for each point
    struct p, a As struct, b As struct, c As struct, d As struct,_
    e As struct, f As struct, g As struct, h As struct, i As struct

    'structs for points:
    struct a,x1 As Long, y1 As Long
    struct b,x2 As Long, y2 As Long
    struct c,x3 As Long, y3 As Long
    struct d,x4 As Long, y4 As Long
    struct e,x5 As Long, y5 As Long
    struct f,x6 As Long, y6 As Long
    struct g,x7 As Long, y7 As Long
    struct h,x8 As Long, y8 As Long
    struct i,x9 As Long, y9 As Long

    'fill point structs:
    a.x1.struct = X1
    a.y1.struct = Y1
    b.x2.struct = X2
    b.y2.struct = Y2
    c.x3.struct = X3
    c.y3.struct = Y3
    d.x4.struct = X4
    d.y4.struct = Y4
    e.x5.struct = X5
    e.y5.struct = Y5
    f.x6.struct = X6
    f.y6.struct = Y6
    g.x7.struct = X7
    g.y7.struct = Y7
    h.x8.struct = X8
    h.y8.struct = Y8
    i.x9.struct = X9
    i.y9.struct = Y9

    'fill struct of point structs:
    p.a.struct=a.struct
    p.b.struct=b.struct
    p.c.struct=c.struct
    p.d.struct=d.struct
    p.e.struct=e.struct
    p.f.struct=f.struct
    p.g.struct=g.struct
    p.h.struct=h.struct
    p.i.struct=i.struct

    struct PolyTotal, p1 As Long, p2 As Long
    PolyTotal.p1.struct=4     '4 pairs for first polygon
    PolyTotal.p2.struct=5     '5 pairs for second polygon

    nCount=2                  'number of items in PolyTotal Struct
    CallDLL #gdi32, "PolyPolygon",hdc as uLong,p As struct,PolyTotal As struct,_
    nCount As Long,result As Boolean
    End Sub

Function SetPolyFillMode(hdc,nMode)
    '_ALTERNATE = 1 _WINDING = 2
    CallDLL #gdi32, "SetPolyFillMode", hdc as uLong, nMode As Long,SetPolyFillMode As Long
    End Function

Function GetPolyFillMode(hdc)
    CallDLL #gdi32, "GetPolyFillMode",hdc as uLong, GetPolyFillMode As Long
    End Function

Function SaveDC(hdc)
    CallDLL #gdi32, "SaveDC",hdc as uLong, SaveDC as uLong
    End Function

Function RestoreDC(hdc,hSaved)
    CallDLL #gdi32, "RestoreDC",hdc as uLong,hSaved as uLong,RestoreDC As Boolean
    End Function

'*******************************************
'ADVAPI32.DLL STUFF
'*******************************************
Function GetUserName$()
    Open "advapi32" For DLL As #ad
    buf$=Space$(100)+Chr$(0)
    struct size,L As Long
    size.L.struct=100
    CallDLL #ad,"GetUserNameA",buf$ As Ptr,size As struct,re As Long
    Close #ad
    GetUserName$=Trim$(buf$)
    End Function

'*******************************************
'HARD-COPY PRINTING
'*******************************************

Function Horzres(pDC)  'printable width of page in dots
    CallDLL #gdi32, "GetDeviceCaps",pDC as uLong, _
    _HORZRES As Long, Horzres As Long
    End Function

Function Vertres(pDC)  'printable height of page in dots
    CallDLL #gdi32, "GetDeviceCaps", pDC as uLong, _
    _VERTRES As Long, Vertres As Long
    End Function

Function Logpixelsx(pDC) 'dots per inch width
    CallDLL #gdi32, "GetDeviceCaps", pDC as uLong, _
    _LOGPIXELSX As Long, Logpixelsx As Long
    End Function

Function Logpixelsy(pDC) 'dots per inch height
    CallDLL #gdi32, "GetDeviceCaps", pDC as uLong, _
    _LOGPIXELSY As Long, Logpixelsy As Long
    End Function

Function PhysicalWidth(pDC) 'actual paper width
    CallDLL #gdi, "GetDeviceCaps", pDC as uLong, _
    _PHYSICALWIDTH As Long, PhysicalWidth As Long
    End Function

Function PhysicalHeight(pDC) 'actual paper height
    CallDLL #gdi32, "GetDeviceCaps", pDC as uLong, _
    _PHYSICALHEIGHT As Long, PhysicalHeight As Long
    End Function

Function PhysicalOffsetx(pDC) 'left unprintable margin in dots per inch
    CallDLL #gdi32, "GetDeviceCaps", pDC as uLong, _
    _PHYSICALOFFSETX As Long, PhysicalOffsetx As Long
    End Function

Function PhysicalOffsety(pDC) 'top unprintable margin in dots per inch
    CallDLL #gdi32, "GetDeviceCaps", pDC as uLong, _
    _PHYSICALOFFSETY As Long, PhysicalOffsety As Long
    End Function

Function EndDoc(pDC) 'end document print
    CallDLL #gdi32, "EndDoc",pDC as uLong,EndDoc As Long
    End Function

Function EndPage(pDC) 'end page/eject
    CallDLL #gdi32, "EndPage",pDC as uLong,EndPage As Long
End Function

Function StartPage(pDC) 'start new page
    CallDLL #gdi32, "StartPage",pDC as uLong,StartPage As Long
    End Function

Function StartDoc(pDC) 'start document print
    struct docInfo, _
    cbSize As Long,_
    lpszDocName$ As Ptr,_
    lpszOutput$ As Ptr,_
    lpszDatatype$ As Ptr,_
    fwType As Ulong

    docInfo.cbSize.struct=Len(docInfo.struct)
    docInfo.lpszDocName$.struct="Printer Test"+Chr$(0)

    CallDLL #gdi32, "StartDocA",pDC as uLong,_
    docInfo As struct, StartDoc As Long
End Function

Function PrinterDialogDC() 'printer dialog returns DC
    struct PD,lStructSize As Ulong,_
    hwndOwner as uLong,hDevMode As Long,_
    hDevNames As Long,hDC as uLong,_
    Flags As Ulong,nFromPage As Word,_
    nToPage As Word,nMinPage As Word,_
    nMaxPage As Word,nCopies As Word,_
    hInstance as uLong,lCustData As Ulong,_
    lpfnPrintHook As Long,lpfnSetupHook As Long,_
    lpPrintTemplateName As Long,lpSetupTemplateName As Long,_
    hPrintTemplate As Long,hSetupTemplate As Long

    PD.Flags.struct=_PD_RETURNDC
    PD.lStructSize.struct=Len(PD.struct)
    CallDLL #comdlg32, "PrintDlgA",PD As struct, r As Long
    PrinterDialogDC=PD.hDC.struct
    End Function

Function PrinterDefaultDC() 'default printer, returns DC
    'setup values for GetProfileStringA
    appName$ = "windows"
    keyName$ = "device"
    default$ = ""
    result$ = Space$(49)+Chr$(0)
    size = 50
    'get printer and driver info
    CallDLL #kernel32, "GetProfileStringA",_
    appName$ As Ptr,keyName$ As Ptr,default$ As Ptr,result$ As Ptr,_
    size As Long,result As Long

    profile$ = Left$(result$, Instr(result$, Chr$(0)) - 1)

    'parse returned string for individual members
    j = Instr(profile$, ",", 1)
    PrtName$ = Left$(profile$, j-1)
    j = j + 1
    k = Instr(profile$, ",", j)
    Driver$ = Mid$(profile$, j, k-j)
    Output$ = Right$(profile$, Len(profile$)-k)
    Init$ = ""

    'use driver info to create a Device context for printer
    CallDLL #gdi32 , "CreateDCA", _
    Driver$ As Ptr,PrtName$ As Ptr,Output$ As Ptr, _
    Init$ As Ptr, PrinterDefaultDC as uLong
    End Function


