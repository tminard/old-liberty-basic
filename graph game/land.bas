[top]
map$ = "17x17"
maproot = 17
randomtele=17*17'How many tiles
dim field$(2501,100)
dim enemy$(100,10)
'field$(x,0) = what happens
'field$(x,1) = is it hidden?
'field$(x,2) = null
'field$(x,3) = null

'enemy$(x,0) = on tile
'enemy$(x,1) = last tile
loadbmp "dirt1","dirt1.bmp"
loadbmp "grass1","grass.bmp"
loadbmp "grass2","tallgrss.bmp"
loadbmp "man1","man.bmp"
loadbmp "water","water.bmp"
loadbmp "mouse", "mouse.bmp"
loadbmp "selected","selected.bmp"
loadbmp "hide", "hide.bmp"
loadbmp "check", "check.bmp"
loadbmp "tiles1","tiles.bmp"
loadbmp "tile1","tiles.bmp"
loadbmp "rock1","rock1.bmp"
loadbmp "rock2","rock2.bmp"
loadbmp "house1", "house.bmp"
loadbmp "animal1", "animal1.bmp"
loadbmp "animal12", "animal1-2.bmp"
loadbmp "fireup", "fireup.bmp"
loadbmp "fireside", "fireside.bmp"
animal1sprites$ = "animal1 animal1 animal1 animal1 animal1 animal12 animal12 animal12 animal12"

loadbmp "enemy1", "enemy1.bmp"
loadbmp "enemy2", "enemy2.bmp"
enemysprites$ = "enemy1 enemy1 enemy1 enemy1 enemy1 enemy2 enemy2 enemy2 enemy2"

comspeed = fast 'slow = 365MHz, 94MB RAM 2.5MB vid mem, WinXP :-)
yes = 1
no = 0
automap = 1'randomly generate the map if set to 1! Cool!
autotime = 0
quickwalk = 1
quickspeed = 50
coins = 15
nodie = 1
IF comspeed = slow then hidetiles = no:enemy = 2:enemywait = 4'Slow machine running winXP
IF comspeed = fast then hidetiles = no:enemy = 3:enemywait = 8'Fast Machine or slow machine running Win9X


IF comspeed = slow then disablemouse = 1
IF comspeed = fast then disablemouse = 0
finishbmp$ = "house1"
'nomainwin

    WindowWidth = 550
    WindowHeight = 600

    graphicbox #main.graph, 26, 16, 504, 550
    menu #main, "Map Options","Save Map...",[savemap]
    open "Game" for window as #main
    print #main.graph, "fill white; flush"
    print #main, "trapclose [end]"
    print #main.graph, "when characterInput [key]"
    IF disablemouse = 0 then print #main.graph, "when leftButtonUp [leftm.cl]"
    IF disablemouse = 0 then print #main.graph, "when mouseMove [mouse.m]"
    print #main, "font ms_sans_serif 0 16"



goto [load.sprites]
wait


[nothing]
scan
going = 0
wait

[savemap]
open "map.txt" for output AS #sm
print #sm, startingPoint
print #sm, finishPoint
for sm = 0 to squares
  print #sm, field$(sm,2)
  print #sm, field$(sm,0)
next sm
close #sm
wait

[popup]
 'popupmenu "&Hide Land type", [cover]
wait

[coverland]
squares = mapx * mapy
squares = squares - 1

for i = 0 to squares
  print #main.graph, "addsprite hide";i;" hide"
  print #main.graph, "spritexy? dirt";i;" hidx hidy"
  print #main.graph, "spritexy hide";i;" ";hidx;" ";hidy
next i
return

[win]
notice "You found the finish!"
goto [restart]
end

[restart]
notice "Score: ";score
confirm "Try again?";QA$
IF QA$ = "no" then [end]
print #main.graph, "cls"
x = 0
y = 0
timer 0
ons = 0
is = 0
onsquareX = 0
onsquareY = 0
squares = 0
unloadbmp "house1"
unloadbmp "dirt1"
unloadbmp "grass1"
unloadbmp "man1"
unloadbmp "water"
unloadbmp "mouse"
unloadbmp "selected"
unloadbmp "hide"
unloadbmp "check"
unloadbmp "tiles1"
close #main
goto [top]
end

[showall]
for i = 0 to squares
 IF field$(i,1) = "hide" then print #main.graph, "removesprite hide";i
next i
print #main.graph, "drawsprites"
return

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
wait

