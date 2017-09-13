'ANTS test
loadbmp "idle", "images\sonic_idle.bmp"
open "TEST" for graphics_nsb AS #game
for i = 1 to 10
 place = place +30
 print #game, "addsprite ant";i;" idle"
print #game, "spritexy ant";i;" ";place;" -10"
next i
print #game, "trapclose [exit]"
'dot = int(rnd(1)*10) + 1
'y = y + dot
'for i = 1 to 10
'print #game, "spritemovexy ant";i;" ";x;" ";y
'next i
timer 500, [mov.all]
wait

[exit]
timer 0
close #game
end


[mov.all]
for i = 1 to 10
'dot = int(rnd(1)*2) + 1
'y = y + dot
'dotx = int(rnd(0)*2) + 1
'x = x + dotx
print #game, "spritemovexy ant";i;" 0 0"
print #game, "spritemovexy ant";i;" ";x;" ";y
dot = int(rnd(1)*2) + 1
y = y + dot
dotx = int(rnd(0)*2) + 1
x = x + dotx
next i
print #game, "drawsprites"
wait
