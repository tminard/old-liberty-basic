nomainwin
debug = 1
on error goto [see.err]
loadbmp "walk1","images\1.bmp"
loadbmp "walk2","images\2.bmp"
loadbmp "walk3","images\3.bmp"
loadbmp "walk4","images\4.bmp"
loadbmp "walk5","images\5.bmp"
loadbmp "walk6","images\6.bmp"
loadbmp "walk7","images\7.bmp"
loadbmp "walk8","images\8.bmp"
loadbmp "re1", "images\re1.bmp"
loadbmp "re2", "images\re2.bmp"
loadbmp "re3", "images\re3.bmp"
loadbmp "re4", "images\re4.bmp"
loadbmp "re5", "images\re5.bmp"
loadbmp "fall1", "images\fall1.bmp"
loadbmp "fall2", "images\fall2.bmp"
loadbmp "backdrop","images\b2.bmp"
loadbmp "idle", "images\sonic_idle.bmp"
loadbmp "J1", "images\J1.bmp"
loadbmp "J2", "images\J2.bmp"
loadbmp "J3", "images\J3.bmp"
loadbmp "J4", "images\J4.bmp"
loadbmp "grass1", "images\g4.bmp"
IF debug = 0 THEN loadbmp "stopG4","images\stopG4.bmp"
IF debug = 1 THEN loadbmp "stopG4","images\stopG4RED.bmp"
loadbmp "sr1","images\d1.bmp"
loadbmp "sr2","images\d2.bmp"
loadbmp "tree1","images\tr.bmp"
loadbmp "clearwall","images\blocker.bmp"
'loadbmp "health","images\health.bmp"
dim objects$(100, 100)
health = 100
objects = 11
jumprange = 19
cheats = 0
WindowWidth = 300
WindowHeight = 300
UpperLeftX=int((DisplayWidth-WindowWidth)/2)
UpperLeftY=int((DisplayHeight-WindowHeight)/2)
graphicbox #game.win,   5,  22, 280, 240
statictext #game.statictext1, "Health: ";health,   5,   5, 200,  15
open "TEST" for graphics_nsb AS #game
print #game.win, "trapclose [exit]"
print #game.win, "when characterInput [keys]"
IF debug = 1 THEN print #game.win, "when leftButtonUp  [mouse.click]"
print #game.win, "addsprite tree1 tree1"
print #game.win, "spritexy tree1 130 90"
'print #game.win, "addsprite health health"
'print #game.win, "spritexy health 0 0"
'print #game.win, "spritevisible health off";
print #game.win, "addsprite manwalk walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8"
print #game.win, "spritevisible manwalk off";
print #game.win, "addsprite manroll J1 J2 J3 J4"
print #game.win, "spritevisible manroll off";
print #game.win, "addsprite setroll sr1 sr2"
print #game.win, "spritevisible setroll off";
print #game.win, "addsprite ground1 grass1"
print #game.win, "spritexy ground1  100 200"
print #game.win, "addsprite ground2 grass1"
print #game.win, "spritexy ground2  0 350"
print #game.win, "addsprite wk2 clearwall"
print #game.win, "spritexy wk2 -3 310"
print #game.win, "addsprite wk1 clearwall"
print #game.win, "spritexy wk1 -500 255"
print #game.win, "addsprite ground3 grass1"
print #game.win, "spritexy ground3  -500 300"
print #game.win, "addsprite ground4 grass1"
print #game.win, "spritexy ground4  50 700"
print #game.win, "addsprite ground5 grass1"
print #game.win, "spritexy ground5  -500 50"
print #game.win, "addsprite ground6 grass1"
print #game.win, "spritexy ground6  -1000 250"
print #game.win, "addsprite stop2 stopG4"
print #game.win, "spritexy stop2  -500 100"

print #game.win, "addsprite manjump J1 J2 J3 J4"
print #game.win, "spritevisible manjump off";
print #game.win, "addsprite manwait idle"
print #game.win, "addsprite manfall fall1 fall2"
print #game.win, "spritevisible manfall off";
print #game.win, "spritexy manwait 120 100" '100x160
print #game.win, "background backdrop"
print #game.win, "addsprite stop1 stopG4"
print #game.win, "spritexy stop1  100 237"
print #game.win, "drawsprites"
print #game.win, "spritexy? wk2  sx$ sy$"
sy2 = val(sy$)
sx2 = val(sx$)
objects$(6,0) = "wk2"
objects$(6,1) = str$(sx2)
objects$(6,2) = str$(sy2)

