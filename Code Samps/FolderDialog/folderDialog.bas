txt$ = "Choose a folder to save file in: "
print SHBrowseForFolder$(txt$)
input "Hit 'Enter' to quit: ";q$
end

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
