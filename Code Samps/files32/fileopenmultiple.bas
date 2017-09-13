'Access a longfilename dialog
'with LB and no add-on DLLs.
'This one allows user to
'select multiple file names.

open "comdlg32.dll" for dll as #cdlg

z$ = chr$(0)


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

Filter$ = "All files" + z$ + "*.*" + z$ + z$

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
ofn.lpstrTitle$.struct = "Open my file" + z$ 
ofn.flags.struct = _OFN_PATHMUSTEXIST or _OFN_FILEMUSTEXIST _
    or _OFN_ALLOWMULTISELECT
ofn.lpstrDefExt$.struct = "doc" + z$


calldll #cdlg, "GetOpenFileNameA",_
ofn as struct,_
re as long

b$=winstring(ofn.lpstrFile$.struct)
print "long filename is ";b$ 
print

i=1
print "path is ";word$(b$,i)

i=i+1
while word$(b$,i)<>""
    print "filename ";i-1;" is ";word$(b$,i)
    i=i+1
wend
print
print "done"

close #cdlg
end





