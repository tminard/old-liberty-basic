'////////Some Info\\\\\\\\
'|Just some info you need to know!|
'This Program uses the OLD zipper program!
'The 'Fin.mov' section tells to computer to goto whatever place the user selects
'after killing the current running script. Without it, whatever the user presses while a script
'is running will be ignored.

'///////Script commands\\\\\\\\\
'RUNME 'ie. RUNME TIMEPERFRAME (like '1000' for 1 sec.) X Y bmp1.bmp bmp2.bmp etc
'NOARROWS
'ADDARROWS
'CONFIRMYN 'ie. CONFIRMYN Do you want to continue?
' CASENO 'ie. CASENO 1scriptcommand
' CASEYES 'ie. CASEYES 1scriptcommand
'DRAWSPRITES
'RMSPRITE 'ie. RMSPRITE spritename
'PRINTSPRITE 'ie. PRINTSPRITE spritename X Y
'ADDSPRITE 'ie. ADDSPRITE spritename bmpname (For a cycling sprite, use runplay)
'DIE
'STOPWAV
'STOPMIDI
'WAIT 'ie. WAIT 4000 LASTTHING (LASTTHING can be BAD to end script if user presses key
'or GOOD to just continue with script)
'SOUND (ie. SOUND sound.wav)
'MUSICMIDI (ie. MUSICMIDI playme.mid)
'EndScript



gosub [loading.win]
'nomainwin
nomainwin
'Load data
loadtypes$ = "*.pak"
loadtypes = 1'Extracts all stuff from loadtype$ files if set to 1
datafile$ = "data.cfg"
nozip = 0 'No zipped game data if set to 1
ok = 1    'Enable keys
debug = 0 '0 = off. 1 = debug window. 2 = Show-mouse-XY on left mouse click (Useful when placing objects).
usear = 1 'Use arrows if set to 1
disablearrows = 0'If set to 1 all 'ADDARROWS' commands will be ignored
usemenu = 1
GameName$ = "My first Point-n-click game!"
'See if current Desktop Resolution is supported
seeres$ = str$(DisplayWidth)+"x"+str$(DisplayHeight)
IF fileExists("", seeres$+".game") = 0 AND debug > 0 = 0 THEN notice "Unusable screen resolution!"+chr$(13)+"Please change your screen's resolution from ";DisplayWidth;"x";DisplayHeight;" to 1024x768, then restart this program.":close #loading:end
res$ = seeres$

IF loadtypes = 1 then gosub [load.types]
IF usemenu = 1 THEN close #loading
IF usemenu = 1 THEN gosub [start.menu]
IF debug = 1 then gosub [debug.winsub]
IF nozip = 1 AND debug = 1 THEN print #debug, "NOT extracting bitmaps from game file..."
IF debug = 1 THEN print #debug, "Loading Game Data..."
loaded$ = res$+".game"
bmpsat$ = res$+".game"
IF nozip = 0 THEN gosub [extract.bmps]
open datafile$ for input as #getdata
dim map$(1000)
dim data$(1000)
at = 1
for i = 1 to 1000
IF eof(#getdata) <> 0 then exit for
input #getdata, map$(i)
line input #getdata, data$(i)
next i
close #getdata
goto [start]
end

[extract.bmps.7z]
run "7z.dll e "+res$+".game",HIDE
timer 500, [does.exist]
wait
[does.exist]
IF fileExists("", "zz.z") = 0 THEN wait
timer 0
kill "zz.z"
return

[start]
IF usemenu = 0 THEN close #loading
open "Game" for graphics_nsb_fs AS #game
gosub [load.ar]
'loadbmp "map", res$+word$(data$(at), 1)
'print #game, "background map";
'unloadbmp "map"
'print #game, "drawsprites"
print #game, "flush"
print #game, "trapclose [exit]"
print #game, "when characterInput [input]"
IF debug = 2 THEN print #game, "when leftButtonUp [see.debug]"
print #game, "setfocus"
gosub [scripts.exist]'this makes sure that all the required scripts exist
IF loadgamenow = 1 THEN loadgamenow = 0:goto [load]
goto$ = "[home]"
goto [goto]
'goto [input]
wait

[scripts.exist]
open datafile$ for input as #getdata
line input #getdata, blank$
line input #getdata, scripts$
close #getdata
for i = 1 to 100000
IF word$(scripts$,i,"\") = "" THEN exit for
IF fileExists("",word$(scripts$,i,"\")) = 0 THEN notice word$(scripts$,i,"\")+" not found!"+chr$(13)+"A script was not found! Please reinstall this program or remove/reinstall the latest patch.":close #game:end
next i
return

[exit]
IF playingmid = 1 THEN playingmid = 0:STOPMIDI
IF debug = 1 THEN close #debug
timer 0 'just in case
timer 0 'just in case
timer 0 'etc
timer 0
confirm "Save Progess?";QA$
if runscr = 1 and runplay = 1 then rpdid = rpmany - 1:runplay = 0
IF runningscr = 1 or runscr = 1 THEN close #runscr:runningscr = 0
'IF runningscr = 1 THEN print "ERROR! Can not exit while a script is running!":wait
close #game
gosub [cleanup.log]
IF QA$ = "no" THEN end
open "game.sav" for output AS #saveg
print #saveg, goto$
close #saveg
notice "Progress Saved!"
end

[fin.move]
finmove = 0
'notice Inkey$
IF Inkey$ = "w" THEN [forward]
IF Inkey$ = "a" THEN [left]
IF Inkey$ = "d" THEN [right]
IF Inkey$ = "s" THEN [backward]
IF Inkey$ = "1" THEN [saveload]
wait

[saveload]
prompt "Enter 1 to save game or 2 to load: ";q$
IF q$ = "1" THEN [save]
IF q$ = "2" THEN [load]
wait

[save]
open "game.sav" for output AS #saveg
print #saveg, goto$
close #saveg
notice "Game Saved!"
wait
'|
[load]
IF fileExists("", "game.sav") = 0 THEN notice "No games to load!":wait
open "game.sav" for input AS #loadg
line input #loadg, loadgame$
close #loadg
goto$ = loadgame$
goto [goto]
end

[input]
if runscr = 1 and runplay = 1 then goto [end.script]
IF runningscr = 1 THEN runningscr = 0
IF timerwait = 1 THEN timerwait = 0:EE = 1:finmov = 1:return'...IF program is in ScriptWait then cancel scriptwait and continue with script...
'IF Inkey$ = "`" AND debug = 0 THEN debug = 1:goto [debug.win]
'IF Inkey$ = "`" AND debug = 1 THEN debug = 0:close #debug
IF Inkey$ = "d" THEN [right]
IF Inkey$ = "a" THEN [left]
IF Inkey$ = "w" THEN [forward]
IF Inkey$ = "s" THEN [backward]
IF Inkey$ = "1" THEN [saveload]
wait

[see.debug]
notice MouseX;" x ";MouseY
wait

[fix.goto]
goto [goto]
end

[left]
'cls
IF word$(data$(at), 2) = "NULL" THEN goto [fix.goto]:wait
lastgoto$ = goto$
  goto$ = word$(data$(at), 2)
  for i = 1 to 1000
      IF map$(i) = "" THEN exit for
      IF map$(i) = goto$ THEN ok = 1:at = i:exit for
next i
IF ok = 0 and debug = 1 THEN print #debug, "A script is running. Program will now try to close the running script.":print at:wait
IF ok = 0 THEN wait
ok = 0
IF word$(data$(at), 1) = "script" THEN [run.script]
'print #game, "'cls"
loadbmp "map", res$+word$(data$(at), 1)
IF usear = 1 THEN gosub [set.ar]
print #game, "background map";
'unloadbmp "map"
print #game, "drawsprites"
PRINT #game, "flush"
ok = 1
IF word$(data$(at), 6) = "goto" THEN [run.goto]
IF word$(data$(at),6) = "OPENME" THEN print "Walk to open door."
wait

[right]
IF word$(data$(at), 3) = "NULL" THEN goto [fix.goto]:wait
lastgoto$ = goto$
  goto$ = word$(data$(at), 3)
  for i = 1 to 1000
  IF map$(i) = "" THEN exit for
      IF map$(i) = goto$ THEN ok = 1:at = i:exit for
next i
IF ok = 0 and debug = 1 THEN print #debug, "A script is running. Program will now try to close the running script.":print at:wait
IF ok = 0 THEN wait
ok = 0
IF word$(data$(at), 1) = "script" THEN [run.script]
'print #game, "'cls"
loadbmp "map", res$+word$(data$(at), 1)
print #game, "background map";
IF usear = 1 THEN gosub [set.ar]
'unloadbmp "map"
print #game, "drawsprites"
PRINT #game, "flush"
ok = 1
IF word$(data$(at), 6) = "goto" THEN [run.goto]
IF word$(data$(at),6) = "OPENME" THEN print "Walk to open door."
wait


[forward]
'cls
IF word$(data$(at), 4) = "NULL" THEN goto [fix.goto]:wait
lastgoto$ = goto$
  goto$ = word$(data$(at), 4)
  for i = 1 to 1000
  IF map$(i) = "" THEN exit for
      IF map$(i) = goto$ THEN ok = 1:at = i:exit for
next i
IF ok = 0 and debug = 1 THEN print #debug, "A script is running. Program will now try to close the running script.":print at:move$ = "n":wait
IF ok = 0 THEN wait
ok = 0
IF word$(data$(at), 1) = "script" THEN [run.script]
'print #game, "'cls"
loadbmp "map", res$+word$(data$(at), 1)
print #game, "background map";
IF usear = 1 THEN gosub [set.ar]
'unloadbmp "map"
print #game, "drawsprites"
PRINT #game, "flush"
ok = 1
IF word$(data$(at), 6) = "goto" THEN [run.goto]
IF word$(data$(at),6) = "OPENME" THEN print "Walk to open door."
wait

[backward]
'cls
IF word$(data$(at), 5) = "NULL" THEN goto [fix.goto]:wait
lastgoto$ = goto$
  goto$ = word$(data$(at), 5)
  for i = 1 to 1000
  IF map$(i) = "" THEN exit for
      IF map$(i) = goto$ THEN ok = 1:at = i:exit for
next i
IF ok = 0 and debug = 1 THEN print #debug, "A script is running. Program will now try to close the running script.":print at:wait
IF ok = 0 THEN wait
ok = 0
IF word$(data$(at), 1) = "script" THEN [run.script]
'print #game, "'cls"
loadbmp "map", res$+word$(data$(at), 1)
print #game, "background map";
IF usear = 1 THEN gosub [set.ar]
''unloadbmp "map"
print #game, "drawsprites"
PRINT #game, "flush"
ok = 1
IF word$(data$(at), 6) = "goto" THEN [run.goto]
IF word$(data$(at),6) = "OPENME" THEN print "Walk to open door."
wait



[run.script]
'IF runningscr = 1 THEN return
runningscr = 1
bmpsat$ = word$(data$(at),2)
script$ = word$(data$(at),2)
gosub [extract.bmps]
open "scriptdat.txt" for input as #runscr
runscr = 1
goto [run.my.script.go]
end

[end.script]
EN = 1
finmove = 1
IF runplay = 1 THEN timer 0:print #game, "removesprite rp":print #game, "drawsprites":runplay = 0:return
wait

[script.wait]
timerwait = 1
timewait = val(word$(command$,2))
timer timewait, [wait.go]
wait
'|_
    [wait.go]
    timer 0
    timerwait = 0
    return

[script.adds]
loadbmp word$(command$,3), res$+word$(command$,3)
print #game, "addsprite "+word$(command$,2)+" "+word$(command$,3)
return

[script.prints]
print #game, "spritexy "+word$(command$,2)+" "+word$(command$,3)+" "+word$(command$,4)
return

[script.rm]
print #game, "removesprite "+word$(command$,2)
return

[confirm]
doYN$ = ""
confirm word$(command$,2,"|");YN$
IF YN$ = "no" THEN doYN$ = "no"
IF YN$ = "yes" THEN doYN$ = "yes"
return

[run.my.script.go]
for i = 1 to 1000
IF eof(#runscr) <> 0 THEN exit for
line input #runscr, command$

'//////////Here are all the dif. script commands!\\\\\\\\\\\
IF upper$(word$(command$,1)) = "CASENO" AND doYN$ = "no" THEN doYN$ = "":command$ = upper$(word$(command$,2))
IF upper$(word$(command$,1)) = "CASEYES" AND doYN$ = "yes" THEN doYN$ = "":command$ = upper$(word$(command$,2))
IF lower$(word$(command$,1)) = "runme" THEN gosub [runcode]

IF EN = 1 THEN EN = 0: exit for

IF upper$(command$) = "NOARROWS" THEN usear = 0:gosub [rm.ar]
IF upper$(command$) = "ADDARROWS" AND disablearrows = 0 THEN usear = 1:gosub [set.ar]
IF upper$(word$(command$,1,"|")) = "CONFIRMYN" THEN gosub [confirm]
IF upper$(word$(command$,1)) = "DRAWSPRITES" THEN print #game, "drawsprites"
IF upper$(word$(command$,1)) = "RMSPRITE" THEN gosub [script.rm]'RMSPRITE spritename
IF upper$(word$(command$,1)) = "PRINTSPRITE" THEN gosub [script.prints]'PRINTSPRITE spritename X Y
IF upper$(word$(command$,1)) = "ADDSPRITE" THEN gosub [script.adds]'ADDSPRITE spritename bmpname
IF upper$(command$) = "DIE" THEN notice "You Died!":close #runscr:runscr = 0:close #game:end
IF upper$(command$) = "STOPWAV" THEN playwave ""
IF upper$(command$) = "STOPMIDI" THEN stopmidi
IF upper$(word$(command$,1)) = "WAIT" THEN gosub [script.wait]'WAIT 4000 END (or 'GOOD')

IF EE = 1 THEN timer 0
IF EE = 1 AND upper$(word$(command$,3)) = "END" THEN exit for
IF EE = 1 AND upper$(word$(command$,3)) = "" or upper$(word$(command$,3)) = "GOOD" THEN EE = 0

IF upper$(word$(command$,1)) = "SOUND" THEN playwave "":playwave word$(command$, 2), async
IF upper$(word$(command$,1)) = "MUSICMIDI" AND playingmid = 1 THEN STOPMIDI:playmidi word$(command$,2), howLong
IF upper$(word$(command$,1)) = "MUSICMIDI" AND playingmid = 0 THEN playmidi word$(command$,2), howLong:playingmid = 1
IF command$ = "EndScript" THEN exit for
next i

IF EE = 1 THEN finmove = 1:EE = 0
'open script$+".log" for input AS #killall
'for kg = 1 to 100000
'IF eof(#killall) <> 0 THEN exit for
'line input #killall, killme$
'IF fileExists("", killme$) THEN kill killme$
'next kg
'close #killall
'IF fileExists("", script$+".log") THEN kill script$+".log"

close #runscr
runscr = 0
goto$ = word$(data$(at), 3)
runningscr = 0
goto [goto]
end

[runcode]
runme$ = ""
runme$ = right$(command$, len(command$)-5)
gosub [runplay]
return

[goto]
'IF usear = 1 THEN gosub [set.ar]
  for i = 1 to 1000
  IF map$(i) = "" THEN exit for
      IF map$(i) = goto$ THEN ok = 1:at = i:exit for
next i
IF finmove = 1 THEN print "Doing Fin.Mov...":goto [fin.move]
IF ok = 0 and debug = 1 THEN print #debug, "A script is running. Program will now try to close the running script.":print at:wait
IF ok = 0 THEN wait
ok = 0
IF word$(data$(at), 1) = "script" THEN [run.script]
'print #game, "'cls"
loadbmp "map", res$+word$(data$(at), 1)
print #game, "background map";
'unloadbmp "map"
IF usear = 1 THEN gosub [set.ar]
print #game, "drawsprites"
PRINT #game, "flush"
IF word$(data$(at), 6) = "goto" THEN [run.goto]
IF word$(data$(at),6) = "OPENME" THEN print "Walk to open door."'I never use this
wait

[rm.ar]
print #game, "spritevisible ar1 off";
print #game, "spritevisible ar2 off";
print #game, "spritevisible ar3 off";
print #game, "spritevisible ar4 off";
return

[set.ar]
'notice data$(at)
'word$(data$(at), 2) = left
'word$(data$(at), 3) = right
'word$(data$(at), 4) = forward
'word$(data$(at), 5) = backward
IF word$(data$(at), 2) = "NULL" = 0 THEN print #game, "spritevisible ar1 on":print #game, "spritetofront ar1 ";
IF word$(data$(at), 3) = "NULL" = 0 THEN print #game, "spritevisible ar2 on":print #game, "spritetofront ar2 ";
IF word$(data$(at), 4) = "NULL" = 0 THEN print #game, "spritevisible ar3 on":print #game, "spritetofront ar3 ";
IF word$(data$(at), 5) = "NULL" = 0 THEN print #game, "spritevisible ar4 on":print #game, "spritetofront ar4 ";

IF word$(data$(at), 2) = "NULL" THEN print #game, "spritevisible ar1 off";
IF word$(data$(at), 3) = "NULL" THEN print #game, "spritevisible ar2 off";
IF word$(data$(at), 4) = "NULL" THEN print #game, "spritevisible ar3 off";
IF word$(data$(at), 5) = "NULL" THEN print #game, "spritevisible ar4 off";
return

[load.ar]
loadbmp "arrow1", res$+"arrow1.bmp"'Left (and right)
loadbmp "arrow2", res$+"arrow2.bmp"'Up (and down)
print #game, "addsprite ar1 arrow1";
print #game, "spritexy ar1 15 56";
print #game, "addsprite ar2 arrow1";
print #game, "spritexy ar2 87 58";
print #game, "spriteorient ar2 rotate180";
print #game, "addsprite ar3 arrow2";
print #game, "spritexy ar3 60 11";
print #game, "addsprite ar4 arrow2";
print #game, "spritexy ar4 59 90";
print #game, "spriteorient ar4 rotate180";
print #game, "spritevisible ar1 off";
print #game, "spritevisible ar2 off";
print #game, "spritevisible ar3 off";
print #game, "spritevisible ar4 off";
return
[run.goto]
goto$ = word$(data$(at), 7)
goto [goto]
end


[extract.bmps]
'IF playingmid = 1 THEN playingmid = 0:STOPMIDI
IF drivess$ = "quit" then end
IF trim$(drivess$) = "" THEN drivess$ = DefaultDir$
IF right$(drivess$,1) = "\" = 0 THEN drivess$ = drivess$+"\"
IF fileExists("",bmpsat$) = 0 THEN notice "Please insert next disk"+chr$(13)+"Please insert the disk that contains the file '"+bmpsat$+"' Press 'ok' to continue."
IF fileExists("",bmpsat$) = 0 THEN end
open bmpsat$ for input AS #1
input #1, file
input #1, pass$
goto [top2]
end

[top2]
IF err$ = "on" THEN close #1:err$="":wait
input #1, filename$
IF filename$ = "endall" THEN close #1:print "Done!":return

open bmpsat$+".log" for append AS #sn
print #sn, filename$
close #sn

input #1, lenth$
lenth = val(lenth$)
doitnow = mkdir(drivess$)
IF err$ = "on" THEN close #2:close #1:err$="":wait
open drivess$+filename$ for output AS #2
text$ = input$(#1, lenth)
print #2, text$
close #2
'IF eof(#1) <> 0 then close #1:return
input #1, blank$
IF blank$ = "NEXT DISK" THEN input #1, nextdisk$:notice "Please insert the next disk to continue setup"
IF blank$ = "NEXT DISK" THEN goto [get.nextdisk]
'IF eof(#1) <> 0 then close #1:return
goto [top2]
end




[get.nextdisk]
IF err$ = "on" THEN close #1:err$="":wait
if fileExists("",nextdisk$) THEN goto [load.nextdisk]
IF fileExists("",nextdisk$) = 0 THEN notice "Invailed Disk! Please insert next disk! Continue?";cont$
IF cont$ = "no" then close #1:end
goto [get.nextdisk]
end

[load.nextdisk]
close #1
open nextdisk$ for input AS #1
input #1, file
input #1, pass$
goto [top2]
end





[functions]
dim info$(100,10)
FUNCTION fileExists(path$, filename$) ' Does file exist?
    files path$, filename$, info$(
    fileExists = val(info$(0, 0)) > 0
END FUNCTION


Sub DrawText hdc,text$,x,y,w,h
    length=Len(text$)
    style=_DT_WORDBREAK  OR _DT_CENTER
    Rect.x1.struct=x : Rect.y1.struct=y
    Rect.x2.struct=w : Rect.y2.struct=h

    CallDLL #user32,"DrawTextA", hdc as uLong,text$ As Ptr,length As Long,_
    Rect As struct, style As Long,result As Long
    End Sub

[cleanup.log]
dim logsb$(10, 10)
dim logs$(1000)
gosub [get.logs]
for c = 1 to val(logsb$(0,0))
 open logs$(c) for input AS #kf
   for b = 1 to 100000
    IF eof(#kf) <> 0 THEN exit for
    line input #kf, killme$
    IF fileExists("",killme$) THEN kill killme$
    next b
    close #kf
    kill logs$(c)
next c
return

[clear.main]
open loaded$+".log" for input AS #getf
getf = lof(#getf)
loadedtxt$ = input$(#getf, getf)
close #getf
kill loaded$+".log"
open "mainlo.log" for output AS #getf
print #getf, loadedtxt$
close #getf
return

[get.logs]
IF nozip = 0 THEN gosub [clear.main]
dim logsb$(10, 10)
dim logs$(1000)
 files DefaultDir$, "*.log", logsb$(
 for i = 1 to val(logsb$(0,0))
 logs$(i) = logsb$(i,0)
 'notice logs$(i)
 next i
 return

[load.types]
dim types$(10, 10)
dim type$(1000)
 files DefaultDir$, loadtypes$, types$(
 for i = 1 to val(types$(0,0))
 type$(i) = types$(i,0)
 bmpsat$ = type$(i)
 gosub [extract.bmps]
 'notice logs$(i)
 next i
 return

[runplay]'This clip runs a 'script' to display a series of bitmaps at the fps given!!!!
runplay = 1
'runme$ = "1000 0 0 1.bmp 2.bmp 3.bmp"
'------ =  fps x y bmp1 bmp2 bmp3

rpmany = 0
rpdid = 0
rptime = val(word$(runme$,1))
rpbmps$ = ""
for rp =4 to 1000
IF trim$(word$(runme$,rp)) = "" THEN exit for
rpmany = rpmany + 1
loadbmp word$(runme$,rp), res$+word$(runme$,rp)
rpbmps$ = rpbmps$ + " "+word$(runme$,rp)
next rp

'notice rpbmps$
print #game, "addsprite rp "+rpbmps$;

rpx = val(word$(runme$,2))
rpy = val(word$(runme$,3))
print #game, "spritexy rp ";rpx;" ";rpy
print #game, "cyclesprite rp 1 once"
print #game, "drawsprites"
timer rptime, [rp.draw]
wait

[rp.draw]
rpdid = rpdid + 1
print #game, "drawsprites"
IF rpdid = rpmany THEN timer 0:print #game, "removesprite rp":print #game, "drawsprites":runplay = 0:return
wait

[debug.win]
open "PACG" for text as #debug
wait


[debug.winsub]
open "PACG" for text as #debug
return

[start.menu]

    WindowWidth = 300
    WindowHeight = 330
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    groupbox #mmenu.groupbox5, "",  50,  32, 155, 175
    button #mmenu.button1,"New Game",[button1Click], UL,  80,  47, 100,  25
    button #mmenu.button2,"Continue Game",[button2Click], UL,  80,  87, 102,  25
    button #mmenu.button3,"Quit",[quit.menu], UL,  10, 262,  40,  25
    button #mmenu.button4,"About",[button4Click], UL, 105, 162,  55,  25

    '-----End GUI objects code

    open GameName$ for window_nf as #mmenu
    print #mmenu, "font ms_sans_serif 10"
    print #mmenu, "trapclose [quit.menu]"


[menu.inputLoop]   'wait here for input event
    wait



[button1Click]   'Perform action for the button named 'button1'
close #mmenu
return



[button2Click]   'Perform action for the button named 'button2'
IF fileExists("", "game.sav") = 0 THEN notice "No games to continue!":wait
close #mmenu
loadgamenow = 1
return



[button4Click]   'Perform action for the button named 'button4'

    'Insert your own code here

    wait

[quit.menu] 'End the program
    close #mmenu
    end

'Form created with the help of Freeform 3 v03-27-03
'Generated on Apr 23, 2006 at 16:36:10


[loading.win]

    '-----Begin code for #loading

    nomainwin
    WindowWidth = 180
    WindowHeight = 50
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    groupbox #loading.groupbox3, "",   5,  -3, 170,  45
    statictext #loading.statictext1, "Loading, please wait...",  25,  17, 140,  20

    '-----End GUI objects code

    open "" for window_popup as #loading
    print #loading, "font ms_sans_serif 10"
    print #loading, "trapclose [quit.loading]"


[loading.inputLoop]   'wait here for input event
    return


[quit.loading] 'End the program
    close #loading
    end

