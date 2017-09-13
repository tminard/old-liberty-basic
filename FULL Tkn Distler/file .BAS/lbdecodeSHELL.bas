fileName$ = word$(CommandLine$,2,"|")

[shell]
regentered = 0
working = 0
    WindowWidth = 265
    WindowHeight = 145
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    open "Loading..." for graphics_nsb_nf as #logo
    print #logo, "down;fill black; flush"
    print #logo, "color darkblue; backcolor black"
    print #logo, "font ms_sans_serif 10"
    locaty = 40
    locatx = 100
gosub [displayLogo]
close #logo
    nomainwin
    WindowWidth = 410
    WindowHeight = 240
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)

    BackgroundColor$ = "black"
    ForegroundColor$ = "darkblue"

    '-----Begin GUI objects code

    button #mainW.button1,"Open Tkn file...",[openTkn], UL,   5,   5,  98,  25
    statictext #mainW.openTkn, "Loaded Tkn:", 115,  12, 470,  20
    button #mainW.button3,"Output Bas...",[openBas], UL,   5,  37, 100,  25
    statictext #mainW.openBas, "Output:", 115,  42, 400,  20
    statictext #mainW.statictext5, "--------------------------------------------------------------------------",  50,  67, 296,  20
    button #mainW.button6,"Enter LB Registration Information",[enterReg], UL,   5, 177, 203,  25
    button #mainW.button7,"Close",[closeall], UL, 305, 177,  75,  25
    statictext #mainW.statictext8, "--------------------------------------------------------------------------------------",  30, 152, 344,  20
    statictext #mainW.percent, "Percent: 0%", 155,  82,  100,  20
    statictext #mainW.working, "Working on this...", 100, 122, 20000,  40

    '-----End GUI objects code

    open "Tkn Distler v1.0" for window_nf as #mainW
    print #mainW, "font ms_sans_serif 10"
    print #mainW, "trapclose [quit.mainW]"


[mainW.inputLoop]   'wait here for input event
print #mainW.working, "Before we can start, please enter registration."
wait

[displayLogo]
timer 1, [show.Logo]
wait

[show.Logo]
font=font+1
locatx = locatx - 4
  print #logo, "font arial ";font;" italic"
  print #logo, "place ";locatx;" ";locaty
  print #logo, "\\"+"ADELPHOS PRO"
  print #logo, "flush"
  IF font = 20 then timer 0:endlogo = 1:timer 500, [return]
wait
[return]
timer 0
return

[openTkn]   'Perform action for the button named 'button1'
IF trim$(fileName$) = "" then filedialog "Open tkn file", "*.tkn", fileName$
IF trim$(fileName$) = "" then tknopen = 0:wait
#mainW.openTkn, fileName$
tknopen = 1
IF tknopen = 1 and basopen = 1 AND regentered = 1 then print #mainW.working, "Ok! We are ready! Click 'Start'!":print #mainW.button6, "Start!"
IF tknopen = 0 or basopen = 0 then print  #mainW.working, "Please choose input and/or output file."
IF regentered = 0 then print  #mainW.working, "Before we can start, please enter registration."
    wait


[openBas]   'Perform action for the button named 'button3'
IF trim$(savebas$) = "" then filedialog "Save As...", "*.bas", savebas$
IF trim$(savebas$) = "" then basopen = 0:wait
basopen = 1
#mainW.openBas, savebas$
IF tknopen = 1 and basopen = 1 AND regentered = 1 then print #mainW.working, "Ok! We are ready! Click 'Start'!":print #mainW.button6, "Start!"
IF tknopen = 0 or basopen = 0 then print  #mainW.working, "Please choose input and/or output file."
IF regentered = 0 then print  #mainW.working, "Before we can start, please enter registration."
    wait


