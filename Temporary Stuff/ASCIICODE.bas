'goto [do.text]


goto [main.win]
end


[exiit]
exi = 1
open "Finished.bas" for output AS #savit
print #savit, fileName$
print #savit, "File decoded by TONICODE on "+date$()
print #savit, ""

open fileName$ for input AS #tr
open "readytkn.tkn" for output AS #tp
print #main.textedit1, "Starting up..."
for i = 1 to 1000000000000
IF eof(#tr) <> 0 THEN exit for
txt$ = input$(#tr,1)
IF lasttxt$ = "" AND txt$ = "" THEN print #tp, gettxt$:gettxt$ = "":goto [next.ib]
lasttxt$ = txt$
gettxt$ = gettxt$ + txt$
goto [next.ib]
end

[next.ib]
next i
close #tr
close #tp


fileName$ = "readytkn.tkn"
open fileName$ for input AS #text
print #main.textedit1, "Done"
print #main.textedit1, "Starting processes..."
print #main.textedit1, "Done."
print #main.textedit1, "Translating now...."
goto [doit]
end

[doit]
onword = onword + 1
line input #text, ss2$
ss$ = ss2$
'notice ss$
'ss$ = word$(alltext$,onword,"")
'confirm ss$; end$
'IF end$ = "yes" THEN close #text:end
IF eof(#text) <> 0 THEN close #text:print #main.textedit1,"Done!":exi = 0:close #savit:wait
'IF trim$(ss$) = "" THEN close #text:end
'found = 0
gosub [do.text]
goto [doit]
end

[do.text]
'ss$ = "UFXX\TWI'Hfwq%Lzsijq'1'>GHII='"' 'ss$' = start string
'prompt "Enter some text: ";ss$
'ss$  = "UFXX\TWI"
lenth = len(ss$)
fintxt$ = ""
open "txt.txt" for output AS #pf' 'pf' = print out
print #pf, ss$
close #pf
endkey = 100
open "txt.txt" for input AS #iff' 'if' = input file
key = -50

open "Text.txt" for output AS #savefind

print #savefind, "This file was created by the ASCIICODE program"
print #savefind, "Copyright (c) 2006 by Tyler Minard"
print #savefind, "Any number within the '()' marks is undecodeable text. (ie. '(-27) = chr$(-27)))"
print #savefind, "---------------------------"
'Here is the commands database
dodata = 1'IF '0' then prog will print all text
cmds = 21
dim cmd$(1000)
cmd$(1) = "password "
cmd$(19) = "end"
cmd$(3) = "confirm "
cmd$(4) = "open "
cmd$(5) = "notice "
cmd$(6) = "prompt "
cmd$(7) = "mid$"
cmd$(8) = "then "
cmd$(9) = "next "
cmd$(10) = "graphics"
cmd$(11) = "print"
cmd$(12) = "main"
cmd$(13) = "window"
'cmd$(14) = "$"
cmd$(14) = " run "
cmd$(15) = "dll"
cmd$(16) = "kill"
cmd$(17) = "goto "
cmd$(18) = "instr("
cmd$(2) = " = "
cmd$(19) = "for "
cmd$(20) = "if "
cmd$(21) = "sprite"
'First, get a key
[do.i]
for i = 1 to lenth
IF eof(#iff) <> 0 THEN exit for
txt$ = input$(#iff, 1)
realkey = asc(txt$)
newkey = realkey + key
IF txt$ = "" THEN [next.i]
'IF found = 1 THEN exit for
IF newkey < 0 or newkey > 126 THEN fintxt$ = fintxt$ + "(UNSUPPORTED:";newkey;")":fintxt$ = "":exit for
newtxt$ = chr$(newkey)
'newtxt$ = "" OR newtxt$ = "" or newtxt$ = "" or newtxt$ = ""
IF asc(newtxt$) < 33 AND asc(newtxt$) > 0 THEN fintxt$ = fintxt$ + " "
'newtxt$ = "" = 0 and newtxt$ = "" = 0 AND newtxt$ = "" = 0 AND newtxt$ = "" = 0
IF asc(newtxt$) > 32 THEN fintxt$ = fintxt$ + newtxt$
goto [next.i]
end

[next.i]
next i
close #iff
found = 0
'print fintxt$
IF dodata = 1 THEN gosub [toprint.ornottoprint]
IF dodata = 0 THEN print "Key: ";key;" Text: "+fintxt$
key = key + 1
goto [next.key]
end

[toprint.ornottoprint]
'print #savefind, "Key: ";key;". Text: "+fintxt$
tmp$ = lower$(fintxt$)
'print tmp$
for com = 1 to cmds
scan
regname$ = word$(fintxt$,2,""+chr$(34)+"")
regnum$ = word$(fintxt$,4,""+chr$(34)+"")
IF instr(tmp$,"password") AND showp = 0 THEN showp = 1:print #main.textbox4, word$(fintxt$,2,""+chr$(34)+""):print #main.textbox5, word$(fintxt$,4,""+chr$(34)+"")
'IF instr(tmp$,cmd$(com)) = 1 AND found = 1 THEN print " (or)"
'IF instr(tmp$,cmd$(com)) = 1 AND found = 1 THEN  print "     "+fintxt$:found = 1:exit for:return
IF str$(val(word$(tmp$,1))) = word$(tmp$,1) = 0 THEN exit for
IF instr(tmp$,cmd$(com)) AND showp = 1 THEN print #main.textedit1, fintxt$:print #savit, fintxt$:found = 1:exit for':return
next com
return

[next.key]
'IF fintxt$ = "" THEN kill "txt.txt":close #savefind:end
IF key = endkey THEN kill "txt.txt":close #savefind:return
fintxt$ = ""
open "txt.txt" for input AS #iff' 'if' = input file
goto [do.i]
end


[main.win]

    nomainwin
    WindowWidth = 560
    WindowHeight = 385
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    BackgroundColor$ = "black"
    ForegroundColor$ = "green"

    '-----Begin GUI objects code

    TexteditorColor$ = "black"
    texteditor #main.textedit1,   0, 232, 550, 105
    groupbox #main.groupbox11, "About", 340,   2, 205,  80
    groupbox #main.groupbox10, "Output text",  -5, 212, 575, 185
    groupbox #main.groupbox6, "Registration",   0,  -3, 305,  75
    statictext #main.statictext2, "Registration Name:",  15,  22, 115,  20
    statictext #main.statictext3, "Registration Number:",  15,  47, 126,  20
    TextboxColor$ = "darkgray"
    textbox #main.textbox4, 155,  17, 135,  25
    textbox #main.textbox5, 155,  42, 135,  25
    statictext #main.statictext7, "File to decode:",  15, 102,  89,  20
    textbox #main.textbox8, 120,  97, 215,  25
    button #main.button9,"Browse...",[button9Click], UL, 345,  92,  64,  25
    statictext #main.statictext12, "Program by Tyler Minard", 350,  22, 148,  20
    button #main.button13,"Open finished file...",[button13Click], UL, 165, 132, 121,  25
    button #main.button14,"Decode!",[button14Click], UL, 420,  92,  75,  25

    '-----End GUI objects code

    '-----Begin menu code

    menu #main, "Edit"  ' <-- Texteditor menu.


    '-----End menu code

    open "TONICODE" for window as #main
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"


[main.inputLoop]   'wait here for input event
    wait



[button9Click]   'Perform action for the button named 'button9'
filedialog "Open tkn file", "*.tkn", fileName$
print #main.textedit1, "File chosen is ";fileName$
print ""
IF fileName$ = "" THEN isready = 0:wait
print #main.textbox8, fileName$
isready = 1

    wait


[button13Click]   'Perform action for the button named 'button13'
run "notepad.exe finished.bas"

    wait


[button14Click]   'Perform action for the button named 'button14'
IF isready = 0 THEN notice "Program does not yet have enough information to preform this operation. Please fill in all required text.":wait
goto [exiit]

    wait

[quit.main] 'End the program

IF exi = 1 then close #text:close #savit:close #savefind:kill "txt.txt":kill "readytkn.tkn":kill "text.txt"
    close #main
    end







