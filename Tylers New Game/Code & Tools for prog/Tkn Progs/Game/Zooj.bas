


PASSWORD "Carl Gundel", "9BCDD8"
GOSUB [get.games]
DIM orders( 100 , 2 )
GOSUB [get.os]
PRINT "Running OS: " + OS$
PRINT "Loading, Please Wait..."
LDTEXT$ = "Loading Game, Please Wait!"
GOSUB [loading.Screen]
KEY$ = "ycpwf"
INFILE$ = bmpsat$
IF fileExists( "" , bmpsat$ + ".tmp" ) THEN KILL bmpsat$ + ".tmp"
OUTFILE$ = bmpsat$ + ".tmp"
MODE = 1
GOSUB [encrypt]
IF cryok = 0 THEN END
bmpsat$ = bmpsat$ + ".tmp"
ONGAME$ = bmpsat$
GOSUB [extract.bmps]
CLOSE #ld

[reset]
enemy = 0
mon = 100
hel = 100
foo = 100
debug = 1

[progstart]
en = 100
NOMAINWIN
OPEN "maps.txt" FOR INPUT AS #1
INPUT #1 , many$
many = VAL( many$ )

[top]
IF WORD$( map$ , 1 ) = "auto" THEN map = VAL( WORD$( map$ , 2 ) ) : map$ = WORD$( map$ , 2 ) : GOTO [keeplook]
map = 1
map$ = STR$( map )
IF map <= 0 OR map > many THEN NOTICE "Map not found!" : GOTO [top] : END
GOTO [keeplook]
END

[keeplook]
INPUT #1 , input$
IF input$ = map$ = 0 THEN [keeplook]
INPUT #1 , back$
INPUT #1 , data$
data$ = "data.txt"
CLOSE #1
GOTO [start]
END

[start]
WindowWidth = 310
WindowHeight = 370
UpperLeftX = DisplayHeight / 2
UpperLeftY = 200
PRINT "Screen res is " ; DisplayWidth ; "," ; DisplayHeight
bmpsat$ = "map" + map$ + ".map"
GOSUB [extract.bmps]
bmpsat$ = "objects.obj"
GOSUB [extract.bmps]
LOADBMP "loading" , "main.bmp"
OPEN back$ FOR graphics_nsb_nf AS #1
PRINT #1 , "|"
PRINT #1 , "|"
PRINT #1 , "|"
PRINT #1 , "|"
PRINT #1 , "|                      Loading!....."
h = 0
LOADBMP "en" , "en.bmp"
LOADBMP "wall" , "wall.bmp"
LOADBMP "map1" , back$ + ".bmp"
LOADBMP "man" , "man.bmp"
LOADBMP "house" , "house.bmp"
LOADBMP "tree" , "tree.bmp"
LOADBMP "fin" , "fin.bmp"
PRINT #1 , "background map1" ;
PRINT #1 , "drawsprites"
PRINT #1 , "trapclose [end.all]"
OPEN data$ FOR INPUT AS #2
open2$ = "yes"
LOADBMP "m" , "m.bmp"
LOADBMP "mr" , "mr.bmp"

[loop]
INPUT #2 , text$
IF LEFT$( text$ , 5 ) = "enemy" THEN [enemy]
IF WORD$( text$ , 1 ) = "block" THEN [block]
IF WORD$( text$ , 1 ) = "fin" THEN [fin]
IF WORD$( text$ , 1 ) = "tree" THEN [tree]
IF WORD$( text$ , 1 ) = "house" THEN [house]
IF WORD$( text$ , 1 ) = "endr" THEN [startg]
IF WORD$( text$ , 1 ) = "wall" THEN [wallb]
IF WORD$( text$ , 1 ) = "wallb" THEN [wallbo]
IF WORD$( text$ , 1 ) = "wallr" THEN [wallr]
IF WORD$( text$ , 1 ) = "walll" THEN [walll]
IF WORD$( text$ , 1 ) = "man" THEN [man]
GOTO [loop]
NOTICE "Error reading map file(s)! press 'Ctrl + Pause/Break' to quit"
GOTO [loop]
END

