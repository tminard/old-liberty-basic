gosub [get.games]
dim orders(100,2)'orders(1,0) = enemyName; ord(1,1) = X; ord(1,2) = Y
'bmpsat$ = "original.game"

gosub [get.os] 'for fut. use

print "Running OS: "+OS$
print "Loading, Please Wait..."
LDTEXT$ = "Loading Game, Please Wait!"
gosub [loading.Screen]

KEY$ = "ycpwf"
INFILE$ = bmpsat$
IF fileExists("",bmpsat$+".tmp") THEN kill bmpsat$+".tmp"
OUTFILE$ = bmpsat$+".tmp"
MODE = 1
gosub [encrypt]
IF cryok = 0 THEN end
bmpsat$ = bmpsat$ + ".tmp"
ONGAME$ = bmpsat$
gosub [extract.bmps]
close #ld

[reset]
enemy = 0
mon = 100 'for fut. use
hel = 100 'for fut. use
foo = 100 'for fut. use
debug = 1 'Enable one step at a time

'----------------------------Welome to the new world of my game!-----------------
[progstart]
 'on error goto [error] 'every time there is an error go to [error]!! Cool!
en = 100

nomainwin 'you know the deal!

Open "maps.txt" For input AS #1              'find out how many maps there are
input #1, many$
many = val(many$)
[top]
IF word$(map$,1) = "auto" THEN map = val(word$(map$,2)):map$ = word$(map$,2):goto [keeplook]
'prompt "Map number:(1-"+many$+")";map     'ask for map number
map = 1
map$ = str$(map)
IF map <= 0 or map > many THEN notice "Map not found!":goto [top]:end
goto [keeplook]                'ask again!
end

[keeplook]
input #1, input$
IF input$ = map$ = 0 THEN [keeplook]
input #1, back$
input #1, data$
data$ = "data.txt"
close #1
goto [start]
end




'-----------------------------------------The Game! Now we're ready!!!-----------------------
[start]
'330 310
 WindowWidth = 310
  WindowHeight = 370
  UpperLeftX = DisplayHeight / 2
   UpperLeftY = 200

    print "Screen res is ";DisplayWidth;",";DisplayHeight
   ' notice "Screen height is ";DisplayHeight

bmpsat$ = "map"+map$+".map"
gosub [extract.bmps]

bmpsat$ = "objects.obj"
gosub [extract.bmps]
loadbmp "loading", "main.bmp"
open back$ for graphics_nsb_nf AS #1 'open window
print #1, "|"
print #1, "|"
print #1, "|"
print #1, "|"
print #1, "|                      Loading!....."
'
h = 0
'--------bmp------------
loadbmp "en", "en.bmp"
loadbmp "wall", "wall.bmp"
loadbmp "map1", back$+".bmp"  'load bmps
loadbmp "man", "man.bmp"
loadbmp "house", "house.bmp"
loadbmp "tree", "tree.bmp"
loadbmp "fin", "fin.bmp"
'set background
print #1, "background map1";

'draw sprites/Background
print #1, "drawsprites"
print #1, "trapclose [end.all]"

'---------------------------------read map file----------------------------
open data$ for input AS #2
open2$ = "yes"
loadbmp "m", "m.bmp"
loadbmp "mr", "mr.bmp"

'for i = 1 to 3
'enemy = enemy + 1
'x$ = str$(int(rnd(1)*310) + 1)
'y$ = str$(int(rnd(1)*370) + 1)
'print #1, "addsprite enemy";enemy;" en"
'print #1, "spritexy enemy";enemy;" "+x$+" "+y$
'print #1, "drawsprites"
'enemy(enemy,0) = enemy
'enemy(enemy,1) = val(x$)
'enemy(enemy,2) = val(y$)
'next i

[loop]
input #2, text$
IF left$(text$,5) = "enemy" THEN [enemy]
IF word$(text$,1) = "block" THEN [block]
IF word$(text$,1) = "fin" THEN [fin]
IF word$(text$,1) = "tree" THEN [tree]
IF word$(text$,1) = "house" THEN [house]
IF word$(text$,1) = "endr" THEN [startg]
IF word$(text$,1) = "wall" THEN [wallb]
IF word$(text$,1) = "wallb" THEN [wallbo]
IF word$(text$,1) = "wallr" THEN [wallr]
IF word$(text$,1) = "walll" THEN [walll]
IF word$(text$,1) = "man" THEN [man]
goto [loop]
notice "Error reading map file(s)! press 'Ctrl + Pause/Break' to quit"
goto [loop]
end


