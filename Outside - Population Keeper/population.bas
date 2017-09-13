'This program will help keep population count for outside

'Form created with the help of Freeform 3 v03-27-03
'Generated on Jan 29, 2008 at 16:14:33
[loadbmps]
loadbmp "background", "outside.bmp"
loadbmp "building", "point.bmp"
loadbmp "point", "point.bmp"





[setup.main.Window]

    '-----Begin code for #main

    nomainwin
    WindowWidth = 455
    WindowHeight = 615
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    graphicbox #main.back,   0,  12, 435, 480
    button #main.add,"Add Location",[add], UL,   5, 512,  89,  25
    statictext #main.s, "Selected:",   5, 552, 275,  20
    button #main.edit,"Edit Location",[edit], UL, 110, 512,  87,  25
    button #main.button6,"Delete Location",[delete.point], UL, 210, 512, 104,  25
    menu #main, "Controls","Get Total Population",[gettotpop]
    '-----End GUI objects code

    open "untitled" for window as #main
   ' print #main.back, "down; fill white; flush"
   print #main.back, "when leftButtonUp [click]"
    'print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"
    print #main.back, "background background";
    print #main.back, "drawsprites"
    print #main.back, "flush"
    print #main.back, "addsprite mouse point"
    print #main.back, "centersprite mouse"
    print #main.back, "spritevisible mouse off"

[loadpoints]'load existing points
for i = 1 to 100
IF fileExists("",i;".txt") = 0 then i = 100
IF fileExists("",i;".txt") then
    open i;".txt" for input AS #getl
        line input #getl, xy$
        close #getl
        print #main.back, "addsprite ";i;" building"
        print #main.back, "centersprite ";i
        print #main.back, "spritexy ";i;" "+xy$
        build = build + 1
end if
next i

[main.inputLoop]   'wait here for input event
timer 100, [draw]
    wait
[draw]
print #main.back, "drawsprites"
wait

[gettotpop]
totpop = 0
for i = 1 to 100
IF fileExists("",i;".txt") = 0 then i = 100

IF fileExists("",i;".txt") then
open i;".txt" for input AS #loadi
line input #loadi, nothing$
line input #loadi, modname$
while eof(#loadi) = 0
line input #loadi, loadi$
    IF lower$(word$(loadi$,1,"=")) = "man" then
        totpop = totpop + val(word$(word$(loadi$,2,"="),2,","))
    end if
wend
close #loadi
end if

next i
notice "Total Population: ";totpop
wait

[delete.point]
IF selected$ = "" then wait
open word$(selected$,1)+".txt" for input AS #del
line input #del, tmp$
line input #del, name$
close #del
confirm "Delete "+name$+"?";QA$
IF QA$ = "yes" then
    print #main.back, "removesprite "+word$(selected$,1)
    kill word$(selected$,1)+".txt"
end if
print #main.back, "drawpsprites"
wait

[click]
print #main.back, "spritexy mouse ";MouseX;" ";MouseY
print #main.back, "drawsprites"
print #main.back, "spritecollides mouse selected$";
IF doadd = 1 then doadd = 0:goto [do.add]
print #main.s, "Selected: "+selected$
wait

[do.add]
build = build + 1
print #main.back, "addsprite ";build;" building"
print #main.back, "centersprite ";build
print #main.back, "spritexy ";build;" ";MouseX;" ";MouseY
print #main.back, "drawsprites"
open build;".txt" for output as #savestat
prompt "Name: ";name$
IF trim$(name$) = "" then name$ = str$(build)
print #savestat, MouseX;" ";MouseY
print #savestat, name$
print #savestat, "man=Conover,0"
close #savestat
wait

[add]   'Perform action for the graphicbox named 'back'
doadd = 1
    wait


[edit]   'Perform action for the button named 'edit'
goto [info]
    wait


[delete]   'Perform action for the button named 'button6'

    'Insert your own code here

    wait

[quit.main] 'End the program
timer 0
    close #main
    end

[info]'infobr
IF selected$ = "" then wait
pop = 0
WindowWidth = 300
    WindowHeight = 285
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    TexteditorColor$ = "white"
    texteditor #info.text,   5,  -3, 275, 155
    button #info.add,"+/-",[add.info], UL,   5, 172,  40,  25
    'button #info.remove,"-",[remove.info], UL,  55, 172,  40,  25
    button #info.button5,"Close",[close.info], UL,  95, 207,  80,  25

    '-----End GUI objects code

    open "Statistics" for window_nf as #info
    print #info, "font ms_sans_serif 10"
    print #info, "trapclose [close.info]"
gosub [getinfo]
wait

[close.info]
close #info
wait

[add.info]
WindowWidth = 255
    WindowHeight = 160
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    button #addman.button1,"Add",[add.now], UL, 165,  92,  70,  25
    button #addman.button2,"Cancel",[cancel.add], UL,   0,  92,  52,  25
    statictext #addman.manytxt, "How Many:",   5,  17,  66,  20
    TextboxColor$ = "white"
    textbox #addman.many,  80,  12, 100,  25
    statictext #addman.kindtxt, "What Kind:",   5,  47,  63,  20
    textbox #addman.kind,  80,  42, 100,  25

    '-----End GUI objects code

    open "Add/Remove man" for window_nf as #addman
    print #addman, "font ms_sans_serif 10"
    print #info, "trapclose [cancel.add]"
    wait
[cancel.add]
close #addman
wait
[add.now]
print #addman.many, "!contents? addmany$";
print #addman.kind, "!contents? addkind$";
open word$(selected$,1)+".txt" for append as #addinfo
print #addinfo, "man="+addkind$+","+addmany$
close #addinfo
gosub [getinfo]
goto [cancel.add]
wait

[getinfo]
pop = 0
open word$(selected$,1)+".txt" for input AS #loadi
line input #loadi, nothing$
line input #loadi, modname$
while eof(#loadi) = 0
line input #loadi, loadi$
    IF lower$(word$(loadi$,1,"=")) = "man" then
        pop = pop + val(word$(word$(loadi$,2,"="),2,","))
    end if
wend
print #info.text, "!cls"
print #info.text,"Name: "+modname$
print #info.text,"Population: ";pop
print #info.text, chr$(13)
close #loadi
return

function fileExists(path$, filename$)
dim info$(10,10)
  'dimension the array info$( at the beginning of your program
  files path$, filename$, info$()
  fileExists = val(info$(0, 0))  'non zero is true
end function
