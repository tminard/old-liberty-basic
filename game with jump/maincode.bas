'This code clip controls the main window!
atmap = 1
lastmove$ = "right"
[main]
speed = 4
gosub [load.objects]
clip = val(word$(place$(1),2))
open "My game" for graphics_nsb AS #main
print #main, "trapclose [exit.main]"
print #main, "when characterInput [key.click]"
gosub [build.map]
close #go
for c = 1 to objects
doobject$ = object$(c)
action$ = "\bmps\"+object$(c)+"\standstill\"
gosub [add.sp]
next c
timer 100, [move.all]
wait

[exit.main]
timer 0
print #main, "up"
print #main, "goto 20 90"
print #main, "down"
#main, "cls"
#main, "fill black"
#main, "color blue"
print #main, "\Finishing Process: Exiting in 2 seconds..."
print "Trigger [TrapClose]: Exiting in 2 seconds..."
disablekeys = 1
timer 2000, [quit.con]
wait

[quit.con]
timer 0
close #main
end

[load.objects]
dim object$(1000)
dim place$(1000)
open atmap;".map" for input AS #go
for i=1 to 10000
line input #go, item$
IF item$ = "endob" THEN exit for
object$(i) = item$
next i
i = i - 1
objects= i

IF i = 1 THEN line input #go, place$(1):goto [lo2]:end
IF i = 0 then return

for b = 1 to i
line input #go, place$
IF trim$(place$) = "" THEN [next.b]
place$(b) = place$
[next.b]
next b
goto [lo2]
end

[lo2]
line input #go, blank$
return


[build.map]
print "Creating map..."
for jk = objects+1 to 10000
line input #go, isobject$
IF trim$(isobject$) = "endob" then exit for
object$(jk) = trim$(isobject$)
line input #go, action$
doobject$ = trim$(object$(jk))
gosub [add.sp]
line input #go, place$(jk)
print #main, "spritexy  "+object$(jk)+" "+place$(jk);
next jk
print "Map created!"
return

[add.sp]
for i = 1 to 10000
IF doobject$ = object$(i) THEN atobject = i:exit for
next i

IF doobject$ = object$(atobject) = 0 THEN notice "Invalid Object name!":return

