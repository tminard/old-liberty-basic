'overite.bas
'Based on code by Brent Thorn.
'Uses common save file dialog
'with overwrite prompt activated
'if chosen filename already exists.
'Can cause vstubs.  Don't move the dialog
'when it is open!
'You may use this code in your programs
'freely.  Please do not distribute
'this file.
'Alyce Watson.

Open "comdlg32.dll" For DLL As #cdlg
z$ = Chr$(0)

struct ofn, _
lStructSize        as long, _
hwndOwner          as long, _
hInstance          as long, _
lpstrFilter$       as ptr, _
lpstrCustomFilter$ as ptr, _
nMaxCustFilter     as long, _
nFilterIndex       as long, _
lpstrFile$         as ptr, _
nMaxFile           as long, _
lpstrFileTitle$    as ptr, _
nMaxFileTitle      as long, _
lpstrInitialDir$   as ptr, _
lpstrTitle$        as ptr, _
flags              as long, _
nFileOffset        as word, _
nFileExtension     as word, _
lpstrDefExt$       as ptr, _
lCustData          as long, _
lpfnHook           as long, _
lpTemplateName     as long

Filter$ = "Text files" + z$ + "*.txt" + z$ + _
          "All files" + z$ + "*.*" + z$ + _
          z$

ofn.lStructSize.struct = len(ofn.struct)
ofn.lpstrFilter$.struct = Filter$
ofn.lpstrCustomFilter$.struct = space$(260) + z$
ofn.nMaxCustFilter.struct = 260
ofn.nFilterIndex.struct = 1
ofn.lpstrFile$.struct = z$ + space$(260) + z$
ofn.nMaxFile.struct = 260
ofn.lpstrFileTitle$.struct = space$(260) + z$
ofn.nMaxFileTitle.struct = 260
ofn.lpstrInitialDir$.struct = "C:\" + z$
ofn.lpstrTitle$.struct = "Save File As..." + z$ 
ofn.flags.struct = _OFN_OVERWRITEPROMPT
ofn.lpstrDefExt$.struct = "txt" + z$ 

CallDLL #cdlg, "GetSaveFileNameA", ofn As struct, re As word

'ofn.lpstrFile.struct returns a long integer memory address.
'Use winstring() to retrieve the string of text
'at that address, as filled by the function.

b$=winstring(ofn.lpstrFile$.struct)
If b$<>"" Then
    Print "filename is ";b$
Else
    Print "user canceled"
End If
Print "done"

Close #cdlg
End

'OFN_READONLY = &H1
'OFN_OVERWRITEPROMPT = &H2
'OFN_HIDEREADONLY = &H4
'OFN_NOCHANGEDIR = &H8
'OFN_SHOWHELP = &H10
'OFN_ENABLEHOOK = &H20
'OFN_ENABLETEMPLATE = &H40
'OFN_ENABLETEMPLATEHANDLE = &H80
'OFN_NOVALIDATE = &H100
'OFN_ALLOWMULTISELECT = &H200
'OFN_EXTENSIONDIFFERENT = &H400
'OFN_PATHMUSTEXIST = &H800
'OFN_FILEMUSTEXIST = &H1000
'OFN_CREATEPROMPT = &H2000
'OFN_SHAREAWARE = &H4000
'OFN_NOREADONLYRETURN = &H8000
'OFN_NOTESTFILECREATE = &H10000
'OFN_NONETWORKBUTTON = &H20000
'OFN_NOLONGNAMES = &H40000                      '  force no long names for 4.x modules
'OFN_EXPLORER = &H80000                         '  new look commdlg
'OFN_NODEREFERENCELINKS = &H100000
'OFN_LONGNAMES = &H200000                       '  force long names for 3.x modules

'OFN_SHAREFALLTHROUGH = 2
'OFN_SHARENOWARN = 1
'OFN_SHAREWARN = 0




