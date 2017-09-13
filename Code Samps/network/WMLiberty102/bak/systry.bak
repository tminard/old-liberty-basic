'SystemTray.bas - A Liberty BASIC Example to Send an aplication to the system tray

    NOMAINWIN
    struct Tray,_
        cbsize as long,_
        hwnd as long,_
        ID as long,_
        Flags as long,_
        CallbackMessage as long,_
        hIcon as long,_
        Tip as char[28] 'length of tip
    dim Msg(0)

    'Set Size & Placement of the window
    WindowWidth = 216 : WindowHeight = 122
    UpperLeftX = INT((DisplayWidth-WindowWidth)/2)
    UpperLeftY = INT((DisplayHeight-WindowHeight)/2)

   'Add controls
    statictext  #main.static1, "Press the button to send it to the System Tray.", 5, 30, 200, 35
    button      #main.button1, "Send To System Tray",[sendToTray],UL, 5, 5, 200, 25
    button      #main.button2, "&Quit",[quit],UL, 5, 65, 200, 25

    'Open all Windows and DLLs
    Open "System Tray Example" for window_nf as #main
    open "user32" for dll as #user
    open "shell32" for dll as #shell
    open "WMLiberty.dll" For DLL As #wmliberty
    print #main,"trapclose [quit]"
    hwnd = hwnd(#main)

    'Setup System Tray
    WM.TRAYMSG = _WM_USER + 1
    hIcon = LoadImage("tray.ico",16,16) 'Load the icon
    Tray.cbsize.struct = 88
    Tray.hwnd.struct = hwnd 'The window handle
    Tray.Flags.struct = 7
    Tray.CallbackMessage.struct = _WM_USER + 1
    Tray.hIcon.struct = hIcon 'the icon handle
    Tray.Tip.struct = "Click right here for a menu" 'the tool tip

    Callback TrayMsgCallback, TrayMsg( long, long, long, long ), long 'Setup the calback function

    CallDLL #wmliberty, "SetWMHandler",_
        hwnd As long,_
        WM.TRAYMSG As long, _
        TrayMsgCallback As long,_
        ret As long

[inputLoop]
scan
goto [inputLoop]

[inTrayLoop] 'The aplication is in the System Tray
    If Msg(0) = 1 then 'The left button is up
        Msg(0) = 0
        goto [removeFromTray]
    end if

    If Msg(0) = 2 then 'The left button is down
        Msg(0) = 0
    end if

    If Msg(0) = 3 then 'The right button is up
        Msg(0) = 0
        popupmenu "&Show", [removeFromTray] , | , "E&xit",[quit]
    end if

    If Msg(0) = 4 then 'The right button is down
        Msg(0) = 0
    end if

    If Msg(0) = 5 then 'The mouse is moving
        Msg(0) = 0
    end if
    scan
goto [inTrayLoop]

[quit]
    calldll #shell,"Shell_NotifyIconA",_
        2 as long,_
        Tray as struct,_
        inTray as long

    'close all Windows and DLLs
    close #main
    close #user
    close #shell
    close #wmliberty
    end

[sendToTray] 'Send the aplication to the system tray
    calldll #user,"ShowWindow",_
        hwnd as long,_
        _SW_HIDE as long,_
        ret as boolean
    calldll #shell,"Shell_NotifyIconA",_
        0 as long,_
        Tray as struct,_
        inTray as long
goto [inTrayLoop]

[removeFromTray] 'Remove the aplication from the system tray
    calldll #user,"ShowWindow",_
        hwnd as long,_
        _SW_SHOW as long,_
        ret as boolean
    calldll #shell,"Shell_NotifyIconA",_
        2 as long,_
        Tray as struct,_
        inTray as long
goto [inputLoop]

Function LoadImage(imagePath$,width,height)
    calldll #user, "LoadImageA",_
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
        if lParam = _WM_LBUTTONDOWN then Msg(0) = 2
        if lParam = _WM_RBUTTONUP then Msg(0) = 3
        if lParam = _WM_RBUTTONDOWN then Msg(0) = 4
        if lParam = _WM_MOUSEMOVE then Msg(0) = 5
    end if
End Function