print #game.win, "spritexy? wk1  sx$ sy$"
sy2 = val(sy$)
sx2 = val(sx$)
objects$(11,0) = "wk1"
objects$(11,1) = str$(sx2)
objects$(11,2) = str$(sy2)

print #game.win, "spritexy? manwait x$ y$"
x = val(x$)
y = val(y$)
print #game.win, "spritexy? ground1  sx$ sy$"
sy = val(sy$)
sx = val(sx$)
print #game.win, "spritexy? ground2  sx$ sy$"
sy2 = val(sy$)
sx2 = val(sx$)
objects$(2,0) = "ground2"
objects$(2,1) = str$(sx2)
objects$(2,2) = str$(sy2)
objects$(1,0) = "ground1"
objects$(1,1) = str$(sx)
objects$(1,2) = str$(sy)
print #game.win, "spritexy? stop1  sx3$ sy3$"
sy3 = val(sy3$)
sx3 = val(sx3$)
objects$(3,0) = "stop1"
objects$(3,1) = str$(sx3)
objects$(3,2) = str$(sy3)

print #game.win, "spritexy? stop2  sx3$ sy3$"
sy3 = val(sy3$)
sx3 = val(sx3$)
objects$(9,0) = "stop2"
objects$(9,1) = str$(sx3)
objects$(9,2) = str$(sy3)

print #game.win, "spritexy? ground3  sx$ sy$"
objects$(5,0) = "ground3"
objects$(5,1) = sx$
objects$(5,2) = sy$

print #game.win, "spritexy? ground4  sx$ sy$"
objects$(7,0) = "ground4"
objects$(7,1) = sx$
objects$(7,2) = sy$

print #game.win, "spritexy? ground5 sx$ sy$"
objects$(8,0) = "ground5"
objects$(8,1) = sx$
objects$(8,2) = sy$

print #game.win, "spritexy? ground6 sx$ sy$"
objects$(10,0) = "ground6"
objects$(10,1) = sx$
objects$(10,2) = sy$

print #game.win, "spritexy? tree1  sx3$ sy3$"
sy3 = val(sy3$)
sx3 = val(sx3$)
objects$(4,0) = "tree1"
objects$(4,1) = str$(sx3)
objects$(4,2) = str$(sy3)
print #game.win, "spritecollides manwait list$";
IF instr(list$,"ground") = 0 THEN goto [fall]
wait

[exit]
CLOSE #game
end

[see.err]
'notice Err
IF Err= 0 = 0 THEN notice Err$
close #game
end

[mouse.click]
notice "X = ";MouseX;" Y = ";MouseY
wait

[keys]
keys$ = keys$ +Inkey$'Collect a record of all keys pressed
IF len(keys$) = 10 THEN keys$ = right$(keys$,3)'Reset record after it is x characters long
'notice Inkey$
IF jumping = 1 AND Inkey$ = "d" AND d$ = "" THEN [jumpD]
IF jumping = 1 AND Inkey$ = "a" AND a$ = "" THEN [jumpA]
IF jumping = 1 THEN wait
IF inkey = 1 then Inkey$ = "": wait
IF rolling = 1 AND Inkey$ = "s" THEN [stop.roll]
IF rolling = 1 AND Inkey$ = "d" AND d$ = "" THEN [roll.d]
IF rolling = 1 AND Inkey$ = "a" AND a$ = "" THEN [roll.a]
IF Inkey$ = "s" THEN [set.roll]
IF Inkey$ = "d" AND d$ = "" THEN [walkD]
IF Inkey$ = "a" AND a$ = "" THEN [walkA]
IF cheats = 1 AND Inkey$ = "f" THEN [fly]
IF cheats = 1 AND Inkey$ = " " AND rolling = 0 THEN jumprange = 50:goto [jump]
IF Inkey$ = " " AND rolling = 0 THEN [jump]
wait

[fly]
IF fly = 1 THEN fly = 0:print #game.win, "\Fly OFF":wait
fly = 1
print #game.win, "\Fly ON"
wait

[set.roll]
IF jumping = 1 THEN wait
print #game.win, "spritevisible manwait off";
print #game.win, "spritevisible manwalk off";
'print #game.win, "spritexy setroll ";x;" ";y
'print #game.win, "spritevisible setroll on";
'print #game.win, "cyclesprite setroll 1"
'tt = 0
'timer 100, [draw.setroll]
'wait

