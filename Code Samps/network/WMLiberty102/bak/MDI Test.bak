FRAMECLASS$ = "WMLibertyMDIFrame": FRAMECLASS$(0) = FRAMECLASS$
CHILDCLASS$ = "WMLibertyMDIChild": CHILDCLASS$(0) = CHILDCLASS$

Open "Kernel32" For DLL As #kernel
Open "User32" For DLL As #user
Open "WMLiberty.dll" For DLL As #wmlib

CallDLL #kernel, "GetModuleHandleA", _
    _NULL As long, _
    hInstance As long
hInstance(0) = hInstance

CallDLL #user, "LoadCursorA", _
    _NULL As long, _
    _IDC_ARROW As long, _
    hCursor As long

style = _CS_HREDRAW Or _CS_VREDRAW
CallDLL #wmlib, "RegisterMDIFrameClass", _
    FRAMECLASS$ As ptr, _
    style As long, _
    0 As long, _
    0 As long, _
    hInstance As long, _
    0 As long, _
    hCursor As long, _
    _COLOR_WINDOW As long, _
    result As long

style = _WS_OVERLAPPEDWINDOW Or _WS_VISIBLE
CallDLL #user, "CreateWindowExA", _
    0 As long, _
    FRAMECLASS$ As ptr, _
    "MDI Test - Click Window->New Window" As ptr, _
    style As long, _
    _CW_USEDEFAULT As long, _
    _CW_USEDEFAULT As long, _
    _CW_USEDEFAULT As long, _
    _CW_USEDEFAULT As long, _
    0 As long, _
    0 As long, _
    hInstance As long, _
    0 As long, _
    hWndFrame As long

CallDLL #user, "CreateMenu", _
    hMenuMain As long

CallDLL #user, "CreatePopupMenu", _
    hMenuFile As long

flags = _MF_STRING Or _MF_POPUP
CallDLL #user, "AppendMenuA", _
    hMenuMain As long, _
    flags As long, _
    hMenuFile As long, _
    "&File" As ptr, _
    result As long

flags = _MF_STRING
CallDLL #user, "AppendMenuA", _
    hMenuFile As long, _
    flags As long, _
    1 As long, _
    "E&xit" As ptr, _
    result As long

CallDLL #user, "CreatePopupMenu", _
    hMenuWindow As long

flags = _MF_STRING Or _MF_POPUP
CallDLL #user, "AppendMenuA", _
    hMenuMain As long, _
    flags As long, _
    hMenuWindow As long, _
    "&Window" As ptr, _
    result As long

flags = _MF_STRING
CallDLL #user, "AppendMenuA", _
    hMenuWindow As long, _
    flags As long, _
    2 As long, _
    "&New Window" As ptr, _
    result As long

CallDLL #user, "SetMenu", _
    hWndFrame As long, _
    hMenuMain As long, _
    result As long

style = _WS_CHILD Or _WS_CLIPCHILDREN Or _WS_VISIBLE
CallDLL #wmlib, "CreateMDIClient", _
    style As long, _
    0 As long, _
    0 As long, _
    -1 As long, _
    -1 As long, _
    hWndFrame As long, _
    0 As long, _
    hInstance As long, _
    hMenuWindow As long, _
    101 As long, _
    hWndMDIClient As long
hWndMDIClient(0) = hWndMDIClient

style = _CS_HREDRAW Or _CS_VREDRAW
CallDLL #wmlib, "RegisterMDIChildClass", _
    CHILDCLASS$ As ptr, _
    style As long, _
    0 As long, _
    0 As long, _
    hInstance As long, _
    0 As long, _
    hCursor As long, _
    _COLOR_WINDOW As long, _
    result As long

Callback lpfnSysCommand, OnSysCommand( long, long, long, long ), long
CallDLL #wmlib, "SetWMHandler", _
    hWndFrame As long, _
    _WM_SYSCOMMAND As long, _
    lpfnSysCommand As long, _
    0 As long, _
    result As long

Callback lpfnSize, OnSize( long, long, long, long ), long
CallDLL #wmlib, "SetWMHandler", _
    hWndFrame As long, _
    _WM_SIZE As long, _
    lpfnSize As long, _
    0 As long, _
    result As long

Callback lpfnCommand, OnCommand( long, long, long, long ), long
CallDLL #wmlib, "SetWMHandler", _
    hWndFrame As long, _
    _WM_COMMAND As long, _
    lpfnCommand As long, _
    0 As long, _
    result As long

Running(0) = 1

[DoEvents]
Scan
If Running(0) Then [DoEvents]

CallDLL #user, "DestroyWindow", _
    hWndFrame As long, _
    result As long

CallDLL #user, "UnregisterClassA", _
    FRAMECLASS$ As ptr, _
    hInstance As long, _
    result As long

CallDLL #user, "UnregisterClassA", _
    CHILDCLASS$ As ptr, _
    hInstance As long, _
    result As long

Close #kernel
Close #user
Close #wmlib

End

Function OnSysCommand( hWnd, uMsg, wParam, lParam )
    OnSysCommand = 1
    If _SC_CLOSE = wParam Then Running(0) = 0
End Function

Function OnCommand( hWnd, uMsg, wParam, lParam )
    OnCommand = 1
    Select Case LOWORD(wParam)
    Case 1
        Notice "You clicked Exit."
        Running(0) = 0
        OnCommand = 0
    Case 2
        CHILDCLASS$ = CHILDCLASS$(0)
        hWndMDIClient = hWndMDIClient(0)
        hInstance = hInstance(0)
        CallDLL #user, "CreateMDIWindowA", _
            CHILDCLASS$ As ptr, _
            "New Window" As ptr, _
            _WS_VISIBLE As long, _
            _CW_USEDEFAULT As long, _
            _CW_USEDEFAULT As long, _
            _CW_USEDEFAULT As long, _
            _CW_USEDEFAULT As long, _
            hWndMDIClient As long, _
            hInstance As long, _
            0 As long, _
            hWndChild As long
    End Select
End Function

Function OnSize( hWnd, uMsg, wParam, lParam )
    OnSize = 1
    If wParam <> _SIZE_MINIMIZED Then
        nWidth = LOWORD(lParam)
        nHeight = HIWORD(lParam)

        hWndMDIClient = hWndMDIClient(0)
        CallDLL #user, "MoveWindow", _
            hWndMDIClient As long, _
            0 As long, _
            0 As long, _
            nWidth As long, _
            nHeight As long, _
            1 As long, _
            result As long
    End If
End Function

Function LOWORD( dw )
    LOWORD = (dw And 65535)
End Function

Function HIWORD( dw )
    HIWORD = Int((dw And 4294901760) / 65536)
End Function