[block]
bw = bw + 1
INPUT #2 , x$
INPUT #2 , y$
IF WORD$( text$ , 2 ) = "" = 0 THEN usebmp$ = WORD$( text$ , 2 ) : LOADBMP usebmp$ , usebmp$
IF WORD$( text$ , 2 ) = "" THEN usebmp$ = "wall"
PRINT #1 , "addsprite wall" ; bw ; " " + usebmp$
PRINT "Block" ; bw ; " Bitmap: " + usebmp$
PRINT #1 , "spritexy wall" ; bw ; " " + x$ + " " + y$
'PRINT #1 , "drawsprites"
GOTO [loop]
END

[fin]
INPUT #2 , finx$
INPUT #2 , finy$
IF WORD$( text$ , 2 ) = "" = 0 THEN usebmp$ = WORD$( text$ , 2 ) : LOADBMP usebmp$ , usebmp$
IF WORD$( text$ , 2 ) = "" THEN usebmp$ = "fin"
PRINT #1 , "addsprite fin " + usebmp$
PRINT #1 , "spritexy fin " + finx$ + " " + finy$
PRINT "Finish Bitmap: " + usebmp$
'PRINT #1 , "drawsprites"
GOTO [loop]
END

[enemy]
enemy = enemy + 1
INPUT #2 , x$
INPUT #2 , y$
IF WORD$( text$ , 2 ) = "" = 0 THEN usebmp$ = WORD$( text$ , 2 ) : LOADBMP usebmp$ , usebmp$
IF WORD$( text$ , 2 ) = "" THEN usebmp$ = "en"
PRINT #1 , "addsprite enemy" ; enemy ; " " + usebmp$
PRINT #1 , "spritexy enemy" ; enemy ; " " + x$ + " " + y$
PRINT "Enemy" ; enemy ; " Bitmap: " + usebmp$
'PRINT #1 , "drawsprites"
enemy( enemy , 0 ) = enemy
enemy( enemy , 1 ) = VAL( x$ )
enemy( enemy , 2 ) = VAL( y$ )
GOTO [loop]
END

[mov.enim]
IF enemy = 0 THEN RETURN
FOR i = 1 TO enemy
#1 "spritetravelxy enemy" ; i ; " " ; x ; " " ; y ; " " ; speed ; " [loopfind]"
NEXT i
RETURN

[house]
h = h + 1
INPUT #2 , x$
INPUT #2 , y$
IF WORD$( text$ , 2 ) = "" = 0 THEN usebmp$ = WORD$( text$ , 2 ) : LOADBMP usebmp$ , usebmp$
IF WORD$( text$ , 2 ) = "" THEN usebmp$ = "house"
PRINT #1 , "addsprite house" ; h ; " " + usebmp$
PRINT #1 , "spritexy house" ; h ; " " + x$ + " " + y$
PRINT "House" ; h ; " Bitmap: " + usebmp$
'PRINT #1 , "drawsprites"
GOTO [loop]
END

[tree]
t = t + 1
INPUT #2 , x$
INPUT #2 , y$
IF WORD$( text$ , 2 ) = "" = 0 THEN usebmp$ = WORD$( text$ , 2 ) : LOADBMP usebmp$ , usebmp$
IF WORD$( text$ , 2 ) = "" THEN usebmp$ = "tree"
PRINT #1 , "addsprite tree" ; t ; " " + usebmp$
PRINT #1 , "spritexy tree" ; t ; " " + x$ + " " + y$
PRINT "Tree" ; t ; " Bitmap: " + usebmp$
'PRINT #1 , "drawsprites"
GOTO [loop]
END

[man]
INPUT #2 , lo$
INPUT #2 , x$
IF x = 0 = 0 AND list$ = "ml" THEN x = 280 : y = y
IF x = 0 = 0 AND list$ = "mr" THEN x = 10 : y = y
IF y = 0 = 0 AND list$ = "mb" THEN y = 10 : x = x
IF y = 0 = 0 AND list$ = "m" THEN y = 311 : x = x
IF y = 0 AND x = 0 THEN y = VAL( lo$ ) : x = VAL( x$ )
GOTO [loop]
END

[wallb]
INPUT #2 , x$
INPUT #2 , y$
twall$ = y$
PRINT #1 , "addsprite m m"
PRINT #1 , "spritexy m " + x$ + " " + y$
'PRINT #1 , "drawsprites"
GOTO [loop]
END

