NoMainWin

Struct TVITEM, _
    mask As long, _
    hItem As long, _
    state As long, _
    stateMask As long, _
    pszText As ptr, _
    cchTextMax As long, _
    iImage As long, _
    iSelectedImage As long, _
    cChildren As long, _
    lParam As long
Struct TVINSERTSTRUCT, _
    hParent As long, _
    hInsertAfter As long, _
    mask As long, _
    hItem As long, _
    state As long, _
    stateMask As long, _
    pszText As ptr, _
    cchTextMax As long, _
    iImage As long, _
    iSelectedImage As long, _
    cChildren As long, _
    lParam As long
Struct NMHDR, _
    hwndFrom As long, _
    idFrom As long, _
    code As long

Open "ComCtl32" For DLL As #comctl
Open "User32" For DLL As #user
Open "WMLiberty.dll" For DLL As #wmlib

CallDLL #comctl, "InitCommonControls", _
    ret As void

Open "TreeView Label Edit Test" For Window As #1
#1 "TrapClose [Quit]"

h1 = HWnd(#1)

CallDLL #user, "GetWindowLongA", _
    h1 As long, _
    _GWL_HINSTANCE As long, _
    hinst As long

style = _WS_CHILD Or _WS_VISIBLE Or 15
CallDLL #user, "CreateWindowExA", _
    _WS_EX_CLIENTEDGE As long, _
    "SysTreeView32" As ptr, _
    0 As long, _
    style As long,_
    0 As long, _
    0 As long, _
    200 As long, _
    200 As long, _
    h1 As long, _
    0 As long, _
    hinst As long, _
    0 As long, _
    hTV As long

h(1) = hTV

TVINSERTSTRUCT.mask.struct = 1 'TVIF_TEXT
TVINSERTSTRUCT.pszText.struct = "Desktop"
TVINSERTSTRUCT.hParent.struct = 0
TVINSERTSTRUCT.hInsertAfter.struct = 0
TVINSERTSTRUCT.cChildren.struct = 1
CallDLL #user, "SendMessageA", _
    hTV As long, _
    4352 As long, _ 'TVM_INSERTITEM
    0 As long, _
    TVINSERTSTRUCT As struct, _
    hRoot As long

TVINSERTSTRUCT.pszText.struct = "My Computer"
TVINSERTSTRUCT.hParent.struct = hRoot
TVINSERTSTRUCT.hInsertAfter.struct = 4294901762 'TVI_LAST
TVINSERTSTRUCT.cChildren.struct = 0
CallDLL #user,"SendMessageA", _
    hTV As long, _
    4352 As long, _ 'TVM_INSERTITEM
    0 As long, _
    TVINSERTSTRUCT As struct, _
    hLast As long

TVINSERTSTRUCT.pszText.struct = "My Documents"
CallDLL #user,"SendMessageA", _
    hTV As long, _
    4352 As long, _ 'TVM_INSERTITEM
    0 As long, _
    TVINSERTSTRUCT As struct, _
    hLast As long

TVINSERTSTRUCT.pszText.struct = "Internet Explorer"
CallDLL #user,"SendMessageA", _
    hTV As long, _
    4352 As long, _ 'TVM_INSERTITEM
    0 As long, _
    TVINSERTSTRUCT As struct, _
    hLast As long

TVINSERTSTRUCT.pszText.struct = "Network Neighborhood"
CallDLL #user,"SendMessageA", _
    hTV As long, _
    4352 As long, _ 'TVM_INSERTITEM
    0 As long, _
    TVINSERTSTRUCT As struct, _
    hLast As long

TVINSERTSTRUCT.pszText.struct = "Recycle Bin"
CallDLL #user,"SendMessageA", _
    hTV As long, _
    4352 As long, _ 'TVM_INSERTITEM
    0 As long, _
    TVINSERTSTRUCT As struct, _
    hLast As long

Callback lpfnNotify, OnNotify( long, long, long, long ), long
CallDLL #wmlib, "SetWMHandler", _
    h1 As long, _
    _WM_NOTIFY As long, _
    lpfnNotify As long, _
    0 As long, _
    ret As long

[Wait]
Scan
GoTo [Wait]

[Quit]
Close #1
Close #comctl
Close #user
Close #wmlib

End

Function OnNotify( hWnd, uMsg, wParam, lParam )
    NMHDR.struct = lParam
    hwnd = NMHDR.hwndFrom.struct
    If h(1) = hwnd Then
        Select Case NMHDR.code.struct
        Case -411 'TVN_ENDLABELEDIT
            ptvi = lParam + Len(NMHDR.struct)
            TVITEM.struct = ptvi
            If TVITEM.pszText.struct Then
                CallDLL #user, "SendMessageA", _
                    hwnd As long, _
                    4365 As long, _ 'TVM_SETITEM
                    0 As long, _
                    TVITEM As struct, _
                    ret As long
            End If
        End Select
    End If
End Function

