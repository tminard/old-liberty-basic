'run
notice "DO NOT select 'cancel' in ANY extraction window!!! We will fix this bug soon"
main$ = "main\" 'main\ = AA; mainta\ = SP; maintt\ = BT
version$ = " 2.2"
IF main$ = "main\" THEN game$ = version$+" Medal of Honor Allied Assault"
IF main$ = "mainta\" THEN game$ = "Medal of Honor Allied assault - Spearhead"
IF main$ = "maintt\" then game$ = "Medal of Honor Allied assault - Breakthrough"

preface$ = "zzzzzzzzzzzzzzzzzzzzzzz_"'this will follow all weapon files file name.
dim record$(1000,20)
open "read.txt" for input AS #rda
gosub [theengine]
goto [main.win]
end



[list]
listing = val(word$(com$,2))
 for i = 1 to 4
  print record$(listing,i)
 next i
return

[list.type]
finding$ = word$(com$,2)
 for i = 1 to recs
  IF lower$(record$(i,3)) = lower$(finding$) THEN print record$(i,0);" | ";i
  next i
return

[runapp]
notice "It is OK if the program tries to overwrite files. Select 'Yes to All' when an overwrite window pops up. DO NOT HIT CANCEL!"

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
s.lpFile$.struct="files.exe"
s.lpParameters$.struct=""
s.lpDirectory$.struct=DefaultDir$
s.nShow.struct=_SW_NORMAL

calldll #shell32 , "ShellExecuteExA",_
s as struct,r as long

if r<>0 then
    hProcess=s.hProcess.struct
else
    print "Error."
    end
end if

waitResult=-1
while waitResult<>0
calldll #kernel32, "WaitForSingleObject",_
hProcess as long,0 as long,_
waitResult as long
wend

print "Launched process has ended"
return