'[draw.setroll]
'tt = tt + 1
'print #game.win, "backgroundxy ";bx;" ";by
'print #game.win, "drawsprites"
'IF tt = 2 THEN timer 0 :goto [setroll.con]
'wait

'[setroll.con]
'print #game.win, "spritevisible setroll off";
print #game.win, "spritexy manroll ";x;" ";y
print #game.win, "spritevisible manroll on";
IF facing$ = "" or facing$ = "d" THEN print #game.win, "spriteorient manroll normal";
IF facing$ = "a" THEN print #game.win, "spriteorient manroll mirror";
print #game.win, "backgroundxy ";bx;" ";by
print #game.win, "drawsprites"
rolling = 1
wait

[stop.roll]
timer 0
rolling = 0
print #game.win, "spritevisible manroll off";
print #game.win, "spritexy? manroll x$ y$"
x = val(x$)
y = val(y$)
print #game.win, "spritexy manwait ";x;" ";y
print #game.win, "spritevisible manwait on";
print #game.win, "backgroundxy ";bx;" ";by
print #game.win, "drawsprites"
wait

[roll.d]
facing$ = "d"
print #game.win, "spriteorient manroll normal";
print #game.win, "cyclesprite manroll 1"
timer 50, [draw.roll]
wait

[roll.a]
facing$ = "a"
print #game.win, "spriteorient manroll mirror";
print #game.win, "cyclesprite manroll 1"
timer 50, [draw.rolla]
wait

[draw.rolla]
for pp = 1 to objects
object$ = objects$(pp,0)
sx = val(objects$(pp,1))
sy = val(objects$(pp,2))
sx = sx +10
print #game.win, "spritexy "+object$+" ";sx;" ";sy
objects$(pp,1) = str$(sx)
objects$(pp,2) = str$(sy)
next pp
print #game.win, "spritecollides manfall list$";
bx=bx - 10
print #game.win, "backgroundxy ";bx;" ";by
IF instr(list$,"wk") = 0 THEN a$ = "":d$ = ""
IF instr(list$,"ground") = 0 THEN timer 0:rolling = 0:print #game.win, "spritevisible manroll off":goto [fall]
'IF instr(list$,"wk") THEN timer 0:d$ = "":a$ = "":IF instr(list$,"wk") AND walk$ = "d" THEN d$ = "n":IF instr(list$,"wk") AND walk$ = "a" THEN a$ = "n":wait
IF instr(list$,"wk") AND facing$ = "d" OR facing$ = "" THEN goto [roll.a]
IF instr(list$,"wk") AND facing$ = "a" THEN goto [roll.d]
print #game.win, "drawsprites"
wait

[draw.roll]
for pp = 1 to objects
object$ = objects$(pp,0)
sx = val(objects$(pp,1))
sy = val(objects$(pp,2))
sx = sx -10
print #game.win, "spritexy "+object$+" ";sx;" ";sy
objects$(pp,1) = str$(sx)
objects$(pp,2) = str$(sy)
next pp
print #game.win, "spritecollides manfall list$";
bx=bx + 10
print #game.win, "backgroundxy ";bx;" ";by
IF instr(list$,"stop") = 0 THEN a$ = "":d$ = ""
IF instr(list$,"ground") = 0 THEN timer 0:rolling = 0:print #game.win, "spritevisible manroll off":goto [fall]
IF instr(list$,"stop") THEN timer 0:d$ = "":a$ = "":IF instr(list$,"wk") AND walk$ = "d" THEN d$ = "n":IF instr(list$,"wk") AND walk$ = "a" THEN a$ = "n":wait
print #game.win, "drawsprites"
wait

[jumpD]
facing$ = "d"
walk$ = "d"
print #game.win, "spriteorient manjump normal";
bx=bx + 4
print #game.win, "backgroundxy ";bx;" ";by
jumpmov$ = "d"
'sx = sx - 5
'print #game.win, "spritexy grassground ";sx;" ";sy
for pp = 1 to objects
object$ = objects$(pp,0)
sx = val(objects$(pp,1))
sy = val(objects$(pp,2))
sx = sx -4
print #game.win, "spritexy "+object$+" ";sx;" ";sy
objects$(pp,1) = str$(sx)
objects$(pp,2) = str$(sy)
next pp
IF dosub = 1 THEN dosub = 0:return
wait