[enterReg]   'Perform action for the button named 'button6'
IF tknopen = 1 and basopen = 1 and regentered = 1 then goto [start]
prompt " Enter User Name: ";checkname$
prompt " Enter Password: ";checkpassword$
regentered = 1
IF tknopen = 1 and basopen = 1 then print #mainW.working, "Ok! We are ready! Click 'Start'!":print #mainW.button6, "Start!"
IF tknopen = 0 or basopen = 0 then print  #mainW.working, "Please choose input and/or output file."
    wait

[closeall]   'Perform action for the button named 'button7'
goto [quit.mainW]
    wait

[quit.mainW] 'End the program
if working = 1 then confirm "Kill program? ";QA$
    close #mainW
    end

[start]
print "             Tkn Distler(tm)  "
print "             By Tyler Minard"
print ""
print "-------------------------------------------------------"
print " This program was intended for personal use ONLY! You may"
print "not decode other people's tokenized files unless you are"
print "permitted to do so by the creator of the file."
print "This program is NOT expected to work with files created"
print "using Liberty BASIC v5.0"
print "You can protect your programs by adding a [PROTECTtKNdIS]"
print "branch somewhere in your program. You will not be allowed"
print "to decode it!"
print "I am not responsible of how you use this program."
print "If you have any questions, email us at: adelphospro2000@yahoo.com"
print "--------------------------------------------------------"
tknFile$ = fileName$
dim subs$(2000,50)
open tknFile$ for input AS #mainf
fileSize = lof(#mainf)
for readfile = 1 to 1000000
 IF eof(#mainf) <> 0 then exit for
for i = 1 to 10000000
   dummy$ = input$(#mainf,1)
   IF dummy$ = CHR$(27) then exit for
   linetext$=linetext$ + dummy$
next i
encoded$ = linetext$
for doing = 1 to 1
testkey = len(encoded$)* -1 'here's the key!
WORDTEXT$ = ""
for a = 1 to LEN(encoded$)
TMPDECODE$ = mid$(encoded$,a,1)
 TMPDECODE$ = chr$(asc(TMPDECODE$)+testkey)
  WORDTEXT$ = WORDTEXT$ + TMPDECODE$
NEXT a
IF BRANCH = 1 then subsub = subsub + 1:subs$(subs,subsub) = WORDTEXT$:BRANCH = 0
next doing
linetext$ = ""
IF left$(WORDTEXT$,1) = "[" AND right$(WORDTEXT$,1) = "]" then subsub = 0:subs = subs + 1:subs$(subs,0) = WORDTEXT$:BRANCH = 1
IF instr(WORDTEXT$,":\") then exit for
next readfile
branches$ = ""
FOR i = 1 TO subs
  FOR tmp = 1 TO 1000
   IF subs$( i , tmp ) = "" THEN EXIT FOR
     instr$ = instr$ + " " + subs$( i , tmp )
     branches$ = branches$ + subs$(i,0)
 NEXT tmp
NEXT i
print #mainW.working, "Subs Found: "+str$(subs)+". Preparing... "
print "Getting ready to decode!"
dummy$ = ""
'PART 2!
open savebas$ for output AS #savefile
IF checkname$ = "debugingPerposeOnly" then print #savefile, "'Decoded ILLEGALLY using Tkn Distler(tm)!!! Decoded by "+checkname$:for i = 1 to 1000:print #savefile,"ILLEGAL!":next i
IF checkname$ = "debugingPerposeOnly" = 0 then print #savefile, "'Decoded LEGALLY using Tkn Distler(tm). Decoded by "+checkname$
for waiting = 1 to 100000
IF eof(#mainf) <> 0 then exit for
while right$(lbstring$,2) = chr$(27)+chr$(27)=0
 dummy$ = input$(#mainf,1)
 lbstring$ = lbstring$ + dummy$
wend

showloc = loc(#mainf)
done = (showloc / fileSize) * 100
cls
print #mainW.percent, int(done);"% Decoded!"

lbstring$ = left$(lbstring$,len(lbstring$)-2)'Ok, now I have the encoded version of the string. Now to decode it...
if instr(lbstring$,"UFXX\TWI") then print #mainW.working, "Checking Password...":gosub [check.password]:skip = 1
IF skip = 1 then skip = 0:goto [skip1]
for i = 1 to 10000
 IF word$(lbstring$,i,chr$(27)) = "" then words = i - 1:exit for
next i
key = (words) * -1 'here's the key!
WORDTEXT$ = ""
for i = 1 to len(lbstring$)
 tmp$ = mid$(lbstring$,i,1)
 IF asc(tmp$)+key < 33 then newchar$ = " ":nonext = 1
 IF asc(tmp$)+key = 15 then newchar$ = " ":nonext = 1
 IF asc(tmp$)+key = 19 then newchar$ = " ":nonext = 1
 IF asc(tmp$)+key = 10 then newchar$ = " ":nonext = 1
 IF asc(tmp$)+key > 0 AND nonext = 0 then newchar$ = chr$(asc(tmp$)+key)
 IF asc(tmp$)+key < 0 then newchar$ = " "
 WORDTEXT$ = WORDTEXT$ + newchar$
 nonext = 0
next i
ln  = val(word$(WORDTEXT$,1))
IF instr(instr$,str$(ln)) then gosub [insertB]
cutout = len(word$(WORDTEXT$,1," "))+1
print #savefile, right$(WORDTEXT$, len(WORDTEXT$) - cutout)
[skip1]
WORDTEXT$ = ""
dummy$ = ""
lbstring$ = ""
next waiting
close #mainf
close #savefile
print #mainW.working, "DONE! First line of code is just an intro."
working = 0
wait

[insertB]
for getB = 1 to 1000
 IF val(subs$(getB,1)) = ln then print #savefile, "":print #savefile, subs$(getB,0):exit for
next getB
return
[check.password]
key = -5 'Key used to decode 5 words: linenum PASSWORD "Someone" , "PASSWORD"
'                                       (1)      (2)       (3)  (4)    (5)
for i = 1 to len(lbstring$)
 tmp$ = mid$(lbstring$,i,1)
 IF asc(tmp$)+key < 33 then newchar$ = " ":nonext = 1
 IF asc(tmp$)+key = 15 then newchar$ = " ":nonext = 1
 IF asc(tmp$)+key = 19 then newchar$ = " ":nonext = 1
 IF asc(tmp$)+key = 10 then newchar$ = " ":nonext = 1
 IF asc(tmp$)+key > 0 AND nonext = 0 then newchar$ = chr$(asc(tmp$)+key)
 IF asc(tmp$)+key < 0 then newchar$ = " "
 WORDTEXT$ = WORDTEXT$ + newchar$
 nonext = 0
next i
for trimpass = 1 to len(WORDTEXT$)
 IF word$(WORDTEXT$,trimpass) = "PASSWORD" then exit for
next trimpass
username$ = word$(WORDTEXT$,2,chr$(34))
userpass$ = word$(WORDTEXT$,4,chr$(34))
userok = 0
passok = 0
'IF instr(branches$,"[PROTECTtKNdIS]") then print #mainW.working, "File is Protected!":goto [end]
IF checkname$ = "debugingPerposeOnly" then print #mainW.working, " NAME IS: "+username$:checkname$ = username$:print " PASSWORD IS: "+userpass$:checkpassword$ = userpass$
IF instr(lower$(username$),lower$(checkname$)) then userok = 1
IF instr(lower$(userpass$),lower$(checkpassword$)) then passok = 1
IF passok = 0 or userok = 0 then print #mainW.working, "Invalid Information!":goto [end]
print #mainW.working, " Information OK!"
print #mainW.working, "Decoding now....."
return
[end]
close #mainf
close #savefile
print #mainW.working, "Invalid information was given!"
kill savebas$
working = 0
wait

[PROTECTtKNdIS]
'protect the file from being decoded!
end




function fileExists(path$, filename$)
dim info$(100,10)
  'dimension the array info$( at the beginning of your program
  files path$, filename$, info$()
  fileExists = val(info$(0, 0))  'non zero is true
end function
