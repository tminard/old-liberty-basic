'//////////////////////HOST\\\\\\\\\\\\\\\\\\\\\\
command = mkdir(left$(DefaultDir$,3)+"risknet")
open left$(DefaultDir$,3)+"risknet\talk.txt" for output AS #calling
close #calling
IF command = 1 THEN notice "There was an Error creating a network connection!":end
gosub [set.bat]
BackgroundColor$ = "black"
 ForegroundColor$ = "darkblue"
 progtitle$ = "NETWORISK(TM) HOST BETA 1 by Tyler Minard. This is an test to create a network game."
'dim nowalk$(100,2)
gosub [open.game]
run "MS7B.dll e "+chr$(34)+""+file$+""+chr$(34)+" -y", HIDE

while fileExists("","data.txt") = 0
      ' some action performing code might be placed here
wend

while fileExists("","files.txt") = 0
      ' some action performing code might be placed here
wend


dim nowalk$(1000,2)
dim info$(1000,10)
dim player1$(1,3) '1,0 = cityname; 1,1 = citylocation; 1,2 = citypop
dim player2$(1,3) '1,0 = cityname; 1,1 = citylocation; 1,2 = citypop
dim player3$(1,3) '1,0 = cityname; 1,1 = citylocation; 1,2 = citypop
dim player4$(1,3) '1,0 = cityname; 1,1 = citylocation; 1,2 = citypop
onmap$ = "data.txt"
print "Loading map config..."
gosub [load.fileop]
print "OK"
print "Load done."



loadbmp "cu","cursor.bmp"
'loadbmp "camp","camp.bmp"
'loadbmp "ryan", "ryan.bmp"
'loadbmp "back","yard.bmp"
'loadbmp "oldc", "nocamp.bmp"
'loadbmp "rock", "rock.bmp"
'loadbmp "city", "city.bmp"
dim area(1000)
dim area$(1000)
dim main$(1000)
dim player(1000)
dim adv$(10)
adv$(1) = "Visit us on the web at www.smartscript.4t.com!"
adv$(2) = "If if have any questions about this program, email us at adelphospro2000@yahoo.com!"
adv$(3) = "Program copyright (c) 2006 by Tyler Minard"
adv$(4) = "This program was written in the Liberty BASIC programming language"
adv$(5) = "www.libertybasic.com"

turn = 1
'players = 2

'\\NOTE: Some data is collected from 'data.txt' in file$.pak!


lands = 3
gosub [setup.people.Window]
turn$ = player$(1)

'Wahh, ha ha ha haaaaa!

'Cheats for player 1
defendcheat(1) = 0
attackcheat(1) = 0

'Cheats for player 2
defendcheat(2) = 0
attackcheat(2) = 0

for i = 1 to players
area$(i)=player$(i)
next i

area(1) = val(player1$(1,2))
area(2) = val(player2$(1,2))