[key]
IF Inkey$ = "i" then [fire.up]
IF Inkey$ = "l" then [fire.right]
IF Inkey$ = "j" then [fire.left]
IF Inkey$ = "k" then [fire.down]

IF Inkey$ = "w" then [up]
IF Inkey$ = "s" then [down]
IF Inkey$ = "d" then [right]
IF Inkey$ = "a" then [left]
IF Inkey$ = "1" then [savemap]
wait

[fire.up]
fireat = ons - 3
print #main.graph, "spritexy? man1 x y"
print #main.graph, "spritexy fireup ";x;" ";y
print #main.graph, "spritexy? dirt";fireat;" firex firey"
print #main.graph, "spritevisible fireup on"
#main.graph "spritetravelxy fireup " ;firex; " " ;firey; " 50 [nothing]"
wait

[fire.right]
fireat = ons + (maproot*3)
IF fireat > randomtele then wait
print #main.graph, "spritexy? man1 x y"
print #main.graph, "spritexy fireup ";x;" ";y
print #main.graph, "spritexy? dirt";fireat;" firex firey"
print #main.graph, "spritevisible fireup on"
#main.graph "spritetravelxy fireup " ;firex; " " ;firey; " 50 [nothing]"
wait

[fire.left]
fireat = ons - (maproot*3)
IF fireat < 0 then wait
print #main.graph, "spritexy? man1 x y"
print #main.graph, "spritexy fireup ";x;" ";y
print #main.graph, "spritexy? dirt";fireat;" firex firey"
print #main.graph, "spritevisible fireup on"
#main.graph "spritetravelxy fireup " ;firex; " " ;firey; " 50 [nothing]"
wait

[fire.down]
fireat = ons + 3
print #main.graph, "spritexy? man1 x y"
print #main.graph, "spritexy fireup ";x;" ";y
print #main.graph, "spritexy? dirt";fireat;" firex firey"
print #main.graph, "spritevisible fireup on"
#main.graph "spritetravelxy fireup " ;firex; " " ;firey; " 50 [nothing]"
wait

[mouse.m]
print #main.graph, "spritexy mouse ";MouseX;" ";MouseY
wait

[right]
IF ons + maproot > randomtele then wait
IF field$(ons + maproot,0) = "stop" then wait'[stay]
ons = ons + maproot' val(word$(list$,2,"dirt")
print #main.graph, "spritexy? dirt";ons; " x y"
there = 0
#main.graph "spritetravelxy man1 " ;x; " " ;y; " 6 [nothing]"
while there = 0
call Pause 10
print #main.graph, "spritexy? man1 checkx checky"
print #main.graph, "drawsprites"
if checkx = x and checky = y then there = 1
wend
gosub [same]
IF field$(ons,0) = "die" then [die]
IF field$(ons,0) = "win" then [win]
goto [same.wait]
'print #main.graph, "drawsprites"
wait



[stay]
print #main.graph, "spritexy? dirt";ons; " x y":print #main.graph, "spritexy man1 ";x;" ";y:wait
wait

[die]
print #main.graph, "drawsprites"
notice "You died!"
goto [restart]
end

[same]
print #main.graph, "spritecollides man1 tmpmanlist$"
IF instr(tmpmanlist$,"coin") then gosub [score1]
tmpmanlist$ = ""
gosub [uncover]
return

[score1]
print #main.graph, "removesprite coin"+str$(val(word$(tmpmanlist$,2,"coin")))
score = score + 1
return

[left]
IF ons - maproot < 0 then wait
IF field$(ons - maproot,0) = "stop" then wait'[stay]
ons = ons - maproot' val(word$(list$,2,"dirt")
print #main.graph, "spritexy? dirt";ons; " x y"
there = 0
#main.graph "spritetravelxy man1 " ;x; " " ;y; " 6 [nothing]"
while there = 0
call Pause 10
print #main.graph, "spritexy? man1 checkx checky"
print #main.graph, "drawsprites"
if checkx = x and checky = y then there = 1
wend
gosub [same]
IF field$(ons,0) = "die" then [die]
IF field$(ons,0) = "win" then [win]
goto [same.wait]
'print #main.graph, "drawsprites"
wait

