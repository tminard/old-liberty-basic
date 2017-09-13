'   Demonstration of creating Windows controls
'   with Deanslib.dll.
'
'   Especially written for Liberty BASIC users by:
'   Dean Hodgson mailto:dhodgson@nexus.edu.au
'
'   Sample program by Dean and Alyce:
'   Alyce Watson mailto:awatson@wctc.net
'
'   24 June 1998



nomainwin
WindowWidth=640:WindowHeight=480
UpperLeftX=1:UpperLeftY=1

  button #3.add, "Add entry!",[add.list],UL,5,10,100,30
  button #3.chg, "Change Directory!",[change.dir],UL,120,400,180,30
open "Controls Created with Deanslib.dll" for window as #3
    print#3,"trapclose [quit]";

    h=hwnd(#3)

    open "deanslib.dll" for dll as #dd


[centered.statictext.with.border]
    sstyle=_SS_CENTER OR _WS_BORDER
    calldll#dd,"StaticText",_
        h as short,_
        "Centered Static Text" as ptr,_
        102 as short,_
        120 as short, 10 as short, 180 as short, 20 as short,_
        sstyle as long,_
        hst as short



[create.wordwrap.editbox]
    edstyle=_ES_UPPERCASE OR _ES_MULTILINE OR _WS_DLGFRAME OR _ES_AUTOVSCROLL OR _WS_VSCROLL
    calldll#dd,"EditBox",_
        h as short,_
        "Here is an editbox with all upper case, word wrap, vertical scrolling and a scroll bar.  Type Something." as ptr,_
        103 as short,_
        120 as short, 40 as short, 180 as short,116 as short,_
        edstyle as long,_
        he as short



[create.a.listbox]
    lbstyle=_LBS_STANDARD
    calldll#dd,"ListBox",_
        h as short,_
        "" as ptr,_
        101 as short,_
        15 as short,50 as short,80 as short,180 as short,_
        lbstyle as long,_
        hlb as short



[load.simple.listbox]
    list$="one|two|three|four|five|six|seven|eight|nine|ten"
    calldll#dd,"lbload",hlb as short,list$ as ptr,result as short



[create.simple.statictext]
    sstyle=_SS_LEFT
    calldll#dd,"StaticText",_
        h as short,_
        "Windows Directory:" as ptr,_
        105 as short,_
        120 as short, 165 as short, 180 as short, 20 as short,_
        sstyle as long,_
        hst2 as short



[create.simple.listbox]
    lbstyle=_LBS_STANDARD OR _WS_THICKFRAME
    calldll#dd,"ListBox",_
        h as short,_
        "" as ptr,_
        104 as short,_
        120 as short,190 as short,180 as short,200 as short,_
        lbstyle as long,_
        hlb2 as short



[get.win.dir]
    open "kernel" for dll as #kernel
        WindowsDir$=space$(200)+CHR$(0)
        calldll #kernel, "GetWindowsDirectory", _
        WindowsDir$ as ptr, _
        200 as word, _
        result as word
    close #kernel
    dir$=word$(WindowsDir$,1)+"\*.*"



[load.dir.into.listbox]
    CALLDLL#dd,"lbdir",_
        hlb2 as short,_
        dir$ as ptr,_
        result as short



[create.framed.statictext]
    sstyle=_SS_LEFT OR _WS_DLGFRAME
    calldll#dd,"StaticText",_
        h as short,_
        "Type Password:" as ptr,_
        107 as short,_
        320 as short, 10 as short, 120 as short, 30 as short,_
        sstyle as long,_
        hst3 as short



[create.password.editbox]
    edstyle=_ES_PASSWORD OR _WS_DLGFRAME
    calldll#dd,"EditBox",_
        h as short,_
        "" as ptr,_
        106 as short,_
        320 as short, 50 as short, 120 as short, 30 as short,_
        edstyle as long,_
        he2 as short



[create.sorted.combobox]
    cstyle=_CBS_HASSTRINGS OR _CBS_DROPDOWN OR _CBS_AUTOHSCROLL OR _CBS_SORT
    CALLDLL#dd, "ComboBox",_
        h AS short,_
        "" AS ptr,_
        108 AS short,_
        490 AS short,10 AS short,120 AS short,200 AS short,_
        cstyle AS long,_
        hc AS short



[load.combobox.and.select]
    sl$="Chicken|Beef|Ham|fish|Peanut Butter"
    CALLDLL#dd,"cbload",_
        hc as short,_
        sl$ as ptr,_
        result as short
    calldll #dd, "cbselectstring",hc as short,"Peanut Butter" as ptr, r as short




[multi.column.listbox]
    lbstyle=_LBS_MULTICOLUMN OR _LBS_STANDARD OR _WS_CAPTION
    calldll#dd,"ListBox",_
        h as short,_
        "Multi Column Listbox" as ptr,_
        110 as short,_
        320 as short,125 as short,180 as short,140 as short,_
        lbstyle as long,_
        hlb3 as short
            list$="CARL|TOM|DEAN|BROSCO|GARRETT|DOYLE|ANTHONY|MICHAEL|BRIAN|ALYCE|MARC|RICK|CHRIS|DAVID|FRANK|BRAD|ERIC|JIM|MARK"



[load.listbox.and.select]
    calldll#dd,"lbload",hlb3 as short,list$ as ptr,result as short
    calldll #dd, "lbselectstring",hlb3 as short,"DEAN" as ptr, r as short



[set.focus] 'set focus on desired control
CALLDLL#dd, "SetFocus",_
he2 AS short,_
result AS void


[play.sound]
dur=1
CALLDLL#dd, "Sound", 60 AS long, dur AS long, result AS void
CALLDLL#dd, "Sound", 65 AS long, dur AS long, result AS void
CALLDLL#dd, "Sound", 70 AS long, dur AS long, result AS void
CALLDLL#dd, "Sound", 75 AS long, dur AS long, result AS void
CALLDLL#dd, "Sound", 80 AS long, dur AS long, result AS void
CALLDLL#dd, "Sound", 85 AS long, dur AS long, result AS void
CALLDLL#dd, "Sound", 90 AS long, dur AS long, result AS void
CALLDLL#dd, "Sound", 95 AS long, dur AS long, result AS void
CALLDLL#dd, "Sound", 100 AS long, dur AS long, result AS void


[loop]
    input a$
    goto [loop]



[quit]
    calldll#dd,"CloseObject",hlb as short,result as void
    calldll#dd,"CloseObject",hlb2 as short,result as void
    calldll#dd,"CloseObject",hlb3 as short,result as void
    calldll#dd,"CloseObject",he as short,result as void
    calldll#dd,"CloseObject",he2 as short,result as void
    calldll#dd,"CloseObject",hc as short,result as void

    close#dd
    close#3
END

[add.list]
    if s$="END!" then [loop]
    if s$="thirteen" then s$="END!"
    if s$="twelve" then s$="thirteen"
    if s$="eleven" then s$="twelve"
    if s$="" then s$="eleven"

    CALLDLL#dd,"lbaddstring",_
        hlb as short,_       'handle of the listbox
        s$ as ptr,_          'string to be added
        result as short      'the index of the new entry
    goto [loop]


[change.dir]
Calldll #dd, "lbclear",_
    hlb2 as short,_
    r as void,

    if dir$=word$(WindowsDir$,1)+"\*.*" then
        dir$=DefaultDir$+"\*.*"
        CALLDLL#dd, "SetText", hst2 AS short, "DefaultDir$:" AS ptr, result AS void
    else
        dir$=word$(WindowsDir$,1)+"\*.*"
        CALLDLL#dd, "SetText", hst2 AS short, "Windows Directory:" AS ptr, result AS void
      end if

[do.change.dir]
CALLDLL#dd,"lbdir",_
    hlb2 as short,_         'handle of the listbox
    dir$ as ptr,_           'string containing a filespec
    result as short         'number of entries in the listbox
    goto [loop]