[jumpA]
facing$ = "a"
walk$ = "a"
print #game.win, "spriteorient manjump mirror";
bx=bx - 4
print #game.win, "backgroundxy ";bx;" ";by
jumpmov$ = "a"
'sx = sx + 5
'print #game.win, "spritexy grassground ";sx;" ";sy
for pp = 1 to objects
object$ = objects$(pp,0)
sx = val(objects$(pp,1))
sy = val(objects$(pp,2))
sx = sx + 4
print #game.win, "spritexy "+object$+" ";sx;" ";sy
objects$(pp,1) = str$(sx)
objects$(pp,2) = str$(sy)
next pp

IF dosub = 1 THEN dosub =0:return
wait

[jump]
IF jumping = 1 then wait
startj = 0
jumping = 1
inkey = 1
IF walking = 0 THEN print #game.win, "spritexy? manwait x$ y$"
IF walking = 1 THEN print #game.win, "spritexy? manwalk x$ y$"
x = val(x$)
y = val(y$)
startjump$ = x$+"x"+y$
print #game.win, "spritevisible manwait off";
print #game.win, "spritevisible manwalk off";
print #game.win, "spritevisible manjump on";
IF facing$ = "a" THEN print #game.win, "spriteorient manjump mirror";
IF facing$ = "d" THEN print #game.win, "spriteorient manjump normal";
'print #game.win, "spritexy? grassground  sx$ sy$"
'sy = val(sy$)
'sx = val(sx$)
tmpsee$ = right$(keys$,2)
IF left$(tmpsee$,1) = "d" THEN dosub = 1:gosub [jumpD]
IF left$(tmpsee$,1) = "a" THEN dosub = 1:gosub [jumpA]
print #game.win, "cyclesprite manjump 1"
for i = 1 to jumprange
IF i = 6 THEN startj = 1
IF i = jumprange - 1 THEN timer 0:exit for
tmpsee$ = right$(keys$,2)
IF left$(tmpsee$,1) = "d" THEN dosub = 1:gosub [jumpD]
IF left$(tmpsee$,1) = "a" THEN dosub = 1:gosub [jumpA]
'gosub [reset.objects]
'y =y - 2
'sy =sy + 5:print #game.win, "spritexy grassground ";sx;" ";sy
'print #game.win, "spritecollides manjump list$";
'IF trim$(list$) = "" = 0 AND goingdown = 0 AND startj = 1 THEN timer 0:goto [going.down]
for pp = 1 to objects
object$ = objects$(pp,0)
sx = val(objects$(pp,1))
sy = val(objects$(pp,2))
sy = sy + 5
print #game.win, "spritexy "+object$+" ";sx;" ";sy
objects$(pp,1) = str$(sx)
objects$(pp,2) = str$(sy)
next pp
by=by - 5:print #game.win, "backgroundxy ";bx;" ";by
print #game.win, "spritexy manjump ";x;" ";y
timer 50, [dsjump]
wait
[dsjump]
print #game.win, "spritecollides manjump list$";
'IF instr(list$,"ground") AND instr(list$,"stop") = 0 THEN exit for
IF instr(list$, "stop") AND goingdown = 0 AND startj = 1 THEN timer 0:exit for
'by = by + 5
print #game.win, "drawsprites"
next i
IF fly = 1 THEN goto [skip.go]
goto [going.down]
end

[going.down]
for i = 1 to 10000
IF i = 60 then dofall = 1:exit for
tmpsee$ = right$(keys$,2)
IF left$(tmpsee$,1) = "d" THEN dosub = 1:gosub [jumpD]
IF left$(tmpsee$,1) = "a" THEN dosub = 1:gosub [jumpA]
print #game.win, "spritecollides manjump list$";
IF instr(list$,"stop") = 0 AND instr(list$,"ground") THEN exit for
'IF instr(list$,"ground") AND goingdown = 0 THEN by = by + 5
goingdown = 1
'gosub [reset.objects]
'y =y + 2
'sy =sy - 5:print #game.win, "spritexy grassground ";sx;" ";sy
for pp = 1 to objects
object$ = objects$(pp,0)
sx = val(objects$(pp,1))
sy = val(objects$(pp,2))
sy = sy - 5
print #game.win, "spritexy "+object$+" ";sx;" ";sy
print #game.win, "spritecollides manjump list$";
'IF instr(list$,"stop") = 0 AND instr(list$,"ground") THEN exit for
objects$(pp,1) = str$(sx)
objects$(pp,2) = str$(sy)
next pp
print #game.win, "spritecollides manjump list$";
IF instr(list$,"stop") = 0 AND instr(list$,"ground") THEN exit for

