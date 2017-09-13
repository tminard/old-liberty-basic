loadbmp "room", "room1.bmp"
loadbmp "ball", "ball.bmp"
percent = 100

dim sprit$(1000)
   WindowWidth = 500
    WindowHeight = 500
    nomainwin
open "Test" for graphics_nsb_nf AS #1

print #1,"addsprite Back room";
print #1, "spritexy Back 0 0"
sprit$(1) = "Back"
sprites = 1

print #1, "addsprite ball ball"
print #1, "spritexy ball 50 50"
sprit$(2) = "ball"
sprites = 2

print #1, "when characterInput [key]"
gosub [do.per]
print #1, "drawsprites"
wait


[key]

IF doingkey = 1 THEN Inkey$ = ""
doingkey = 1
print #1, "spritexy? Back x y"
IF Inkey$ = "P" THEN notice x;" + ";y
IF Inkey$ = "d" THEN
gosub [mov.d]
print #1, "drawsprites"
end if

IF Inkey$ = "a" AND x = 0 = 0 THEN
gosub [mov.a]
print #1, "drawsprites"
end if

IF Inkey$ = "w" THEN
gosub [mov.w]
print #1, "drawsprites"
end if

IF Inkey$ = "s" AND percent = 100 = 0 THEN
gosub [mov.s]
print #1, "drawsprites"
end if

doingkey = 0
wait

[mov.d]
IF x < -949 AND x > -961 THEN print #1, "spritexy Back 50 0"
for i = 1 to sprites
print #1, "spritemovexy "+sprit$(i)+" -50 0";
next i
return

[mov.a]
for i = 1 to sprites
print #1, "spritemovexy "+sprit$(i)+" 50 0";
next i
return

[mov.w]
percent = percent + 10
for i = 1 to sprites
print #1, "spritescale "+sprit$(i)+" ";percent
print #1, "spritemovexy "+sprit$(i)+" -10 -10";
next i
return

[mov.s]
percent = percent - 10
for i = 1 to sprites
print #1, "spritescale "+sprit$(i)+" ";percent
print #1, "spritemovexy "+sprit$(i)+" -10 10";
next i
return


[do.per]
for i = 1 to sprites
print #1, "spritescale "+sprit$(i)+" ";percent
next i
return