gosub [test.shell]'This is now the default shell! (The old one sucks :-))
    print #main.g, "down; fill white; flush"
    print #main.g, "addsprite "+player1$(1,0)+"=1 city"
    print #main.g, "spritexy "+player1$(1,0)+"=1 "+player1$(1,1)
    main$(1) = "1"
     print #main.g, "addsprite "+player2$(1,0)+"=2 city"
     print #main.g, "spritexy "+player2$(1,0)+"=2 "+player2$(1,1)
     main$(2) = "2"
 '   print #main.g, "addsprite trace cu"
 '   print #main.g, "spritexy trace 0 0"
   ' camps = 2
  '  print #main.g, "addsprite range100 range100"
   ' print #main.g, "spritevisible range100 off"
    print #main.g, "addsprite cursor cu"
    print #main.g, "spritexy cursor 0 0"
    print #main.g, "spritevisible cursor off"
    print #main.g, "background back"
    gosub [add.others]
    print #main.g, "drawsprites"
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"
    print #main.g, "when mouseMove [mouse]"
    print #main.g, "when leftButtonUp [click]"
    print #main.g, "when rightButtonUp [info]"
    print #main.g, "when characterInput [inkey]"
    call ChangeCur hwnd(#main.g),"main.cur"
    value$ = "Program copyright (c) 2006 by Tyler Minard. Have Fun!"
    timer 5000, [redraw.menu]
    gosub [changeMessageBar]
[main.inputLoop]   'wait here for input event
    wait

[inkey]
keylist$ = keylist$ + Inkey$
IF len(keylist$) = 20 or Inkey$ = chr$(13) THEN keylist$ = ""
IF left$(keylist$,4) = "god1" THEN [cheat1]
IF left$(keylist$,4) = "god2" THEN [cheat2]
'IF left$(keylist$,4) = "god1" THEN gosub [cheat1]
wait

[cheat1]
    IF cheat1 = 1 THEN value$ = "Cheats have been disabled for player 1!"
    IF cheat1 = 0 THEN value$ = "Cheats have been enabled for player 1!"
    IF cheat1 = 1 THEN defendcheat(1) = 0
    IF cheat1 = 1 THEN attackcheat(1) = 0
    IF cheat1 = 0 THEN attackcheat(1) = 1
    IF cheat1 = 0 THEN defendcheat(1) = 1
    IF cheat1 = 0 THEN cheat1 = 1:keylist$ = "":gosub [changeMessageBar]:wait
    IF cheat1 = 1 THEN cheat1 = 0
    keylist$ = ""
    gosub [changeMessageBar]
    wait


[cheat2]
    IF cheat2 = 1 THEN value$ = "Cheats have been disabled for player 2!"
    IF cheat2 = 0 THEN value$ = "Cheats have been enabled for player 2!"
    IF cheat2 = 1 THEN defendcheat(2) = 0
    IF cheat2 = 1 THEN attackcheat(2) = 0
    IF cheat2 = 0 THEN attackcheat(2) = 1
    IF cheat2 = 0 THEN defendcheat(2) = 1
    IF cheat2 = 0 THEN cheat2 = 1:keylist$ = "":gosub [changeMessageBar]:wait
    IF cheat2 = 1 THEN cheat2 = 0
    keylist$ = ""
    gosub [changeMessageBar]
    wait



[add.others]
for doit = 1 to sprite
  print #main.g, "addsprite "+word$(spritesex$(doit),2,"*")+" "+word$(spritesex$(doit),3,"*")
  print #main.g, "spritexy "+word$(spritesxy$(doit),2,"*")+" "+word$(spritesxy$(doit),3,"*")
next doit
return

[redraw.menu]
time = time + 1
IF time = 4 then goto [adver]
IF goingfrom$ = "" THEN print #main.g, "drawsprites"
value$ = "Selected: "+word$(goingfrom$,1,"=")+"    Turn: "+turn$
gosub [changeMessageBar]
wait

[adver]
doad = int(rnd(1)*5) + 1
value$ = adv$(doad)
gosub [changeMessageBar]
time = 0
wait

[reset]
goingfrom$ = "":call ChangeCur hwnd(#main.g),"main.cur":attack$ = ""
print #main.g, "drawsprites"
'value$ = "Selected: NULL    Turn: "+turn$
gosub [changeMessageBar]
return

[action1]   'Perform action for the button named 'ayour own code here
IF action$ = "cancel" then goingfrom$ = "":call ChangeCur hwnd(#main.g),"main.cur":attack$ = "":gosub [reset]

    wait


[Endturn]   'Perform action for the button named 'et'
gosub [add.men]
turn = turn + 1
IF turn = players + 1 then turn = 1
turn$ = player$(turn)
gosub [reset]
print #main.g, "drawsprites"
'area(val(main$(turn))) = area(val(main$(turn))) + 10
value$ = "It is now "+turn$+"'s turn"
gosub [changeMessageBar]
'notice "It is "+turn$+"'s turn now"
    'Insert your own code here
    wait

[add.men]
area(val(main$(turn))) = area(val(main$(turn))) + 10
return

[mouse]
print #main.g, "spritexy cursor ";MouseX;" ";MouseY
print #main.g, "spritecollides cursor hc$"
cover$ = word$(hc$,1)
'print #main.g, "spritexy? "+cover$+" tmpx2 tmpy2"
'range1 = tmpx+tmpy'+tmpy'from - to
'range2 = MouseX+MouseY'+MouseY
'range = max(range1,range2) - min(range1,range2)
'print #main.a1, "Range: ";range
'print #main.s3, "Pop: ";arm
'print cover$
wait

[info]
arm = val(word$(cover$,2,"="))
print #main.g, "spritexy cursor ";MouseX;" ";MouseY
print #main.g, "spritecollides cursor hc$"
cover$ = word$(hc$,1)
IF cover$ = "" then [popup_other]:wait
IF instr(cover$,"camp") then popupmenu "&Build City", [build.city],|,"&Information", [show.Info]:wait

IF instr(lower$(cover$),"rock") THEN wait'popupmenu "&Information", [rock.info]:wait',"&Information", [show.Info]:wait

popupmenu "&Make Capital", [mk.cap],|,_
           "&Information", [show.Info]
wait

[popup_other]
    popupmenu   "Make City" , [build.city.sub],_
                "Build Camp", [build.camp],_
                "Unselect Selected", [reset.sub],|,_
                "End Turn"  , [Endturn]
                wait
[build.camp]
IF goingfrom$ = "" THEN wait
'IF instr(goingfrom$,"camp") = 0 THEN wait
popupcamp = 1
goto [camp]
wait

[mk.cap]
doitto = val(word$(hc$,2,"="))
gosub [reset]
IF area$(doitto) = turn$ = 0 THEN value$ = "This city is under the command of "+area$(doitto):gosub [changeMessageBar]:wait
main$(turn) = str$(doitto)
value$ = "City "+word$(hc$,1,"=")+" is now the capital!"
gosub [changeMessageBar]
wait

[rock.info]
notice "Information"+chr$(13)+"This land contains lots and lots of rocks."+chr$(13)+"You cannot build anything on rocks."
wait

[show.Info]
IF turn$ = area$(arm) = 0 THEN showpop$ = "Population: Unknown"
IF turn$ = area$(arm) THEN showpop$ = "Population: ";area(arm)
notice "Information"+chr$(13)+"Name: "+word$(cover$,1,"=")+chr$(13)+"Run by: "+area$(arm)+chr$(13)+showpop$
wait

[build.city]
'notice "WAIT!"
IF area$(arm) = turn$ = 0 THEN value$ = "This area is not yours to command!":gosub [changeMessageBar]:wait
IF area(arm) < 50 then value$ = "You need AT LEST 50 men in this camp to build a city!":gosub [changeMessageBar]:wait
prompt "What do you want to name this city: ";namme$
IF instr(namme$," ") THEN notice "City names cannot contain spaces (yet!)":goto [build.city]
IF trim$(namme$) = "" THEN value$ = "No city built":gosub [changeMessageBar]:wait
tmptx$ = word$(hc$,2,"=")
print #main.g, "spritexy? "+hc$+" tmx tmy"
print #main.g, "removesprite "+hc$
print #main.g, "addsprite "+namme$+"="+tmptx$+" city"
print #main.g, "spritexy "+namme$+"="+tmptx$+" ";tmx;" ";tmy
print #main.g, "drawsprites"
area(arm) = area(arm) + 10
value$ = "City "+namme$+" created!"
gosub [changeMessageBar]
gosub [add.men]
turn = turn + 1
IF turn = players + 1 then turn = 1
turn$ = player$(turn)
gosub [reset]
'value$ = "It is "+turn$+"'s turn now"
'gosub [changeMessageBar]


wait

[is.block]
bfound = 0
for iii = 1 to 10000
 IF nowalk$(iii,1) = "" THEN exit for
 IF instr(lower$(hc$),lower$(nowalk$(iii,1))) THEN bfound = 1:value$ = nowalk$(iii,2):gosub [changeMessageBar]:exit for
 next iii
return

[click]
'print #main.g, "spritexy? "+goingfrom$+" tmpx tmpy"
'print #main.g, "spritexy? "+cover$+" tmpx2 tmpy2"
' print #main.a1, MouseX;" ";MouseY
arm = val(word$(cover$,2,"="))
'IF goingfrom$ = "" = 0 AND instr(lower$(cover$),"water") or instr(lower$(cover$),"rock") then value$ = "Information: Rocky Ground, You can't build anything on this ground":gosub [changeMessageBar]:wait
gosub [is.block]
IF bfound = 1 then wait
IF cover$ = "" AND instr(goingfrom$,"camp") THEN [set.camp]
IF cover$ = "" AND goingfrom$ = "" = 0 THEN [popup_other]:wait'goto [camp]:wait
IF left$(goingfrom$,4) = "camp" THEN [send.ar]
IF cover$ = "" THEN value$ = "Information: Grassland, You may build cities and camps here":gosub [changeMessageBar]:wait
IF goingfrom$ = ""  AND area$(arm) = turn$ = 0 THEN value$ = "You do not own that area! (Yet!)":gosub [changeMessageBar]:wait
if goingfrom$ = "" THEN goingfrom$ = cover$:ClickX = MouseX:ClickY = MouseY:value$ = "Selected: "+word$(goingfrom$,1,"=")+"    Turn: "+turn$:gosub [changeMessageBar]:call ChangeCur hwnd(#main.g),"man.cur":action$ = "cancel":gosub [selected.ob]:wait
IF goingfrom$ = "" = 0 THEN [attack]
wait

[selected.ob]
'Prog goes here every time you click something and it becomes selected
'NOTE: DO NOT add a 'drawsprites' command after this one! (in this branch, anyway)
print #main.g, "drawsprites"'Last one for this branch. (If you add any more, the circle will
'not be visible)

print #main.g, "up"
print #main.g, "goto ";ClickX;" ";ClickY
print #main.g, "down"
print #main.g, "circle 100"
print #main.g, "flush"

print #main.g, "segment drawSegment"'this line & next line keeps mem from being used up
print #main.g, "delsegment "; drawSegment - 1
'print #main.g, "drawsprites"
return

[set.camp]
fromcc = 1
goto [camp]
notice "DudE!"
wait

[send.ar]
'print #main.g, "spritexy? "+goingfrom$+" tmpx tmpy"
'print #main.g, "spritexy? "+cover$+" tmpx2 tmpy2"
range1 = ClickX'+tmpy'+tmpy'from - to
range2 = MouseX'+MouseY'+MouseY
rangex = max(range1, range2) - min(range1,range2)
range1 = ClickY
range2 = MouseY
rangey = max(range1, range2) - min(range1,range2)
'range = range2 / range1
range = rangex+rangey
'notice "Range: ";rangex+rangey';" by ";rangey
IF range > 150 then value$ = "That sight is too far!":gosub [changeMessageBar]:wait
fromc = 1
goto [attack]
wait

[can.attackq]
range1 = ClickX'+tmpy'+tmpy'from - to
range2 = MouseX'+MouseY'+MouseY
rangex = max(range1, range2) - min(range1,range2)
range1 = ClickY
range2 = MouseY
rangey = max(range1, range2) - min(range1,range2)
'range = range2 / range1
range = rangex+rangey
notnear = 0
'notice range
IF range > 150 then notnear = 1
return

[attack]
print #main.g,"spritecollides "+goingfrom$+" am$"
IF cover$ = "" then wait
atfrom = val(word$(goingfrom$,2,"="))
atto = val(word$(cover$,2,"="))
'notice area$(atfrom)+" "+area$(atto)
IF area$(atfrom) = area$(atto) THEN goto [reforce]
gosub [can.attackq]
IF notnear = 1 then value$ = word$(goingfrom$,1,"=")+" cannot attack "+word$(cover$,1,"="):gosub [changeMessageBar]:wait
'IF instr(am$,cover$) = 0 AND fromc = 0 THEN value$ = word$(goingfrom$,1,"=")+" cannot attack "+word$(cover$,1,"="):gosub [changeMessageBar]:wait

fromc = 0
IF goingfrom$ = "" = 0 THEN attack$ = cover$':print #main.s2, "Turn: "+turn$

atfrom = val(word$(goingfrom$,2,"="))
atto = val(word$(attack$,2,"="))

confirm "Attack "+word$(attack$,1,"=")+" ("+area$(atto)+") from "+word$(goingfrom$,1,"=")+"?";QA$
IF QA$ = "no" THEN attack$ = "":wait
IF area(atfrom) < 2 THEN value$ = "Sir! We need more solders here!":gosub [changeMessageBar]:wait
IF area(atto) = 0 THEN [mov]
defender = area(atto)
attacker = area(atfrom)
gosub [attack.core]
'doit = attack(area(atfrom),area(atto))
IF attack > 1 then notice "Mission Accomplished!":area(atfrom) = a:goto [mov]:end
IF attack = 1 then notice "Ahh! All our troops but one have fallen! Fall Back!!":area(atfrom) = 1:area(atto) = b
'IF attack = 1 = 0 AND attack = 2 = 0 THEN notice "Attack Error!"
gosub [add.men]
turn = turn + 1
IF turn = players + 1 then turn = 1
turn$ = player$(turn)
gosub [reset]
value$ = "It is "+turn$+"'s turn now":gosub [changeMessageBar]
wait

[reforce]
gosub [can.attackq]
IF notnear = 1 then value$ = word$(goingfrom$,1,"=")+" is to far from "+word$(cover$,1,"="):gosub [changeMessageBar]:wait
QA = 0
willyou = 100 - area(atto)
IF area(atfrom) < willyou THEN upto = area(atfrom)
IF area(atfrom) > willyou or area(atfrom) = willyou THEN upto = willyou
IF instr(cover$, "camp") THEN prompt "Fiendly Area"+chr$(13)+"Transport: (up to "+str$(upto)+")";QA
IF instr(cover$, "camp") = 0 THEN prompt "Fiendly Area"+chr$(13)+"Transport: (up to "+str$(area(atfrom))+")";QA
upto = 0
QA = val(using("###########.", QA))
IF QA < 1 THEN value$ = "Action Canceled":gosub [changeMessageBar]:gosub [reset]:wait
IF QA > area(atfrom) THEN notice "We do not have that many men to move!":goto [reforce]:wait
':print #main.g, "addsprite "+goingfrom$+" oldc"
IF instr(cover$, "camp") AND area(atto) + QA > 100 THEN notice "Sir, Our camps can only hold up to 100 troops":goto [reforce]
area(atfrom) = area(atfrom) - QA
IF area(atfrom) = 0 AND instr(goingfrom$,"camp") THEN print #main.g, "addsprite "+goingfrom$+" oldc"
area(atto) = area(atto) + QA
area(atto) = val(using("###########.", area(atto)))

area(atfrom) = val(using("###########.", area(atfrom)))
IF area(atfrom) = 0 THEN area$(atfrom) = "Unclaimed Land"
value$ = "Move successful"
gosub [changeMessageBar]
print #main.g, "drawsprites"
goto [Endturn]
wait

[camp]
'print #main.g, "spritexy? "+goingfrom$+" tmpx tmpy"
'print #main.g, "spritexy? "+cover$+" tmpx2 tmpy2"
range1 = ClickX'+tmpy'+tmpy'from - to
range2 = MouseX'+MouseY'+MouseY
rangex = max(range1, range2) - min(range1,range2)
range1 = ClickY
range2 = MouseY
rangey = max(range1, range2) - min(range1,range2)
'range = range2 / range1
range = rangex+rangey
'notice "Range: ";rangex+
IF range > 150 THEN value$ = "We cannot set up a camp here. That spot is too far away.":gosub [changeMessageBar]:wait
IF popupcamp = 1 THEN QA$ = "yes"
IF popupcamp = 0 THEN confirm "The land that you have selected is empty. Would you like us to set up a camp?";QA$
popupcamp = 0
IF QA$ = "no" THEN wait
camps = camps + 1
lands = lands + 1
goto [reprompt]
end

[reprompt]
QA = 0
upto = 0
atfrom = val(word$(goingfrom$,2,"="))
IF fromcc = 1 THEN QA = area(atfrom)
IF area(atfrom)-2 = 100 THEN upto = area(atfrom)-2
IF area(atfrom)-2 < 100 THEN upto = area(atfrom)-2
IF area(atfrom)-2 > 100 THEN upto = 100
IF fromcc = 0 THEN prompt "Move: (up to "+str$(upto)+") ";QA
QA = val(using("###########.", QA))
IF QA = 0 THEN lands = lands - 1:camps = camps - 1:wait
IF QA > area(atfrom)-2 AND fromcc = 0 THEN notice "Sir! We do not have that many men to move!":goto [reprompt]
IF QA > area(atfrom) AND fromcc = 1 THEN notice "Sir! We do not have that many men to move!":goto [reprompt]
IF QA < 0 THEN [reprompt]
IF QA > 100 THEN notice "Sir, Our camps can only hold up to 100 troops":goto [reprompt]
fromcc = 0
area$(lands) = turn$
area(lands) = QA
area(atfrom) = area(atfrom) - QA
IF area(atfrom) = 0 THEN value$ = "Old camp abandoned!":gosub [changeMessageBar]:area$(atfrom) = "Unclaimed Land":print #main.g, "addsprite "+goingfrom$+" oldc"
IF area(lands) - 5 < 1 = 0 THEN area(lands) = area(lands) - 5'taxation :-) There is a workaround tax. First you mk a camp w/ 1 guy, then you transport more over on next turn.

area(lands) = val(using("###########.", area(lands)))
area(atfrom) = val(using("###########.", area(atfrom)))

print #main.g, "addsprite camp";camps;"=";lands;" camp"
print #main.g, "spritexy camp";camps;"=";lands;" ";MouseX;" ";MouseY
print #main.g, "drawsprites"
goto [Endturn]
wait

[traceit]
print #main.g, "spritexy? "+goingfrom$+" trx try"
print #main.g, "spritexy? "+attack$+" trx2 try2"
print #main.g, "spritexy trace ";trx;" ";try
print #main.g, "spritetravelxy trace ";trx2;" ";try2;" 1 [trace.stop]";
ntrace = 0
for i = 1 to 1000000000
  print #main.g, "spritecollides trace trace$"
  IF trace$ = "" AND instr(trace$,goingfrom$) = 0 AND instr(trace$,attack$) = 0 THEN ntrace = 1:exit for
  IF instr(trace$,attack$) THEN exit for
   print #main.g, "drawsprites"
   next i
IF ntrace = 0 then return
notice "Sorry, But something is blocking the road."
return

[trace.stop]
wait

[mov]
IF area(atfrom) = 100 THEN upto = area(atfrom)
IF area(atfrom) < 100 THEN upto = area(atfrom)
IF area(atfrom) > 100 THEN upto = 100
IF instr(attack$,"camp") = 1 THEN prompt "Move: (up to "+str$(upto)+") ";QA
IF instr(attack$,"camp") = 0 THEN prompt "Move: (up to "+str$(area(atfrom))+") ";QA
QA = val(using("###########.", QA))
IF instr(attack$,"camp") = 1 AND QA > 100 THEN notice "Our camps can only hold up to 100 troops!":goto [mov]
IF QA = area(atfrom) THEN confirm "Abandon "+word$(goingfrom$,1,"=")+"?";QA$:IF QA$ = "no" THEN goto [mov]
IF QA > area(atfrom) THEN notice "We do not have that many troops!":goto [mov]:end
IF QA < 0 THEN notice "Sir! We are in no condition to kill our own guys!":goto [mov]:end
'gosub [traceit]
'IF ntrace = 1 then wait
area(atto) = QA
IF QA = 0 = 0 THEN area$(atto) = area$(atfrom)
IF QA = 0 THEN area$(atto) = "Unclaimed Land"
IF area(atfrom) - QA = 0 AND instr(goingfrom$, "camp") THEN print #main.g, "addsprite "+goingfrom$+" oldc"
area(atfrom) = area(atfrom) - QA
IF turn + 1 = players + 1 = 0 THEN nextplayer$ = player$(turn+1)
IF turn + 1 = players + 1 THEN nextplayer$ = player$(1)
value$ = "You have moved ";QA;" troops from "+word$(goingfrom$,1,"=")+" to "+word$(attack$,1,"=")+". It is now "+nextplayer$+"'s turn"
'notice "You have moved ";QA;" troops from "+word$(goingfrom$,1,"=")+" to "+word$(attack$,1,"=")'+"! It is now "+turn$+"'s turn"
IF instr(goingfrom$,"camp") AND area(atfrom) = 0 then print #main.g, "addsprite "+goingfrom$+" oldc":print #main.g, "drawsprites"
IF instr(attack$,"camp") AND area(atto) = 0 = 0 THEN print #main.g, "addsprite "+attack$+" camp":print #main.g, "drawsprites"
IF area(atfrom) = 0 = 0 AND instr(goingfrom$,"camp") THEN print #main.g, "addsprite "+goingfrom$+" camp":print #main.g, "drawsprites"
IF area(atfrom) = 0 THEN area$(atfrom) = "Unclaimed Land"
IF area(atto) = 0 = 0 AND instr(attack$,"camp") THEN print #main.g, "addsprite "+attack$+" camp":print #main.g, "drawsprites"
'IF area(atto) = 0 = 0 THEN print #main.g, "addsprite "+attack$+" oldc":print #main.g, "drawsprites"
area(atto) = val(using("###########.", area(atto)))
area(atfrom) = val(using("###########.", area(atfrom)))
gosub [add.men]
turn = turn + 1
IF turn = players + 1 then turn = 1
turn$ = player$(turn)
gosub [reset]
'value$ = "You have moved ";QA;" troops from "+word$(goingfrom$,1,"=")+" to "+word$(attack$,1,"=")+"! It is now "+turn$+"'s turn"
'gosub [changeMessageBar]
'value$ = "It is "+turn$+"'s turn now"
'gosub [changeMessageBar]
wait

[override.cheat]
attackcheat(turn) = 0
defendcheat(turn) = 0
attackcheat(seep) = 0
defendcheat(seep) = 0
IF seep = 1 then cheat1 = 0
IF seep = 2 then cheat2 = 0
IF turn = 1 then cheat1 = 0
if turn = 2 then cheat2 = 0
value$ = "Cheat code conflict! Resetting cheats!"
gosub [changeMessageBar]
return

[attack.core] 'Here is the CORE of the program's attack system (Ha! This IS the Attack system!)
a = attacker
b = defender
attacked = val(word$(attack$,2,"="))
attacked$ = area$(attacked)
seep = 0'see player
for ga = 1 to players
  seep = seep + 1
  IF area$(attacked) = area$(ga) THEN exit for
next ga
IF attackcheat(turn) = 1 AND defendcheat(seep) = 1 then gosub [override.cheat]
for bb = 1 to 1000000000000000000000000000
 dicea = int(rnd(1)*6) + 1'attack
 diceb = int(rnd(1)*6) + 1'defend
 IF a = 1 THEN attack = 1:exit for'You lost
 IF b = 0 THEN attack = a:exit for'You won!
 IF dicea > diceb AND defendcheat(seep) = 0 THEN b = b - 1
 IF dicea < diceb AND attackcheat(turn) = 0 THEN a = a - 1
 IF dicea = diceb AND attackcheat(turn) = 0 then a = a - 1
 value$ = "Attacker: ";a;" Defender: ";b
 at= SendMessagePtr(hStatusBar,_WM_SETTEXT,0,value$)
next bb
return

function fileExists(path$, filename$)

  files path$, filename$, info$()
  fileExists = val(info$(0, 0))  'non zero is true
end function

[quit.main] 'End the program
    value$ = "Thanks for Playing!"
    gosub [changeMessageBar]
    timer 0
    timer 900, [end]
    wait

    [end]
    timer 0
    a= SendMessageLong(hStatusBar,_WM_DESTROY,0,0) 'Destroy the statusbar
    close #main
    goto [quit.all]
    end

[quit.all]
open "files.txt" for input AS #1
for i = 1 to 100000000
IF eof(#1) <> 0 then exit for
 line input #1, killt$
 IF fileExists("",killt$) then kill killt$
 next i
close #1
KILL "files.txt"
gosub [unload.share]
end

[unload.share]
open "setnet.bat" for output AS #batt
print #batt,"net share risk /delete"
close #batt
run "setnet.bat", HIDE
command = rmdir(left$(DefaultDir$,3)+"risknet\")
IF command <> 0 then print "Ignore"
return

sub ChangeCur h,cursor$
'h=hwnd(#1) 'window handle
'cursor$ = DefaultDir$ + "\liberty.cur"
'load cursor
calldll #user32, "LoadImageA",_
0 as long,_            'instance - use 0 for image from file
cursor$ as ptr,_       'path and filename of image
_IMAGE_CURSOR as long,_'type of image
0 as long,_            'desired width
0 as long,_            'desired height
_LR_LOADFROMFILE as long,_  'load flag = load-from-file
hCursor as ulong        'handle of cursor

calldll #user32,"SetClassLongA",_
h as ulong,_            'window handle
_GCL_HCURSOR as long,_ 'flag to change cursor
hCursor as ulong,_     'handle of cursor
r as long
end sub


[test.shell]


    nomainwin
    WindowWidth = 835
    WindowHeight = 510
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    graphicbox #main.g,   5,   5, 819, 430

    '-----End GUI objects code

    '-----Begin menu code

    menu #main, "File","Exit", [quit.main]

    menu #main, "Actions",_
                "Make City" , [build.city.sub],_
                "Unselect Selected", [reset.sub],|,_
                "End Turn"  , [Endturn]


    '-----End menu code

    open progtitle$ for window_nf as #main
    print #main.g, "down; fill white; flush"
    print #main, "font ms_sans_serif 10"

    '----Begin code for statusbar

    h=hwnd(#main)
    value$ = "Put your statusbar message here.  Change it with [changeMessageBar]"
    styleValue = _WS_VISIBLE or _WS_CHILD
    hStatusBar=initalizeStatusBar(h,value$)
    print #main, "resizehandler [resizeStatusbar]"

    '----End code for statusbar

    print #main, "trapclose [quit.main]"


'[main.inputLoop]   'wait here for input event
    return

[reset.sub]
gosub [reset]
wait




[build.city.sub]   'Perform action for menu Actions, item Build Camp
IF instr(goingfrom$,"camp") = 0 THEN value$ = "You can't turn "+word$(goingfrom$,1,"=")+" into a city":gosub [changeMessageBar]:wait
goto [build.city]
    wait


'[build.city]   'Perform action for menu Actions, item Make City

    'Insert your own code here

    wait


'[Endturn]   'Perform action for menu Actions, item End Turn

    'Insert your own code here

    wait

[changeMessageBar]
timer 0
    '----This changes the text in the statusbar
    '----Change the text in value$ then gosub this routine
   ' value$="New Text"
    a= SendMessagePtr(hStatusBar,_WM_SETTEXT,0,value$)
timer 5000, [redraw.menu]
    return

[set.bat]
open "setnet.bat" for output AS #batt
print #batt,"net share risk="+left$(DefaultDir$,3)+"risknet"
close #batt
run "setnet.bat", HIDE
return


'[quit.main] 'End the program

  '  a= SendMessageLong(hStatusBar,_WM_DESTROY,0,0) 'Destroy the statusbar
  '  close #main
  '  end


'------------------------------------------------------
'----------------- Subs and Functions -----------------
'------------------------------------------------------

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


'------------------------------------------------------
'--------------- End Subs and Functions ---------------
'------------------------------------------------------





[setup.people.Window]

    '-----Begin code for #people

    nomainwin
    WindowWidth = 260
    WindowHeight = 385
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    ListboxColor$ = "white"
    listbox #people.listbox1, player$(, [confirm.play],    5,   5, 235, 220
    statictext #people.statictext2, "Selected: ",   0, 232, 250,  20
    button #people.button3,"Add Player",[add.play], UL,   5, 257,  96,  25
    button #people.button4,"Remove Player",[rmplay], UL, 125, 257, 105,  25
    button #people.button5,"Play!",[Play], UL,  65, 317,  96,  25

    '-----End GUI objects code

    open "Players" for dialog_nf_modal as #people
    print #people, "font ms_sans_serif 10"
    print #people, "trapclose [quit.people]"


[people.inputLoop]   'wait here for input event
    wait



[confirm.play]   'Perform action for the listbox named 'listbox1'
#people.listbox1, "selection? sel$"
IF sel$ = "" then wait
#people.statictext2, "Selected: "+sel$

    wait


[add.play]   'Perform action for the button named 'button3'
prompt "Player's Name: ";QA$
IF trim$(QA$) = "" then wait
players = players + 1
player$(players) = QA$
print #people.listbox1, "reload"

    wait


[rmplay]   'Perform action for the button named 'button4'



    wait


[Play]   'Perform action for the button named 'button5'
IF players < 2 THEN notice "You need at lest 2 players!":wait
IF players > 2 THEN notice "Only 2 players are supported right now!":wait
close #people
return

[quit.people] 'End the program
    close #people
    goto [quit.all]
    end





[load.fileop]
open onmap$ for input AS #1
gosub [get.line]
'dim object$(1000)
dim images$(1000)
dim lplay$(1000)
dim spritesex$(1000)
dim spritesxy$(1000)
gosub [fill.in]
close #1
'print control$(3)
return

[fill.in]
IF eof(#1) <> 0 THEN return
IF trim$(txtline$) = "" THEN line input #1, txtline$:goto [fill.in]

IF left$(txtline$,1) = "$" AND right$(txtline$,len(txtline$)-1)= "sprites" THEN [sprites]
IF left$(txtline$,1) = "$" AND right$(txtline$,len(txtline$)-1)= "images" THEN [images]
IF left$(txtline$,1) = "$" AND right$(txtline$,len(txtline$)-1)= "nowalk" THEN [nowalk]
IF left$(txtline$,1) = "$" AND word$(right$(txtline$,len(txtline$)-1),1,"=") = "players" THEN [players]
'obj = obj + 1
line input #1, txtline$
goto [fill.in]
end

[sprites]
line input #1, txtline$
IF txtline$ = "ENDBLOCK" THEN line input #1, txtline$:goto [fill.in]
IF trim$(txtline$) = "" THEN [sprites]
'\\actions go here
IF word$(txtline$,1,"*") = "addsprite" THEN sprite = sprite +1:spritesex$(sprite) = txtline$
IF word$(txtline$,1,"*") = "spritexy" THEN spritesxy$(sprite) = txtline$
'\\End actions
goto [sprites]
end


[images]
line input #1, txtline$
IF txtline$ = "ENDBLOCK" THEN line input #1, txtline$:goto [fill.in]
IF trim$(txtline$) = "" THEN [images]
'\\actions go here
bimpname$ = word$(txtline$,1,"=")
  bimppath$ =  word$(txtline$,2,"=")
loadbmp bimpname$,bimppath$
'\\End actions
goto [images]
end

[nowalk]
line input #1, txtline$
IF txtline$ = "ENDBLOCK" THEN line input #1, txtline$:goto [fill.in]
IF trim$(txtline$) = "" THEN [nowalk]
nowalk = nowalk + 1
'\\actions go here
nowalk$(nowalk, 1) = word$(txtline$,1,"=") 'scan this...
nowalk$(nowalk, 2) = word$(txtline$,2,"=") 'Display that...
'\\End actions
goto [nowalk]
end

[players]
line input #1, txtline$
IF txtline$ = "ENDBLOCK" THEN line input #1, txtline$:goto [fill.in]
IF trim$(txtline$) = "" THEN [players]
'\\actions go here
IF word$(txtline$,1,"=") = "player1" THEN player1$(1,0) = word$(txtline$,2,"="): player1$(1,1) = word$(txtline$,3,"="): player1$(1,2) = word$(txtline$,4,"=")
IF word$(txtline$,1,"=") = "player2" THEN player2$(1,0) = word$(txtline$,2,"="): player2$(1,1) = word$(txtline$,3,"="): player2$(1,2) = word$(txtline$,4,"=")
IF word$(txtline$,1,"=") = "player3" THEN player3$(1,0) = word$(txtline$,2,"="): player3$(1,1) = word$(txtline$,3,"="): player3$(1,2) = word$(txtline$,4,"=")
IF word$(txtline$,1,"=") = "player4" THEN player4$(1,0) = word$(txtline$,2,"="): player4$(1,1) = word$(txtline$,3,"="): player4$(1,2) = word$(txtline$,4,"=")
'\\End actions
goto [players]
end


'notice object$(obj)


[get.line]
line input #1, txtline$
IF left$(txtline$,3) = "REM" or left$(txtline$,2) = "//" THEN goto [get.line]
return

[kilgw]
IF graphopen = 1 THEN close #gw
graphopen = 0
wait


[open.game]
filedialog "Open Game Level", "*.pak", file$
IF trim$(file$) = "" THEN gosub [unload.share]:end
print "File chosen is ";file$
return

IF trim$(file$) = "" THEN end
name "MS7B.dll" AS "MS7B.exe"
SEEMASKNOCLOSEPROCESS = 64 '0x40

Struct s,_
cbSize as long,_
fMask as long,_
hwnd as long,_
lpVerb$ as ptr,_
lpFile$ as ptr,_
lpParameters$ as ptr ,_
lpDirectory$ as ptr,_
nShow as long,_
hInstApp as long,_
lpIDList as long,_
lpClass as long,_
hkeyClass as long,_
dwHotKey as long,_
hIcon as long,_
hProcess as long

s.cbSize.struct=len(s.struct)
s.fMask.struct=SEEMASKNOCLOSEPROCESS
s.hwnd.struct=0
s.lpVerb$.struct="Open"
s.lpFile$.struct="MS7B.exe"
s.lpParameters$.struct="e "+file$+" -y"
s.lpDirectory$.struct=DefaultDir$
s.nShow.struct=_SW_HIDE

calldll #shell32 , "ShellExecuteExA",_
s as struct,r as long

if r<>0 then
    hProcess=s.hProcess.struct
else
    notice "Error."
    end
end if

waitResult=-1
while waitResult<>0
calldll #kernel32, "WaitForSingleObject",_
hProcess as long,0 as long,_
waitResult as long
wend

print "Launched process has ended"
name "MS7B.exe" AS "MS7B.dll"
return