by=by + 5:print #game.win, "backgroundxy ";bx;" ";by
print #game.win, "spritexy manjump ";x;" ";y
'IF  str$(x)+"x"+str$(y) = startjump$ THEN timer 0:exit for
timer 50, [dsjump2]
wait
[dsjump2]
print #game.win, "spritecollides manjump list$";
IF instr(list$,"stop") = 0 AND instr(list$,"ground") THEN exit for
print #game.win, "drawsprites"
next i
goto [skip.go]
end

[skip.go]
goingdown = 0
timer 0
inkey = 0
jumping = 0
d$ = ""
a$ = ""
IF instr(list$,"wk") AND walk$ = "d" THEN d$ = "n"
IF instr(list$,"wk") AND walk$ = "a" THEN a$ = "n"
print #game.win, "spritevisible manjump off";
IF dofall = 1 THEN dofall = 0:goto [fall]
print #game.win, "spritevisible manwait on";
print #game.win, "spritexy manwait ";x;" ";y
IF facing$ = "a" THEN print #game.win, "spriteorient manwait mirror";
IF facing$ = "d" THEN print #game.win, "spriteorient manwait normal";
by = by + 5
print #game.win, "backgroundxy ";bx;" ";by
'print #game.win, "spritexy grassground ";sx;" ";sy
print #game.win, "drawsprites"
print #game.win, "spritecollides manwait list$";
IF instr(list$,"ground") = 0 THEN goto [fall]
wait

[walkD]
facing$ = "d"
walk$ = "d"
goto [walk]
end

[walkA]
facing$ = "a"
walk$ = "a"
goto [walk]
end

[reset.objects]
'print "Reset hit!"
'notice "Debug: Reset hit!"
return

[walk]
walking = 1
Inkey$ = ""
inkey = 1
print #game.win, "spritexy? manwait x$ y$"
x = val(x$)
y = val(y$)
'IF walk$ = " " THEN y =y - 5:by=by + 5:print #game.win, "backgroundxy ";bx;" ";by
IF walk$ = "d" THEN x = x + 0:bx=bx + 5:by=by:print #game.win, "backgroundxy ";bx;" ";by
IF walk$ = "a" THEN x = x - 0:bx=bx - 5:by=by:print #game.win, "backgroundxy ";bx;" ";by

for pp = 1 to objects
object$ = objects$(pp,0)
sx = val(objects$(pp,1))
sy = val(objects$(pp,2))
IF walk$ = "a" THEN sx = sx + 5
IF walk$ = "d" THEN sx = sx - 5
print #game.win, "spritexy "+object$+" ";sx;" ";sy
objects$(pp,1) = str$(sx)
objects$(pp,2) = str$(sy)
next pp
'print #game.win, "spritexy grassground ";sx;" ";sy
'gosub [reset.objects]
'x$ = str$(x)
'y$ = str$(y)
print #game.win, "spritexy manwalk "+x$+" "+y$
print #game.win, "spritevisible manwait off";
print #game.win, "spritevisible manwalk on";
IF walk$ = "a" THEN print #game.win, "spriteorient manwalk mirror";
IF walk$ = "d" THEN print #game.win, "spriteorient manwalk normal";
print #game.win, "cyclesprite manwalk 1 once"
for i = 1 to 8
timer 50, [drawsprites]
wait
[drawsprites]
'IF walk$ = " " THEN y =y - 5:by=by + 5:print #game.win, "backgroundxy ";bx;" ";by
IF walk$ = "d" THEN x = x + 0:bx=bx + 5:by=by:print #game.win, "backgroundxy ";bx;" ";by
IF walk$ = "a" THEN x = x - 0:bx=bx - 5:by=by:print #game.win, "backgroundxy ";bx;" ";by
'print #game.win, "spritexy? grassground  sx$ sy$"
'sy = val(sy$)
'sx = val(sx$)
'print #game.win, "spritexy grassground ";sx;" ";sy
'x$ = str$(x)
'y$ = str$(y)
for pp = 1 to objects
object$ = objects$(pp,0)
sx = val(objects$(pp,1))
sy = val(objects$(pp,2))
IF walk$ = "a" THEN sx = sx + 5
IF walk$ ="d" THEN sx = sx - 5
print #game.win, "spritexy "+object$+" ";sx;" ";sy
objects$(pp,1) = str$(sx)
objects$(pp,2) = str$(sy)
next pp

