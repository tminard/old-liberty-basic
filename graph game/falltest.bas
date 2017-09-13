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


nomainwin

    WindowWidth = 550
    WindowHeight = 410

    graphicbox #main.graph, 26, 16, 504, 350
    open "Game" for window_nf as #main
    print #main.graph, "fill white; flush"
    print #main, "trapclose [end]"
    print #main.graph, "when characterInput [key]"
    print #main.graph, "when leftButtonUp [leftm.cl]"
    print #main.graph, "when mouseMove [mouse.m]"
    print #main, "font ms_sans_serif 0 16"


goto [load.sprites]
wait



[end]
timer 0
close #main
end

[leftm.cl]
print #main.graph, "spritecollides mouse mouse$"
print #main.graph, "spritexy? "+word$(mouse$,1)+" mx my"
print #main.graph, "spritexy selected ";mx;" ";my
print #main.graph, "spritevisible selected on"
selected$ = word$(mouse$,1)
wait

[key]
IF Inkey$ = "w" then [up]
IF Inkey$ = "s" then [down]
IF Inkey$ = "d" then [right]
IF Inkey$ = "a" then [left]
wait

[mouse.m]
print #main.graph, "spritexy mouse ";MouseX;" ";MouseY
wait

[right]
print #main.graph, "spritexy? dirt";ons; " x y"
x = x + 30
print #main.graph, "spritexy man1 ";x;" ";y
print #main.graph, "spritecollides man1 list$";
IF list$ = "" then [stay]
print #main.graph, "spritexy? "+list$+" x y"

IF field$(val(word$(list$,2,"dirt")),0) = "stop" then [stay]
ons = val(word$(list$,2,"dirt"))
gosub [same]
IF field$(ons,0) = "die" then [die]
wait

[stay]
print #main.graph, "spritexy? dirt";ons; " x y":print #main.graph, "spritexy man1 ";x;" ";y:wait
wait

[die]
print #main.graph, "drawsprites"
notice "You died!"
goto [end]
end

[same]'This branch is common in all movement keys
return

[left]
print #main.graph, "spritexy? dirt";ons; " x y"
x = x - 30
print #main.graph, "spritexy man1 ";x;" ";y
print #main.graph, "spritecollides man1 list$";
IF list$ = "" then [stay]
print #main.graph, "spritexy? "+list$+" x y"
IF field$(val(word$(list$,2,"dirt")),0) = "stop" then [stay]
ons = val(word$(list$,2,"dirt"))
gosub [same]
IF field$(ons,0) = "die" then [die]
wait

[up]
IF ons - 1 < 0 then wait
IF field$(ons - 1,0) = "stop" then [stay]
ons = ons - 1
print #main.graph, "spritexy? dirt";ons; " x y"
print #main.graph, "spritexy man1 ";x;" ";y
gosub [same]
IF field$(ons,0) = "die" then [die]
wait

[down]
IF ons + 1 > 203 then wait
IF field$(ons + 1,0) = "stop" then [stay]
ons = ons + 1
print #main.graph, "spritexy? dirt";ons; " x y"
print #main.graph, "spritexy man1 ";x;" ";y
gosub [same]
IF field$(ons,0) = "die" then [die]
wait

[load.sprites]
while onsquareX = 510 = 0
for i = 1 to 12
tmp = int(rnd(1)*4) + 1
 IF tmp = 1 then chosen$ = "dirt1"
 IF tmp = 2 then chosen$ = "grass1"
 IF tmp = 3 then chosen$ = "water"
 IF tmp = 4 then chosen$ = "dirt1"
 IF tmp = 3 then field$(is,0) = "die"
print #main.graph, "addsprite dirt";is;" "+chosen$
print #main.graph, "spritexy dirt";is;" ";onsquareX;" ";onsquareY
field$(is,1) = "hide"
onsquareY = onsquareY + 30
is = is + 1
next i
hidden = is - 1
onsquareX = onsquareX + 30
onsquareY = 0
wend

 print #main.graph, "addsprite man1 man1"
 ons = 0
 print #main.graph, "spritexy? dirt";ons; " x y"
 print #main.graph, "spritexy man1 ";x;" ";y
print #main.graph, "addsprite mouse mouse"
print #main.graph, "spritexy mouse ";MouseX;" ";MouseY
print #main.graph, "addsprite selected selected"
print #main.graph, "spritevisible selected off"
print #main.graph, "addsprite check check"
print #main.graph, "spritexy check ";x;" ";y
field$(0,1) = "view"
print #main.graph, "drawsprites"
timer 100, [draw]
wait

[draw]
print #main.graph, "drawsprites"
wait



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