[block]
bw = bw + 1
input #2, x$
input #2, y$
IF word$(text$,2) = "" = 0 THEN usebmp$ = word$(text$,2):loadbmp usebmp$, usebmp$
IF  word$(text$,2) = "" THEN usebmp$ = "wall"
print #1, "addsprite wall";bw;" "+usebmp$
print "Block";bw;" Bitmap: "+usebmp$
print #1, "spritexy wall";bw;" "+x$+" "+y$
'print #1, "centersprite wall";bw
print #1, "drawsprites"
goto [loop]
end


[fin]
input #2, finx$
input #2, finy$
IF word$(text$,2) = "" = 0 THEN usebmp$ = word$(text$,2):loadbmp usebmp$, usebmp$
IF  word$(text$,2) = "" THEN usebmp$ = "fin"
print #1, "addsprite fin "+usebmp$
print #1, "spritexy fin "+finx$+" "+finy$
'print #1, "centersprite fin"
print "Finish Bitmap: "+usebmp$
print #1, "drawsprites"
goto [loop]
end

[enemy]
enemy = enemy + 1
input #2, x$
input #2, y$
IF word$(text$,2) = "" = 0 THEN usebmp$ = word$(text$,2):loadbmp usebmp$, usebmp$
IF  word$(text$,2) = "" THEN usebmp$ = "en"
print #1, "addsprite enemy";enemy;" "+usebmp$
print #1, "spritexy enemy";enemy;" "+x$+" "+y$
'print #1, "centersprite enemy";enemy
print "Enemy";enemy;" Bitmap: "+usebmp$
print #1, "drawsprites"
enemy(enemy,0) = enemy
enemy(enemy,1) = val(x$)
enemy(enemy,2) = val(y$)
goto [loop]
end

[mov.enim]
IF enemy = 0 THEN return
for i = 1 to enemy
#1 "spritetravelxy enemy";i;" ";x;" ";y;" ";speed; " [loopfind]"
next i
return

[house]
h = h + 1
input #2, x$
input #2, y$
IF word$(text$,2) = "" = 0 THEN usebmp$ = word$(text$,2):loadbmp usebmp$, usebmp$
IF  word$(text$,2) = "" THEN usebmp$ = "house"
print #1, "addsprite house";h;" "+usebmp$
print #1, "spritexy house";h;" "+x$+" "+y$
'print #1, "centersprite house";h
print "House";h;" Bitmap: "+usebmp$
print #1, "drawsprites"
goto [loop]
end

[tree]
t = t + 1
input #2, x$
input #2, y$
IF word$(text$,2) = "" = 0 THEN usebmp$ = word$(text$,2):loadbmp usebmp$, usebmp$
IF  word$(text$,2) = "" THEN usebmp$ = "tree"
print #1, "addsprite tree";t;" "+usebmp$
print #1, "spritexy tree";t;" "+x$+" "+y$
'print #1, "centersprite tree";t
print "Tree";t;" Bitmap: "+usebmp$
print #1, "drawsprites"
goto [loop]
end

[man]
input #2, lo$
input #2, x$
'This next section of code is VERY importain! It controls
'the man's movement between 'maps'.
IF x = 0 = 0 AND list$ = "ml" THEN x = 280:y = y
IF x = 0 = 0 AND list$ = "mr" then x = 10:y = y
IF y = 0 = 0 AND list$ = "mb" THEN y = 10:x = x
IF y = 0 = 0 AND list$ = "m" THEN y = 311:x = x

if y = 0 and x = 0 then y = val(lo$): x = val(x$)
goto [loop]
end


[wallb]
input #2, x$
input #2, y$
twall$ = y$
print #1, "addsprite m m"
print #1, "spritexy m "+x$+" "+y$
print #1, "drawsprites"
goto [loop]
end


[wallbo]
input #2, x$
input #2, y$
bwall$ = y$
print #1, "addsprite mb m"
print #1, "spritexy mb "+x$+" "+y$
print #1, "drawsprites"
goto [loop]
end



