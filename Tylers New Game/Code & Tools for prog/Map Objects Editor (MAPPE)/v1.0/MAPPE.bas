'Form created with the help of Freeform 3 v03-27-03
'Generated on Feb 22, 2006 at 08:07:36

[setup.main.Window]
loaded$ = ""
    '-----Begin code for #main

    nomainwin
    WindowWidth = 440
    WindowHeight = 430
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    statictext #main.statictext1, "Loaded: ",   5,   7, 137,  20
    ListboxColor$ = "white"
    listbox #main.listbox2, maps$(, [listbox2DoubleClick],    5,  27, 130, 240
    statictext #main.statictext3, "Maps",  40, 277,  45,  20
    statictext #main.statictext4, "Selected Map: ", 175,   7, 154,  20
    listbox #main.listbox5, objects$(, [listbox5DoubleClick],  160,  27, 105, 245
    button #main.button6,"Edit Selected...",[button6Click], UL, 290,  32,  99,  25
    statictext #main.statictext7, "Selected: ", 290,  67, 604,  20
    statictext #main.statictext8, "Objects", 180, 277,  46,  20

    '-----End GUI objects code

    '-----Begin menu code

    menu #main, "File",_
                "Open"      , [open.game],_
                "Save"      , [save.game],_
                "Save As...", [saveas.game],_
                "Exit"      , [end.all]

   ' menu #main, "Files",_
   '             "Show Objects", [show.obj],_
   '             "Show Maps"   , [show.mps]


    '-----End menu code

    open "MAPPE" for window_nf as #main
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [end.all]"


[main.inputLoop]   'wait here for input event
    wait



[listbox2DoubleClick]   'Perform action for the listbox named 'listbox2'

