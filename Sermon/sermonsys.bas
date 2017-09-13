'List of Changes as of v1.0
    'v1.51 - Added support for 2 servers
    'v1.5 - Updated sermon location to match new church web site
    'v1.4 - Added code for auto prompt of options on first start!
    'v1.3 - Added line to quit downloading if shutdown file found. This makes it possible to shutdown without having to finish getting all sermons
    'v1.2 - Fixed issues in GUI, added file command 'newsermon', added commands to delete shutdown command files on startup to avoid confusion

[load.vars]'BRANCH 'load vars
version = 1.51
SermonLocation$ = "http://sgcsc.org/sermons/"
SermonLocation2$ = "http://djcomputers.org/gccmp3/"
tmp$ = date$("mm/dd/yy")' "The Sermon's Name Format"
SermonNameFor$ = word$(tmp$,1,"/")+"."+word$(tmp$,2,"/")+"."+word$(tmp$,3,"/")
minutedelay = 5 'Wait in mins before checking for a sermon
timedelay = 1000*60*minutedelay
doai = 1'Use 'ai' to get sermon name
getsermon$ = ""
SermonExt$ = "mp3" 'Sermon file extention
SecondExt$ = "" 'Secondary extention just in case
COMMAND$ = ""'Background system for executing internal (Maybe external someday!) commands
SermonSaveDir$ = "D:\TYLER\My Documents\My Music\GCC Sermons"+"\" 'Guess what this means!
daynum = val(date$("days"))
STARTCHECK = 7 'Ignore this, i dont know what it does right now :) Kinda forgot......
checkdays = 7' days to check in past
useGUI = 1 'Do not accept inputed commands if set to 1
startup = 1
BETA = 0'Show beta warnings and notices durring execution
skipstartgui = 1'If set to 1, will not load window that gives the user to end the program.
checkcont = 0'goes up 1 for every 3 minutes, this helps to know when to start sermon checking
nomainwin
dim info$(10,10)
IF BETA = 1 then notice "Look Out!"+chr$(13)+"Welcome to Adelphos Pro Sermon Downloader v";version;"! This is the beta testing of the main code."+chr$(13)+"A GUI (Windows and buttons) will be created soon."+chr$(13)+"For now, please end this program from the task manager (Ctrl-Alt-Delete), I am working on a system tray icon."+chr$(13)+"Thanks for helping!"
goto [preload]
end

[preload]'BRANCH 'Load DLLs and Files
'open "user32" for dll as #user
'open "shell32" for dll as #shell
IF fileExists("","Sermons.exe") then gosub [startgui]'Startup sermongui.tkn if not started
IF fileExists("","shutdownok") then kill "shutdownok"
IF fileExists("","shutdown") then kill "shutdown"
gosub [load.options]
timer 3000, [start.timersystem]
IF skipstartgui = 1 then [raw.GUI]
goto [main.window]
wait

[startgui]
IF fileExists("","guistate") then run "sermons.exe sermongui.tkn":return
'Now double check
open "PINGGUI" for output AS #verifyGUI
close #verifyGUI
quickexit = 0
while fileExists("","PINGGUI") and quickexit = 10 = 0
calldll #kernel32, "Sleep", 1000 as long, re as void
quickexit = quickexit + 1
wend
IF quickexit = 10 then run "sermons.exe sermongui.tkn"
return