[up]
IF ons - 1 < 0 then wait'[stay]
IF field$(ons - 1,0) = "stop" then wait'[stay]
ons = ons - 1
print #main.graph, "spritexy? dirt";ons; " x y"
'print #main.graph, "spritexy man1 ";x;" ";y
there = 0
#main.graph "spritetravelxy man1 " ;x; " " ;y; " 6 [nothing]"
while there = 0
call Pause 10
print #main.graph, "spritexy? man1 checkx checky"
print #main.graph, "drawsprites"
if checkx = x and checky = y then there = 1
wend
gosub [same]
IF field$(ons,0) = "die" then [die]
IF field$(ons,0) = "win" then [win]
goto [same.wait]
'print #main.graph, "drawsprites"
wait
[landed.man]
wait

[teleport]
randomok = 0
while randomok = 0
trytile = int(rnd(0)*randomtele)
IF field$(trytile,0) = "tele" then randomok = trytile
wend
ons = randomok
print #main.graph, "spritexy? dirt";ons; " x y"
'print #main.graph, "spritexy man1 ";x;" ";y
there = 0
#main.graph "spritetravelxy man1 " ;x; " " ;y; " 6 [nothing]"
while there = 0
call Pause 10
print #main.graph, "spritexy? man1 checkx checky"
print #main.graph, "drawsprites"
if checkx = x and checky = y then there = 1
wend
gosub [same]
wait

[down]
IF ons + 1 > randomtele then wait'[stay]
IF field$(ons + 1,0) = "stop" then wait'[stay]
ons = ons + 1
print #main.graph, "spritexy? dirt";ons; " x y"
'print #main.graph, "spritexy man1 ";x;" ";y
there = 0
#main.graph "spritetravelxy man1 " ;x; " " ;y; " 6 [nothing]"
while there = 0
call Pause 10
print #main.graph, "spritexy? man1 checkx checky"
print #main.graph, "drawsprites"
if checkx = x and checky = y then there = 1
wend
gosub [same]
IF field$(ons,0) = "die" then [die]
IF field$(ons,0) = "win" then [win]
goto [same.wait]
'print #main.graph, "drawsprites"
wait

[same.wait]
IF field$(ons,0) = "tele" then [teleport]
wait

[automap]
mapx = val(word$(map$,1,"x"))
mapy = val(word$(map$,2,"x"))
squares = mapx * mapy
while onsquareX / 30 = mapx = 0
for i = 1 to mapy
tmp = int(rnd(1)*8) + 1
 IF tmp = 1 then chosen$ = "grass1"'grass1,water,dirt1,tiles1,rock1
 IF tmp = 2 then chosen$ = "grass1"
 IF tmp = 3 then chosen$ = "grass1"
 IF tmp = 4 then chosen$ = "grass2"
 IF tmp = 5 then chosen$ = "rock1"
 IF tmp = 6 then chosen$ = "rock2"
 IF tmp = 7 then chosen$ = "water"
 IF tmp = 8 then chosen$ = "grass2"

 'IF tmp = 4 then field$(is,0) = "stop"
 IF tmp = 5 then field$(is,0) = "stop"'die,stop
 IF tmp = 6 then field$(is,0) = "stop"
 IF tmp = 7 then field$(is,0) = "die"
 IF tmp = 8 then field$(is,0) = "tele"
 field$(is,2) = chosen$
print #main.graph, "addsprite dirt";is;" "+chosen$
print #main.graph, "spritexy dirt";is;" ";onsquareX;" ";onsquareY
field$(is,1) = "hide"
'print #main.graph, "drawsprites"
onsquareY = onsquareY + 30
is = is + 1
next i
hidden = is - 1
onsquareX = onsquareX + 30
onsquareY = 0
wend
return

[script]'Scripts to be installed soon!!
script$ = word$(field$(ons,0),2)
gosub [exec.script]
wait
[exec.script]
return

[scanner]' Scan land tiles and fix connected objects!
return 'Not ready yet
for i = 1 to squares
  print field$(i,2)
