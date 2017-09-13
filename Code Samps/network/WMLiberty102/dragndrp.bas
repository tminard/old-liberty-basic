 'Dragndrop.bas - a Liberty BASIC Drag and Drop Example

    NOMAINWIN
    Open "User32" For DLL As #user
    Open "shell32" For DLL As #shell
    Open "WMLiberty.dll" For DLL As #wmlib

    listbox #1.tb, list$(), [DoEvents], 50, 25, 200, 75
    Open "Drag n Drop Test" For Window As #1

    list$(1)="Drag and drop"
    list$(2)="multiple files"
    list$(3)="anywhere on this window"
    Print #1, "TrapClose [Quit]"
    Print #1.tb, "reload"

    h1 = HWnd(#1)
    Callback lpfnCallback, OnDrop( long, long, long, long), long
    CallDLL #wmlib, "SetWMHandler", h1 As long, _WM_DROPFILES As long,_
    lpfnCallback As long, ret As long
    calldll #shell, "DragAcceptFiles", h1 as long, 1 as short, ret as void

[DoEvents]
    Scan
GoTo [DoEvents]

[Quit]
    Close #1
    Close #user
    Close #shell
    Close #wmlib

    End

Function OnDrop( hWnd, uMsg, wParam, lParam)

    'this will cause dragqueryfile to return the number of files dropped,
    'instead of their actual names
    HowMany=Hexdec("FFFFFFFF")

    calldll #shell, "DragQueryFileA", wParam as long, HowMany as ulong,_
    buffer$ as ptr, 0 as ulong, amt as ulong

    'redim list to fit all the files
    redim list$(amt)

    'this will fill up the list, one file at a time
    for i = 0 to amt-1
    buffer$=space$(254)+chr$(0)
    calldll #shell, "DragQueryFileA", wParam as long, i as ulong,_
    buffer$ as ptr, 255 as ulong, result as ulong
    list$(i)=buffer$
    next i

    print #1.tb, "reload"
    'Free up Memory after Drop finished
    calldll #shell, "DragFinish", wParam as long, result as void
    End Function