[load.options]
file.command$ = ""
IF fileExists("","settings.ini") = 0 then gosub [create.options]
open "settings.ini" for input AS #rs
while eof(#rs) <> 0 = 0 and file.command$ = "eof" = 0
 Line input #rs, fileread$
 file.command$ = lower$(word$(fileread$,1,"="))
 file.subcommand$ = word$(fileread$,2,"=")
  IF file.command$ = "savedir" then
   IF file.subcommand$ = SermonSaveDir$ = 0 then OldSermonSave$ = SermonSaveDir$
  SermonSaveDir$ = file.subcommand$
  end if
  IF file.command$ = "checkdays" then checkdays = val(file.subcommand$)
  IF file.command$ = "minutedelay" then minutedelay = val(file.subcommand$):timedelay = 1000*60*minutedelay
wend
close #rs
return

[create.options]
open "settings.ini" for output AS #sf
print #sf, "savedir="+DefaultDir$+"\"
print #sf, "minutedelay=30"
print #sf, "checkdays=7"
print #sf, "eof"
close #sf
return

[main.window]'BRANCH
return

[start.timersystem]
IF downloaddoing = 1 then wait
IF fileExists("","reloadoptions") then kill "reloadoptions":gosub [load.options]
IF fileExists("","movesermons") then kill "movesermons":gosub [moveSermons]
IF fileExists("","shutdown") then kill "shutdown":goto [end.all]
IF fileExists("","do.download") then kill "do.download":checkcont = 0:goto [download.system]
IF startup = 1 then startup = 0:goto [download.system]
checkcont = checkcont + 1'20 = 1 minute at 1+ for every 3seconds
'IF DayofWeek$(tmp$) = "Sunday" = 0 and DayofWeek$(tmp$) = "Tuesday" = 0 then print "Not Day": wait
IF checkcont = 20*minutedelay then checkcont = 0:goto [download.system]
wait

[moveSermons]
gosub [load.options]
while downloaddoing = 1
wend
IF OldSermonSave$ = "" then notice "Error!":return
downloaddoing = 1 'Keep system from downloading sermons
IF fileExists("","reloadoptions") then kill "reloadoptions"
files OldSermonSave$, "."+SermonExt$, info$(
IF val(info$(0,0)) = 0 then downloaddoing = 0:return
for copyfiles = 1 to val(info$(0,0))
name OldSermonSave$+info$(copyfiles,0) as SermonSaveDir$+info$(copyfiles,0)
next copyfiles
downloaddoing = 0
notice "Sermons Moved!"
return



[raw.GUI]'BRANCH
print "Comands:"
print "check = Check for sermon"
print "download = check and download sermon"
print "quit = quit this program"
print "getfile = download a file"
'IF useGUI = 1 then wait
wait

'Old code below, keeping just in case!
while COMMAND$ = ""
scan
'input "ADPSD> ";COMMAND$
WEND
gosub [rawsystem]
IF system.error = 1 then NOTICE ERROR$
gosub [CLEAR.SYSTEM]
goto [raw.GUI]
end

[CLEAR.SYSTEM]'BRANCH 'Empty some vars
cls
print "Command "+COMMAND$+" Completed!"
COMMAND$ = ""
system.error = 0
ERROR$ = ""
return

[end.all]
while downloaddoing = 1 'Make sure download operations are not executing
calldll #kernel32, "Sleep", 100 as long, re as void
wend
while fileExists("","newsermon.*") 'Wait for the GUI to show new sermon status if any
calldll #kernel32, "Sleep", 100 as long, re as void
wend
timer 0
IF skipstartgui = 0 then print #root, "trapclose"
IF skipstartgui = 0 then close #root
open "shutdownok" for output AS #didit
close #didit
end

[rawsystem]'BRANCH'This will always be here. It controls everything.
IF COMMAND$ = "quit" then goto [end.all]
IF COMMAND$ = "download" then return.system = 1:gosub [download.system]
IF COMMAND$ = "check" then gosub [check.system]
IF COMMAND$ = "days" then prompt "Days ago: ";STARTCHECK
if COMMAND$ = "getfile" then gosub [getfile]
return

[getfile]
input "Internet Address: ";getfile.file$
getfile.file$ = SermonLocation$+getfile.file$
'IF getfile.file$ = "" then getfile.file$ = SermonLocation$+"06.18.06.mp3"'"http://adelphospro.homeip.net/downloads/ftp/updates/backfire/updates.dat"
input "File name: ";getfile.save$
IF getfile.file$ = "" or getfile.save$ = "" then return
downurl$ = getfile.file$
downto$ = getfile.save$
print " Downloading "+downurl$+ " to "+downto$
gosub [download.file]
IF fileExists("",downto$) = 0 then PRINT "Not Downloaded":return
IF fileExists("",downto$) then PRINT "Downloaded!"
confirm "Remove file?";QA$
IF QA$ = "yes" then kill downto$
return

[newfolder]
open "newfolder" for output as #sc
close #sc
while fileExists("","newfolder")
calldll #kernel32, "Sleep", 500 as long, re as void
wend
return

'NOT FN
[download.system]'BRANCH 'This is the main download system! It contains NO AI so sermon file name will have to be predeclared by code or user
PRint "Preparing to Download...."
IF downloaddoing = 1 then wait
IF SermonSaveDir$ = DefaultDir$+"\" then gosub [newfolder]
open "downloading" for output AS #sendcommand
close #sendcommand
downloaddoing = 1
foundsome = 0
tmp$ = date$("mm/dd/yy")' "The Sermon's Name Format"
    print "1..."
tmp2$ = date$(tmp$)
    print "2..."
rootdate = val(tmp2$)
getyear$ = right$(tmp2$,2)
getrest$ = left$(tmp2$,len(tmp2$)-4)
tmp2$ = getrest$+getyear$
for tmploop = 0 to checkdays
 tmp2 = rootdate - tmploop
 tmp2$ = date$(str$(tmp2))
    ' print "Finding..."
tmp3$ = date$(tmp2)
 getyear$ = right$(tmp3$,2)
 getrest$ = left$(tmp3$,len(tmp3$)-4)
 tmp3$ = getrest$+getyear$
SermonNameFor$ = str$(val(word$(tmp3$,1,"/")))+"."+str$(val(word$(tmp3$,2,"/")))+"."+word$(tmp3$,3,"/")
downurl$ = SermonLocation$+SermonNameFor$+"."+SermonExt$
downto$ = SermonSaveDir$+SermonNameFor$+"."+SermonExt$
issunday = 0
checkingdate$ = date$(tmp2)
IF DayofWeek$(checkingdate$) = "Sunday" then issunday = 1
IF fileExists("",downto$) = 0 and issunday = 1 then
    print "Checking for Sermon for "+tmp3$
    gosub [download.file]
    IF fileExists("",downto$) then gosub [is.empty]
end if

IF fileExists("",downto$) = 0 and issunday = 1 then
    downurl$ = SermonLocation2$+SermonNameFor$+"."+SermonExt$
    downto$ = SermonSaveDir$+SermonNameFor$+"."+SermonExt$
    print "Checking for Sermon for "+tmp3$
    gosub [download.file]
    IF fileExists("",downto$) then gosub [is.empty]
end if

issunday = 0
IF fileExists("","reloadoptions") then exit for
IF fileExists("","shutdown") then exit for'End search so system can shutdown
next tmploop
print "DONE!"
'IF foundsome > 0 then notice foundsome;" Sermon(s) downloaded!"
kill "downloading"
IF foundsome > 0 then
open "newsermon."+str$(foundsome) for output As #sendcommand 'Tell Gui of new sermon!
close #sendcommand
end if
downloaddoing = 0
IF return.system = 1 then return.system = 0:return
wait

[is.empty]
open downto$ for input AS #checkme
testit$ = input$(#checkme,9)
close #checkme
IF testit$ = "<!DOCTYPE" then print "Sermon not found":kill downto$:return
Print "Sermon downloaded!"
foundsome = foundsome + 1
return

[download.file]
down.a$ = downurl$ '"http://adelphospro.homeip.net/index.htm"
down.b$ = downto$ '"new.jpg"
down.c$ = "tmpfile.down"
down.run$ = "cscript.exe"
downscript$ = "download.vbs"
down.run2$ = downscript$+" "; down.a$; " "; down.c$
IF fileExists("",down.b$) then kill down.b$
IF fileExists("",down.c$) then kill down.c$
IF fileExists("",downscript$) = 0 then gosub [download.create]
call RunWait down.run$,down.run2$,"",0
IF fileExists("",down.c$) = 0 then print "Not found!": return 'File not downloaded because it was not found
name down.c$ as down.b$
return

[download.create]
print " + Creating download Script...."
open downscript$ for output as #1
print #1, "Set objArgs = WScript.Arguments"
print #1, "url = objArgs(0)"
print #1, "pix = objArgs(1)"
print #1, "With CreateObject("; chr$(34); "MSXML2.XMLHTTP"; chr$(34); ")"
print #1, " .open "; chr$(34); "GET"; chr$(34); ", url, False"
print #1, " .send"
print #1, " a = .ResponseBody"
print #1, " End With"
print #1, " With CreateObject("; chr$(34); "ADODB.Stream"; chr$(34); ")"
print #1, " .Type = 1 'adTypeBinary"
print #1, " .Mode = 3 'adModeReadWrite"
print #1, " .Open"
print #1, " .Write a"
print #1, " .SaveToFile pix, 2 'adSaveCreateOverwrite"
print #1, " .Close"
print #1, " End With"
close #1
print " + Done"
return

[tray.sendToTray] 'Send the aplication to the system tray
    calldll #user32,"ShowWindow",_
        hwnd as long,_
        _SW_HIDE as long,_
        ret as boolean
    calldll #shell32,"Shell_NotifyIconA",_
        0 as long,_
        Tray as struct,_
        inTray as long
goto [tray.inputLoop]

[tray.removeFromTray] 'Remove the aplication from the system tray
    calldll #user32,"ShowWindow",_
        hwnd as long,_
        _SW_SHOW as long,_
        ret as boolean
    calldll #shell32,"Shell_NotifyIconA",_
        2 as long,_
        Tray as struct,_
        inTray as long
goto [tray.inputLoop]

Function LoadImage(imagePath$,width,height)
    calldll #user32, "LoadImageA",_
        0 as long,_
        imagePath$ as ptr,_
        1 as long,_
        width as long,_
        height as long,_
        16 as long,_
        LoadImage as long
End Function

Function TrayMsg( hWnd, uMsg, wParam, lParam )
    Msg(0) = 0
    if uMsg = _WM_USER + 1 then
        if lParam = _WM_LBUTTONUP then Msg(0) = 1
        if lParam = _WM_RBUTTONUP then Msg(0) = 2
    end if
End Function

sub RunWait file$, para$, dir$, type
' sub to open an application or file
'
' Usage:
' call RunWait {filename}, {parameters}, {startfolder}
'
' filename ...... full path to file or executable
' parameters .... if file is a document this should be empty
'                 if file is an executable any parameters
'                 that should be passed to it
' startfolder ... initial folder, can be empty

    SEE.MASK.NOCLOSEPROCESS = hexdec("40")
    SEE.MASK.FLAG.DDEWAIT = hexdec("100")

    struct ExecInfo, _
        Size        as long, _
        fMask     as long, _
        hwnd        as long, _
        Verb$     as ptr, _
        File$     as ptr, _
        Parameters$ as ptr, _
        Directory$ as ptr, _
        Show        as long, _
        InstApp     as long, _
        IDList     as long, _
        Class$     as ptr, _
        keyClass    as long, _
        HotKey     as long, _
        Icon        as long, _
        Process     as long

    ExecInfo.fMask.struct = SEE.MASK.NOCLOSEPROCESS or SEE.MASK.FLAG.DDEWAIT
    ExecInfo.File$.struct = file$ + chr$(0)
    ExecInfo.Parameters$.struct = para$ + chr$(0)
    ExecInfo.Directory$.struct = dir$ + chr$(0)
    IF type = 0 then ExecInfo.Show.struct = _SW_HIDE
    IF type = 1 then ExecInfo.Show.struct = _SW_SHOWNORMAL
    ExecInfo.Size.struct = len(ExecInfo.struct)

    calldll #shell32, "ShellExecuteExA", _
        ExecInfo as struct, _
        result as long

    if result <> 0 then
        Handle = ExecInfo.Process.struct
        Milliseconds = _INFINITE
        calldll #kernel32, "WaitForSingleObject", _
            Handle     as long, _
            Milliseconds as long, _
            result     as long
    end if
end sub

sub Pause mil
    t=time$("milliseconds")
    while time$("milliseconds")<t+mil
    wend
    end sub

function DayofWeek$(dt$)
  day = date$(dt$) mod 7 + 7  ' +7 for dates before Jan 1, 1901
  select case (day mod 7)
    case 0: d$ = "Tuesday"
    case 1: d$ = "Wednesday"
    case 2: d$ = "Thursday"
    case 3: d$ = "Friday"
    case 4: d$ = "Saturday"
    case 5: d$ = "Sunday"
    case 6: d$ = "Monday"
  end select
  DayofWeek$ = d$
end function

function fileExists(path$, filename$)
dim info$(10,10)
  'dimension the array info$( at the beginning of your program
  files path$, filename$, info$()
  fileExists = val(info$(0, 0))  'non zero is true
end function


Function GetFolder$( hWndOwner, Prompt$, Title$, lpfnCallback )
  'SHBrowseForFolder is a 32-bit function that allows a user to choose a folder .
  'Adapted for LB from:
  'KPD-Team 1998
  'URL: http://www.allapi.net/
  'KPDTeam@Allapi.net
  'Kindly provided by Alyce Watson

    Struct BrowseInfo, _
        hWndOwner As long, _
        pIDLRoot As long, _
        pszDisplayName As long, _
        lpszTitle$ As ptr, _
        ulFlags As long, _
        lpfnCallback As long, _
        lParam As ptr, _
        iImage As long

    BrowseInfo.hWndOwner.struct    = hWndOwner
    BrowseInfo.lpszTitle$.struct   = Prompt$
    BrowseInfo.ulFlags.struct      = 1 'BIF_RETURNONLYFSDIRS
    BrowseInfo.lpfnCallback.struct = lpfnCallback
    If lpfnCallback <> 0 And Len(Title$) > 0 Then
        BrowseInfo.lParam.struct = Title$ + Chr$(0)
    End If

    CallDLL #shell32, "SHBrowseForFolder", _
        BrowseInfo As struct, _
        lpIDList As ulong

    If lpIDList Then
        sPath$ = Space$(_MAX_PATH) + Chr$(0)
        'Get the path from the IDList
        CallDLL #shell32, "SHGetPathFromIDList", _
            lpIDList As long, _
            sPath$ As ptr, _
            r As long

        Open "ole32" For DLL As #ole
        CallDLL #ole, "CoTaskMemFree", _
            lpIDList As long, _
            r As long
        Close #ole

        iNull = InStr(sPath$, Chr$(0))
        If iNull Then sPath$ = Left$(sPath$, iNull - 1) _
                 Else sPath$ = ""
    End If
    GetFolder$ = sPath$ 
End Function