next i
return
[loadmap]
is = 0
open "map.txt" for input AS #loadmap
mapx = val(word$(map$,1,"x"))
mapy = val(word$(map$,2,"x"))
line input #loadmap, ons$
line input #loadmap, fin$
finishPoint = val(fin$)
ons = val(ons$)
while onsquareX / 30 = mapx = 0
for i = 1 to mapy
 IF eof(#loadmap) <> 0 then exit for
  line input #loadmap, chosen$
  line input #loadmap, dowhat$
  print #main.graph, "addsprite dirt";is;" "+chosen$
  print #main.graph, "spritexy dirt";is;" ";onsquareX;" ";onsquareY
  'print #main.graph, "drawsprites"
  field$(is,1) = "hide"
  field$(is,0) = dowhat$
  field$(is,2) = chosen$
  'print #main.graph, "drawsprites"
onsquareY = onsquareY + 30
is = is + 1
next i
hidden = is - 1
onsquareX = onsquareX + 30
onsquareY = 0
wend
close #loadmap
return

[wait]
wait

[load.sprites]
IF automap = 1 then gosub [automap]
IF automap = 0 then gosub [loadmap]


 print #main.graph, "addsprite man1 man1"
IF automap = 1 then
 for i = 1 to 10000
   tmp = int(rnd(1)*squares) + 1
   IF field$(tmp,0) = "die" = 0 AND field$(tmp,0) = "win" = 0 and field$(tmp,0) = "stop" = 0 then exit for
 next i
 ons = tmp
 startingPoint = ons
end if


print #main.graph, "addsprite selected selected"
print #main.graph, "spritevisible selected off"
 print #main.graph, "spritexy? dirt";ons; " x y"
 print #main.graph, "spritexy man1 ";x;" ";y
print #main.graph, "spritexy selected ";x;" ";y
print #main.graph, "spritevisible selected on"

print #main.graph, "addsprite fireup fireup"
print #main.graph, "spritexy fireup ";x;" ";y
print #main.graph, "spritevisible fireup off"
print #main.graph, "addsprite fireside fireside"
print #main.graph, "spritexy fireside ";x;" ";y
print #main.graph, "spritevisible fireside off"

print #main.graph, "addsprite mouse mouse"
print #main.graph, "spritexy mouse ";MouseX;" ";MouseY
print #main.graph, "addsprite check check"
print #main.graph, "spritexy check ";x;" ";y
gosub [plant.enemy]
gosub [plant.coins]
'#main.graph, "spritetravelxy enemy1 ";x;" ";y;" 5 [wait]"
'#main.graph, "spritetravelxy enemy2 ";x;" ";y;" 8 [wait]"
IF automap = 1 then tmp = int(rnd(1)*squares) + 1
IF automap = 0 then tmp = finishPoint

IF hidetiles = yes then gosub [coverland]
field$(tmp,0) = "win"
finishPoint = tmp
print #main.graph, "spritexy? dirt";tmp;" tmpx tmpy"
print #main.graph, "removesprite dirt";tmp
IF hidetiles = yes then print #main.graph, "removesprite hide";tmp
print #main.graph, "addsprite dirt";tmp;" "+finishbmp$
print #main.graph, "spritexy dirt";tmp;" ";tmpx;" ";tmpy
IF hidetiles = yes then gosub [uncover]
field$(0,1) = "view"
print #main.graph, "drawsprites"
print #main.graph, "setfocus"
IF autotime = 1 then timespeed = squares
IF autotime = 1 and timespeed < 200 then timespeed = 200
IF autotime = 0 then timespeed = 100
timer timespeed, [draw]
wait
nomainwin

[plant.enemy]
for i = 1 to enemy
print #main.graph, "addsprite enemy";i;" "+enemysprites$
goto [plant.it]
end

[plant.it]
tmp = int(rnd(1)*squares) + 1
while field$(tmp,0) = "win" or field$(tmp,0) = "stop" or field$(tmp,0) = "die" or tmp = ons
tmp = int(rnd(1)*squares) + 1
wend
IF tmp < 1 or tmp > squares then goto [plant.it]

print #main.graph, "spritexy? dirt";tmp;" tmpx tmpy"
print #main.graph, "spritexy enemy";i;" ";tmpx;" ";tmpy
print #main.graph, "cyclesprite enemy";i;" 1"
tmp = -1
next i
return


[plant.coins]
for i = 1 to coins
print #main.graph, "addsprite coin";i;" "+animal1sprites$
goto [plant.itcoin]
end

[plant.itcoin]
tmp = int(rnd(1)*squares) + 1
while field$(tmp,0) = "win" or field$(tmp,0) = "stop" or field$(tmp,0) = "die" or field$(tmp,0) = "tele" or tmp = ons
tmp = int(rnd(1)*squares) + 1
wend
IF tmp < 1 or tmp > squares then goto [plant.itcoin]

print #main.graph, "spritexy? dirt";tmp;" tmpx tmpy"
print #main.graph, "spritexy coin";i;" ";tmpx;" ";tmpy
print #main.graph, "cyclesprite coin";i;" 1"
tmp = -1
next i
return


[draw]
if enemymoving=1 then wait
'move enemy
for men = 1 to enemy
  print #main.graph, "spritexy? enemy";men;" enex eney"
  print #main.graph, "spritecollides enemy";men;" tmplist$"
  thinkdir = int(rnd(1)*enemywait) + 1 'choose direction
  goto [choose.move]
  end

   [choose.move]
   gosub [ai]
   IF str$(thinkdir) = enemy$(men,1) then lastmove = val(enemy$(men,1)):gosub [new.move]

   enemy$(men,1) = str$(thinkdir)
' IF distance > 20 then goto [skip.men]
   IF thinkdir = 1 then gosub [ene.right]
   IF thinkdir = 2 then gosub [ene.left]
   IF thinkdir = 3 then gosub [ene.up]
   IF thinkdir = 4 then gosub [ene.down]
   IF thinkdir > 4 then gosub [ene.stay]
   '[skip.men]
next men
print #main.graph, "drawsprites"
wait


[new.move]
   'while thinkdir = lastmove
  '      thinkdir = int(rnd(1)*4) + 1
  ' wend
   IF thinkdir = 1 then gosub [ene.right]
   IF thinkdir = 2  then gosub [ene.left]
   IF thinkdir = 3  then gosub [ene.up]
   IF thinkdir = 4 then gosub [ene.down]

   return

[ai] 'Giv'em some smarts!
print #main.graph, "spritecollides man1 list$";
print #main.graph, "spritexy? "+list$+" x y"
ons = val(word$(list$,2,"dirt"))
gotoit = ons

 for tmpget = 1 to 10
  IF instr(word$(tmplist$,tmpget), "dirt") then ondirt$ = word$(tmplist$,tmpget):exit for
  next tmpget
ondirt = val(word$(ondirt$,2,"dirt"))
'distance = max(ondirt,ons) - min(ondirt,ons)
'IF distance > meny*2 then return
'print "Dist: "; distance
gosub [goto]

return

[goto]
goleft = ondirt - 12 'goleft
goright = ondirt + 12 'go right
godown = ondirt + 1 'go down
goup = ondirt - 1 'go up
IF Inkey$ = "F" then notice ons;" ; ";ondirt:Inkey$ = ""
tmpdo = int(rnd(1)*enemywait) + 1
iF tmpdo = 1 = 0 then thinkdir = 0:return


IF goleft > goright AND goleft > godown AND goleft > goup AND goleft <= gotoit then thinkdir =2:return
IF goright > goleft AND goright > godown AND goright > goup AND goright <= gotoit then thinkdir =1:return
IF godown > goright AND godown > goleft AND godown > goup AND godown <= gotoit then thinkdir =4:return
IF goup > goright AND goup > goleft AND goup > godown AND goup <= gotoit then thinkdir =3:return

goingleft = max(goleft,gotoit) - min(goleft,gotoit)
goingright = max(goright,gotoit) - min(goright,gotoit)
goingup =  max(goup,gotoit) - min(goup,gotoit)
goingdown = max(godown,gotoit) - min(godown,gotoit)

IF goingleft < goingright and goingleft < goingup AND goingleft < goingdown then thinkdir = 2:return
IF goingright < goingleft and goingright < goingup AND goingright < goingdown then thinkdir = 1:return
IF goingup < goingright and goingup < goingleft AND goingup < goingdown then thinkdir = 3:return
IF goingdown < goingright and goingdown < goingup AND goingdown < goingleft then thinkdir = 4:return
return

[next.area]
  print #main.graph, "spritexy? enemy";men;" enex eney"
  print #main.graph, "spritecollides enemy";men;" tmplist$"
  oldtmp = thinkdir
  while thinkdir = oldtmp
  thinkdir = int(rnd(1)*4) + 1 'choose direction
  wend
   IF oldtmp = 1 = 0 AND thinkdir = 1 then gosub [ene.right]
   IF oldtmp = 2 = 0 AND thinkdir = 2 then gosub [ene.left]
   IF oldtmp = 3 = 0 AND thinkdir = 3 then gosub [ene.up]
   IF oldtmp = 4 = 0 AND thinkdir = 4 then gosub [ene.down]
return

[ene.right]
IF instr(tmplist$,"man") and nodie = 0 then notice "You were caught!! Ahh!":goto [restart]
IF instr(tmplist$,"fire") then print #main.graph, "spritevisible enemy";men;" off"
 for tmpget = 1 to 10
  IF instr(word$(tmplist$,tmpget), "dirt") then ondirt$ = word$(tmplist$,tmpget):exit for
  next tmpget
ondirt = val(word$(ondirt$,2,"dirt"))
IF ondirt + mapx > (mapx * mapy) then return
tmper = ondirt + mapx
IF field$(tmper,0) = "stop" or field$(tmper,0) = "die"  then [next.area]
goto [move.enemyall]
end

[ene.stay]
tmper = ondirt
goto [move.enemyall]
end

[ene.left]
IF instr(tmplist$,"man") and nodie = 0 then notice "You were caught!! Ahh!":goto [restart]
IF instr(tmplist$,"fire") then print #main.graph, "spritevisible enemy";men;" off"
 for tmpget = 1 to 10
  IF instr(word$(tmplist$,tmpget), "dirt") then ondirt$ = word$(tmplist$,tmpget):exit for
  next tmpget
ondirt = val(word$(ondirt$,2,"dirt"))
IF ondirt - mapx < 0 then return
tmper = ondirt - mapx
IF field$(tmper,0) = "stop" or field$(tmper,0) = "die"  then [next.area]
goto [move.enemyall]
end

[move.enemyall]
print #main.graph, "spritexy? dirt";tmper;" tmperx tmpery"
print #main.graph, "spritexy enemy";men;" ";tmperx;" ";tmpery
return

print #main.graph, "spritetravelxy enemy";men;" ";tmperx;" ";tmpery;" 5 [landed]"
landedtmp=0
while landedtmp = 0
print #main.graph, "drawsprites"
wend
enemymoving=0
return
[landed]
landedtmp=1
wait

[ene.up]
IF instr(tmplist$,"man") and nodie = 0 then notice "You were caught!! Ahh!":goto [restart]
IF instr(tmplist$,"fire") then print #main.graph, "spritevisible enemy";men;" off"
 for tmpget = 1 to 10
  IF instr(word$(tmplist$,tmpget), "dirt") then ondirt$ = word$(tmplist$,tmpget):exit for
  next tmpget
ondirt = val(word$(ondirt$,2,"dirt"))
IF ondirt - 1 < 0 then return
tmper = ondirt - 1
IF field$(tmper,0) = "stop" or field$(tmper,0) = "die"  then [next.area]
goto [move.enemyall]
end


[ene.down]
IF instr(tmplist$,"man") and nodie = 0 then notice "You were caught!! Ahh!":goto [restart]
IF instr(tmplist$,"fire") then print #main.graph, "spritevisible enemy";men;" off"
 for tmpget = 1 to 10
  IF instr(word$(tmplist$,tmpget), "dirt") then ondirt$ = word$(tmplist$,tmpget):exit for
  next tmpget
ondirt = val(word$(ondirt$,2,"dirt"))
IF ondirt + 1 > squares then return
tmper = ondirt + 1
IF field$(tmper,0) = "stop" or field$(tmper,0) = "die"  then [next.area]
goto [move.enemyall]
end

[uncover]
'gosub [coverland]
'print #main.graph, "removesprite hide";ons
print #main.graph, "spritexy? man1 x y"
print #main.graph, "spritexy check ";x;" ";y
for docheck = 1 to 5
 IF docheck = 1 then gosub [set.north]
 IF docheck = 2 then gosub [set.south]
 IF docheck = 3 then gosub [set.east]
  IF docheck = 4 then gosub [set.west]
  IF docheck = 5 then gosub [set.center]
 print #main.graph, "spritexy check ";tmpx;" ";tmpy
 print #main.graph, "spritecollides check dlist$";
 for i = 1 to 1000
   IF word$(dlist$,i) = "" then exit for
   IF instr(word$(dlist$,i),"hide") then print #main.graph, "removesprite "+word$(dlist$,i):hidden = hidden - 1:field$(val(word$(word$(dlist$,i),2,"hide")),1) = "view"
 next i
next docheck
return

[set.center]
tmpx = x
tmpy = y
return

[set.north]
tmpx = x +0
tmpy = y - 30
return

[set.south]
tmpx = x +0
tmpy = y + 30
return

[set.east]
tmpx = x + 30
tmpy = y
return

[set.west]
tmpx = x - 30
tmpy = y
return



sub Pause mil
    t=time$("milliseconds")
    while time$("milliseconds")<t+mil
    wend
    end sub