[wallr]
input #2, x$
input #2, y$
rwall$ = w$
print #1, "addsprite mr mr"
print #1, "spritexy mr "+x$+" "+y$
print #1, "drawsprites"
goto [loop]
end


[walll]
input #2, x$
input #2, y$
lwall$ = x$
print #1, "addsprite ml mr"
print #1, "spritexy ml "+x$+" "+y$
print #1, "drawsprites"
goto [loop]
end



[colid.enim]
'IF enemy = 0 THEN return
for q = 1 to enemy
ey = y: ex = x:#1 "spritetravelxy enemy";q;" ";ex;" ";ey;" ";speed; " [ene]"
next q
return


print enemy
for q = 1 to enemy
print #1, "spritexy? enemy";q;" ex ey"
print #1, "spritecollides enemy";q;" enlist$";
If enlist$ = "" THEN ey = y: ex = x:#1 "spritetravelxy enemy";q;" ";ex;" ";ey;" ";speed; " [ene]"
IF enlist$ = "" = 0 THEN print "E ";q;" Col!":gosub [handel.enim]
IF left$(enlist$, 5) = "enemy" THEN  ey = y: ex = x:print "Enim Collided!!":#1 "spritetravelxy enemy";q;" ";ex;" ";ey;" ";speed; " [ene]"
enemy(q,1) = ex
enemy(q,2) = ey
next q

for t = 1 to enemy
print #1, "spritexy? enemy";t;" ex ey"
enemy(t,1) = ex
enemy(t,2) = ey
next t
return

[loopfinddon]
moven = 0
wait

[handel.enim]
ex = enemy(q,1)
ey = enemy(q,2)
speed = 1
#1 "spritetravelxy enemy";q;" ";ex;" ";ey;" ";speed; " [ene]"
'4 < 3 then [...]
print "Enim Collided!!"
'print #1, "spritecollides enemy";q;" enlist$";
print #1, "drawsprites"
return


[ene]
for er = 1 to enemy
#1 "spritetravelxy enemy";er;" ";x;" ";y;" ";speed; " [ene]"
next er
wait




