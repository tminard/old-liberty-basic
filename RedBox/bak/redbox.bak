'// Redbox by Tyler Minard \\'
'Code copyright (c) 2006 by Tyler Minard
'All rights reserved
IF fileExists("", "operation.op") THEN kill "operation.op":notice "Error starting program!"+chr$(13)+"Redbox is currently running. Please close that one first, then try starting this program again.":end
ver$ = "v2.2"
open "operation.op" for output AS #blo
close #blo
doreg = 0
nomainwin

[start.top]
loadwin$ = "Loading Game..."
gosub [load.win]
run "apak.dll x redbox.pk3 -aoa ", HIDE
timer 1000, [con2]
wait

[con2]
timer 0
cls
IF fileExists("","load.dat.tmp") then gosub [create.ld]
firstrun = 1
cursor crosshair
IF fileExists("","redbox.ini") THEN
 open "redbox.ini" for input AS #fini
 line input #fini, skin$
 close #fini
end if

IF fileExists("",skin$) = 0 THEN skin$ = "game.dat"':notice "Skin "+skin$+" not found! using original!"
IF fileExists("","load.dat") = 0 THEN open "load.dat" for output AS #1:print #1, "game.dat":close #1

name "load.dat" AS "load.dat.tmp"
open "load.dat.tmp" for input AS #tmp
open "load.dat" for output AS #ld
for i = 1 to 1000000
IF eof(#tmp) <> 0 THEN exit for
line input #tmp, txt$
print #ld, txt$
next i
close #ld
close #tmp

open "load.dat" for append AS #ssk
print #ssk, skin$
close #ssk
print "Using Skin: "+skin$
IF fileExists("", "redbox.ini") = 0 THEN skin$ = "game.dat"

regok = 0
doreg = 1

open "load.dat" for input AS #67
for i = 1 to 1000
IF eof(#67) <> 0 THEN exit for
line input #67, bmpsat$
IF trim$(bmpsat$) = "" THEN exit for
print "Loading file: "+bmpsat$

'KEY$ = "ycpwf"
'INFILE$ = bmpsat$
'OUTFILE$ = bmpsat$+".inc"
'MODE = 2
'gosub [encrypt]

gosub [extract.bmps]
next i
close #67

bmpsat$ = skin$
gosub [extract.bmps]
IF firstrun = 1 then close #lw
IF doreg = 1 THEN gosub [is.activ]
'IF doreg = 1 THEN gosub [reg.me]
IF doreg = 0 THEN regok = 1

'IF regok = 0 THEN skin$ = "game.dat"
IF regok = 0 THEN print "Invalid activation information. Program not registered!"
goto [start]
end

[start]
loadwin$ = "Loading Game..."
gosub [load.win]
'nominwin
'debug = 2 'Enable this and the man can only die if hit by a wall!
'debug = 1 'Enable this and: Every time you let the mouse go, your X and Y location is displayed.
startspeed = 2 'Starting enemy speed
enspeed = 2

loadbmp "sq1", "en1.bmp" 'Square 1
loadbmp "sq2", "en2.bmp" 'Square 2
loadbmp "sq3", "en3.bmp" 'Square 3
loadbmp "box", "box.bmp" 'Box
loadbmp "rb", "man.bmp"  'Redbox (You!)
loadbmp "mouse", "mo.bmp"' Invisible Sprite. Used to see if mouse is on 'man'

start = 1

'Form created with the help of Freeform 3 v03-27-03
'Generated on Mar 18, 2006 at 13:26:29


[setup.main.Window]
    '-----Begin code for #main

   ' 'nominwin
    ' UpperLeftX = DisplayWidth / 2
    ' UpperLeftY = DisplayHeight / 2
    WindowWidth = 375
    WindowHeight = 450
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    graphicbox #g.main,  20,   7, 323, 347
   ' stylebits #g, _DS_CENTER OR _DS_CENTERMOUSE, 0, 0, 0
    button #g.button2,"Quit",[button2Click], UL,  10, 362,  50,  25
    statictext #g.statictext3, "Time:", 240, 372, 100,  20
close #lw
    '-----End GUI objects code
    menu #g, "&Game", "Exit", [quit]
    menu #g, "&Skins", "&Change Skin...", [change.skn],|,"Install new skin...", [inst.skn]
    IF regok = 0 THEN menu #g, "R&egistration", "Activate program...",[reg.me.sub]
    IF regok = 1 then open "RedBox by Adelphos Pro "+ver$+" - Registered " for window_nf as #g
    IF regok = 0 then open "RedBox by Adelphos Pro "+ver$+" - UNREGISTERED!" for window_nf as #g
    print #g.main, "down; fill white; flush"
    print #g, "font ms_sans_serif 10"
    print #g, "trapclose [quit]"


IF firstrun = 1 THEN firstrun = 0:close #g:goto [start]' Shutdown the game on first run to make
'it go to middle of screen

[main.inputLoop]   'wait here for input event
goto [main.code]
    wait

[reg.me.sub]
timer 0
gosub [reg.me]
timer 1, [draw]
wait

[button2Click]   'Perform action for the button named 'button2'
print #g.button2, "!disable"
goto [quit]
wait


[main.code]
print #g.main, "when leftButtonMove [mouse]"
print #g.main, "when leftButtonDown [mouse.down]"
print #g.main, "when leftButtonUp  [mouse.up]"
 print #g.main, "when characterInput [mov]"

print #g, "trapclose [quit]"

print #g.main, "addsprite sq1 sq1"
'print #g.main, "centersprite sq1"

print #g.main, "addsprite sq2 sq2"
'print #g.main, "centersprite sq2"

print #g.main, "addsprite sq3 sq3"
'print #g.main, "centersprite sq3"

print #g.main, "addsprite sq4 sq1"
'print #g.main, "centersprite sq4"

print #g.main, "background box 0 0"
print #g.main, "addsprite man rb"
'print #g.main, "centersprite man"

print #g.main, "addsprite mouse mouse"
'print #g.main, "centersprite mouse"

print #g.main, "spritexy man 142 160"
print #g.main, "spritexy sq1 107 95"
print #g.main, "spritexy sq2 206 122"
print #g.main, "spritexy sq3 121 227"
print #g.main, "spritexy sq4 196 220"

print #g.main, "drawsprites"
print #g.main, "setfocus"
timer 1, [draw]
wait

[mouse]
IF pause = 1 THEN wait
scan
IF mouse$ = "up" THEN wait
IF mouse$ = "" THEN wait
IF manok = 0 THEN wait
speed = 1000
#g.main "spritetravelxy man " ;MouseX-10; " " ;MouseY-10; " " ;speed; " [wait]"
wait

[mouse.down]
IF pause = 1 THEN wait
IF start = 1 THEN startTime = time$("ms"):gosub [en.go1.sub]:gosub [en.go2.sub]:gosub [en.go4.sub]:gosub [en.go3.sub]

start = 0
mouse$ = "down"
gosub [activate]
IF manok = 0 THEN mouse$ = "down":wait
wait

[mouse.up]
IF pause = 1 THEN wait
print #g.main, "spritexy? man tx$ ty$"
IF debug = 1 THEN print tx$+" "+ty$
mouse$ = "up"
manok = 0
wait

[activate]
manok = 0
print #g.main, "spritexy mouse ";MouseX;" ";MouseY
print #g.main, "drawsprites"
print #g.main, "spritecollides mouse list$"
for i = 1 to 10000
IF trim$(word$(list$,i)) = "" THEN manok = 0:exit for
IF trim$(word$(list$,i)) = "man" THEN manok = 1:exit for
next i
return

[wait]
wait

[draw]
SCAN
IF start = 1 THEN wait
print #g.main, "spritecollides man mlist$"
IF mlist$ = "" = 0 AND instr(mlist$, "mouse") = 0 THEN [exit]

print #g.main, "spritexy? man tx$ ty$"
scan
IF val(tx$) > 260 or  val(ty$) > 304 or val(tx$) < 39 or val(ty$) < 15 THEN goto [exit]:end
scan
goingTime =time$("ms")
goingTime=goingTime-startTime
goingTime = goingTime/1000
#g.statictext3, "Time: ";goingTime
'print #g.main, "drawsprites"
IF goingTime > 15 AND regok = 0 THEN timer 0:print #g.main, "down; fill black; flush":notice "Unregistered Version!":goto [exit.go]


IF goingTime >  10 AND goingTime < 11 THEN enspeed = startspeed + 1
IF goingTime > 14 AND goingTime < 15 THEN enspeed = startspeed + 2
IF goingTime > 17 AND goingTime < 18 THEN enspeed = startspeed + 3
IF goingTime > 19 AND goingTime < 20 THEN enspeed = startspeed+ 4
IF goingTime > 20 AND goingTime < 26 THEN enspeed = startspeed + 5
IF goingTime > 26 AND goingTime < 27 THEN enspeed = startspeed + 6
IF goingTime > 28 AND goingTime < 30 THEN enspeed = startspeed + 7
IF goingTime > 30 THEN enspeed = enspeed + 0.01
print #g.main, "drawsprites"
scan
wait
'print #g.main, "spritecollides man mlist$"
'print #g.main, "drawsprites"
'scan
'IF debug = 2 = 0 AND left$(word$(mlist$,1),2) = "sq" THEN goto [exit]
'print #g.main, "spritexy? man tx$ ty$"
'IF val(tx$) > 260 or  val(ty$) > 304 or val(tx$) < 39 or val(ty$) < 15 THEN goto [exit]:end
'scan
'wait

[exit]
timer 0
endTime=time$("ms")
timeDid = endTime-startTime
notice "You lasted ";timeDid / 1000;" seconds!"
open "scores.txt" for append As #ss
print #ss, timeDid / 1000
close #ss
goto [exit.go]
end

[exit.go]
timer 0
'confirm "Restart? ";YN$
print #g.main, "removesprite mouse"
'print #g.main, "centersprite mouse"

print #g.main, "removesprite man"
print #g.main, "removesprite sq1"
print #g.main, "removesprite sq2"
print #g.main, "removesprite sq3"
print #g.main, "removesprite sq4"
print #g.main, "cls"
unloadbmp "sq1"
unloadbmp "sq2"
unloadbmp "sq3"
unloadbmp "box"
unloadbmp "rb"
unloadbmp "mouse"
close #g
enspeed = 0
open "redbox.ini" for output AS #ss
print #ss, skin$
close #ss
goto [start.top]
end

[quit]
timer 0
cursor normal
timer 1000, [wait.g]
wait

[wait.g]
timer 0
close #g

open "game.dat.log" for input AS #kf
for i = 1 to 100000
IF eof(#kf) <> 0 THEN exit for
line input #kf, killme$
IF fileExists("",killme$) THEN kill killme$
next i
close #kf
kill "game.dat.log"
'IF fileExists("", skin$+".log") = 0 THEN end

'open skin$+".log" for input AS #kf
'for i = 1 to 100000
'IF eof(#kf) <> 0 THEN exit for
'line input #kf, killme$
'IF fileExists("",killme$) THEN kill killme$
'next i
'close #kf
'kill skin$+".log"

open "load.dat" for input AS #67
for i = 1 to 1000
IF eof(#67) <> 0 THEN exit for
line input #67, killme$
IF fileExists("",killme$+".log") THEN gosub [killit1]
next i
close #67

kill "load.dat"
name "load.dat.tmp" as "load.dat"
kill "redbox.pk3"
run "apak.dll a -t7z redbox.pk3 @files.dat",HIDE
'loadwin$ = "Closing Game..."
'gosub [load.win]
timer 3000, [con]
wait

[con]
timer 0
gosub [kill.pak]
'close #lw
kill "operation.op"
end

[killit1]
open killme$+".log" for input AS #kf
km$ = killme$
for qq = 1 to 100000
IF eof(#kf) <> 0 THEN exit for
line input #kf, killme$
print "Removing File: "+killme$
IF fileExists("",killme$) THEN kill killme$
next qq
close #kf
kill km$+".log"
IF fileExists("",killme$+".inc") THEN kill killme$+".inc"
return

[en.go1]
endgo = int(rnd(1)*8) + 1

IF endgo = 1 THEN sq1x = 54:sq1y = 28
IF endgo = 2 THEN sq1x = 245:sq1y = 284
IF endgo = 3 THEN sq1x = 124:sq1y = 289
IF endgo = 4 THEN sq1x = 246:sq1y = 32
IF endgo = 5 THEN sq1x = 48:sq1y = 283
IF endgo = 6 THEN sq1x = 50:sq1y = 152
IF endgo = 7 THEN sq1x = 136:sq1y = 14
IF endgo = 8 THEN sq1x = 49:sq1y = 133

#g.main "spritetravelxy sq1 " ;sq1x; " " ;sq1y; " " ;enspeed; " [en.go1]"
wait
[en.go1.sub]
endgo = int(rnd(1)*1) + 1
IF endgo = 1 THEN sq1x = 54:sq1y = 28 'start by going to the top left side

#g.main "spritetravelxy sq1 " ;sq1x; " " ;sq1y; " " ;enspeed; " [en.go1]"
return



[en.go2.sub]
endgo = int(rnd(1)*1) + 1

IF endgo = 1 THEN sq2x = 246:sq2y = 32 'top right
#g.main "spritetravelxy sq2 " ;sq2x; " " ;sq2y; " " ;enspeed; " [en.go2]"
return
[en.go2]
endgo = int(rnd(1)*8) + 1

IF endgo = 1 THEN sq2x = 54:sq2y = 28
IF endgo = 2 THEN sq2x = 245:sq2y = 284
IF endgo = 3 THEN sq2x = 124:sq2y = 289
IF endgo = 4 THEN sq2x = 246:sq2y = 32

IF endgo = 5 THEN sq2x = 48:sq2y = 283
IF endgo = 6 THEN sq2x = 50:sq2y = 152
IF endgo = 7 THEN sq2x = 136:sq2y = 14
IF endgo = 8 THEN sq2x = 49:sq2y = 133
#g.main "spritetravelxy sq2 " ;sq2x; " " ;sq2y; " " ;enspeed; " [en.go2]"
wait

[en.go3.sub]
endgo = int(rnd(1)*1) + 1

'IF endgo = 1 THEN sq2x = 54:sq2y = 28
IF endgo = 1 THEN sq2x = 245:sq2y = 284
'IF endgo = 3 THEN sq2x = 124:sq2y = 289
'IF endgo = 4 THEN sq2x = 246:sq2y = 32
'IF endgo = 5 THEN sq2x = 48:sq2y = 283
'IF endgo = 6 THEN sq2x = 50:sq2y = 152
'IF endgo = 7 THEN sq2x = 136:sq2y = 14
'IF endgo = 8 THEN sq2x = 49:sq2y = 133
#g.main "spritetravelxy sq3 " ;sq2x; " " ;sq2y; " " ;enspeed; " [en.go3]"
return
[en.go3]
endgo = int(rnd(1)*8) + 1

IF endgo = 1 THEN sq2x = 54:sq2y = 28
IF endgo = 2 THEN sq2x = 245:sq2y = 284
IF endgo = 3 THEN sq2x = 124:sq2y = 289
IF endgo = 4 THEN sq2x = 246:sq2y = 32

IF endgo = 5 THEN sq2x = 48:sq2y = 283
IF endgo = 6 THEN sq2x = 50:sq2y = 152
IF endgo = 7 THEN sq2x = 136:sq2y = 14
IF endgo = 8 THEN sq2x = 49:sq2y = 133
#g.main "spritetravelxy sq3 " ;sq2x; " " ;sq2y; " " ;enspeed; " [en.go3]"
wait


[en.go4.sub]
endgo = int(rnd(1)*8) + 1

IF endgo = 1 THEN sq2x = 54:sq2y = 28
IF endgo = 2 THEN sq2x = 245:sq2y = 284
IF endgo = 3 THEN sq2x = 124:sq2y = 289
IF endgo = 4 THEN sq2x = 246:sq2y = 32
IF endgo = 5 THEN sq2x = 48:sq2y = 283
IF endgo = 6 THEN sq2x = 50:sq2y = 152
IF endgo = 7 THEN sq2x = 136:sq2y = 14
IF endgo = 8 THEN sq2x = 49:sq2y = 133
#g.main "spritetravelxy sq4 " ;sq2x; " " ;sq2y; " " ;enspeed; " [en.go4]"
return
[en.go4]
endgo = int(rnd(1)*8) + 1

IF endgo = 1 THEN sq2x = 54:sq2y = 28
IF endgo = 2 THEN sq2x = 245:sq2y = 284
IF endgo = 3 THEN sq2x = 124:sq2y = 289
IF endgo = 4 THEN sq2x = 246:sq2y = 32

IF endgo = 5 THEN sq2x = 48:sq2y = 283
IF endgo = 6 THEN sq2x = 50:sq2y = 152
IF endgo = 7 THEN sq2x = 136:sq2y = 14
IF endgo = 8 THEN sq2x = 49:sq2y = 133
#g.main "spritetravelxy sq4 " ;sq2x; " " ;sq2y; " " ;enspeed; " [en.go4]"
wait


[change.skn]
filedialog "Open skin file", "*.skn", sknName$
IF trim$(sknName$) = "" THEN wait
IF right$(trim$(sknName$),4) = ".skn" = 0 THEN wait
skin$ = sknName$
bmpsat$ = skin$
gosub [extract.bmps]
timer 0
close #g
open "redbox.ini" for output AS #ss
print #ss, skin$
close #ss
open "load.dat" for append AS #67
print #67, skin$
close #67
goto [start]
end


[extract.bmps]
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
IF fileExists("",nextdisk$) = 0 THEN notice "Invalid Disk! Please insert next disk! Continue?";cont$
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


[is.activ]
IF fileExists("","reg.txt") = 0 then open "reg.txt" for output AS #1:print #1, "REGME":print #1, "REGME":close #1

IF fileExists("", "reg.txt") = 0 THEN l1$ = "diff":l2$ = "erant":goto [no.reg]:end
open "reg.txt" for input AS #2

line input #2, l1$
gregname$ = l1$
gosub [regsys]
l1$ = regnum$
line input #2, l2$
close #2
gosub [no.reg]
return
'end

[no.reg]
IF l1$ = l2$ = 0 THEN notice "Invalid Registration!"+chr$(13)+"This program is not licensed to run on this machine!" :regok = 0:return
regok = 1
return

[reg.me]
IF regok = 1 THEN return
'IF regok = 0 THEN YN$ = "no"
'IF regok = 0 AND YN$ = "no" THEN return

gregname$ = l1$
gosub [regsys]
regnum$ = ""
prompt "Please enter your name: ";regnum$
prompt "Please enter the Registration Key given to you: ";conID$
realname$ = regnum$
gregname$ = regnum$
gosub [regsys]
IF conID$ = regnum$ = 0 THEN notice "Invalid key given!":regok = 0:return
'notice regnum



 'run "regedit /e registration.txt ";_
        'chr$(34);"Hkey_Local_Machine\Software\Microsoft\Windows\CurrentVersion",hide
open "reg.txt" for output AS #344
print #344, realname$
print #344, conID$
close #344

open "tmp.log" for output AS #3
'print #3, "reg.txt"
print #3, "box.bmp"
print #3, "en1.bmp"
print #3, "en2.bmp"
print #3, "en3.bmp"
print #3, "man.bmp"
print #3, "mo.bmp"
close #3

open "tmp.log" for input AS #ghjkl
zof$ = "game.dat"
gosub [zipper]
close #ghjkl
kill "tmp.log"

notice "Thank You for Registering!"+chr$(13)+"Registration Successful!"
bmpsat$ = "game.dat"
gosub [extract.bmps]
gosub [is.activ]
return

[zipper]
filesfound = 1
open zof$ for output AS #3
doing = 3
'filedialog "Open a file", "*.*", file$
word = 1
line input #ghjkl, file$
[top3]
'test$ = right$(file$, (len(file$)-doing))
'gosub [isvailedname]
IF testok$="no"then doing=doing+1:goto[top3]:end
IF trim$(file$) = "" THEN close #3:end
print #3, "1"
print #3,""
[input]
open file$ for input as #4
'file$=test$
doit = lof(#4)
text$ = input$(#4,doit)
close #4

print #3, file$
print #3, doit
print #3, text$
close #3
filesfound = filesfound + 1
'confirm "Anymore files?";tmp$
word = word + 1 :IF eof(#ghjkl) <> 0 THEN tmp$ = "no"
IF tmp$ = "no" THEN open zof$ for append AS #3:print #3, "endall":close #3:tmp$ = "":return
open zof$ for append AS #3
file = file + 1
line input #ghjkl, file$
IF trim$(file$) = "" THEN close #3:end
[top.b]
'test$ = right$(file$, (len(file$)-doing))
'gosub [isvailedname]
IF testok$="no"then doing=doing+1:goto[top.b]:end
'file$ = "noracc";file;".txt"
goto [input]
end

[isvailedname]
testok$ = ""
'IF len(test$) > 1000 THEN notice "Please change your user name so that it is UNDER 1000 characters long!":return
open "i.tmp" for output as #testme
print #testme, test$
close #testme
open "i.tmp" for input as #testme
for i = 1 to 1000
IF eof(#testme) <> 0 then exit for
tmp$ = input$(#testme, 1)
IF tmp$ = "*" or tmp$ = ":" or tmp$ = "/" or tmp$ = "\" or tmp$ = "?" or tmp$ = ">" or tmp$ = "<" or tmp$ = "|" or tmp$ = chr$(34) then testok$ = "no":exit for': notice "Invailed user name! Please change some characters!":exit for
next i
close #testme
kill "i.tmp"
return



[regsys]
open "sys.sys" for output AS #greg
print #greg, gregname$
close #greg
open "sys.sys" for input AS #greg
regnum = 0
for gr = 1 to len(gregname$)
   tmpregn = asc(input$(#greg,1))
   tmpregn = tmpregn / 9426.41
   regnum = regnum + tmpregn
next gr
close #greg
regnum$ = right$(str$(regnum),len(str$(regnum)) - 2)
regnum = val(regnum$)
fregnum$ = ""

open "sys.sys" for output AS #greg
print #greg, regnum$
close #greg
open "sys.sys" for input AS #greg
for gr = 1 to len(regnum$)
   tmpregn$ = input$(#greg,1)
   IF tmpregn$ = "1" THEN fregnum$ = fregnum$ + "A"
   IF tmpregn$ = "2" THEN fregnum$ = fregnum$ + "B"
   IF tmpregn$ = "3" THEN fregnum$ = fregnum$ + "C"
   IF tmpregn$ = "4" THEN fregnum$ = fregnum$ + "1"
   IF tmpregn$ = "5" THEN fregnum$ = fregnum$ + "2"
   IF tmpregn$ = "6" THEN fregnum$ = fregnum$ + "3"
   IF tmpregn$ = "7" THEN fregnum$ = fregnum$ + "4"
   IF tmpregn$ = "8" THEN fregnum$ = fregnum$ + "D"
   IF tmpregn$ = "9" THEN fregnum$ = fregnum$ + "0"
   IF tmpregn$ = "." or tmpregn$ = "e" or tmpregn$ = "-" THEN fregnum$ = fregnum$ + "E"
next gr
regnum$ = fregnum$
close #greg
kill "sys.sys"
return


[mov]
IF lower$(Inkey$) = "p" AND pause = 1 THEN timer 1, [draw]:pause = 0:wait
IF lower$(Inkey$) = "p" AND pause = 0 THEN timer 0:pause = 1:print #g.main, "up":print #g.main, "goto 50 150":print #g.main, "down":print #g.main, "\Game paused, Press 'p' to resume":print #g.main, "flush":wait
wait

[wait.man]
wait

[load.win]


    nomainwin
    WindowWidth = 215
    WindowHeight = 120
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    groupbox #lw.groupbox4, "",   5,  -3, 190,  85
    statictext #lw.statictext1, loadwin$,  45,  32,  98,  20
    statictext #lw.statictext2, "..................................",  45,  52, 102,  20
    statictext #lw.statictext3, "..................................",  45,   7, 102,  20

    '-----End GUI objects code

    open "Please Wait" for window_nf as #lw
    print #lw, "font ms_sans_serif 10"
    print #lw, "trapclose [quit.lw]"


[lw.inputLoop]   'wait here for input event
    return


[quit.lw] 'End the program
wait

[create.ld]
kill "load.dat"
name "load.dat.tmp" as "load.dat"
return


[inst.skn]
filedialog "Open skin installation file", "*.apak", instskn$
print "File chosen is ";instskn$
IF trim$(instskn$) = "" THEN wait
loadwin$ = "Installing Skin..."
gosub [load.win]
bmpsat$ = instskn$
gosub [extract.bmps]
open "install.ini" for input AS #inst
line input #inst, namtxt$
close #inst
kill "install.ini"
open namtxt$ for output AS #skn
open "install.skn" for input AS #skn2
skn = lof(#skn2)
txt$ = input$(#skn2,skn)
print #skn, txt$
close #skn
close #skn2
kill "install.skn"
close #lw
notice "Skin installed!"
wait



'KEY$ = "Tyler"
'INFILE$ = "test.bit"
'OUTFILE$ = "ff.bit"
'MODE = 2
'gosub [encrypt]
'IF cryok = 1 THEN notice "Done!"
'end
[encrypt]   'Do it!
cryok = 0
   ' #main.key, "!contents? KEY$"
   ' #main.source, "!contents? INFILE$"
   ' #main.destination, "!contents? OUTFILE$"

    cursor hourglass
    RESULT = ENCRYPTION(MODE,INFILE$,OUTFILE$,KEY$)
    cursor normal
    if RESULT = 1 then cryok = 1
    if RESULT = 2 then notice "Mode not properly selected!"
    if RESULT = 3 then notice "Source file does not exist!"
    if RESULT = 4 then notice "Destination file already exists!"
    if RESULT = 5 then notice "No key specified!"
    return


function ENCRYPTION(MODE,INFILE$,OUTFILE$,KEY$)
    open "cryptor.dll" for dll as #en
    calldll #en, "_ENCRYPT",_
        MODE as short,_
        INFILE$ as ptr,_
        OUTFILE$ as ptr,_
        KEY$ as ptr,_
        RESULT as short
    close #en
    ENCRYPTION = RESULT
end function


[kill.pak]
open "files.dat" for input AS #1
for i = 1 to 10000
IF eof(#1) <> 0 THEN exit for
line input #1, killme$
if fileExists("",killme$) THEN kill killme$
next i
close #1
return
