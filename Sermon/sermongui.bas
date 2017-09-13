'For v1.3-1.51; GUI v1.5
version = 1.51
    'SystemTray.bas - A Liberty BASIC Example to Send an aplication to the system tray
    NOMAINWIN
    struct Tray,_
        cbsize as long,_
        hwnd as long,_
        ID as long,_
        Flags as long,_
        CallbackMessage as long,_
        hIcon as long,_
        Tip as char[64] 'length of tip
    dim Msg(0)

    WindowWidth = 216 : WindowHeight = 122
    UpperLeftX = INT((DisplayWidth-WindowWidth)/2)
    UpperLeftY = INT((DisplayHeight-WindowHeight)/2)

   ' button      #main.button1, "STT",[tray.sendToTray],UL, 5, 5, 200, 25
    'button      #main.button2, "&Quit",[quit],UL, 5, 65, 200, 25

    Open "Church Sermons" for window_nf as #main
    open "WMLiberty.dll" For DLL As #wmliberty
    print #main,"trapclose [quit]"
    hwnd = hwnd(#main)

    WM.TRAYMSG = _WM_USER + 1
    hIcon = LoadImage("tray.ico",16,16) 'Load the icon
    Tray.cbsize.struct = 88
    Tray.hwnd.struct = hwnd 'The window handle
    Tray.Flags.struct = 7
    Tray.CallbackMessage.struct = _WM_USER + 1
    Tray.hIcon.struct = hIcon 'the icon handle
    Tray.Tip.struct = "Sermons will be downloaded as they become available!" 'the tool tip

    Callback TrayMsgCallback, TrayMsg( long, long, long, long ), long

    CallDLL #wmliberty, "SetWMHandler",_
        hwnd As long,_
        WM.TRAYMSG As long, _
        TrayMsgCallback As long,_
        ret As long
gosub [load.options]
IF fileExists("","guistate") then kill "guistate"
IF fileExists("","shutdownok") then kill "shutdownok"
IF fileExists("","shutdown") then kill "shutdown"
goto [tray.sendToTray]
end

[load.options]
file.command$ = ""
while fileExists("","settings.ini") = 0
wend
open "settings.ini" for input AS #rs
while eof(#rs) <> 0 = 0 and file.command$ = "eof" = 0
 Line input #rs, fileread$
 file.command$ = lower$(word$(fileread$,1,"="))
 file.subcommand$ = word$(fileread$,2,"=")
  IF file.command$ = "savedir" then SermonSaveDir$ = file.subcommand$
  IF file.command$ = "checkdays" then checkdays = val(file.subcommand$)
  IF file.command$ = "minutedelay" then minutedelay = val(file.subcommand$):timedelay = 1000*60*minutedelay
wend
close #rs
return


[tray.inputLoop]
scan
IF newfolder = 1 then calldll #kernel32, "Sleep", 100 as long, re as void:goto [tray.inputLoop]
    If Msg(0) = 1 then 'The left button is up
        Msg(0) = 0
        IF fileExists("","shutdown") = 0 then goto [checknow]
    end if

    If Msg(0) = 2 then 'The right button is up
        Msg(0) = 0
        IF fileExists("","shutdown") then popupmenu "Cancel Exit", [cancel.exit], "Nevermind", [tray.inputLoop]
        IF fileExists("","shutdown") = 0 then popupmenu "Check for Sermons Now", [checknow], "Status", [show.status] , | , "Options", [options], "About", [about], | , "Exit",[quit], "Nevermind", [tray.inputLoop]
    end if
    IF aboutopen = 1 and fileExists("","logo.bmp") then print #About.logo, "drawsprites"
    IF fileExists("","PINGGUI") then kill "PINGGUI"
    IF fileExists("","newfolder") and newfolder = 0 then [NewFolder]
   IF fileExists("","newsermon.*") then gosub [notice.newsermon]
   IF fileExists("","shutdownok") then skipprompt = 1:goto [quit]
   downloadingnow = downloadingnow + 100
   IF downloadingnow / 1000 > 8 then gosub [notice.downloading]'notice "Downloading sermon......."
   IF fileExists("","downloading") = 0 or dontnoticeagain = 1 then downloadingnow = 0:dontnoticeagain = 0
   calldll #kernel32, "Sleep", 100 as long, re as void 'Pause for 100ms so as not to waste CPU
goto [tray.inputLoop]
end

[notice.downloading]
playwave "downloading.wav", async
'notice.window$ = "Sermon Watcher"
'notice.warning$ = chr$(13)+chr$(13)+"           Downloading sermon....."
'gosub [open.notice]
dontnoticeagain = 1
'calldll #kernel32, "Sleep", 3000 as long, re as void
'gosub [close.notice]
return

[cancel.exit]
IF fileExists("","shutdown") = 0 then notice "Too Late. Please start Sermon Watcher again!":goto [tray.inputLoop]:end
kill "shutdown"
goto [tray.inputLoop]
end

[NewFolder]
IF newfolder = 1 then [tray.inputLoop]
newfolder = 1
closeonok = 0
    WindowWidth = 350
    WindowHeight = 165
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    statictext #blankroot.text, "Welcome! Please click [Browse] to choose a new folder to save sermons! Thank you for using Adelphos Pro Software!" ,  10,  17, 310,  75
    button #blankroot.button,"Browse ->",[get.newfolder], UL, 115, 102,  69,  25
    open "Welcome!" for window_nf as #blankroot
    print #blankroot, "font ms_sans_serif 10"
    print #blankroot, "trapclose [get.newfolder]"
goto [tray.inputLoop]
end


[get.newfolder]
filedialog "Save Sermons At...", "All Sermons", fileName$
IF fileName$ = "" then [get.newfolder]
folderpath$ = FilePath$(fileName$)
IF right$(folderpath$,1) = "\" = 0 then folderpath$ = folderpath$ + "\"
IF folderpath$ = SermonSaveDir$ then [get.newfolder]
SermonSaveDir$ = folderpath$
open "settings.ini" for output AS #sf
print #sf, "savedir="+SermonSaveDir$
print #sf, "minutedelay=30"
print #sf, "checkdays=7"
print #sf, "eof"
close #sf
open "reloadoptions" for output AS #sc
close #sc
close #blankroot
newfolder = 0
kill "newfolder"
goto [tray.inputLoop]
end


[notice.newsermon]
dim info$(10,10)
files DefaultDir$,"newsermon.*", info$(
newsermons = val(word$(info$(1,0),2,"."))
playwave "downloaded.wav", async
IF newsermons > 1 then notice newsermons;" new sermons have been downloaded!"
IF newsermons = 1 then notice "A new sermon has been downloaded!"
kill info$(1,0)
return

[checknow]
IF fileExists("","downloading") then notice "Your computer is already searching for a new sermon":goto [tray.inputLoop]
open "do.download" for output AS #command
close #command
goto [tray.inputLoop]

[show.status]
IF fileExists("","newsermon") then kill "newsermon":notice "New Sermon(s) have been downloaded!":goto [tray.inputLoop]
IF fileExists("","downloading") then notice "Searching for a Sermon now..."
IF fileExists("","downloading") = 0 then notice "No new sermons are available"
goto [tray.inputLoop]

[options]
gosub [options.GUI]
goto [tray.inputLoop]

[quit]
QA$ = "NULL"
IF skipprompt = 0 then confirm "Quit?  Your computer will no longer receive new sermons!";QA$
IF QA$ = "no" then goto [tray.inputLoop]
IF aboutopen = 1 then close #About:aboutopen = 0
IF settingsopen = 1 then close #opt:settingsopen = 0
timer 0
if skipprompt = 0 then
open "shutdown" for output As #sendcommand
close #sendcommand
end if
looperror = 0
waiting = 0
IF fileExists("","downloading") then notice "Still checking for sermons.... Program will shutdown when it finishes!":goto [tray.inputLoop]
while fileExists("","shutdownok") = 0 and waiting = 12 = 0
calldll #kernel32, "Sleep", 1000 as long, re as void
waiting = waiting + 1
wend
IF waiting = 12 then looperror = 1
IF looperror = 1 then
fail = fail + 1
IF fail = 2 then notice  "Main Application is not responding this time either. It may have already been shutdown. This program will now close"
IF fail = 2 = 0 then notice "Main Application is not responding. It may have already been shutdown. Please try again"
end if
IF looperror = 1 and fail = 2 = 0 then goto [tray.inputLoop] 'Dont end yet, try again
goto [endall.now]
end

[about]
IF aboutopen = 1 or settingsopen = 1 then [tray.inputLoop]
aboutopen = 1
WindowWidth = 305
    WindowHeight = 535
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    graphicbox #About.logo,  75,   7, 120, 135
    button #About.button1,"Ok",[close.about], UL,  95, 460,  75,  25
    statictext #About.statictext2, "    Thank you for using Adelphos Pro Software! Sermon Watcher was designed to quietly download the latest sermons from the Sovereign Grace Church website and place them in one neat folder. It has been my pleasure to offer Sermon Watcher to you complete and (hopefully!) bug free! I pray that God will be glorified even through this small piece of code! Above all, I hope that we will together be overwellmed yet again by wonder, worship, and joy by the Power and Love of God shown to us in the saving sacrifice of Christ our Lord! Second I would like to thank Pastors Jim Britt and Rick Thomas for their great Cross centered, lively sermons (and character!) that keep even the dullest of persons awake (even during the week :))!"+chr$(13)+"    In Christ, Tyler Minard"   ,  15, 147, 260, 365

    '-----End GUI objects code

    open "About Sermon Watcher v";version for dialog_modal as #About
    print #About.logo, "down; fill white; flush"
    print #About, "font ms_sans_serif 10"
    IF fileExists("","logo.bmp") then
    loadbmp "logo", "logo.bmp"
    print #About.logo, "background logo"
    print #About.logo, "drawsprites"
    end if
    print #About, "trapclose [close.about]"
goto [tray.inputLoop]
end

[close.about]
aboutopen = 0
close #About
goto [tray.inputLoop]
end

[open.notice]
IF noticeopen = 1 then [update.notice]
    WindowWidth = 325
    WindowHeight = 160
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    statictext #notices.warning, notice.warning$,  10,  12, 295,  65
    'statictext #notices.statictext2, "---------------------------------------------------------------------------------------------------",  -5,  82, 396,  20
   ' button #notices.yes,"Yes",[notice.yes], UL,  50,  97,  90,  25
   ' button #notices.no,"No",[notice.no], UL, 165,  97,  85,  25

    '-----End GUI objects code

    open notice.window$ for dialog as #notices
    print #notices, "font ms_sans_serif 10"
    noticeopen = 1
    print #notices, "trapclose [wait.notice]"
return

[update.notice]
IF noticeopen = 0 then gosub [open.notice]
print #notices.warning, notice.warning$
return

[wait.notice]
wait

[notice.yes]
notice.confirm$ = "yes"
return

[notice.no]
notice.confirm$ = "no"
return

[close.notice]
IF noticeopen = 0 then return
close #notices
noticeopen = 0
return

[options.GUI]
IF settingsopen = 1 or aboutopen = 1 then [tray.inputLoop]
gosub [load.options]
settingsopen = 1
unsaved.opt = 0
checkweek = checkdays / 7
promptminutes = minutedelay
unsaved.minutedelay = 0
unsaved.weekcheck = 0
unsaved.SermonSaveDir$ = ""
promptweeks = checkweek
 WindowWidth = 250
    WindowHeight = 335
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    button #opt.button1,"Save",[opt.save], UL, 150, 272,  80,  25
    button #opt.button2,"Close",[exit.opt], UL,   5, 272,  85,  25
    statictext #opt.statictext3, "Save Sermons to:",  10,  17, 110,  20
    TextboxColor$ = "white"
    textbox #opt.textbox4,  10,  42, 225,  25
    button #opt.button5,"Change >",[change.savedir], UL, 130,  12,  67,  25
    statictext #opt.statictext6, "Check for Sermons every ";minutedelay;" minutes",  10,  87, 110,  70
    button #opt.button7,"Change >",[change.minutedelay], UL, 130, 112,  67,  25
    statictext #opt.statictext8, "Check for ";checkweek;" week(s) worth of sermons every time",  10, 177, 110,  65
    button #opt.button9,"Change >",[change.weekcheck], UL, 130, 197,  67,  25

    '-----End GUI objects code

    open "Sermon Watcher Settings" for window_nf as #opt
    print #opt, "font ms_sans_serif 10"
    print #opt.textbox4, "!disable"
    print #opt.textbox4, SermonSaveDir$
    print #opt, "trapclose [exit.opt]"
goto [tray.inputLoop]

[change.savedir]
filedialog "Save Sermons At...", "All Sermons", fileName$
IF fileName$ = "" then [tray.inputLoop]
folderpath$ = FilePath$(fileName$)
IF right$(folderpath$,1) = "\" = 0 then folderpath$ = folderpath$ + "\"
IF folderpath$ = SermonSaveDir$ then [tray.inputLoop]
unsaved.SermonSaveDir$ = folderpath$
unsaved.opt = 1
print #opt.textbox4, folderpath$
goto [tray.inputLoop]
end

[movesermons]
open "movesermons" for output AS #sendcommand 'Dont let sermon downloader download sermons durring copy operations
close #sendcommand
return

[change.minutedelay]
prompt "How many minutes to check?";promptminutes
IF promptminutes = 0 then promptminutes = minutedelay:notice "Please enter a valid number!":goto [change.minutedelay]
IF promptminutes = minutedelay then [tray.inputLoop]
unsaved.opt = 1
unsaved.minutedelay = promptminutes
print #opt.statictext6, "Check for Sermons every ";unsaved.minutedelay;" minutes"
goto [tray.inputLoop]
[change.weekcheck]
prompt "How many weeks to watch?";promptweeks
IF promptweeks < 1 then promptweeks = checkweek:notice "Please enter a number equal to or larger then 1!":goto [change.weekcheck]
IF promptweeks = checkweek then [tray.inputLoop]
unsaved.opt = 1
unsaved.weekcheck = promptweeks
print #opt.statictext8, "Check for ";unsaved.weekcheck;" week(s) worth of sermons every time"
goto [tray.inputLoop]

[opt.savesys]
IF unsaved.opt = 0 then return
IF unsaved.weekcheck = 0 = 0 then checkweek = unsaved.weekcheck
IF unsaved.minutedelay = 0 = 0 then minutedelay = unsaved.minutedelay
IF unsaved.SermonSaveDir$ = "" = 0 then
SermonSaveDir$ = unsaved.SermonSaveDir$
end if

unsaved.opt = 0
unsaved.minutedelay = 0
unsaved.weekcheck = 0
checkdays = checkweek * 7
open "settings.ini" for output AS #sop
print #sop, "savedir="+SermonSaveDir$
print #sop, "checkdays=";checkdays
print #sop, "minutedelay=";minutedelay
print #sop, "EOF"
close #sop
open "reloadoptions" for output AS #sc
close #sc
IF unsaved.SermonSaveDir$ = "" = 0 then
'Had some errors in the below feature. shame, would have been good! Ill figure it out later
'confirm "Would you like to move existing sermons to the new folder?";QA$
'IF QA$ = "yes" then gosub [movesermons]
end if
unsaved.SermonSaveDir$ = ""
return

[exit.opt]
QA$ = "NULL"
IF unsaved.opt = 1 then confirm "Save changes?";QA$
IF QA$ = "yes" then gosub [opt.savesys]
close #opt
settingsopen = 0
goto [tray.inputLoop]

[opt.save]
IF unsaved.opt = 1 then gosub [opt.savesys]
notice "Settings Saved!"
goto [tray.inputLoop]

[endall.now]
    IF aboutopen = 1 then close #About:aboutopen = 0 'Just in case
    IF settingsopen = 1 then close #opt:settingsopen = 0 'Just in case
    calldll #shell32,"Shell_NotifyIconA",_
        2 as long,_
        Tray as struct,_
        inTray as long

    close #main
    close #wmliberty
    IF fileExists("","shutdownok") then kill "shutdownok"
    open "guistate" for output as #ss
    close #ss
    end

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

sub Pause mil
    t=time$("milliseconds")
    while time$("milliseconds")<t+mil
    wend
    end sub

Sub CopyFile file$, to$
    open "kernel32" for dll as #kernel
    calldll #kernel, "CopyFileA",_
    file$ as ptr,_
    to$ as ptr,_
    1 as long,_
    re as long
    close #kernel
end sub

Function FilePath$( File$ )
    iSlash = InStr(File$, "\")
    If iSlash Then
        I = InStr(File$, "\", iSlash + 1)
        While I
            iSlash = I
            I = InStr(File$, "\", iSlash + 1)
        Wend
        FilePath$ = Left$(File$, iSlash)
    Else
        FilePath$ = File$ + "\"
    End If
End Function


Function aTrayMsg( hWnd, uMsg, wParam, lParam )
    Msg(0) = 0
    if uMsg = _WM_USER + 1 then
        if lParam = _WM_LBUTTONUP then Msg(0) = 1
        if lParam = _WM_RBUTTONUP then Msg(0) = 2
    end if
End Function

function TrayMsg(hwnd,uMsg,wParam,lParam)   'icon message handler--lParam hold the mouse message from the icon
    select case lParam              'wParam holds the icon identifier (in case you have more than one icon)
        case _WM_LBUTTONDOWN        'don't do anything unless they let the button up while the cursor is over our icon
            isOk=0
        case _WM_LBUTTONUP          'tell them how to use the prog if they left click
            Msg(0) = 2
            isOk=0
        case _WM_RBUTTONDOWN        'don't do anything unless they let the button up while the cursor is over our icon
            isOk=0
        case _WM_RBUTTONUP
            Msg(0) = 2           'haven't been able to get the popup menu to work here yet
            isOk=0
        case else
            isOk=99                 'let the dll know that we don't do anything with _WM_MOUSEMOVE etc.
    end select
    iconMessage=isOk        'return a value to the dll to indicate if the message was handled
end function
function fileExists(path$, filename$)
dim info$(10,10)
  'dimension the array info$( at the beginning of your program
  files path$, filename$, info$()
  fileExists = val(info$(0, 0))  'non zero is true
end function