[theengine]
 for i = 1 to 10000000
   IF eof(#rda) <> 0 then exit for
   line input #rda, command$
    IF left$(command$,1) = ":" then gosub [read.start]
 next i
close #rda
return

[read.start]
recs = recs + 1
record$(recs,0) = word$(command$,2,":")
line input #rda, blank$
line input #rda,team$
line input #rda,file$
line input #rda,type$
line input #rda,txt$
line input #rda, blank$
team$ = word$(team$,2,"=")
file$ = word$(file$,2,"=")
type$ = word$(type$,2,"=")
txt$ = word$(txt$,2,"=")
record$(recs,1) = team$
record$(recs,2) = file$
record$(recs,3) = type$
record$(recs,4) = txt$

return



'Form created with the help of Freeform 3 v03-27-03
'Generated on Jul 26, 2006 at 09:04:53


[main.win]

    '-----Begin code for #main
   mohdir$ = "C:\program files\ea games\MOHAA\"+main$
   IF fileExists("C:\program files\ea games\MOHAA\","mohaa.exe") = 0 THEN notice "The program will now scan your hard disk for MOH. This may take some time"
   IF fileExists("C:\program files\ea games\MOHAA\","mohaa.exe") = 0 THEN RootPath$="c:\"
   IF fileExists("C:\program files\ea games\MOHAA\","mohaa.exe") = 0 THEN InputPathName$="mohaa.exe" + chr$(0)   'filename only
   IF fileExists("C:\program files\ea games\MOHAA\","mohaa.exe") = 0 THEN OutputPathBuffer$=space$(1023)+chr$(0)
   IF fileExists("C:\program files\ea games\MOHAA\","mohaa.exe") = 0 THEN gosub [find.moh]
   IF fileExists("C:\program files\ea games\MOHAA\","mohaa.exe") = 0 THEN IF ok = 0 then notice "Error!"+chr$(13)+"Medal of Honor - Allied assault not installed.":end
    nomainwin
    WindowWidth = 360
    WindowHeight = 195
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    groupbox #main.groupbox8, "Other", 205,   7, 125, 150
    groupbox #main.groupbox5, "Games", 100,   7,  100,  90
    groupbox #main.groupbox2, "Weapons",   5,   7,  85,  90
    button #main.button3,"Allies",[allieswep], UL,  25,  27,  45,  25
    button #main.button4,"Axis",[axiswep], UL,  25,  62,  45,  25
    button #main.button6,"Install Mods",[instmod], UL, 100,  27,  95,  25
    button #main.button7,"Default Game",[set.default], UL, 100,  62,  95,  25
    button #main.button9,"Update Patches",[upd], UL, 215,  27, 107,  25
    button #main.button10,"Addons",[addon], UL, 215,  62, 105,  25
    TextboxColor$ = "white"
    textbox #main.textbox11,   5, 117, 190,  25
    statictext #main.statictext12, "By Tyler Minard", 220, 117,  94,  20
    menu #main, "Install", "Update Files", [upd.prog]
    '-----End GUI objects code

    open "Mods - "+game$ for window_nf as #main
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"
    IF fileExists("C:\program files\ea games\MOHAA\","mohaa.exe") = 0 THEN mohdir$ = left$(trim$(OutputPathBuffer$),len(trim$(OutputPathBuffer$))-9)
    print #main.textbox11, mohdir$

[main.inputLoop]   'wait here for input event

    wait

[instmod]
    nomainwin
    WindowWidth = 390
    WindowHeight = 335
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    dim notinstg$(1000)
    dim instgames$(1000)
    dim allgames$(1000,10)
    gosub [get.all.games]
    gosub [get.installed.games]

    '-----Begin GUI objects code

    statictext #games.statictext1, "Availible Files",  40,   7,  85,  20
    ListboxColor$ = "white"
    listbox #games.listbox2, notinstg$(, [listbox2DoubleClick.g],   20,  27, 145, 180
    statictext #games.statictext3, "Installed", 235,   7,  50,  20
    listbox #games.listbox4, instgames$(, [listbox4DoubleClick.g],  190,  27, 155, 180
    statictext #games.statictext5, "Selected:",  10, 217, 165,  20
    button #games.button6,"Install Selected",[inst.sel.g], UL,  35, 237, 101,  25
    button #games.button7,"Remove Selected",[rm.sel.g], UL, 205, 237, 119,  25
   ' button #addon.button8,"Close",[quit.addon], UL, 250, 277,  70,  25
    statictext #games.statictext9, "Selected:", 190, 217, 170,  20
    ', UL, 250, 277,  70,  25
    statictext #games.info, "Info:", 10, 277,  700,  25

    '-----End GUI objects code

    open "MOH Add Ons" for dialog_modal as #games
    print #games, "font ms_sans_serif 10"
    print #games.info, "!font ms_sans_serif 1"
    print #games, "trapclose [quit.games]"


[games.inputLoop]   'wait here for input event
    wait

[quit.games]
close #games
wait

[get.all.games]
alladd = 0
finding$ = "game"
for i = 1 to recs
  IF lower$(record$(i,3)) = lower$(finding$) THEN alladd = alladd + 1:allgames$(alladd,0) = record$(i,0):allgames$(alladd,1) = record$(i,2)
next i
return

[get.installed.games]
notinst = 0
inst = 0
for ga = 1 to alladd
'notice mohdir$+"main\"+word$(alladd$(ga,1),2,"\")
 IF fileExists("",mohdir$+word$(allgames$(ga,1),2,"\")) = 0 THEN notinst = notinst + 1:notinstg$(notinst) = allgames$(ga,0)
 IF fileExists("",mohdir$+word$(allgames$(ga,1),2,"\")) THEN inst = inst + 1:instgames$(inst) = allgames$(ga,0)
next ga
return

[listbox2DoubleClick.g]
print #games.listbox2, "selectionindex? noinstnum"
print #games.listbox2, "selection? selected$"
print #games.statictext5, "Selected: "+selected$
finding$ = selected$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN latnum = i:exit for
next i

txt$ = record$(latnum,4)
#games.info, txt$
'popupmenu "Information",[information]
wait



[listbox4DoubleClick.g]   'Perform action for the listbox named 'listbox4'
print #games.listbox4, "selectionindex? instednum"
print #games.listbox4, "selection? selectedin$"
print #games.statictext9, "Selected: "+selectedin$
finding$ = selectedin$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN latnum = i:exit for
next i

txt$ = record$(latnum,4)
#games.info, txt$
'popupmenu "Information",[information]
wait


[upd.prog]
notice "Not yet created! Lines of code complete in section: 15 of esti. 50":wait
filedialog "Open program file", "*.upd", fileName$
print "File chosen is ";fileName$
IF fileName$ = "" then wait
open "read.txt" for append AS #apend
open fileName$ for input AS #readme
for i = 1 to 7
 line input #readme, tmp$
 print #apend, tmp$
next i
line input #readme, dataf$
close #readme
close #apend
dofiles$ = dataf$
wait





[allieswep]   'Perform action for the button named 'button3'
onteam$ = "allies"
pst = 1
rfl = 1
sbm = 1
lgm = 1
grd = 1
hvy = 1
dim pistols$(100)
dim rifles$(100)
dim subm$(100)
dim largm$(100)
dim gran$(100)
dim heavy$(100)
pistols$(1) = "Colt 45"
rifles$(1) = "M1 Grand"
subm$(1) = "Thompson"
largm$(1) = "BAR"
gran$(1) = "Standard"
heavy$(1) = "Bazooka"

finding$ = "pistol"
 for i = 1 to recs
  IF lower$(record$(i,3)) = lower$(finding$) THEN pst = pst + 1:pistols$(pst) = record$(i,0)
  next i
finding$ = "rifle"
 for i = 1 to recs
  IF lower$(record$(i,3)) = lower$(finding$) THEN rfl = rfl + 1:rifles$(rfl) = record$(i,0)
  next i
finding$ = "submach"
 for i = 1 to recs
  IF lower$(record$(i,3)) = lower$(finding$) THEN sbm = sbm + 1:subm$(sbm) = record$(i,0)
  next i
finding$ = "largmach"
 for i = 1 to recs
  IF lower$(record$(i,3)) = lower$(finding$) THEN lgm = lgm + 1:largm$(lgm) = record$(i,0)
  next i
  goto [wep.win]
  end



[axiswep]   'Perform action for the button named 'button4'

    'Insert your own code here

    wait


[addon]   'Perform action for the button named 'button9'
gosub [addon.win]
    'Insert your own code here

    wait


[upd]   'Perform action for the button named 'button10'

    'Insert your own code here

    wait

[quit.main] 'End the program
playwave "exit.wav"
close #main
end

'Form created with the help of Freeform 3 v03-27-03
'Generated on Jul 26, 2006 at 09:10:05
[set1]
IF current$ = "NULL" THEN current$ = pistols$(1)
print #web.c1, "select "; current$
return
[set2]
IF current$ = "NULL" THEN current$ = rifles$(1)
print #web.c2, "select "; current$
return
[set3]
IF current$ = "NULL" THEN current$ = subm$(1)
print #web.c3, "select "; current$
return
[set4]
IF current$ = "NULL" THEN current$ = largm$(1)
print #web.c4, "select "; current$
return
[set5]
IF current$ = "NULL" THEN current$ = gran$(1)
print #web.c5, "select "; current$
return
[set6]
IF current$ = "NULL" THEN current$ = heavy$(1)
print #web.c6, "select "; current$
return

[wep.win]

    '-----Begin code for #web

    nomainwin
    WindowWidth = 665
    WindowHeight = 185
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    statictext #web.statictext1, "Pistol:",  10,  27,  50,  20
    ComboboxColor$ = "white"
    combobox #web.c1, pistols$(, [combobox2DoubleClick],   60,  27, 100, 225
    statictext #web.statictext3, "Rifle:", 190,  27,  30,  20
    combobox #web.c2, rifles$(, [combobox4DoubleClick],  235,  27, 100, 235
    statictext #web.statictext5, "Sub Machine Gun:", 355,  27, 108,  20
    combobox #web.c3, subm$(, [combobox6DoubleClick],  475,  27, 170, 190
    statictext #web.statictext7, "Large Machine Gun:",  10,  77, 119,  20
    combobox #web.c4, largm$(, [combobox8DoubleClick],  140,  77, 100, 100
    statictext #web.statictext9, "Granade:", 265,  77,  56,  20
    combobox #web.c5, gran$(, [combobox10DoubleClick],  330,  77, 100, 170
    statictext #web.statictext11, "Heavy:", 465,  77,  43,  20
    combobox #web.c6, heavy$(, [combobox12DoubleClick],  515,  77, 100, 100
    button #web.button13,"Update!",[button13Click], UL, 565, 122,  85,  25
    button #web.button14,"Back",[quit.web], UL,  10, 122,  52,  25
    button #web.button15,"Reset",[button15Click], UL, 300, 122,  55,  25

    '-----End GUI objects code

    open "Choose Weapons" for window_nf as #web
    print #web, "font ms_sans_serif 10"
    print #web, "trapclose [quit.web]"
open onteam$+"wep.txt" for input AS #getsel
for i = 1 to 10000
IF eof(#getsel) <> 0 then exit for
 line input #getsel, current$
 IF i = 1 THEN gosub [set1]
 IF i = 2 THEN gosub [set2]
 IF i = 3 THEN gosub [set3]
 IF i = 4 THEN gosub [set4]
 IF i = 5 THEN gosub [set5]
 IF i = 6 THEN gosub [set6]
 IF i = 7 then exit for
next i
close #getsel

[web.inputLoop]   'wait here for input event
    wait



[combobox2DoubleClick]   'Perform action for the combobox named 'combobox2'

print #web.c1, "selection? tmp$"
finding$ = tmp$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN latnum = i:exit for
next i

txt$ = record$(latnum,4)
popupmenu "Information",[information]
wait



[combobox4DoubleClick]   'Perform action for the combobox named 'combobox4'
print #web.c2, "selection? tmp$"
finding$ = tmp$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN latnum = i:exit for
next i

txt$ = record$(latnum,4)
'popupmenu "Information",[information]
wait



[combobox6DoubleClick]   'Perform action for the combobox named 'combobox6'
print #web.c3, "selection? tmp$"
finding$ = tmp$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN latnum = i:exit for
next i

txt$ = record$(latnum,4)
popupmenu "Information",[information]
wait

[combobox8DoubleClick]   'Perform action for the combobox named 'combobox8'
print #web.c4, "selection? tmp$"
finding$ = tmp$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN latnum = i:exit for
next i

txt$ = record$(latnum,4)
popupmenu "Information",[information]
wait


[combobox10DoubleClick]   'Perform action for the combobox named 'combobox10'
print #web.c5, "selection? tmp$"
finding$ = tmp$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN latnum = i:exit for
next i

txt$ = record$(latnum,4)
popupmenu "Information",[information]
wait


[combobox12DoubleClick]   'Perform action for the combobox named 'combobox12'
print #web.c6, "selection? tmp$"
finding$ = tmp$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN latnum = i:exit for
next i

txt$ = record$(latnum,4)
popupmenu "Information",[information]
wait


[button13Click]   'Perform action for the button named 'button13'
print #web.c1, "selection? a$"
print #web.c2, "selection? b$"
print #web.c3, "selection? c$"
print #web.c4, "selection? d$"
print #web.c5, "selection? e$"
print #web.c6, "selection? f$"
val$ = "ok"
IF a$ = "" then val$ = "NULL"
IF b$ = "" then val$ = "NULL"
IF c$ = "" then val$ = "NULL"
IF d$ = "" then val$ = "NULL"
if e$ = "" then val$ = "NULL"
if f$ = "" then val$ = "NULL"
IF val$ = "NULL" then notice "Please choose a weapon for EACH group":wait

IF a$ = pistol$(1) AND fileExists("",copyto$+preface$+"pistol.pk3") THEN kill copyto$+preface$+"pistol.pk3"
IF b$ = rifle$(1) AND fileExists("",copyto$+preface$+"rifle.pk3") THEN kill copyto$+preface$+"rifle.pk3"
IF c$ = subm$(1) AND fileExists("",copyto$+preface$+"submach.pk3") THEN kill copyto$+preface$+"submach.pk3"
IF d$ = largm$(1) AND fileExists("",copyto$+preface$+"machine.pk3") THEN kill copyto$+preface$+"machine.pk3"
IF e$ = gran$(1) AND fileExists("",copyto$+preface$+"granade.pk3") THEN kill copyto$+preface$+"granade.pk3"
IF f$ = heavy$(1) AND fileExists("",copyto$+preface$+"heavy.pk3") THEN kill copyto$+preface$+"heavy.pk3"

    WindowWidth = 325
    WindowHeight = 150
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    statictext #waiti.statictext1, "Extracting Files... Please wait...",  55,  37, 180,  20
    open "Working..." for dialog_modal as #waiti
    print #waiti, "font ms_sans_serif 10"
    gosub [runapp]
    open onteam$+"wep.txt" for output AS #savsel
    print #savsel, a$
    print #savsel, b$
    print #savsel, c$
    print #savsel, d$
    print #savsel, e$
    print #savsel, f$
    close #savsel
close #waiti

finding$ = a$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN at = i:gosub [copy.file.a]:exit for
next i
finding$ = b$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN at = i:gosub [copy.file.b]:exit for
next i
finding$ = c$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN at = i:gosub [copy.file.c]:exit for
next i
finding$ = d$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN at = i:gosub [copy.file.d]:exit for
next i
finding$ = e$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN at = i:gosub [copy.file.e]:exit for
next i
finding$ = f$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN at = i:gosub [copy.file.f]:exit for
next i
notice "Done!"
wait


FUNCTION fileExists(path$, filename$) ' Does file exist?
dim info$(100,10)
    files path$, filename$, info$(
    fileExists = val(info$(0, 0)) > 0
END FUNCTION

[copy.file.a]
copyfrom$ = record$(at,2)
copyto$ = mohdir$
IF fileExists("",copyto$+preface$+"pistol.pk3") THEN kill copyto$+preface$+"pistol.pk3"
name copyfrom$ as copyto$+preface$+"pistol.pk3"
return

[copy.file.b]
copyfrom$ = record$(at,2)
copyto$ = mohdir$
IF fileExists("",copyto$+preface$+"rifle.pk3") THEN kill copyto$+preface$+"rifle.pk3"
name copyfrom$ as copyto$+preface$+"rifle.pk3"
return

[copy.file.c]
copyfrom$ = record$(at,2)
copyto$ = mohdir$
IF fileExists("",copyto$+preface$+"submach.pk3") THEN kill copyto$+preface$+"submach.pk3"
name copyfrom$ as copyto$+preface$+"submach.pk3"
return

[copy.file.d]
copyfrom$ = record$(at,2)
copyto$ = mohdir$
IF fileExists("",copyto$+preface$+"machine.pk3") THEN kill copyto$+preface$+"machine.pk3"
name copyfrom$ as copyto$+preface$+"machine.pk3"
return

[copy.file.e]
copyfrom$ = record$(at,2)
copyto$ = mohdir$
IF fileExists("",copyto$+preface$+"granade.pk3") THEN kill copyto$+preface$+"granade.pk3"
name copyfrom$ as copyto$+preface$+"granade.pk3"
return

[copy.file.f]
copyfrom$ = record$(at,2)
copyto$ = mohdir$
IF fileExists("",copyto$+preface$+"heavy.pk3") THEN kill copyto$+preface$+"heavy.pk3"
name copyfrom$ as copyto$+preface$+"heavy.pk3"
return

[button14Click]   'Perform action for the button named 'button14'

    'Insert your own code here

    wait


[button15Click]   'Perform action for the button named 'button15'
confirm "Reset ALL weapons?";QA$
IF QA$ = "no" then wait
copyto$ = mohdir$

IF fileExists("",copyto$+preface$+"pistol.pk3") THEN kill copyto$+preface$+"pistol.pk3"
IF fileExists("",copyto$+preface$+"rifle.pk3") THEN kill copyto$+preface$+"rifle.pk3"
IF fileExists("",copyto$+preface$+"submach.pk3") THEN kill copyto$+preface$+"submach.pk3"
IF fileExists("",copyto$+preface$+"machine.pk3") THEN kill copyto$+preface$+"machine.pk3"
IF fileExists("",copyto$+preface$+"granade.pk3") THEN kill copyto$+preface$+"granade.pk3"
IF fileExists("",copyto$+preface$+"heavy.pk3") THEN kill copyto$+preface$+"heavy.pk3"
notice "Reset done!"
    wait

[quit.web] 'End the program
    close #web
    wait

[find.moh]
ok = 0
'search for a file, given a filename alone,
'or partial path and filename.



print "Searching (c:\) for ";InputPathName$
print "Please wait..."

open "imagehlp" for dll as #ih
calldll #ih, "SearchTreeForFile",_
RootPath$ as ptr,_
InputPathName$ as ptr,_
OutputPathBuffer$ as ptr,_
ret as long
close #ih

if ret=0 then
print InputPathName$;" not found.":ok = 0:return
else
print "Full path is ";trim$(OutputPathBuffer$)
end if
print "Finished"
ok = 1
return




[addon.win]


    nomainwin
    WindowWidth = 390
    WindowHeight = 335
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    dim notinst$(1000)
    dim inst$(1000)
    dim alladd$(1000,10)
    gosub [get.all]
    gosub [get.installed]

    '-----Begin GUI objects code

    statictext #addon.statictext1, "Availible Files",  40,   7,  85,  20
    ListboxColor$ = "white"
    listbox #addon.listbox2, notinst$(, [listbox2DoubleClick],   20,  27, 145, 180
    statictext #addon.statictext3, "Installed", 235,   7,  50,  20
    listbox #addon.listbox4, inst$(, [listbox4DoubleClick],  190,  27, 155, 180
    statictext #addon.statictext5, "Selected:",  10, 217, 165,  20
    button #addon.button6,"Install Selected",[inst.sel], UL,  35, 237, 101,  25
    button #addon.button7,"Remove Selected",[rm.sel], UL, 205, 237, 119,  25
   ' button #addon.button8,"Close",[quit.addon], UL, 250, 277,  70,  25
    statictext #addon.statictext9, "Selected:", 190, 217, 170,  20
    ', UL, 250, 277,  70,  25
    statictext #addon.info, "Info:", 10, 277,  700,  25

    '-----End GUI objects code

    open "MOH Add Ons" for dialog_modal as #addon
    print #addon, "font ms_sans_serif 10"
    print #addon.info, "!font ms_sans_serif 1"
    print #addon, "trapclose [quit.addon]"


[addon.inputLoop]   'wait here for input event
    return

[get.all]
alladd = 0
finding$ = "addon"
for i = 1 to recs
  IF lower$(record$(i,3)) = lower$(finding$) THEN alladd = alladd + 1:alladd$(alladd,0) = record$(i,0):alladd$(alladd,1) = record$(i,2)
next i
return

[get.installed]
notinst = 0
inst = 0
for ga = 1 to alladd
'notice mohdir$+"main\"+word$(alladd$(ga,1),2,"\")
 IF fileExists("",mohdir$+word$(alladd$(ga,1),2,"\")) = 0 THEN notinst = notinst + 1:notinst$(notinst) = alladd$(ga,0)
 IF fileExists("",mohdir$+word$(alladd$(ga,1),2,"\")) THEN inst = inst + 1:inst$(inst) = alladd$(ga,0)
next ga
return

[listbox2DoubleClick]
print #addon.listbox2, "selectionindex? noinstnum"
print #addon.listbox2, "selection? selected$"
print #addon.statictext5, "Selected: "+selected$
finding$ = selected$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN latnum = i:exit for
next i

txt$ = record$(latnum,4)
#addon.info, txt$
'popupmenu "Information",[information]
wait

[wait]
wait


[listbox4DoubleClick]   'Perform action for the listbox named 'listbox4'
print #addon.listbox4, "selectionindex? instednum"
print #addon.listbox4, "selection? selectedin$"
print #addon.statictext9, "Selected: "+selectedin$
finding$ = selectedin$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN latnum = i:exit for
next i

txt$ = record$(latnum,4)
#addon.info, txt$
'popupmenu "Information",[information]
wait

[information]
notice txt$
wait

[rm.sel.g]   'Perform action for the button named 'button7'
IF trim$(selectedin$) = "" then wait
confirm "Unistall "+selectedin$+"?";QA$
IF QA$ = "no" THEN wait
finding$ = selectedin$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN instto = i:ok = 1:exit for
next i
IF ok = 0 THEN notice "Error!":wait
IF fileExists("",mohdir$+word$(record$(i,2),2,"\")) = 0 THEN notice "Not installed!":wait
kill mohdir$+word$(record$(i,2),2,"\")
selectedin$ = ""
 dim notinstg$(1000)
    dim instgame$(1000)
    dim allgames$(1000,10)
    gosub [get.all.games]
    gosub [get.installed.games]
    print #games.listbox4, "reload"
    print #games.listbox2, "reload"
    wait
    

[set.default] 'still working on this
    dim notinstg$(1000)
    dim instgame$(1000)
    dim allgames$(1000,10)
    gosub [get.all.games]
gosub [get.installed.games]
gosub [def.win]
wait

[def.win]
for a = 1 to 100
 IF allgames$(a,0) = "" then exit for
 IF fileExists(mohdir$, "zzzzzzzzzzzzz"+allgames$(a,1)) then gdefault$ = allgames$(a,0):exit for
next a

    nomainwin
    WindowWidth = 305
    WindowHeight = 400
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    statictext #setdef.statictext1, "Installed Games",  75,  12, 130,  20
    ListboxColor$ = "white"
    instgame$(1) = "Original"
    listbox #setdef.listbox2, instgame$(, [defg.click],   40,  37, 185, 220
    button #setdef.button3,"Install More...",[def.inst], UL, 200, 337,  87,  25
    button #setdef.button4,"Apply",[def.app], UL, 105, 337,  65,  25
    button #setdef.button5,"Cancel",[def.can], UL,   5, 337,  65,  25
    statictext #setdef.statictext6, "Default: "+gdefault$,  40, 267, 255,  20
    statictext #setdef.statictext7, "Selected:",  40, 292, 270,  20

    '-----End GUI objects code

    open "Set the default game" for dialog_modal as #setdef
    print #setdef, "font ms_sans_serif 10"
    print #setdef, "trapclose [quit.setdef]"
    print #setdef.listbox2, "select ";gdefault$

[setdef.inputLoop]   'wait here for input event
    return



[defg.click]   'Perform action for the listbox named 'listbox2'
#setdef.listbox2, "selection? defsel$"
print #setdef.statictext7, defsel$
    wait


[def.inst]   'Perform action for the button named 'button3'

    'Insert your own code here

    wait


[def.app]   'Perform action for the button named 'button4'

    wait


[def.can]   'Perform action for the button named 'button5'
close #setdef
    wait

[quit.setdef] 'End the program
    close #setdef
    wait

[inst.sel.g]
IF trim$(selected$) = "" THEN wait
ok = 0
finding$ = selected$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN instfrom = i:ok = 1:exit for
next i
IF ok = 0 then notice "Error!":wait
installfrom$ = record$(instfrom,2)

IF fileExists("",installfrom$) = 0 then
   WindowWidth = 325
    WindowHeight = 150
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    statictext #waiti.statictext1, "Extracting Files... Please wait...",  55,  37, 180,  20
    open "Working..." for dialog_modal as #waiti
    print #waiti, "font ms_sans_serif 10"
    gosub [runapp]
close #waiti
end if

installto$ = mohdir$+word$(record$(instfrom,2),2,"\")
name installfrom$ as installto$
selected$ = ""
    dim notinstg$(1000)
    dim instgame$(1000)
    dim allagames$(1000,10)
    gosub [get.all.games]
    gosub [get.installed.games]
    print #games.listbox4, "reload"
    print #games.listbox2, "reload"
    wait


[inst.sel]  'Perform action for the button named 'button6'
IF trim$(selected$) = "" THEN wait


ok = 0
finding$ = selected$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN instfrom = i:ok = 1:exit for
next i
IF ok = 0 then notice "Error!":wait
installfrom$ = record$(instfrom,2)

IF fileExists("",installfrom$) = 0 then
   WindowWidth = 325
    WindowHeight = 150
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    statictext #waiti.statictext1, "Extracting Files... Please wait...",  55,  37, 180,  20
    open "Working..." for dialog_modal as #waiti
    print #waiti, "font ms_sans_serif 10"
    gosub [runapp]
close #waiti
end if

installto$ = mohdir$+word$(record$(instfrom,2),2,"\")
name installfrom$ as installto$
selected$ = ""
    dim notinst$(1000)
    dim inst$(1000)
    dim alladd$(1000,10)
    gosub [get.all]
    gosub [get.installed]
    print #addon.listbox4, "reload"
    print #addon.listbox2, "reload"
    wait


[rm.sel]   'Perform action for the button named 'button7'
IF trim$(selectedin$) = "" then wait
confirm "Unistall "+selectedin$+"?";QA$
IF QA$ = "no" THEN wait
finding$ = selectedin$
for i = 1 to recs
  IF lower$(record$(i,0)) = lower$(finding$) THEN instto = i:ok = 1:exit for
next i
IF ok = 0 THEN notice "Error!":wait
IF fileExists("",mohdir$+word$(record$(i,2),2,"\")) = 0 THEN notice "Not installed!":wait
kill mohdir$+word$(record$(i,2),2,"\")
selectedin$ = ""
 dim notinst$(1000)
    dim inst$(1000)
    dim alladd$(1000,10)
    gosub [get.all]
    gosub [get.installed]
    print #addon.listbox4, "reload"
    print #addon.listbox2, "reload"
    wait
    wait


[can.add]   'Perform action for the button named 'button8'

    'Insert your own code here

    wait

[quit.addon] 'End the program
    close #addon
    wait

