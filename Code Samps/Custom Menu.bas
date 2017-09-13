    dim menuText$(10)
    menuText$(01)="Test";chr$(9);"ctrl-z"
    menuText$(02)="Test2";chr$(9);"ctrl-x"
    menuText$(03)="Test3";chr$(9);"ctrl-c"
    menuText$(04)="paste";chr$(9);"ctrl-v"
    menuText$(05)="clear";chr$(9);"del"
    menuText$(06)="select all";chr$(9);"ctrl-a"
    menuText$(07)="print selection";chr$(9);"ctrl-p"
    menuText$(08)=""
    menuText$(09)="find";chr$(9);"ctrl-f"
    menuText$(10)="find again";chr$(9);"ctrl-g"

    nomainwin
    WindowWidth = 550
    WindowHeight = 410
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    texteditor #1.edit1,  40,  82, 405, 245

    menu #1, "&Files",_        ' position=0
             "E&xit",[quit.1]

    menu #1, "Edit"            ' position=1 <-- Texteditor menu.

    menu #1, "Help","help",[p],"in2",[p] ' position=2


    open "untitled" for window as #1
    print #1, "font ms_sans_serif 8"
    print #1, "trapclose [quit.1]"

    call fixMenu hWnd(#1), 2 'window handle and menu position.
[p]
wait

[quit.1]
    close #1
    END

SUB fixMenu hWnd,position
'menu bar
    CallDll #user32, "GetMenu",_
                      hWnd as ulong,_
                  hMenuBar as ulong
'sub menu
    calldll #user32, "GetSubMenu",_
                   hMenuBar as ulong, _
                   position as long, _
                   hSubMenu as ulong



'10 menu items total in sub menu
    for x=0 to 9
        if menuText$(x+1)<>"" then
            flags=_MF_STRING or _MF_BYCOMMAND
        else
           flags=_MF_SEPARATOR or _MF_BYCOMMAND
        end if

        CallDll #user32, "GetMenuItemID",_
                          hSubMenu As ulong,_
                                 x As long,_
                       getMenuItem As ulong
                buf$ = menuText$(x+1)

                calldll #user32, "ModifyMenuA", _
                                  hSubMenu as ulong, _
                              getMenuItem  as ulong,_
                                     flags as long, _
                              getMenuItem  as ulong, _
                                      buf$ as ptr, _
                                       ret as boolean
    next
END SUB