print #main.listbox2, "selection? sobj$"
IF right$(sobj$,4) = ".txt" THEN run "notepad.exe "+sobj$:wait
IF sobj$ = "" THEN wait
dim objects$(1000)
IF fileExists("",sobj$+".log") THEN kill sobj$+".log"
bmpsat$ = sobj$
gosub [extract.bmps]
open sobj$+".log" for input AS #getf
for i = 1 to 10000
IF eof(#getf) <> 0 THEN exit for
line input #getf, objects$(i)
next i
close #getf
print #main.listbox5, "reload"
    wait

    wait


[listbox5DoubleClick]   'Perform action for the listbox named 'listbox5'
print #main.listbox5, "selection? sm$"
#main.statictext7, "Selected: "+sm$

    wait


[button6Click]   'Perform action for the button named 'button6'
print #main.listbox5, "selection? sm$"
IF sm$ = "" THEN wait
IF right$(sm$,4) = ".bmp" THEN run "mspaint.exe "+chr$(34)+sm$+chr$(34):wait
IF right$(sm$,4) = ".txt" THEN run "notepad.exe "+chr$(34)+sm$+chr$(34):wait
filedialog "Open "+sm$+" With...", "*.exe", openme$
IF openme$ = "" THEN notice "Program not found!":wait
IF right$(openme$,4) = ".exe" = 0 THEN notice "The program chosen is not valid!":wait
IF fileExists("",openme$) = 0 THEN notice "Program not found!":wait
run openme$+" "+sm$
    wait


[open.game]   'Perform action for menu File, item Open
filedialog "Open game file", "*.game", loaded$
IF loaded$ = "" THEN notice "No File Loaded!":wait

open loaded$+".log" for output AS #getf
close #getf

bmpsat$ = loaded$
gosub [extract.bmps]
dim maps$(1000)
gosub [get.logs]
open loaded$+".log" for input AS #getf
for i = 1 to 10000
IF eof(#getf) <> 0 THEN exit for
line input #getf, maps$(i)
next i
close #getf
print #main.listbox2, "reload"
    wait


[save.game]   'Perform action for menu File, item Save
notice "Command not YET supported!"
    'Insert your own code here

    wait


[saveas.game]   'Perform action for menu File, item Save As...
notice "Command not YET supported!":wait
comit$ = ""

gosub [get.logs]
for f = 1 to 1000
IF fileExists("","map";f;".map.log") = 0 THEN exit for
open "map";f;".map.log" for input AS #saveas

for g = 1 to 1000
IF eof(#saveas) <> 0 THEN exit for
line input #saveas, tmp$
comit$ = comit$ + "+"+tmp$
next g
close #saveas
saveasout$ = "maptest";f;".map"
gosub [zipper]
comit$ = ""
next f
notice "Saved!"
    'Insert your own code here

    wait


[end.all]   'Perform action for menu File, item Exit
IF loaded$ = "" THEN close #main: end
dim logsb$(10, 10)
dim logs$(1000)
gosub [get.logs]
for c = 1 to val(logsb$(0,0))
 open logs$(c) for input AS #kf
   for b = 1 to 100000
    IF eof(#kf) <> 0 THEN exit for
    line input #kf, killme$
    IF fileExists("",killme$) THEN kill killme$
    next b
    close #kf
    kill logs$(c)
next c
close #main
end

[get.logs]
open loaded$+".log" for input AS #getf
getf = lof(#getf)
loadedtxt$ = input$(#getf, getf)
close #getf
'kill loaded$+".log"
open "mainlo.log" for output AS #getf
print #getf, loadedtxt$
close #getf
dim logsb$(10, 10)
dim logs$(1000)
 files DefaultDir$, "*.log", logsb$(
 for i = 1 to val(logsb$(0,0))
 logs$(i) = logsb$(i,0)
 'notice logs$(i)
 next i
 return


[show.obj]   'Perform action for menu Files, item Show Objects

    'Insert your own code here

    wait


[show.mps]   'Perform action for menu Files, item Show Maps

    'Insert your own code here

    wait

[quit.main] 'End the program
    close #main
    end



'bmpsat$ = "pk1.pak"
'gosub [extract.bmps]

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



[zipper]
filesfound = 1
open saveasout$ for output AS #3
doing = 3
'filedialog "Open a file", "*.*", file$
word = 1
file$ = word$(comit$,word,"+")
IF file$ = "+" THEN word = word + 1:file$ = word$(comit$,word,"+")
[top3]
test$ = right$(file$, (len(file$)-doing))
gosub [isvailedname]
IF testok$="no"then doing=doing+1:goto[top3]:end
IF trim$(file$) = "" THEN close #3:end
print #3, "1"
print #3,""
[input]
open file$ for input as #4
file$=test$
doit = lof(#4)
text$ = input$(#4,doit)
close #4

print #3, file$
print #3, doit
print #3, text$
close #3
filesfound = filesfound + 1
'confirm "Anymore files?";tmp$
word = word + 1 :IF word$(comit$,word,"+") = "" THEN tmp$ = "no"
IF tmp$ = "no" THEN open "install.set" for append AS #3:print #3, "endall":close #3:tmp$ = "":return
open "install.set" for append AS #3
file = file + 1
doing = 3
file$ = word$(comit$,word,"+")
IF trim$(file$) = "" THEN close #3:end
[top.b]
test$ = right$(file$, (len(file$)-doing))
gosub [isvailedname]
IF testok$="no"then doing=doing+1:goto[top.b]:end
'file$ = "noracc";file;".txt"
goto [input]
end

[isvailedname]
testok$ = ""
'IF len(test$) > 1000 THEN notice "Please change your user name so that it is UNDER 1000 characters long!":return
open "i.tmp" for output as #testme
print #testme, test$
close #testme
open "i.tmp" for input as #testme
for i = 1 to 1000
IF eof(#testme) <> 0 then exit for
tmp$ = input$(#testme, 1)
IF tmp$ = "*" or tmp$ = ":" or tmp$ = "/" or tmp$ = "\" or tmp$ = "?" or tmp$ = ">" or tmp$ = "<" or tmp$ = "|" or tmp$ = chr$(34) then testok$ = "no":exit for': notice "Invailed user name! Please change some characters!":exit for
next i
close #testme
kill "i.tmp"
return

