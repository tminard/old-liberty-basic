dim field$(1000,100)
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
randommap = 1



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
    IF randommap = 0 then gosub [load.mapfile]

goto [load.sprites]
wait

[load.mapfile]
open loadmap$ for input As #loadmap
return

[end]
close #main
end

[key]
IF Inkey$ = "w" then gosub [w]
IF Inkey$ = "s" then gosub [s]
print #main.graph, "spritetofront man"
print #main.graph, "drawsprites"
wait

[w]
gosub [hide.frame]
frame = frame + 1
gosub [drawframe]
return

[s]
gosub [hide.frame]
frame = frame - 1
gosub [drawframe]
return

[hide.frame]
 for drawframe = 1 to ttiles
    print #main.graph, "spritevisible ";frame;"dirt";drawframe;" off"
 next drawframe
return

[load.sprites]
print #main.graph, "addsprite man man1"
print #main.graph, "spritexy man 230 170"
gosub [load.map]
frame = 1
gosub [drawframe]
print #main.graph, "spritetofront man"
print #main.graph, "drawsprites"
IF randommap = 0 then close #loadmap
wait

[random.texture]
pickme = int(rnd(1)*5) + 1
select case pickme
 case 1
    chosenText$ = "grass1"
 case 2
    chosenText$ = "dirt1"
 case 3
    chosenText$ = "water"
 case 4
    chosenText$ = "grass1"
 case 5
    chosenText$ = "grass1"
end select
return

[load.texture]
pickme = val(input$(#loadmap,1))
select case pickme
 case 1
    chosenText$ = "grass1"
 case 2
    chosenText$ = "dirt1"
 case 3
    chosenText$ = "water"
 case 4
    chosenText$ = "grass1"
 case 5
    chosenText$ = "grass1"
end select
return

[load.map]
tile = 0
ony = 0
onx = 0
ttiles=17*17 'Tiles per frame
framekey$ = "" 'This is what the whole frame is based on
for frame = 1 to 50

    for ymap = 1 to 17
        for xmap = 1 to 17
         tile = tile + 1
         IF randommap = 1 then gosub [random.texture]
         IF randommap = 0 then gosub [load.texture]
         print #main.graph, "addsprite ";frame;"dirt";tile;" "+chosenText$
         print #main.graph, "spritexy ";frame;"dirt";tile;" ";onx;" ";ony
         print #main.graph, "spritevisible ";frame;"dirt";tile;" off"
         onx = onx + 30
        next xmap
    ony = ony + 30
    onx = 0
   next ymap

onx = 0
ony = 0
tile = 0
next frame
return

[drawframe]
IF frame = 0 then frame = 1
 for drawframe = 1 to ttiles
    print #main.graph, "spritevisible ";frame;"dirt";drawframe;" on"
 next drawframe
return
