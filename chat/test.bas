
Function AddShare$( name$, share$, sub$ )
'name$ is to share folder as
'share$ is the folder
'sub$ can be: /DELETE /UNLIMITED /REMARK:{text} etc etc
open "shareme.bat" for output AS #sharefolder
print #sharefolder, "net share "+name$+"="+share$+" "+sub$
close #sharefolder
'run "shareme.bat",HIDE
type = 0
file$ = "shareme.bat"
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
End Function

Function DeleteShare$( share$ )
'share$ = folder to be shared
open "shareme.bat" for output AS #sharefolder
print #sharefolder, "net share "+share$+" /DELETE"
print #sharefolder, "del shareme.bat"
close #sharefolder
type = 0
file$ = "shareme.bat"
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
End Function

function fileExists(path$, filename$)
dim info$(10,10)
  'dimension the array info$( at the beginning of your program
  files path$, filename$, info$()
  fileExists = val(info$(0, 0))  'non zero is true
end function