[startg]
th$ = ""
bh$ = ""
lh$ = ""
rh$ = ""
IF eof(#2) <> 0 = 0 THEN line input #2, th$:line input #2, bh$:line input #2, lh$:line input #2, rh$
loadbmp "man", "man.bmp"
print #1, "addsprite man man"
'when user presses any key goto [letter]
'print #1, "centersprite man"
print #1, "when characterInput [letter]"


'speed to move man...
s = 3
print #1, "spritexy man ";x;" ";y
print #1, "drawsprites"
print "Ready!"
print "'timer going..."
print #1, "setfocus"
'timer 1000, [mov.enim2]
'speed of ai
speed = 2
speed2 = 2

'wait
wait

[loopfind]
'gosub [mov.enim]
wait



'-----------------------------------Check to see if enemy got you!---------------
[letter] 'find key pressed
IF upper$(Inkey$) = "`" AND menuon = 0 THEN goto [gamop] ' I put the quit command here so in case of an error,
IF upper$(Inkey$) = "`" AND menuon = 1 THEN menuon = 0:print #1, "removesprite main":print #1, "drawsprites":wait
'the user can still press 'Q'.
IF menuon = 1 AND Inkey$ = "s" THEN [saveg]
IF menuon = 1 AND Inkey$ = "l" THEN [loadgam]
IF Inkey$ = "q" AND menuon = 1 THEN menuon = 0:print #1, "removesprite main":print #1, "drawsprites":wait
IF Inkey$ = "q" THEN [end.all]
IF menuon = 1 THEN wait
score = score + 1 ' For future Use
Gosub [colid.enim]

[lettercon]
print #1, "spritecollides man list$";
print list$
IF list$ = "" = 0 THEN print #1, "spritexy? "+word$(list$,1)+" tmpx tmpy":print tmpx:print tmpy:print ""
goto [nolist]
end

'------------------------------Check colides and key pressed!--------------

[nolist]
print #1, "flush"
IF list$ = "fin" THEN [win]
'IF enemy = 1 AND list$ = "enemy" or enemy = 1 AND list$ = "enemy2" or enemy = 2 AND list$ = "enemy" or enemy = 2 AND list$ = "enemy2" THEN [die1]
IF left$(list$,5) = "enemy" THEN [die1]

IF list$ = "m" AND val(th$) = 0 = 0 THEN map$ = "auto "+th$:close #1:close #2:goto [reset]
IF list$ = "mb" AND val(bh$) = 0 = 0 THEN map$ = "auto "+bh$:close #1:close #2:goto [reset]
IF list$ = "mr" AND val(rh$) = 0 = 0 THEN map$ = "auto "+rh$:close #1:close #2:goto [reset]
IF list$ = "ml" AND val(lh$) = 0 = 0 THEN map$ = "auto "+lh$:close #1:close #2:goto [reset]

IF list$ = "m" THEN [walltest]
IF list$  = "mb" THEN [walltest]
IF list$ = "mr" THEN [walltest]
IF list$ = "ml" THEN [walltest]
IF list$ = "" THEN [inkey]
goto [walltest] 'stop for all other buildings!!!
[inkey]
IF debug = 1 AND Inkey$ = "w" THEN [w]
IF debug = 1 AND Inkey$ = "s" THEN [s]
IF debug = 1 AND Inkey$ = "a" THEN [a]
IF debug = 1 AND Inkey$ = "d" THEN [d]

IF upper$(Inkey$) = "A" THEN [bonmea]
IF upper$(Inkey$) = "D" THEN [bonmed]
IF upper$(Inkey$) = "W" THEN [bonmew]
IF upper$(Inkey$) = "S" THEN [bonmes]
IF debug = 1 AND Inkey$ = "O" THEN [locateme]
'IF Inkey$  ="`" THEN [gamop]
IF Inkey$ = "C" THEN [comme]



'one-step-at-a-time no longer supported! (Unless 'debug' = 1)


IF Inkey$ = "debug" AND debug = 0 THEN debug = 1:print "Debug is ON":wait
IF Inkey$ = "debug" AND debug = 1 THEN debug = 0:print "Debug is OFF":wait

'If key pressed is not listed here Then...
Print "Key '"+Inkey$+"' not defined!"
wait

[comme]
prompt "Command: ";comInkey$
IF lower$(word$(comInkey$,1)) = "move" THEN Inkey$ = word$(comInkey$,2):goto [nolist]
wait

'Bounce you!
[bonmes]
'goto [ty] 'unremark (') this just to see what happens!
waht$ = "s"
x = x + 0
y = y  + s
print #1, "spritexy man ";x;" ";y
print #1, "drawsprites"
'IF enemy = 2 OR enemy = 1 THEN
'#1 "spritetravelxy enemy2 ";x;" ";y;" ";speed; " [loopfind]"
'wait
'else
goto [letter]
wait

[bonmew]
'goto [ty] 'unremark (') this just to see what happens!
waht$ = "w"
x = x + 0
y = y  - s
print #1, "spritexy man ";x;" ";y
print #1, "drawsprites"
'IF enemy = 2 OR enemy = 1 THEN
'#1 "spritetravelxy enemy2 ";x;" ";y;" ";speed; " [loopfind]"
'wait
'else
goto [letter]
wait

[bonmed]
'goto [ty] 'unremark (') this just to see what happens!
waht$ = "d"
x = x + s
y = y  + 0
print #1, "spritexy man ";x;" ";y
print #1, "drawsprites"
'IF enemy = 2 OR enemy = 1 THEN
'#1 "spritetravelxy enemy2 ";x;" ";y;" ";speed; " [loopfind]"
'wait
'else
goto [letter]
wait

[bonmea]
'goto [ty] 'unremark (') this just to see what happens!
waht$ = "a"
x = x - s
y = y  + 0
print #1, "spritexy man ";x;" ";y
print #1, "drawsprites"
'IF enemy = 2 OR enemy = 1 THEN
'#1 "spritetravelxy enemy2 ";x;" ";y;" ";speed; " [loopfind]"
'wait
'else
goto [letter]
wait
 '------------------------------------End of bounce---------------

[die1]
notice "Ha Ha Ha! I got you!"
close #1
close #2
goto [reset]
end


[win]
'notice "Press 'ok' to continue..."
map = map + 1
map$ = "auto ";map
IF map = many+1 THEN Notice "You past all the levels!":map = 1:map$ = "auto ";map
'notice "You Made it!"+chr$(13)+"Your score was ";score;"!"
'gosub [scoreit]
close #1
close #2
goto [reset]

[scoreit]
open "score.txt" for input as #65
Input #65, blank$
input #65, score$
comp = val(score$)
IF comp <= score THEN close #65:notice "Sorry! But '"+blank$+"' still holds the high score!":return
notice "You got the high score! Your score was ";score;"!"
prompt "Please enter your name:";name$
goto [checkn]
end
[scorecon]
open "Score.txt" for output AS #65
print #65, name$ 
print #65, score
close #65
return


[locateme]
notice "Man at location where x = ";x;" And y = ";y;"."
wait


[checkn]
IF ememy = 0 = 0 THEN goto [scorecon]
name$ = name$ + " (No Enemys and on level "+map$+"!)"
goto [scorecon]
end

[w] 'move man forward
waht$ = "w"
x = x + 0
y = y  - s
print #1, "spritexy man ";x;" ";y
print #1, "drawsprites"
IF enemy = 0 THEN wait
'gosub [mov.enim]
wait


[moveme] 'fly away!
IF Inkey$ = "p" THEN goto [s]
goto [su]

[s] 'move man backwards
'goto [ty] 'unremark (') this just to see what happens!
waht$ = "s"
x = x + 0
y = y  + s
print #1, "spritexy man ";x;" ";y
print #1, "drawsprites"
IF enemy =0 THEN wait
'gosub [mov.enim]
wait


[d] 'move man right
waht$ = "d"
x = x + s
y = y  + 0
print #1, "spritexy man ";x;" ";y
print #1, "drawsprites"
IF enemy = 0 THEN wait
'gosub [mov.enim]
wait



[a] 'move man left
waht$ = "a"
x = x - s
y = y  + 0
print #1, "spritexy man ";x;" ";y
print #1, "drawsprites"
IF enemy =0 THEN wait
'gosub [mov.enim]
wait




[wall1] 'man hit top wall!
goto [s]
wait

[wall2]
goto [w]
wait

[wall3]
goto [a]
wait

[wall4]
goto [d]
wait


[walltest]
IF waht$ = "w" THEN [s]
IF waht$ = "s" THEN [w]
IF waht$ = "a" THEN [d]
IF waht$ = "d" THEN [a]
goto [error]
wait








'---------------------------------------Load/Save your game!-----------------
[gamop]
loadbmp "main", "main.bmp"
print #1, "addsprite main main"
print #1, "spritexy main 50 100 "
percent=50
print #1, "spritescale main ";percent
menuon = 1
print #1, "drawsprites"
wait
    WindowWidth = 550
    WindowHeight = 410
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    button #Savl.button1,"Save",[saveg], UL, 220,  57,  42,  25
    button #Savl.button2,"Load",[loadgam], UL, 220,  92,  41,  25
    button #Savl.button3,"Continue",[continue], UL, 215, 242,  62,  25

    '-----End GUI objects code

    open "Save/Load Game" for dialog_nf as #Savl
    print #Savl, "font ms_sans_serif 10"

wait


[continue]
close #Savl
print #1, "drawsprites"
wait


[loadgam]
IF fileExists("","save.dbl") = 0 THEN open "save.dbl" for output AS #s:print #s, "endr":close #s
open "save.dbl" for input AS #loadme
prompt "Enter name of saved game: "; sga$
[looplo]
input #loadme, temp$
IF temp$ = "endr" THEN [nofo]
IF temp$ = sga$ THEN goto[yefo]:end
goto [looplo]
end

[nofo]
notice "Game not found."
close #loadme
wait

[yefo]
'input #loadme, gamen$
gamen$ = temp$
open gamen$+".sav" for input AS #dataf2
close #loadme
input #dataf2, blank$
input #dataf2, x$
INPUT #dataf2, y$
input #dataf2, cmap$
IF map$ = cmap$ = 0 THEN goto [load.game2]
x = val(x$)
y = val(y$)
'close #Savl
print #1, "spritexy man ";x;" ";y
print #1, "drawsprites"
close #dataf2
print #1, "drawsprites"
notice "Game loaded!"
wait

[load.game2]
CLOSE #dataf2
'close #Savl
CLOSE #1
close #2
map$ = "auto "+cmap$
goto [reset]
end

[saveg]
open "temp.tmp" for output AS #temp
prompt "Enter name of game: "; saveg$
dataf$ = saveg$
open "save.dbl" for input AS #li
[loopre]
input #li, list$
IF list$ = "endr" THEN goto [endre]:wait
print #temp, list$
goto [loopre]
wait

[endre]
print #temp, saveg$
print #temp, dataf$
print #temp, "endr"
close #li
close #temp
open "save.dbl" for output AS #li
open "temp.tmp" for input AS #temp
[looptem]
input #temp, text$
IF text$ = "endr" THEN goto [endrt]:end
print #li, text$
goto [looptem]
wait

[endrt]
close #temp
kill "temp.tmp"
print #li, "endr"
close #li
open dataf$+".sav" for output AS #savf
print #savf, "man"
print #savf, x
print #savf, y
print #savf, map$
close #savf
'close #Savl
notice "Game saved!"
wait








'-----------------------------------Trash, dont use!---------------------------------

[mov.enim2]
'IF moven = 1 THEN print #1, "drawsprites":wait
IF enemy = 0 THEN wait
for i = 1 to enemy
speed = 1
'rnx = int(rnd(1)*330) + 1
'rny = int(rnd(1)*310) + 1
ex = ex + eg
ey = ey + egy
print #1, "spritecollides enemy";i;" enlist$";
IF enlist$ = "" = 0 THEN egy = -1: eg = -1
moven = 1
#1 "spritetravelxy enemy";i;" ";ex;" ";ey;" ";speed; " [loopfinddon]"
print #1, "drawsprites"
next i
wait

[wallen]
'x = x - 3
'y = y - 3
speed = speed - 4
speed2 = speed2 - 10
#1 "spritetravelxy enemy2 ";x;" ";y;" ";speed; " [loopfind]"
#1 "spritetravelxy enemy1 ";x;" ";y;" ";speed2; " [loopfind]"
speed = speed + 4
speed2 = speed2 + 10
'x = x + 3
'y = y + 3
goto [nolist]
wait


[pushme]
IF waht$ = "w" THEN [pw]
IF waht$ = "s" THEN [ps]
IF waht$ = "a" THEN [pa]
IF waht$ = "d" THEN [pd]
wait

[pw]
'bx$
'by$
bx = bx + 0
by = by - 5
print #1, "spritexy block";bl;" ";bx;" ";by
print #1, "drawsprites"
s = 2
wait

[ps]
'bx$
'by$
bx = bx + 0
by = by + 5
print #1, "spritexy block";bl;" ";bx;" ";by
print #1, "drawsprites"
s = 2
wait

[pa]
'bx$
'by$
bx = bx - 5
by = by + 0
print #1, "spritexy block";bl;" ";bx;" ";by
print #1, "drawsprites"
s = 2
wait

[pd]
'bx$
'by$
bx = bx + 5
by = by + 0
print #1, "spritexy block";bl;" ";bx;" ";by
print #1, "drawsprites"
s = 2
wait


'-----------------------------End of trash---------------------------------


[error]         'on error go here!
IF Err$ = "" = 0 THEN goto [errorup]
Err$ = "!Unknown!"
[errorup]
 WindowWidth = 370
    WindowHeight = 155
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    button #err.button1,"O&k",[button1Click], UL, 150,  92,  36,  25
    statictext #err.statictext2, "There was an error in this program but it will try to continue",   5,   5, 758,  20
    statictext #err.statictext3, "To kill the game, press 'Ctrl + Pause/Break'. ",   5,  22, 421,  20
    statictext #err.statictext4, "Press 'ok' to quit.",   5,  42, 105,  20
    statictext #err.statictext5, "-Adelphos Programming", 165,  57, 165,  20

    '-----End GUI objects code

    open "Error In program: "+Err$ for dialog as #err
    print #err, "font ms_sans_serif 10"
    print #err, "trapclose [button1Click]"
    open "AdelError.txt" for output AS #45
    print #45, "Adelphos Pro(tm) Error Holder v1.0"
    print #45, "Error: "+Err$
    close #45
wait
[button1Click]
notice "Error info has been saved as Adelerror.txt, Please send this to us."
'goto [end.all]
end

[rm.maps]
open ONGAME$+".log" for input AS #kf
for i = 1 to 100000
IF eof(#kf) <> 0 THEN exit for
line input #kf, killme$
IF fileExists("",killme$) THEN kill killme$
next i

close #kf
kill ONGAME$+".log"
return

[end.all]
'timer 0
IF fileExists("",ONGAME$+".log") THEN gosub [rm.maps]
IF fileExists("","objects.obj.log") = 0 THEN end
close #1
close #2
open "objects.obj.log" for input AS #kf
for i = 1 to 100000
IF eof(#kf) <> 0 THEN exit for
line input #kf, killme$
IF fileExists("",killme$) THEN kill killme$
next i

close #kf
kill "objects.obj.log"

for i = 1 to many
IF fileExists("","map";i;".map.log") = 0 THEN [next.i]
   open "map";i;".map.log" for input AS #kf
   for b = 1 to 100000
    IF eof(#kf) <> 0 THEN exit for
    line input #kf, killme$
    IF fileExists("",killme$) THEN kill killme$
    next b
    close #kf
    kill "map";i;".map.log"
goto [next.i]
end

[next.i]
next i

IF fileExists("",ONGAME$) THEN kill ONGAME$

end



'nomainwin
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
[get.games]
filedialog "Open game file", "*.game", bmpsat$
print "File chosen is ";bmpsat$
gamefile$ = bmpsat$
IF right$(bmpsat$,4) = "game" = 0 THEN notice "An invalid game file was chosen, using original.":bmpsat$ = "Original.game":IF fileExists("", "original.game") = 0 then notice "Program missing a data file! Must close!"
IF fileExists("", "original.game") = 0 AND right$(bmpsat$,4) = "game" = 0 then end
return




[encrypt]   'Do it!
cryok = 0
'MODE = 1 = Decrypt
'MODE = 2 = Encrypt 'It's really the other way around but i'm too lazy to fix it!
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
    open "MAPPEC.DLL" for dll as #en
    calldll #en, "_ENCRYPT",_
        MODE as short,_
        INFILE$ as ptr,_
        OUTFILE$ as ptr,_
        KEY$ as ptr,_
        RESULT as short
    close #en
    ENCRYPTION = RESULT
end function


[get.os]
 struct OSVERSIONINFO,_
        dwOSVersionInfoSize as ulong,_
        dwMajorVersion      as ulong,_
        dwMinorVersion      as ulong,_
        dwBuildNumber       as ulong,_
        dwPlatformId        as ulong,_
        szCSDVersion        as char[128]

    L=len(OSVERSIONINFO.struct)
    OSVERSIONINFO.dwOSVersionInfoSize.struct=L

    calldll #kernel32, "GetVersionExA",_
        OSVERSIONINFO as struct,_
        result as boolean

' Determine wich SubKey to use
    PlatformID = OSVERSIONINFO.dwPlatformId.struct

    select case PlatformID
'Running Win9x,ME
        case _VER_PLATFORM_WIN32_WINDOWS
            OSVersionKey$ = "Windows"
            OS$ = "Windows 9X"
'Running WinNT,2k,XP
        case _VER_PLATFORM_WIN32_NT
            OSVersionKey$ = "Windows NT"
            OS$ = "Windows NT"
'Win3.x or whatever
    case else
       notice "Application Error";chr$(13);"Unsupported Operating system!"
       end
end select
return


[loading.Screen]

    nomainwin
    WindowWidth = 230
    WindowHeight = 110
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    statictext #ld.statictext1, LDTEXT$,  20,  22, 471,  20
    statictext #ld.statictext2, ".......",  95,  47,  61,  20

    '-----End GUI objects code

    open "Please Wait..." for dialog_modal as #ld
    print #ld, "font ms_sans_serif 10"
    print #ld, "trapclose [quit.ld]"


[ld.inputLoop]   'wait here for input event
'timer 1000, [move.dot]
    return


[quit.ld] 'End the program
    close #ld
    wait



