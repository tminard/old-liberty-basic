dim field$(8000,100)
'field$(x,0) = x location
'field$(x,1) = y location
'field$(x,2) = name
'field$(x,3) = what happens

loadbmp "dirt1","dirt1.bmp"
loadbmp "grass1","grass.bmp"
loadbmp "man1","man.bmp"
loadbmp "water","water.bmp"
loadbmp "mouse", "mouse.bmp"
loadbmp "selected","selected.bmp"
loadbmp "hide", "hide.bmp"
loadbmp "check", "check.bmp"



    WindowWidth = 550
    WindowHeight = 410

    graphicbox #main.graph, 26, 16, 504, 350
    open "Game" for window_nf as #main
    print #main.graph, "fill white; flush"
    print #main, "trapclose [end]"
    print #main.graph, "when characterInput [key]"
    'print #main.graph, "when leftButtonUp [leftm.cl]"
    'print #main.graph, "when mouseMove [mouse.m]"
    print #main, "font ms_sans_serif 0 16"

goto [load.sprites]
wait

[end]
close #main
end

[load.sprites]
'Load root location!
rootx = 0
rooty = 0
gosub [load.map]
gosub [show.current]
print #main.graph, "drawsprites"
wait

[key]
IF Inkey$ = "w" then [w]
IF Inkey$ = "s" then [s]
IF Inkey$ = "d" then [d]
IF Inkey$ = "a" then [a]
wait

[w]
IF rooty = 0 then wait
rooty = rooty - 30
gosub [show.current]
print #main.graph, "drawsprites"
wait

[s]
IF rooty = 30*mapy then wait
rooty = rooty + 30
gosub [show.current]
print #main.graph, "drawsprites"
wait

[d]
IF rootx = 30*mapx then wait
rootx = rootx + 30
gosub [show.current]
print #main.graph, "drawsprites"
wait

[a]
IF rootx = 0 then wait
rootx = rootx - 30
gosub [show.current]
print #main.graph, "drawsprites"
wait

[show.current]
showx = rootx + 510
showy = rooty + 510
for showcurrent = 1 to tile
hideit = 1
    IF val(field$(showcurrent,0)) < showx and val(field$(showcurrent,0)) > rootx and val(field$(showcurrent,1)) < showy and val(field$(showcurrent,1)) > rooty then
     print #main.graph, "spritevisible dirt";showcurrent;" on"
     hideit = 0
    end if
IF hideit = 1 then print #main.graph, "spritevisible dirt";showcurrent;" off"
next showcurrent
return

[random.texture]
pickme = int(rnd(1)*5)
select case pickme
 case 1
    chosenText$ = "grass1"
    hitAction$ = ""
 case 2
    chosenText$ = "dirt1"
    hitAction$ = ""
 case 3
    chosenText$ = "water"
    hitAction$ = "stop"
 case 4
    chosenText$ = "grass1"
    hitAction$ = ""
 case 5
    chosenText$ = "grass1"
    hitAction$ = ""
end select
return

[load.map]
'Map size in 30x30p squares!
mapx = 34
mapy = 34
frames = mapx/17

for frameload = 1 to frames
for ymap = 1 to 17
        for xmap = 1 to 17
         tile = tile + 1
         gosub [random.texture]
         field$(tile,0) = str$(onx)
         field$(tile,1) = str$(ony)
         field$(tile,2) = chosenText$
         field$(tile,3) = hitAction$
         print #main.graph, "addsprite dirt";tile;" "+chosenText$
         print #main.graph, "spritexy dirt";tile;" ";fakeonx;" ";fakeony
         print #main.graph, "spritevisible dirt";tile;" off"
         onx = onx + 30
         fakeonx = fakeonx + 30
        next xmap
    ony = ony + 30
    fakeony = fakeony + 30
    onx = 0
    fakeonx = 0
next ymap
fakeony = 0
fakeonx = 0
next frameload
return



