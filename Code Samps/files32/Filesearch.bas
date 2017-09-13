' With acknowledgents to Mark Parkinson for the Recursive Files routine
    'WORKS FROM ROOT DIR
    'Changed by Tyler Minard for easy placement into an application!

[myprog.samp]
'I want to find all .txt files in C:\!
ext.findfiles$ = "*.txt"
DRV.findfiles$ = "C:" 'important!! DO NOT add a back slash to this var! the program will crash!
end.findfiles = 0
show.findfiles = 0
saveas.findfiles$ = "readlist.txt"
return.findfiles = 1
gosub [findfiles]
'{then read the 'readlist.txt' file to get all found file names!!}
notice "files collected!!"
end

[findfiles]
dim file.findfiles$(10000,2) : dim info.findfiles$(10, 10) : dim Q.findfiles(2)
'read all below to (*) and add some or all of the vars to your code BEFORE calling [findfiles]!
rem DRV.findfiles$ = "d:"  'Drive to search
rem ext.findfiles$ = "*.exe" 'Ext to look for
rem end.findfiles = 1 'If set to 1, program will 'end' after finishing
rem return.findfiles = 0 'If set to 1, program will 'return' after finishing
rem show.findfiles = 1  'If set to 1, a file with a list of all found files will be opened, program execution will pause until text file is closed
rem saveas.findfiles$ = "APPfiles.txt" 'file name to save the list in
'NOTE: Place the vars you want somewhere in your code, then goto or gosub (Depends on the vars!) [findfiles]
'(*)'
goto [search.findfiles]
end

[search.findfiles]
    ' Mark Parkinson Recursive Files search routine
    placetohunt$=DRV.findfiles$ : thingtohuntfor$=ext.findfiles$
    C = Q.findfiles(1) : call recurse placetohunt$, thingtohuntfor$

    for f = 1 to Q.findfiles(1)
        tfile$=file.findfiles$(f,1)
        t$="" : ltr = len(tfile$)
        while t$<>"\"
            t$ = mid$(tfile$,ltr,1)
            ltr = ltr -1
        wend
        n = len(tfile$)-ltr-1
        file.findfiles$(f,2) = right$(tfile$,n)
        if len(file.findfiles$(f,2))>18 then file.findfiles$(f,2)=left$(file.findfiles$(f,2),18)
    next f
    if alpha = 1 then sort file.findfiles$(), 1, Q.findfiles(1), 2
    if men = 0 then [list.findfiles]
[list.findfiles]
     win1 = 0
    open saveas.findfiles$ for output as #temp
    for h = 1 to Q.findfiles(1)
        #temp h;" = ";file.findfiles$(h,1)
    next h
    #temp "TOTAL FOUND ";Q.findfiles(1)
    close #temp
   IF show.findfiles = 1 then call RunWait "notepad.exe",saveas.findfiles$,""
   IF show.findfiles = 1 then kill saveas.findfiles$
   IF end.findfiles = 1 then  end
   IF return.findfiles = 1 then return
   wait

sub RunWait file$, para$, dir$
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
    ExecInfo.Show.struct = _SW_SHOWNORMAL
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

Function noPath$(t$)
    while instr(t$, "\")
    t$ = mid$(t$, 2)
    wend
    noPath$ = t$
    end function

Function GetShortPathName$(lPath$)
    lPath$=lPath$+chr$(0)
    sPath$=space$(256)
    lenPath=len(sPath$)
    open "kernel32" for dll as #k
    calldll #k, "GetShortPathNameA",lPath$ as ptr,_
    sPath$ as ptr,lenPath as long,r as long
    close #k
    GetShortPathName$=left$(sPath$,r)
    end function

sub recurse pathspec$,mask$
        'Put in the backslash separator.
        pathspec$=pathspec$+"\"
        files pathspec$, mask$, info.findfiles$(
    filecount=val(info.findfiles$(0, 0))
    subdircount=val(info.findfiles$(0, 1))
    for i=1 to filecount
        filename$= pathspec$+info.findfiles$(i, 0)
        filesize$= info.findfiles$(i, 1)
        datestamp$=info.findfiles$(i, 2)
        if instr(filename$,"Filemenu")>0 then [miss]
        if instr(filename$,"Run.exe")>0 then [miss]
        Q.findfiles(1) = Q.findfiles(1) + 1
        file.findfiles$(Q.findfiles(1),1) = upper$(filename$)
[miss] next i
    for i=1 to subdircount
        list$=list$+pathspec$+info.findfiles$(f + i, 1)+"*"
    next i
    while list$<>""
        p=instr(list$,"*")
        p$=left$(list$,p-1)
        call recurse p$,mask$ 
        list$=mid$(list$,p+1)
    wend
    end sub




