'Form created with the help of Freeform 3 v03-27-03
'Generated on Feb 23, 2006 at 12:20:58
'bmpsat$ = "pk1.pak"
'gosub [extract.bmps]
filedialog "Open Game File", "*.game", loaded$
IF loaded$ = "" THEN end
IF fileExists("",loaded$) = 0 THEN end
    open "cryptor.dll" for dll as #en
LDTEXT$ = "Loading Game, Please Wait!"
gosub [loading.Screen]
IF fileExists("",loaded$+".tmp.log") THEN kill loaded$+".tmp.log"

KEY$ = "ycpwf"
INFILE$ = loaded$
IF fileExists("",loaded$+".tmp") THEN kill loaded$+".tmp"
OUTFILE$ = loaded$+".tmp"
MODE = 1
gosub [encrypt]

IF cryok = 0 THEN close #ld:end
loaded$=loaded$+".tmp"
bmpsat$ = loaded$
close #ld
gosub [extract.bmps]
goto [main]
end

[main]

dim objs$(1000)
open loaded$+".log" for input AS #2
for i = 1 to 10000
 IF eof(#2) <> 0 THEN exit for
 line input #2, objs$(i)
 next i
 close #2
    '-----Begin code for #root

    nomainwin
    WindowWidth = 595
    WindowHeight = 520
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    graphicbox #root.graphicbox2, 245,  32, 310, 370
    groupbox #root.groupbox7, "Main Files",   0,   7, 145, 400
    statictext #root.statictext1, "Viewing:", 245,   7, 165,  20
   ' statictext #root.statictext3, "Object(s) Selected:", 245, 442, 290,  20
  '  button #root.button6,"Save Map",[button6Click], UL, 365, 412,  72,  25
    ListboxColor$ = "white"
    listbox #root.listbox8, objs$(, [listbox8DoubleClick],   10,  22, 120, 375
    statictext #root.statictext9, "Selected:",   5, 417, 140,  20
    button #root.button10,"Edit Files...",[button10Click], UL,  30, 437,  85,  25
    button #root.button11,"Add...",[button11Click], UL, 150,  22,  44,  25

    '-----End GUI objects code

    '-----Begin menu code

    menu #root, "File", "Save As...", [save.as]', "Map Items", "&FixMe", [fixMe]

    '-----End menu code

    open "Map Viewer And Object Editor" for window as #root
    print #root.graphicbox2, "down; fill white; flush"
    print #root, "font ms_sans_serif 10"
    print #root, "trapclose [quit.root]"

timer 500, [draw.sp]
[root.inputLoop]   'wait here for input event
    wait

[draw.sp]
print #root.graphicbox2, "drawsprites"
wait

[button6Click]   'Perform action for the button named 'button6'

    'Insert your own code here

    wait


[listbox8DoubleClick]   'Perform action for the listbox named 'listbox8'
print #root.listbox8, "selection? s8$"
#root.statictext9, "Selected: "+s8$
IF right$(s8$,4) = ".map" = 0 THEN wait
#root.statictext1, "Viewing: "+s8$
IF mbmp$ = "" = 0 AND fileExists("",mbmp$+".bmp") THEN kill mbmp$+".bmp"
bmpsat$ = s8$
gosub [extract.bmps]
open "maps.txt" for input AS #gmbs
line input #gmbs, blank$
line input #gmbs, blank$
for i = 1 to 1000
IF eof(#gmbs) <> 0 THEN exit for
line input #gmbs, mbmp$
IF fileExists("",mbmp$+".bmp") THEN loadbmp "back", mbmp$+".bmp":print #root.graphicbox2, "background back":print #root.graphicbox2,"drawsprites":exit for
line input #gmbs, blank$
line input #gmbs, blank$
next i
close #gmbs
LDTEXT$ = "Loading Map, Please Wait!"
gosub [loading.Screen]
gosub [load.map]
close #ld
print #root.graphicbox2, "drawsprites"

    wait


[button10Click]   'Perform action for the button named 'button10'
goto [Vf]

    wait


[button11Click]   'Perform action for the button named 'button11'

    'Insert your own code here

    wait

[quit.root] 'End the program
timer 0
close #en
'LDTEXT$ = "Closing Program"
'gosub [loading.Screen]

gosub [cleanup.log]
    close #root
    IF fileExists("",loaded$) THEN kill loaded$
  '  close #ld
    end



'Form created with the help of Freeform 3 v03-27-03
'Generated on Feb 23, 2006 at 12:21:17


[Vf]
svft$ = "Selected: None"
print #root.listbox8, "selection? s8$"

IF lower$(right$(s8$,4)) = ".map" = 0 AND lower$(right$(s8$,4)) = ".obj" = 0 THEN run "notepad.exe "+chr$(34)+s8$+chr$(34):wait

IF s8$ = "" THEN notice "Please select an Item!":wait
IF fileExists("",s8$+".log") THEN kill s8$+".log"
bmpsat$ = s8$
gosub [extract.bmps]
dim objs2$(1000)
open s8$+".log" for input AS #2
for i = 1 to 10000
 IF eof(#2) <> 0 THEN exit for
 line input #2, objs2$(i)
 next i
 close #2
    '-----Begin code for #Vf

    nomainwin
    WindowWidth = 320
    WindowHeight = 270
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

   ' groupbox #Vf.groupbox7, "Controls", 160,  12, 125, 145
    ListboxColor$ = "white"
    listbox #Vf.listbox1, objs2$(, [vf1DoubleClick],    5,  27, 145, 200
    statictext #Vf.statictext2, "Items",   5,   7,  90,  20
   ' button #Vf.button3,"Delete",[vf3Click], UL, 170,  27,  50,  25
   ' button #Vf.button4,"Add",[vf4Click], UL, 170,  57,  50,  25
    button #Vf.button5,"Edit Selected",[vf5Click], UL, 170,  97,  90,  25
    statictext #Vf.statictext6, "Selected: ", 170, 132, 702,  20
    button #Vf.button8,"Save",[vf8Click], UL, 180, 172,  75,  25
    button #Vf.button9,"Close",[vf9Click], UL, 180, 202,  75,  25

    '-----End GUI objects code

    open "Edit items in object: "+s8$ for dialog_nf_modal as #Vf
    print #Vf, "font ms_sans_serif 10"
    print #Vf, "trapclose [quit.Vf]"


[Vf.inputLoop]   'wait here for input event
    wait



[vf1DoubleClick]   'Perform action for the listbox named 'listbox1'
#Vf.listbox1, "selection? svft$"
#Vf.statictext6, "Selected: "+svft$

    wait


[vf3Click]   'Perform action for the button named 'button3'

    'Insert your own code here

    wait


[vf4Click]   'Perform action for the button named 'button4'

    'Insert your own code here

    wait


[vf5Click]   'Perform action for the button named 'button5'
IF lower$(svft$) = "selected: none" THEN wait
IF svft$ = "" THEN wait
IF lower$(right$(svft$,4)) = ".txt" THEN run "notepad.exe "+chr$(34)+svft$+chr$(34):wait
IF lower$(right$(svft$,4)) = ".bmp" THEN run "mspaint.exe "+chr$(34)+svft$+chr$(34):wait
notice "Windows does not know how to manage '"+right$(svft$, 4)+"' type files!"
    wait


[vf8Click]   'Perform action for the button named 'button8'
comit$ = ""
open s8$+".log" for input AS #ghjkl
zof$ = s8$
gosub [zipper]
close #Vf
close #ghjkl
    wait


[vf9Click]   'Perform action for the button named 'button9'
goto [quit.Vf]

    wait

[quit.Vf] 'End the program
    close #Vf
    wait

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
open zof$ for output AS #3
doing = 3
'filedialog "Open a file", "*.*", file$
word = 1
line input #ghjkl, file$
[top3]
'test$ = right$(file$, (len(file$)-doing))
'gosub [isvailedname]
IF testok$="no"then doing=doing+1:goto[top3]:end
IF trim$(file$) = "" THEN close #3:end
print #3, "1"
print #3,""
[input]
open file$ for input as #4
'file$=test$
doit = lof(#4)
text$ = input$(#4,doit)
close #4

print #3, file$
print #3, doit
print #3, text$
close #3
filesfound = filesfound + 1
'confirm "Anymore files?";tmp$
word = word + 1 :IF eof(#ghjkl) <> 0 THEN tmp$ = "no"
IF tmp$ = "no" THEN open zof$ for append AS #3:print #3, "endall":close #3:tmp$ = "":return
open zof$ for append AS #3
file = file + 1
line input #ghjkl, file$
IF trim$(file$) = "" THEN close #3:end
[top.b]
'test$ = right$(file$, (len(file$)-doing))
'gosub [isvailedname]
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

[save.as]
timer 0
filedialog "Save As...", "*.game", saveasg$
IF saveasg$ = "" THEN notice "Game file NOT saved!"+chr$(13)+"No valid name was given.":wait

LDTEXT$ = "Saving Game, Please Wait!"
gosub [loading.Screen]
open loaded$+".log" for input AS #ghjkl

zof$ = saveasg$
gosub [zipper]
close #ghjkl

KEY$ = "ycpwf"
INFILE$ = saveasg$
IF fileExists("",saveasg$+".mk") THEN kill saveasg$+".mk"
OUTFILE$ = saveasg$+".mk"
MODE = 2
notice "Going.Encry"
gosub [encrypt]
notice "Done.Encry"
timer 500, [draw.sp]
close #ld
IF cryok = 0 THEN notice "Error Saving File! Please restart the program or your computer.":end
IF fileExists("",saveasg$) THEN kill saveasg$
name saveasg$+".mk" AS saveasg$
IF fileExists("",saveasg$+".mk") THEN kill saveasg$+".mk"
notice "Done!"
    wait

[cleanup.log]
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
return

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

[encrypt]   'Do it!
cryok = 0
'MODE = 1 = Encrypt
'MODE = 2 = Decrypt
   ' #main.key, "!contents? KEY$"
   ' #main.source, "!contents? INFILE$"
   ' #main.destination, "!contents? OUTFILE$"

    cursor hourglass
    scan
    RESULT = ENCRYPTION(MODE,INFILE$,OUTFILE$,KEY$)
    cursor normal
    if RESULT = 1 then cryok = 1
    if RESULT = 2 then notice "Mode not properly selected!"
    if RESULT = 3 then notice "Source file does not exist!"
    if RESULT = 4 then notice "Destination file already exists!"
    if RESULT = 5 then notice "No key specified!"
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

    open "Loading..." for dialog_modal as #ld
    print #ld, "font ms_sans_serif 10"
    print #ld, "trapclose [quit.ld]"


[ld.inputLoop]   'wait here for input event
'timer 1000, [move.dot]
    return


[quit.ld] 'End the program
    close #ld
    wait

[move.dot]
scan
dot$ = dot$+ "."
IF dot$ = "........" THEN dot$ = ""
#ld.statictext2, dot$
wait


[load.map]
endr = 0
print #root.graphicbox2, "cls"
IF objs = 0 = 0 THEN gosub [rm.sp]
objs = 0
dim sprites$(1000)
IF fileExists("","data.txt") = 0 THEN return
bmpsat$ = "objects.obj"
gosub [extract.bmps]

loadbmp "en", "en.bmp"
loadbmp "block", "wall.bmp"
loadbmp "man", "man.bmp"
loadbmp "house", "house.bmp"
loadbmp "tree", "tree.bmp"
loadbmp "fin", "fin.bmp"

open "data.txt" for input AS #mapd
for i = 1 to 10000
line input #mapd, mob$
gosub [see.obj]
IF endr = 1 THEN exit for
next i
close #mapd
return



[see.obj]
IF word$(mob$,1) = "man" THEN [man]
IF word$(mob$,1) = "block" THEN [man]
IF word$(mob$,1) = "fin" THEN [man]
IF word$(mob$,1) = "tree" THEN [man]
IF word$(mob$,1) = "house" THEN [man]
IF word$(mob$,1) = "endr" THEN endr = 1
return

[man]
line input #mapd, x$
line input #mapd, y$
objs = objs + 1
print #root.graphicbox2, "addsprite obj";objs;" "+word$(mob$,1)
sprites$(objs) = "obj";objs
IF word$(mob$,1) = "man" = 0 THEN print #root.graphicbox2, "spritexy obj";objs;" ";val(x$);" ";val(y$)
IF word$(mob$,1) = "man" THEN print #root.graphicbox2, "spritexy obj";objs;" ";val(y$);" ";val(x$)
print #root.graphicbox2, "drawsprites"
return

[rm.sp]
'notice objs
IF objs = 0 THEN return
for i = 1 to objs
#root.graphicbox2, "removesprite "+sprites$(i)
next i
print #root.graphicbox2, "drawsprites"
'dim sprites$(1000)
return



function ENCRYPTION(MODE,INFILE$,OUTFILE$,KEY$)
scan
    calldll #en, "_ENCRYPT",_
        MODE as short,_
        INFILE$ as ptr,_
        OUTFILE$ as ptr,_
        KEY$ as ptr,_
        RESULT as short
    ENCRYPTION = RESULT
end function