[wallbo]
INPUT #2 , x$
INPUT #2 , y$
bwall$ = y$
PRINT #1 , "addsprite mb m"
PRINT #1 , "spritexy mb " + x$ + " " + y$
'PRINT #1 , "drawsprites"
GOTO [loop]
END

[wallr]
INPUT #2 , x$
INPUT #2 , y$
rwall$ = w$
PRINT #1 , "addsprite mr mr"
PRINT #1 , "spritexy mr " + x$ + " " + y$
'PRINT #1 , "drawsprites"
GOTO [loop]
END

[walll]
INPUT #2 , x$
INPUT #2 , y$
lwall$ = x$
PRINT #1 , "addsprite ml mr"
PRINT #1 , "spritexy ml " + x$ + " " + y$
'PRINT #1 , "drawsprites"
GOTO [loop]
END

[colid.enim]
FOR q = 1 TO enemy
ey = y : ex = x : #1 "spritetravelxy enemy" ; q ; " " ; ex ; " " ; ey ; " " ; speed ; " [ene]"
NEXT q
RETURN
PRINT enemy
FOR q = 1 TO enemy
PRINT #1 , "spritexy? enemy" ; q ; " ex ey"
PRINT #1 , "spritecollides enemy" ; q ; " enlist$" ;
IF enlist$ = "" THEN ey = y : ex = x : #1 "spritetravelxy enemy" ; q ; " " ; ex ; " " ; ey ; " " ; speed ; " [ene]"
IF enlist$ = "" = 0 THEN PRINT "E " ; q ; " Col!" : GOSUB [handel.enim]
IF LEFT$( enlist$ , 5 ) = "enemy" THEN ey = y : ex = x : PRINT "Enim Collided!!" : #1 "spritetravelxy enemy" ; q ; " " ; ex ; " " ; ey ; " " ; speed ; " [ene]"
enemy( q , 1 ) = ex
enemy( q , 2 ) = ey
NEXT q
FOR t = 1 TO enemy
PRINT #1 , "spritexy? enemy" ; t ; " ex ey"
enemy( t , 1 ) = ex
enemy( t , 2 ) = ey
NEXT t
RETURN

[loopfinddon]
moven = 0
WAIT

[handel.enim]
ex = enemy( q , 1 )
ey = enemy( q , 2 )
speed = 1
#1 "spritetravelxy enemy" ; q ; " " ; ex ; " " ; ey ; " " ; speed ; " [ene]"
PRINT "Enim Collided!!"
PRINT #1 , "drawsprites"
RETURN

[ene]
FOR er = 1 TO enemy
#1 "spritetravelxy enemy" ; er ; " " ; x ; " " ; y ; " " ; speed ; " [ene]"
NEXT er
WAIT

