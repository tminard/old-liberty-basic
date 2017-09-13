'This version bypasses password requirement!
COMMAND = val(CommandLine$)
PRINT fileName$
PRINT "             Tkn Distler(tm)  "
PRINT "             By Tyler Minard"
PRINT ""
PRINT "-------------------------------------------------------"
print "This is the DEV version. You can decode ALL tkn files"
print "and are not PASSWORD restricted. DO NOT GIVE AWAY!"
print "For Adelphos Pro programmers ONLY! Type '?' for help."
PRINT "--------------------------------------------------------"
nouser = 0
while COMMAND < 1
INPUT "Command> ";COMMAND$
IF COMMAND$ = "?" then cls:gosub [show.help]
IF lower$(COMMAND$) = "start" then COMMAND = 1
IF lower$(COMMAND$) = "kind" then COMMAND = 2
IF lower$(COMMAND$) = "quit" then COMMAND = 3
'IF lower$(COMMAND$) = "install" then gosub [installreg] DO IT MANUALLY or THROUGH INSTALLER!
'IF LOWER$(COMMAND$) = "external" then COMMAND = 4
WEND
IF COMMAND = 2 then nouser = 1
IF COMMAND = 3 then end
IF COMMAND = 4 then gosub [doexternal]:nouser = 1
IF TRIM$( fileName$ ) = "" THEN FILEDIALOG "Open tkn file" , "*.tkn" , fileName$
IF TRIM$( fileName$ ) = "" THEN END
IF TRIM$( savebas$ ) = "" THEN FILEDIALOG "Save As..." , "*.bas" , savebas$
IF TRIM$( savebas$ ) = "" THEN END
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
'--
showloc = loc(#mainf)
done = (showloc / fileSize) * 100
cls
print "Collecting Subs..."
print "++";int(done);"% Read..."
'--
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
print "Subs Found: "+str$(subs)+". Preparing... READY!"
IF nouser = 0 then INPUT "ANY KEY TO CONTINUE> " ; QA$
IF nouser = 1 then print "Decoding Without user input...."
dummy$ = ""
'PART 2!
open savebas$ for output AS #savefile
for waiting = 1 to 100000
IF eof(#mainf) <> 0 then exit for
while right$(lbstring$,2) = chr$(27)+chr$(27)=0
 dummy$ = input$(#mainf,1)
 lbstring$ = lbstring$ + dummy$
wend

IF nouser = 0 then
 showloc = loc(#mainf)
 done = (showloc / fileSize) * 100
 cls
 print "Collecting Subs..."
 print "Subs Found: "+str$(subs)+""
 print "Processing Code Body..."
 print "++";int(done);"% Decoded..."
end if

lbstring$ = left$(lbstring$,len(lbstring$)-2)'Ok, now I have the encoded version of the string. Now to decode it...
if instr(lbstring$,"UFXX\TWI") then print "Finding Password...":gosub [find.password]:skip = 1
IF skip = 1 then skip = 0:goto [skip1]
for i = 1 to 10000
 IF word$(lbstring$,i,chr$(27)) = "" then words = i - 1:exit for
next i
key = (words) * -1 'here's the key! Its how long the string is in words, + 1, TIMES - 1: notice "bob joe" = 3
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
PRINT "DONE!"
PRINT " REGISTRATION NAME IS: " + username$
PRINT " REGISTRATION PASSWORD IS: " + userpass$
open "Registrations.ini" for append AS #saveReg
print #saveReg, "REGISTRATION NAME IS: " + username$
print #saveReg, "REGISTRATION PASSWORD IS: " + userpass$
print #saveReg, "-------"+date$()+"---------------------"
close #saveReg

IF nouser = 0 then INPUT "Any key to continue> " ; QA$
end

[show.help]
PRINT "             Tkn Distler(tm)  "
PRINT "             By Tyler Minard"
PRINT ""
PRINT "-------------------------------------------------------"
print "List of Commands supported in v1.0:"
print " quit  - Close so soon?!"
print " start - Start the decoding process!"
print " kind  - Start but don't pause in the middle. The program"
print "        will close automatically when it's finished."
print "Thanks for using Adelphos Pro Software!"
PRINT "--------------------------------------------------------"
return

[insertB]
for getB = 1 to 1000
 IF val(subs$(getB,1)) = ln then print #savefile, "":print #savefile, subs$(getB,0):exit for
next getB
return

[find.password]
key = -5
FOR i = 1 TO LEN( lbstring$ )
tmp$ = MID$( lbstring$ , i , 1 )
IF ASC( tmp$ ) + key < 33 THEN newchar$ = " " : nonext = 1
IF ASC( tmp$ ) + key = 15 THEN newchar$ = " " : nonext = 1
IF ASC( tmp$ ) + key = 19 THEN newchar$ = " " : nonext = 1
IF ASC( tmp$ ) + key = 10 THEN newchar$ = " " : nonext = 1
IF ASC( tmp$ ) + key > 0 AND nonext = 0 THEN newchar$ = CHR$( ASC( tmp$ ) + key )
IF ASC( tmp$ ) + key < 0 THEN newchar$ = " "
WORDTEXT$ = WORDTEXT$ + newchar$
nonext = 0
NEXT i
FOR trimpass = 1 TO LEN( WORDTEXT$ )
IF WORD$( WORDTEXT$ , trimpass ) = "PASSWORD" THEN EXIT FOR
NEXT trimpass
username$ = WORD$( WORDTEXT$ , 2 , CHR$( 34 ) )
userpass$ = WORD$( WORDTEXT$ , 4 , CHR$( 34 ) )
userok = 0
passok = 0
PRINT " NAME IS: " + username$
PRINT " PASSWORD IS: " + userpass$
print #savefile, "PASSWORD "+chr$(34)+username$+CHR$(34)+", "+CHR$(34)+userpass$+chr$(34)
PRINT "Decoding now....."
RETURN
[PROTECTtKNdIS]
END

[doexternal]'Execute an external file!
open "External.exec" for random as #exc
IF eof(#exc) <> 0 then close #exc:end
line input #exc, fileName$
close #exc
call FileOnly fileName$
call PathOnly fileName$
savebas$ = PathOnly$+word$(FileOnly$,1,".")+".bas"
kill "External.exec"
return


SUB PathOnly getpath$
GLOBAL PathOnly$
 WHILE exitwhile = 1 = 0
   tmp = tmp + 1
   IF word$(getpath$,tmp,"\") = "" then cutout = len(word$(getpath$,tmp-1,"\")):exitwhile = 1
  WEND
 PathOnly$ = left$(getpath$,len(getpath$) - cutout)
END SUB

SUB FileOnly getfile$
GLOBAL FileOnly$
 WHILE exitwhile = 1 = 0
   tmp = tmp + 1
   IF word$(getfile$,tmp,"\") = "" then cutout = len(word$(getfile$,tmp-1,"\")):exitwhile = 1
  WEND
 FileOnly$ = right$(getfile$,cutout)
END SUB

[installreg]
confirm "Add 'Run' and 'Decode' to all .TKN files? ";QA$
IF QA$ = "yes" then
 run "regedit "+DefaultDir$+"\install1.reg"
 run "regedit "+DefaultDir$+"\install2.reg"
 RETURN
END IF
RETURN