print #game.win, "spritexy manwalk "+x$+" "+y$
print #game.win, "spritecollides manwalk list$";
'gosub [reset.objects]
print #game.win, "drawsprites"
IF instr(list$,"wk") THEN exit for
IF instr(list$,"ground") = 0 THEN exit for
next i
d$ = ""
a$ = ""
IF instr(list$,"wk") AND walk$ = "d" THEN d$ = "n"
IF instr(list$,"wk") AND walk$ = "a" THEN a$ = "n"
IF instr(list$,"ground") = 0 THEN timer 0:goto [fall]
timer 0
print #game.win, "spritevisible manwalk off";
print #game.win, "spritevisible manwait on";
IF walk$ = "a" THEN print #game.win, "spriteorient manwait mirror";
IF walk$ = "d" THEN print #game.win, "spriteorient manwait normal";
print #game.win, "spritexy manwait "+x$+" "+y$
print #game.win, "backgroundxy ";bx;" ";by
'print #game.win, "spritexy grassground ";sx;" ";sy
print #game.win, "spritecollides manwait list$";
IF instr(list$,"ground") = 0 THEN goto [fall]
print #game.win, "drawsprites"
inkey = 0
walking = 0
walk$ = ""
wait

[fall]
falling = 1
inkey = 1
print #game.win, "spritevisible manwait off";
print #game.win, "spritevisible manwalk off";
print #game.win, "spritevisible manfall on";
print #game.win, "spritexy manfall ";x;" ";y
for i = 1 to 100000
by = by + 5

for pp = 1 to objects
object$ = objects$(pp,0)
sx = val(objects$(pp,1))
sy = val(objects$(pp,2))
sy = sy - 5
print #game.win, "spritexy "+object$+" ";sx;" ";sy
objects$(pp,1) = str$(sx)
objects$(pp,2) = str$(sy)
next pp

IF i > 100 AND i < 200 THEN health = health - 5
'IF i > 20 AND i < 30 THEN health = health - 10
'IF i > 30 AND i < 40 THEN health = health - 20
'IF i > 40 AND i < 70 THEN health = health - 50
'IF i > 70 AND i < 80 THEN health = health - 70
'IF i > 80 THEN health = health - 100
print #game.statictext1, "Health: ";health

IF health < 1 THEN timer 0:die = 1:exit for
print #game.win, "backgroundxy ";bx;" ";by
print #game.win, "cyclesprite manfall 1"
timer 50, [dsfall]
wait
[dsfall]
'gosub [reset.objects]
print #game.win, "spritecollides manfall list$";
IF instr(list$,"ground") THEN exit for
print #game.win, "drawsprites"
next i
timer 0
IF die = 1 then [die]
IF i > 10 AND i < 20 THEN health = health - 5
IF i > 20 AND i < 30 THEN health = health - 10
IF i > 30 AND i < 40 THEN health = health - 20
IF i > 40 AND i < 70 THEN health = health - 50
IF i > 70 AND i < 80 THEN health = health - 70
IF i > 80 THEN health = health - 100
print #game.statictext1, "Health: ";health
'IF i > 10 THEN print #game.win, "spritevisible health on";:print #game.win, "drawsprites":print #game.win, "spritevisible health off";
IF health < 1 THEN [die]
print #game.win, "spritevisible manfall off";
print #game.win, "spritevisible manwait on";
print #game.win, "spritexy manwait ";x;" ";y
print #game.win, "backgroundxy ";bx;" ";by
print #game.win, "spritecollides manwait list$";
IF instr(list$,"ground") = 0 THEN goto [fall]
falling = 0
print #game.win, "drawsprites"
inkey = 0
falling = 0
wait

[die]
notice "You died!"
goto [exit]
end

[show.health]
print #game.win, "spritevisible health on";
print #game.win, "drawsprites"
timer 500, [end.health]
wait

[end.health]
timer 0
print #game.win, "spritevisible health off";
print #game.win, "drawsprites"
return

