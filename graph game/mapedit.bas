dim field$(203,100)
'field$(x,0) = what happens
'field$(x,1) = who owns the land
'field$(x,2) = the population
'field$(x,3) = the building type

loadbmp "dirt1","dirt1.bmp"
loadbmp "grass1","grass.bmp"
loadbmp "man1","man.bmp"
loadbmp "water","water.bmp"
loadbmp "mouse", "mouse.bmp"
loadbmp "selected","selected.bmp"
loadbmp "hide", "hide.bmp"
loadbmp "check", "check.bmp"
loadbmp "rock1", "rock1.bmp"
loadbmp "tile1", "tiles.bmp"
loadbmp "house1", "house.bmp"

dim images$(1000)
images$(1) = "dirt1"
images$(2) = "grass1"
images$(3) = "tile1"
images$(4) = "water"
images$(5) = "hide"
images$(6) = "rock1"
images$(7) = "house1"

nomainwin

    WindowWidth = 550
    WindowHeight = 470

    graphicbox #main.graph, 26, 16, 504, 350
    menu #main, "File", "Save As...",[saveas]
    menu #main, "Tools", "Choose Tile", [tools], "Set Clear", [set.clear], "Set Action..",[actions], "MAN start point", [start.point], "FINISH point", [fin.point]
    open "Game" for window_nf as #main
    print #main.graph, "fill white; flush"
    print #main, "trapclose [end]"
  '  print #main.graph, "when characterInput [key]"
    print #main.graph, "when leftButtonUp [leftm.cl]"
    print #main.graph, "when rightButtonUp [clear]"
    print #main.graph, "when mouseMove [mouse.m]"
    print #main, "font ms_sans_serif 0 16"
    h=hwnd(#main)
    value$ = "Welcome!"
    styleValue = _WS_VISIBLE or _WS_CHILD
    hStatusBar=initalizeStatusBar(h,value$)
    goto [load.sprites]
    '----End code for statusbar


[changeMessageBar]
    '----This changes the text in the statusbar
    '----Change the text in value$ then gosub this routine
   ' value$="New Text"
    a= SendMessagePtr(hStatusBar,_WM_SETTEXT,0,value$)
    wait

[start.point]
startset = 1
finset = 0
wait

[fin.point]
finset = 1
startset = 0
wait

[clear]
startset = 0
finset = 0
okIm$ = ""
act$ = ""
value$ = "Bitmap: "+okIm$+"; Action: "+act$
a= SendMessagePtr(hStatusBar,_WM_SETTEXT,0,value$)
wait

[set.clear]
wait

[tools]
goto [setImage]
wait

[actions]
 goto [setAction]
 wait

[saveas]
prompt "Enter a file name: ";fN$
open fN$ for output AS #sm
print #sm, starting
print #sm, finish
for i = 0 to 203
  print #sm, field$(i,0)
  print #sm, field$(i,1)
next i
close #sm
notice "Done!"
wait


[options]
IF trim$(selected$) = "" then wait
popupmenu "&Set Image", [setImage], _
    "&Set Action", [setAction]
wait

[setAction]
'val = val(word$(selected$,2,"dirt"))
'act$ = field$(val,1)
prompt "Enter an Action (stop, die...):";act$
'field$(val,1) = act$
value$ = "Bitmap: "+okIm$+"; Action: "+act$
a= SendMessagePtr(hStatusBar,_WM_SETTEXT,0,value$)

print #main.graph, "drawsprites"
wait

[setImage]
    nomainwin
    WindowWidth = 270
    WindowHeight = 140
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    statictext #img.statictext1, "Choose Image:",   5,  27,  91,  20
    ComboboxColor$ = "white"
    combobox #img.combobox3, images$(, [chooseImg],  110,  27, 100, 100
    button #img.button4,"Ok",[okIm], UL,  90,  67,  60,  25

    '-----End GUI objects code
    open "Choose an Image" for dialog_modal as #img
    print #img, "font ms_sans_serif 10"
    print #img, "trapclose [quit.img]"
    val = val(word$(selected$,2,"dirt"))
    print #img.combobox3, "select "+field$(val,0)

[img.inputLoop]   'wait here for input event
    wait
[okIm]
IF okIm$ = "" then wait
'close #img
'PRINT #main.graph, "spritexy? "+selected$+" tmpx tmpy"
'print #main.graph, "removesprite "+selected$
'val = val(word$(selected$,2,"dirt"))
'field$(val,0) = okIm$
'print #main.graph, "addsprite "+selected$+" "+okIm$+" "';tmpx;" ";tmpy
'print #main.graph, "spritexy "+selected$+" ";tmpx;" ";tmpy
'selected$ = ""
'okIm$ = ""
close #img
value$ = "Bitmap: "+okIm$+"; Action: "+act$
a= SendMessagePtr(hStatusBar,_WM_SETTEXT,0,value$)
print #main.graph, "drawsprites"
wait

[drawit]
IF selected$ = "" then wait

PRINT #main.graph, "spritexy? "+selected$+" tmpx tmpy"
val = val(word$(selected$,2,"dirt"))
IF startset = 1 then starting = val:goto [draw.starting]
IF finset = 1 then finish = val:goto [draw.finish]

IF okIm$ = "" then wait
print #main.graph, "removesprite "+selected$
field$(val,0) = okIm$
field$(val,1) = act$
print #main.graph, "addsprite "+selected$+" "+okIm$+" "';tmpx;" ";tmpy
print #main.graph, "spritexy "+selected$+" ";tmpx;" ";tmpy
print #main.graph, "drawsprites"

print #main.graph, "drawsprites"
wait

[draw.starting]
IF didman = 1 then print #main.graph, "removesprite man"
print #main.graph, "addsprite man man1"
print #main.graph, "spritexy man ";tmpx;" ";tmpy
print #main.graph, "drawsprites"
didman = 1
startset = 0
wait

[draw.finish]
IF didfin = 1 then print #main.graph, "removesprite finish"
print #main.graph, "addsprite finish tile1"
print #main.graph, "spritexy finish ";tmpx;" ";tmpy
print #main.graph, "drawsprites"
didfin = 1
finset = 0
wait

[chooseImg]
print #img.combobox3, "selection? okIm$"
wait
[quit.img]
close #img
wait

[end]
timer 0
close #main
end

[leftm.cl]
print #main.graph, "spritecollides mouse mouse$"
IF trim$(mouse$) = "" then wait
print #main.graph, "spritexy? "+word$(mouse$,1)+" mx my"
print #main.graph, "spritexy selected ";mx;" ";my
print #main.graph, "spritevisible selected on"
selected$ = word$(mouse$,1)
print #main.graph, "drawsprites"
goto [drawit]
wait


[mouse.m]
print #main.graph, "spritexy mouse ";MouseX;" ";MouseY
wait





[load.sprites]
while onsquareX = 510 = 0
for i = 1 to 12
tmp = int(rnd(1)*1) + 1
 IF tmp = 1 then chosen$ = "hide"

print #main.graph, "addsprite dirt";is;" "+chosen$
print #main.graph, "spritexy dirt";is;" ";onsquareX;" ";onsquareY
field$(is,0) = "hide" 'Block Image: water, dirt1, grass1, rock, tiles1
field$(is,1) = ""     'what to do on contact: stop, die
onsquareY = onsquareY + 30
is = is + 1
next i
hidden = is - 1
onsquareX = onsquareX + 30
onsquareY = 0
wend

print #main.graph, "addsprite mouse mouse"
print #main.graph, "spritexy mouse ";MouseX;" ";MouseY
print #main.graph, "addsprite selected selected"
print #main.graph, "spritevisible selected off"
print #main.graph, "drawsprites"
'timer 500, [draw]
wait

[draw]
print #main.graph, "drawsprites"
wait


FUNCTION initalizeStatusBar(h, value$)

    calldll #comctl32,"InitCommonControls",_
    result as long

    styleValue = _WS_VISIBLE or _WS_CHILD
    calldll #comctl32,"CreateStatusWindow",_
    styleValue as long,_
    value$ as ptr,_
    h as long,_
    22 as long,_
    r as long
    initalizeStatusBar=r
END FUNCTION


FUNCTION SendMessagePtr(hWnd,msg,w,p$)
    CallDLL #user32, "SendMessageA",_
    hWnd As long, _
    msg As long,_
    w As long,_
    p$ As ptr,_
    SendMessagePtr As long
END FUNCTION


FUNCTION SendMessageLong(hStatusBar,msg,w,p)
    CallDLL #user32, "SendMessageA",_
    hStatusBar As long, _
    msg As long,_
    w As long,_
    p As long,_
    SendMessagePtr As long
END FUNCTION