[startg]
th$ = ""
bh$ = ""
lh$ = ""
rh$ = ""
IF EOF( #2 ) <> 0 = 0 THEN LINE INPUT #2 , th$ : LINE INPUT #2 , bh$ : LINE INPUT #2 , lh$ : LINE INPUT #2 , rh$
LOADBMP "man" , "man.bmp"
PRINT #1 , "addsprite man man"
PRINT #1 , "when characterInput [letter]"
s = 3
PRINT #1 , "spritexy man " ; x ; " " ; y
PRINT #1 , "drawsprites"
PRINT "Ready!"
PRINT "'timer going..."
PRINT #1 , "setfocus"
speed = 2
speed2 = 2
WAIT

[loopfind]
WAIT

[letter]
IF UPPER$( Inkey$ ) = "`" AND menuon = 0 THEN GOTO [gamop]
IF UPPER$( Inkey$ ) = "`" AND menuon = 1 THEN menuon = 0 : PRINT #1 , "removesprite main" : PRINT #1 , "drawsprites" : WAIT
IF menuon = 1 AND Inkey$ = "s" THEN [saveg]
IF menuon = 1 AND Inkey$ = "l" THEN [loadgam]
IF Inkey$ = "q" AND menuon = 1 THEN menuon = 0 : PRINT #1 , "removesprite main" : PRINT #1 , "drawsprites" : WAIT
IF Inkey$ = "q" THEN [end.all]
IF menuon = 1 THEN WAIT
score = score + 1
GOSUB [colid.enim]

[lettercon]
PRINT #1 , "spritecollides man list$" ;
PRINT list$
IF list$ = "" = 0 THEN PRINT #1 , "spritexy? " + WORD$( list$ , 1 ) + " tmpx tmpy" : PRINT tmpx : PRINT tmpy : PRINT ""
GOTO [nolist]
END

[nolist]
PRINT #1 , "flush"
IF list$ = "fin" THEN [win]
IF LEFT$( list$ , 5 ) = "enemy" THEN [die1]
IF list$ = "m" AND VAL( th$ ) = 0 = 0 THEN map$ = "auto " + th$ : CLOSE #1 : CLOSE #2 : GOTO [reset]
IF list$ = "mb" AND VAL( bh$ ) = 0 = 0 THEN map$ = "auto " + bh$ : CLOSE #1 : CLOSE #2 : GOTO [reset]
IF list$ = "mr" AND VAL( rh$ ) = 0 = 0 THEN map$ = "auto " + rh$ : CLOSE #1 : CLOSE #2 : GOTO [reset]
IF list$ = "ml" AND VAL( lh$ ) = 0 = 0 THEN map$ = "auto " + lh$ : CLOSE #1 : CLOSE #2 : GOTO [reset]
IF list$ = "m" THEN [walltest]
IF list$ = "mb" THEN [walltest]
IF list$ = "mr" THEN [walltest]
IF list$ = "ml" THEN [walltest]
IF list$ = "" THEN [inkey]
GOTO [walltest]

[inkey]
IF debug = 1 AND Inkey$ = "w" THEN [w]
IF debug = 1 AND Inkey$ = "s" THEN [s]
IF debug = 1 AND Inkey$ = "a" THEN [a]
IF debug = 1 AND Inkey$ = "d" THEN [d]
IF UPPER$( Inkey$ ) = "A" THEN [bonmea]
IF UPPER$( Inkey$ ) = "D" THEN [bonmed]
IF UPPER$( Inkey$ ) = "W" THEN [bonmew]
IF UPPER$( Inkey$ ) = "S" THEN [bonmes]
IF debug = 1 AND Inkey$ = "O" THEN [locateme]
IF Inkey$ = "C" THEN [comme]
IF Inkey$ = "debug" AND debug = 0 THEN debug = 1 : PRINT "Debug is ON" : WAIT
IF Inkey$ = "debug" AND debug = 1 THEN debug = 0 : PRINT "Debug is OFF" : WAIT
PRINT "Key '" + Inkey$ + "' not defined!"
WAIT

[comme]
PROMPT "Command: " ; comInkey$
IF LOWER$( WORD$( comInkey$ , 1 ) ) = "move" THEN Inkey$ = WORD$( comInkey$ , 2 ) : GOTO [nolist]
WAIT

[bonmes]
waht$ = "s"
x = x + 0
y = y + s
PRINT #1 , "spritexy man " ; x ; " " ; y
PRINT #1 , "drawsprites"
GOTO [letter]
WAIT

[bonmew]
waht$ = "w"
x = x + 0
y = y - s
PRINT #1 , "spritexy man " ; x ; " " ; y
PRINT #1 , "drawsprites"
GOTO [letter]
WAIT

[bonmed]
waht$ = "d"
x = x + s
y = y + 0
PRINT #1 , "spritexy man " ; x ; " " ; y
PRINT #1 , "drawsprites"
GOTO [letter]
WAIT

[bonmea]
waht$ = "a"
x = x - s
y = y + 0
PRINT #1 , "spritexy man " ; x ; " " ; y
PRINT #1 , "drawsprites"
GOTO [letter]
WAIT

[die1]
NOTICE "Ha Ha Ha! I got you!"
CLOSE #1
CLOSE #2
GOTO [reset]
END

[win]
map = map + 1
map$ = "auto " ; map
IF map = many + 1 THEN NOTICE "You past all the levels!" : map = 1 : map$ = "auto " ; map
CLOSE #1
CLOSE #2
GOTO [reset]

[scoreit]
OPEN "score.txt" FOR INPUT AS #65
INPUT #65 , blank$
INPUT #65 , score$
comp = VAL( score$ )
IF comp <= score THEN CLOSE #65 : NOTICE "Sorry! But '" + blank$ + "' still holds the high score!" : RETURN
NOTICE "You got the high score! Your score was " ; score ; "!"
PROMPT "Please enter your name:" ; name$
GOTO [checkn]
END

[scorecon]
OPEN "Score.txt" FOR OUTPUT AS #65
PRINT #65 , name$
PRINT #65 , score
CLOSE #65
RETURN

[locateme]
NOTICE "Man at location where x = " ; x ; " And y = " ; y ; "."
WAIT

[checkn]
IF ememy = 0 = 0 THEN GOTO [scorecon]
name$ = name$ + " (No Enemys and on level " + map$ + "!)"
GOTO [scorecon]
END

[w]
waht$ = "w"
x = x + 0
y = y - s
PRINT #1 , "spritexy man " ; x ; " " ; y
PRINT #1 , "drawsprites"
IF enemy = 0 THEN WAIT
WAIT

[moveme]
IF Inkey$ = "p" THEN GOTO [s]
GOTO [su]

[s]
waht$ = "s"
x = x + 0
y = y + s
PRINT #1 , "spritexy man " ; x ; " " ; y
PRINT #1 , "drawsprites"
IF enemy = 0 THEN WAIT
WAIT

[d]
waht$ = "d"
x = x + s
y = y + 0
PRINT #1 , "spritexy man " ; x ; " " ; y
PRINT #1 , "drawsprites"
IF enemy = 0 THEN WAIT
WAIT

[a]
waht$ = "a"
x = x - s
y = y + 0
PRINT #1 , "spritexy man " ; x ; " " ; y
PRINT #1 , "drawsprites"
IF enemy = 0 THEN WAIT
WAIT

[wall1]
GOTO [s]
WAIT

[wall2]
GOTO [w]
WAIT

[wall3]
GOTO [a]
WAIT

[wall4]
GOTO [d]
WAIT

[walltest]
IF waht$ = "w" THEN [s]
IF waht$ = "s" THEN [w]
IF waht$ = "a" THEN [d]
IF waht$ = "d" THEN [a]
GOTO [error]
WAIT

[gamop]
LOADBMP "main" , "main.bmp"
PRINT #1 , "addsprite main main"
PRINT #1 , "spritexy main 50 100 "
percent = 50
PRINT #1 , "spritescale main " ; percent
menuon = 1
PRINT #1 , "drawsprites"
WAIT
WindowWidth = 550
WindowHeight = 410
UpperLeftX = INT( ( DisplayWidth - WindowWidth ) / 2 )
UpperLeftY = INT( ( DisplayHeight - WindowHeight ) / 2 )
BUTTON #Savl.button1 , "Save" , [saveg] , UL , 220 , 57 , 42 , 25
BUTTON #Savl.button2 , "Load" , [loadgam] , UL , 220 , 92 , 41 , 25
BUTTON #Savl.button3 , "Continue" , [continue] , UL , 215 , 242 , 62 , 25
OPEN "Save/Load Game" FOR dialog_nf AS #Savl
PRINT #Savl , "font ms_sans_serif 10"
WAIT

[continue]
CLOSE #Savl
PRINT #1 , "drawsprites"
WAIT

[loadgam]
IF fileExists( "" , "save.dbl" ) = 0 THEN OPEN "save.dbl" FOR OUTPUT AS #s : PRINT #s , "endr" : CLOSE #s
OPEN "save.dbl" FOR INPUT AS #loadme
PROMPT "Enter name of saved game: " ; sga$

[looplo]
INPUT #loadme , temp$
IF temp$ = "endr" THEN [nofo]
IF temp$ = sga$ THEN GOTO [yefo] : END
GOTO [looplo]
END

[nofo]
NOTICE "Game not found."
CLOSE #loadme
WAIT

[yefo]
gamen$ = temp$
OPEN gamen$ + ".sav" FOR INPUT AS #dataf2
CLOSE #loadme
INPUT #dataf2 , blank$
INPUT #dataf2 , x$
INPUT #dataf2 , y$
INPUT #dataf2 , cmap$
IF map$ = cmap$ = 0 THEN GOTO [load.game2]
x = VAL( x$ )
y = VAL( y$ )
PRINT #1 , "spritexy man " ; x ; " " ; y
PRINT #1 , "drawsprites"
CLOSE #dataf2
PRINT #1 , "drawsprites"
NOTICE "Game loaded!"
WAIT

[load.game2]
CLOSE #dataf2
CLOSE #1
CLOSE #2
map$ = "auto " + cmap$
GOTO [reset]
END

[saveg]
OPEN "temp.tmp" FOR OUTPUT AS #temp
PROMPT "Enter name of game: " ; saveg$
dataf$ = saveg$
OPEN "save.dbl" FOR INPUT AS #li

[loopre]
INPUT #li , list$
IF list$ = "endr" THEN GOTO [endre] : WAIT
PRINT #temp , list$
GOTO [loopre]
WAIT

[endre]
PRINT #temp , saveg$
PRINT #temp , dataf$
PRINT #temp , "endr"
CLOSE #li
CLOSE #temp
OPEN "save.dbl" FOR OUTPUT AS #li
OPEN "temp.tmp" FOR INPUT AS #temp

[looptem]
INPUT #temp , text$
IF text$ = "endr" THEN GOTO [endrt] : END
PRINT #li , text$
GOTO [looptem]
WAIT

[endrt]
CLOSE #temp
KILL "temp.tmp"
PRINT #li , "endr"
CLOSE #li
OPEN dataf$ + ".sav" FOR OUTPUT AS #savf
PRINT #savf , "man"
PRINT #savf , x
PRINT #savf , y
PRINT #savf , map$
CLOSE #savf
NOTICE "Game saved!"
WAIT

[mov.enim2]
IF enemy = 0 THEN WAIT
FOR i = 1 TO enemy
speed = 1
ex = ex + eg
ey = ey + egy
PRINT #1 , "spritecollides enemy" ; i ; " enlist$" ;
IF enlist$ = "" = 0 THEN egy = -1 : eg = -1
moven = 1
#1 "spritetravelxy enemy" ; i ; " " ; ex ; " " ; ey ; " " ; speed ; " [loopfinddon]"
PRINT #1 , "drawsprites"
NEXT i
WAIT

[wallen]
speed = speed - 4
speed2 = speed2 - 10
#1 "spritetravelxy enemy2 " ; x ; " " ; y ; " " ; speed ; " [loopfind]"
#1 "spritetravelxy enemy1 " ; x ; " " ; y ; " " ; speed2 ; " [loopfind]"
speed = speed + 4
speed2 = speed2 + 10
GOTO [nolist]
WAIT

[pushme]
IF waht$ = "w" THEN [pw]
IF waht$ = "s" THEN [ps]
IF waht$ = "a" THEN [pa]
IF waht$ = "d" THEN [pd]
WAIT

[pw]
bx = bx + 0
by = by - 5
PRINT #1 , "spritexy block" ; bl ; " " ; bx ; " " ; by
PRINT #1 , "drawsprites"
s = 2
WAIT

[ps]
bx = bx + 0
by = by + 5
PRINT #1 , "spritexy block" ; bl ; " " ; bx ; " " ; by
PRINT #1 , "drawsprites"
s = 2
WAIT

[pa]
bx = bx - 5
by = by + 0
PRINT #1 , "spritexy block" ; bl ; " " ; bx ; " " ; by
PRINT #1 , "drawsprites"
s = 2
WAIT

[pd]
bx = bx + 5
by = by + 0
PRINT #1 , "spritexy block" ; bl ; " " ; bx ; " " ; by
PRINT #1 , "drawsprites"
s = 2
WAIT

[error]
IF Err$ = "" = 0 THEN GOTO [errorup]
Err$ = "!Unknown!"

[errorup]
WindowWidth = 370
WindowHeight = 155
UpperLeftX = INT( ( DisplayWidth - WindowWidth ) / 2 )
UpperLeftY = INT( ( DisplayHeight - WindowHeight ) / 2 )
BUTTON #err.button1 , "O&k" , [button1Click] , UL , 150 , 92 , 36 , 25
STATICTEXT #err.statictext2 , "There was an error in this program but it will try to continue" , 5 , 5 , 758 , 20
STATICTEXT #err.statictext3 , "To kill the game, press 'Ctrl + Pause/Break'. " , 5 , 22 , 421 , 20
STATICTEXT #err.statictext4 , "Press 'ok' to quit." , 5 , 42 , 105 , 20
STATICTEXT #err.statictext5 , "-Adelphos Programming" , 165 , 57 , 165 , 20
OPEN "Error In program: " + Err$ FOR dialog AS #err
PRINT #err , "font ms_sans_serif 10"
PRINT #err , "trapclose [button1Click]"
OPEN "AdelError.txt" FOR OUTPUT AS #45
PRINT #45 , "Adelphos Pro(tm) Error Holder v1.0"
PRINT #45 , "Error: " + Err$
CLOSE #45
WAIT

[button1Click]
NOTICE "Error info has been saved as Adelerror.txt, Please send this to us."
END

[rm.maps]
OPEN ONGAME$ + ".log" FOR INPUT AS #kf
FOR i = 1 TO 100000
IF EOF( #kf ) <> 0 THEN EXIT FOR
LINE INPUT #kf , killme$
IF fileExists( "" , killme$ ) THEN KILL killme$
NEXT i
CLOSE #kf
KILL ONGAME$ + ".log"
RETURN

[end.all]
IF fileExists( "" , ONGAME$ + ".log" ) THEN GOSUB [rm.maps]
IF fileExists( "" , "objects.obj.log" ) = 0 THEN END
CLOSE #1
CLOSE #2
OPEN "objects.obj.log" FOR INPUT AS #kf
FOR i = 1 TO 100000
IF EOF( #kf ) <> 0 THEN EXIT FOR
LINE INPUT #kf , killme$
IF fileExists( "" , killme$ ) THEN KILL killme$
NEXT i
CLOSE #kf
KILL "objects.obj.log"
FOR i = 1 TO many
IF fileExists( "" , "map" ; i ; ".map.log" ) = 0 THEN [next.i]
OPEN "map" ; i ; ".map.log" FOR INPUT AS #kf
FOR b = 1 TO 100000
IF EOF( #kf ) <> 0 THEN EXIT FOR
LINE INPUT #kf , killme$
IF fileExists( "" , killme$ ) THEN KILL killme$
NEXT b
CLOSE #kf
KILL "map" ; i ; ".map.log"
GOTO [next.i]
END

[next.i]
NEXT i
IF fileExists( "" , ONGAME$ ) THEN KILL ONGAME$
END

[extract.bmps]
IF drivess$ = "quit" THEN END
IF TRIM$( drivess$ ) = "" THEN drivess$ = DefaultDir$
IF RIGHT$( drivess$ , 1 ) = "\" = 0 THEN drivess$ = drivess$ + "\"
IF fileExists( "" , bmpsat$ ) = 0 THEN NOTICE "Please insert next disk" + CHR$( 13 ) + "Please insert the disk that contains the file '" + bmpsat$ + "' Press 'ok' to continue."
IF fileExists( "" , bmpsat$ ) = 0 THEN END
OPEN bmpsat$ FOR INPUT AS #1
INPUT #1 , file
INPUT #1 , pass$
GOTO [top2]
END

[top2]
IF err$ = "on" THEN CLOSE #1 : err$ = "" : WAIT
INPUT #1 , filename$
IF filename$ = "endall" THEN CLOSE #1 : PRINT "Done!" : RETURN
OPEN bmpsat$ + ".log" FOR append AS #sn
PRINT #sn , filename$
CLOSE #sn
INPUT #1 , lenth$
lenth = VAL( lenth$ )
doitnow = MKDIR( drivess$ )
IF err$ = "on" THEN CLOSE #2 : CLOSE #1 : err$ = "" : WAIT
OPEN drivess$ + filename$ FOR OUTPUT AS #2
text$ = INPUT$( #1 , lenth )
PRINT #2 , text$
CLOSE #2
INPUT #1 , blank$
IF blank$ = "NEXT DISK" THEN INPUT #1 , nextdisk$ : NOTICE "Please insert the next disk to continue setup"
IF blank$ = "NEXT DISK" THEN GOTO [get.nextdisk]
GOTO [top2]
END

[get.nextdisk]
IF err$ = "on" THEN CLOSE #1 : err$ = "" : WAIT
IF fileExists( "" , nextdisk$ ) THEN GOTO [load.nextdisk]
IF fileExists( "" , nextdisk$ ) = 0 THEN NOTICE "Invailed Disk! Please insert next disk! Continue?" ; cont$
IF cont$ = "no" THEN CLOSE #1 : END
GOTO [get.nextdisk]
END

[load.nextdisk]
CLOSE #1
OPEN nextdisk$ FOR INPUT AS #1
INPUT #1 , file
INPUT #1 , pass$
GOTO [top2]
END

[functions]
DIM info$( 100 , 10 )
FUNCTION fileExists( path$ , filename$ )
FILES path$ , filename$ , info$(
fileExists = VAL( info$( 0 , 0 ) ) > 0
END FUNCTION

[get.games]
FILEDIALOG "Open game file" , "*.game" , bmpsat$
PRINT "File chosen is " ; bmpsat$
gamefile$ = bmpsat$
IF RIGHT$( bmpsat$ , 4 ) = "game" = 0 THEN NOTICE "An invalid game file was chosen, using original." : bmpsat$ = "Original.game" : IF fileExists( "" , "original.game" ) = 0 THEN NOTICE "Program missing a data file! Must close!"
IF fileExists( "" , "original.game" ) = 0 AND RIGHT$( bmpsat$ , 4 ) = "game" = 0 THEN END
RETURN

[encrypt]
cryok = 0
CURSOR hourglass
RESULT = ENCRYPTION( MODE , INFILE$ , OUTFILE$ , KEY$ )
CURSOR normal
IF RESULT = 1 THEN cryok = 1
IF RESULT = 2 THEN NOTICE "Mode not properly selected!"
IF RESULT = 3 THEN NOTICE "Source file does not exist!"
IF RESULT = 4 THEN NOTICE "Destination file already exists!"
IF RESULT = 5 THEN NOTICE "No key specified!"
RETURN
FUNCTION ENCRYPTION( MODE , INFILE$ , OUTFILE$ , KEY$ )
OPEN "MAPPEC.DLL" FOR dll AS #en
CALLDLL #en , "_ENCRYPT" , MODE AS short , INFILE$ AS ptr , OUTFILE$ AS ptr , KEY$ AS ptr , RESULT AS short
CLOSE #en
ENCRYPTION = RESULT
END FUNCTION

[get.os]
STRUCT OSVERSIONINFO , dwOSVersionInfoSize AS ulong , dwMajorVersion AS ulong , dwMinorVersion AS ulong , dwBuildNumber AS ulong , dwPlatformId AS ulong , szCSDVersion AS char[128]
L = LEN( OSVERSIONINFO.struct )
OSVERSIONINFO.dwOSVersionInfoSize.struct = L
CALLDLL #kernel32 , "GetVersionExA" , OSVERSIONINFO AS STRUCT , result AS boolean
PlatformID = OSVERSIONINFO.dwPlatformId.struct
SELECT CASE PlatformID
CASE 1
OSVersionKey$ = "Windows"
OS$ = "Windows 9X"
CASE 2
OSVersionKey$ = "Windows NT"
OS$ = "Windows NT"
CASE ELSE
NOTICE "Application Error" ; CHR$( 13 ) ; "Unsupported Operating system!"
END
END SELECT
RETURN

[loading.Screen]
NOMAINWIN
WindowWidth = 230
WindowHeight = 110
UpperLeftX = INT( ( DisplayWidth - WindowWidth ) / 2 )
UpperLeftY = INT( ( DisplayHeight - WindowHeight ) / 2 )
STATICTEXT #ld.statictext1 , LDTEXT$ , 20 , 22 , 471 , 20
STATICTEXT #ld.statictext2 , "......." , 95 , 47 , 61 , 20
OPEN "Please Wait..." FOR dialog_modal AS #ld
PRINT #ld , "font ms_sans_serif 10"
PRINT #ld , "trapclose [quit.ld]"

[ld.inputLoop]
RETURN

[quit.ld]
CLOSE #ld
WAIT
END