bitmaps$ = ""
dim info$(100,100)
files DefaultDir$+action$, "*.bmp", info$(
'notice val(info$(0,0))
for i = 1 to val(info$(0,0))
bitmaps$ = bitmaps$ + " "+info$(i, 0)
loadbmp info$(i,0), DefaultDir$+action$+info$(i,0)
next i

'notice bitmaps$


print #main, "addsprite "+doobject$+" "+bitmaps$
'print #main, "spritexy "+doobject$+" "+place$(atobject);
print #main, "drawsprites"
return

'Key controls
[key.click]
IF disablekeys = 1 THEN print "Keys disabled!":wait
x = val(word$(place$(1),1))
y =  val(word$(place$(1),2))

IF onmoving = 1 AND Inkey$ = lastkey$ THEN wait
IF Inkey$ = " " THEN [jump]
lastkey$ = Inkey$
IF Inkey$ = "a" THEN [move.left]
IF Inkey$ = "d" THEN [move.right]
IF Inkey$ = "s" THEN [move.duck]

IF Inkey$ = "O" THEN place$(2) = x;" ";y:cycleon = 1
IF Inkey$ = "P" THEN cycleon = 0
wait


[jump] 'Now this is '[Move.UP]'
Inkey$ = ""
lastmove$ = "down"
speed = 4
onmoving = 1
x = val(word$(place$(1),1))
y =  val(word$(place$(1),2))
y = y - 15
place$(1) = x;" ";y
wait

IF jumping = 1 then Inkey$ = "":wait
x = val(word$(place$(1),1))
y =  val(word$(place$(1),2))
IF onmoving = 1 THEN Inkey$ = lastkey$
IF onmoving = 0 THEN Inkey$ = ""
IF jumping = 0 then jumping = 1:startjump = y:maxjump = y - 100':y = y - 1
place$(1) = x;" ";y
gosub [add.sp]
#main, "drawsprites"
IF Inkey$ = "a" THEN [move.left]
IF Inkey$ = "d" THEN [move.right]
IF Inkey$ = "s" THEN [move.duck]
wait

'move man left
[move.left]
Inkey$ = ""
lastmove$ = "left"
speed = 4
onmoving = 1
x = val(word$(place$(1),1))
y =  val(word$(place$(1),2))
IF jumping = 0 then x = x - 15
IF jumping = 1 then x = x - 70
place$(1) = x;" ";y
doobject$ = "man"
IF ducking = 1 then action$ = "\bmps\"+doobject$+"\manduckmoveleft\"
IF ducking = 0 then action$ = "\bmps\"+doobject$+"\moveleft\"
IF jumping = 1 then action$ = "\bmps\"+doobject$+"\jumpleft\"
gosub [add.sp]
wait

[move.duck]
Inkey$ = ""
lastmove$ = "down"
speed = 4
onmoving = 1
x = val(word$(place$(1),1))
y =  val(word$(place$(1),2))
y = y + 15
place$(1) = x;" ";y
wait

IF jumping = 1 then wait
lastmove$ = "down"
IF ducking = 0 then ducking = 1:justchanged = 1
IF ducking = 1 AND justchanged = 0 then ducking = 0
justchanged = 0
'print "Trigger: Set ManDucking = ";ducking
IF onmoving = 1 THEN wait
speed = 4
doobject$ = "man"
IF action$ = "" THEN action$ = "\bmps\"+doobject$+"\moveright\":gosub [add.sp]:wait
IF action$ = "\bmps\"+doobject$+"\moveleft\" THEN action$ = "\bmps\"+doobject$+"\manduckmoveleft\":lastmove$ = "downleft":gosub [add.sp]:wait
IF action$ = "\bmps\"+doobject$+"\moveright\" THEN action$ = "\bmps\"+doobject$+"\manduckmoveright\":lastmove$ = "downright":gosub [add.sp]:wait
action$ = "\bmps\"+doobject$+"\moveright\"
gosub [add.sp]
wait


[move.right]
'IF onmoving = 1 THEN Inkey$ = ""
lastmove$ = "right"
speed = 4
onmoving = 1
x = val(word$(place$(1),1))
y =  val(word$(place$(1),2))
IF jumping = 0 then x = x + 15
IF jumping = 1 then x = x + 70
place$(1) = x;" ";y
doobject$ = "man"
IF ducking = 1 then  action$ = "\bmps\"+doobject$+"\manduckmoveright\"
IF ducking = 0 then action$ = "\bmps\"+doobject$+"\moveright\"
IF jumping = 1 then action$ = "\bmps\"+doobject$+"\jumpright\"
gosub [add.sp]
wait


'This is were the timer goes!
[move.all]
IF jumping = 1 then gosub [jump.now]

for i = 1 to objects
x = val(word$(place$(i),1))
y =  val(word$(place$(i),2))
IF jumping = 0 then #main, "spritetravelxy "+object$(i)+" " ;x; " " ;y; " " ;speed; " [branchHandler]"
IF jumping = 1 then #main, "spritetravelxy "+object$(i)+" " ;x; " " ;y; " 5 [branchHandler]"
IF cycleon = 1 then print #main, "cyclesprite "+object$(i)+" 1 once"
'place$(i) = x;" ";y
next i
'gosub [add.sp]
#main, "drawsprites"
'#main, "flush"
wait

[branchHandler]
onmoving = 0
'Inkey$ = ""
wait

[stand.still.jump]
doobject$ = "man"
IF lastmove$ = "right" THEN action$ = "\bmps\"+doobject$+"\moveright\":doobject$ = "man":gosub [add.sp]:return
IF lastmove$ = "left" THEN action$ = "\bmps\"+doobject$+"\moveleft\":gosub [add.sp]:return
IF lastmove$ = "downright" THEN action$ = "\bmps\"+doobject$+"\manduckmoveright\":gosub [add.sp]:return
IF lastmove$ = "downleft" THEN action$ = "\bmps\"+doobject$+"\manduckmoveleft\":gosub [add.sp]:return
'action$ = "\bmps\"+doobject$+"\manduckmoveright\":gosub [add.sp]
return

[getbmp.jump]
doobject$ = "man"
IF lastmove$ = "right" THEN action$ = "\bmps\"+doobject$+"\jumpright\":doobject$ = "man":return':gosub [add.sp]:return
IF lastmove$ = "left" THEN action$ = "\bmps\"+doobject$+"\jumpleft\":return':gosub [add.sp]:return
action$ = "\bmps\"+doobject$+"\jumpup\"':gosub [add.sp]
return

[jump.now]
gosub [getbmp.jump]
y = val(word$(place$(1),2))
IF jumping = 1 and goingdown = 0 then y = y - 15
IF jumping = 1 and goingdown = 1 then y = y + 15

IF jumping = 1 and goingdown = 0 AND y = maxjump or y < maxjump then goingdown = 1
IF jumping = 1 and goingdown = 1 AND y = clip or y > clip THEN gosub [stop.jump]:gosub [stand.still.jump]
x = val(word$(place$(1),1))

place$(1) = x;" ";y
return

[stop.jump]
jumping = 0:goingdown = 0
return
