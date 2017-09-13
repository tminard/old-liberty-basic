' Release: LIBERTYBASIC TKN DECODER by Folker Fritz
' Version: 1.12 (2005-02-21)
'  Status: 100% Freeware
'   EMail: folker.fritz@gmx.de
'Homepage: http://www.quickbasic.6x.to
'
' - Please note that this program is only tested with Liberty Basic 4.01 and
'   older. Newer versions are maybe not decodeable with this program. Please
'   also note that the decoded password do not work with all versions of
'   Liberty Basic (example: password from version 3.x will not work with 4.x).
'
' - Please report bugs and/or send me modifications to improve this program.
'
'
' CHANGES Version 1.12                               2005-02-21
'---------------------------------------------------------------
' - Fixed a bug that caused this program to crash when trying to
'   decode very long lines.
' - The decoded Liberty Basic registration username and password
'   is now saved in the decoded file.
'
' CHANGES Version 1.11                               2003-08-27
'---------------------------------------------------------------
' - Little code optimations.
' - Fixed a bug when trying to open files with too long names.
'
' CHANGES Version 1.10                               2003-07-15
'---------------------------------------------------------------
' - Fixed a bug where the body of the *.tkn file was not
'   detected and not decoded.
' - Fixed a bug where linenumbers without Basic commands are not
'   included in the decoded file (happends mostly when a old
'   GW-Basic file is converted into Liberty Basic).
'
' CHANGES Version 1.00                               2003-06-20
'---------------------------------------------------------------
' - Fixed a bug where *.tkn files without password are not
'   correct decoded and displayed.
' - Fixed a bug where the first line was sometimes not encoded.
' - The Liberty Basic registration username and password are now
'   decoded and displayed when exist in the *.tkn file.
'
' CHANGES Version 0.20 beta                          2003-06-13
'---------------------------------------------------------------
' - Added function to decode the header of the *.tkn file.
' - The sub's are recognized and reinsert in the encoded file.
' - The encription key is listed after each line/word.
'
' CHANGES Version 0.11 alpha                         2003-06-12
'---------------------------------------------------------------
' - Fixed a bug where sometimes the new-line was ignored and
'   because of that some parts where decoded incorrectly.
'
' CHANGES Version 0.10 alpha                         2003-06-03
'---------------------------------------------------------------
' - First public release.

DEFINT A-Z
DIM SUBNAME%(2000)
DIM SUBNAME$(2000)
DIM LINENUMBER%(2000)
DIM LINENUMBER$(2000)
SCREEN 0
WIDTH 80, 50
CLS
LOCATE 1, 26
COLOR 12
PRINT "LibertyBASIC TKN Decoder (v1.12)"
LOCATE 1, 46
COLOR 8
LOCATE 2, 27
PRINT "(c) 2003-2005 by Folker Fritz"
LOCATE 3, 28
PRINT "http://www.quickbasic.6x.to"
LOCATE 5, 1
COLOR 15
PRINT "This program is to demonstrate the lameness of Liberty BASIC and what the author"
PRINT "of it calles 'compiling'. The *.tkn files you could create from your *.bas files"
PRINT "are nothing other than only encoded and little bit modified versions of the ori-"
PRINT "ginal sourcecode. This program decodes the *.tkn file back to a *.bas file that"
PRINT "can be run in Liberty BASIC. It also decodes the registration username and pass-"
PRINT "word for Liberty Basic if exist in the *.tkn file and more! So don't belive that"
PRINT "your sourcecode and registrationcode is secure and do not spread *.tkn files."
PRINT "The author of Liberty BASIC, which I had informed about this problem back in the"
PRINT "year 2003, still has not removed it. Instead of this he releases a new mayor"
PRINT "version that still contains this big security risk and he contacted google.com"
PRINT "and other websites where he is doing advertises for Liberty BASIC so they remove"
PRINT "my website from their searchengines and webpages."
PRINT
INPUT "Name of the *.tkn file to open? (Only 8.3 filenames) ", file$

IF file$ = "" THEN END
IF RIGHT$(file$, 4) <> ".tkn" THEN file$ = file$ + ".tkn"
PRINT
IF LEN(file$) > 12 THEN : PRINT "Name of file too long, please rename it!": END

filenum% = FREEFILE
OPEN file$ FOR BINARY AS filenum%
IF LOF(filenum%) = 0 THEN
 COLOR 12: PRINT "File does not exist!"
 CLOSE filenum%: KILL file$
 WHILE INKEY$ = "": WEND: END
END IF
dummy$ = SPACE$(1)

WHILE NOT EOF(filenum%)
 COLOR 15
 WHILE dummy$ <> CHR$(27)
  GET filenum%, , dummy$
  lbstring$ = lbstring$ + dummy$
 WEND
 FOR a = 1 TO LEN(lbstring$) - 1
  PRINT CHR$(ASC(MID$(lbstring$, a, 1)) - (LEN(lbstring$) - 1));
  TEMP1$ = TEMP1$ + CHR$(ASC(MID$(lbstring$, a, 1)) - (LEN(lbstring$) - 1))
 NEXT
 IF tempstart% = 5 THEN
  REMEMBER% = REMEMBER% + 1
  IF REMEMBER% = 2 AND VAL(TEMP2$) <> 0 THEN
   LINENR% = LINENR% + 1
   LINENUMBER%(LINENR%) = VAL(TEMP1$)
   LINENUMBER$(LINENR%) = TEMP2$
  END IF
  IF REMEMBER% = 2 THEN REMEMBER% = 0
 END IF
 IF TEMP1$ = "" THEN tempstart% = tempstart% + 1
 COLOR 8
 IF LEN(lbstring$) - 1 > 0 THEN
  PRINT " key:"; LEN(lbstring$) - 1
 END IF
 IF MID$(TEMP1$, 2, 2) = ":\" THEN
  GOTO continue:
 END IF
 lbstring$ = ""
 dummy$ = SPACE$(1)
 TEMP3$ = TEMP2$
 TEMP2$ = TEMP1$
 TEMP1$ = ""
 IF LEFT$(TEMP3$, 1) = "[" AND RIGHT$(TEMP3$, 1) = "]" THEN
  SUBNR% = SUBNR% + 1
  SUBNAME%(SUBNR%) = VAL(TEMP2$)
  SUBNAME$(SUBNR%) = TEMP3$
  COLOR 10
  PRINT "DETECT SUB: "; SUBNAME$(SUBNR%);
  COLOR 8
  PRINT " position:"; SUBNAME%(SUBNR%)
 END IF
WEND

continue:
COLOR 13
PRINT "FOUND"; SUBNR%; "SUB'S -> PRESS A KEY TO CONTINUE"
COLOR 15

WHILE INKEY$ = "": WEND
PRINT

dummy$ = SPACE$(1)
starter$ = ""
IF dummy$ = CHR$(32) THEN dummy$ = CHR$(27)
starter$ = starter$ + dummy$
GET filenum%, , dummy$
starter$ = starter$ + dummy$

filenum2% = FREEFILE
OPEN "decoded.bas" FOR BINARY AS filenum2%
CLOSE filenum2%
KILL "decoded.bas"
OPEN "decoded.bas" FOR OUTPUT AS filenum2%
PRINT #filenum2%, "' File decoded with LibertyBASIC TKN Decoder (v1.12) by Folker Fritz"
PRINT #filenum2%, "'"

WHILE RIGHT$(starter$, 2) <> CHR$(27) + CHR$(27)
 GET filenum%, , dummy$
 starter$ = starter$ + dummy$
 starter$ = RIGHT$(starter$, 2)
WEND

GET filenum%, LOC(filenum%) - 3, dummy$
lbstring$ = dummy$

WHILE NOT EOF(filenum%)
 IF LEN(lbstring$) < 15 THEN
  IF LOF(filenum%) - LOC(filenum%) < 15 THEN dummy$ = SPACE$(LOF(filenum%) - LOC(filenum%))
  IF LOF(filenum%) = LOC(filenum%) THEN GOTO 1
  GET filenum%, , dummy$
  lbstring$ = lbstring$ + dummy$
  IF RIGHT$(dummy$, 1) = CHR$(27) THEN
   AA = 1
   dummy$ = SPACE$(1)
   GET filenum%, , dummy$
   lbstring$ = lbstring$ + dummy$
   IF RIGHT$(dummy$, 1) = CHR$(27) THEN
    AA = 2
    GET filenum%, , dummy$
    lbstring$ = lbstring$ + dummy$
   END IF
   dummy$ = SPACE$(1)
  END IF
 END IF
 WHILE a <= 15 + AA
  a = a + 1
  TEMP$ = MID$(lbstring$, a, 1)
  IF MID$(lbstring$, a, 2) = CHR$(27) + CHR$(27) THEN
   ENCODE% = ENCODE% - 1
   L = L + 1
   FOR B = 3 TO LEN(temptxt$)
    stemp$ = MID$(temptxt$, B, 1)
    IF stemp$ = CHR$(27) THEN
     WRITETXT$ = WRITETXT$ + " "
    ELSE
     IF ASC(stemp$) - ENCODE% > 0 THEN
      WRITETXT$ = WRITETXT$ + CHR$(ASC(stemp$) - ENCODE%)
     ELSE
      IF ASC(stemp$) > 0 THEN
       WRITETXT$ = WRITETXT$ + CHR$(ASC(stemp$))
      END IF
     END IF
    END IF
   NEXT
   TEMS$ = ""
   DO WHILE TEMS$ <> " "
    AD = AD + 1
    IF AD > LEN(WRITETXT$) THEN EXIT DO
    TEMS$ = MID$(WRITETXT$, AD, 1)
    LNUM$ = LNUM$ + TEMS$
   LOOP
   LNUM% = VAL(LNUM$)
   IF LNUM% = 0 THEN START% = 1
   IF SUBNR% > 0 THEN
    FOR P% = 1 TO SUBNR%
     IF SUBNAME%(P%) = LNUM% THEN
      COLOR 10
      PRINT SUBNAME$(P%)
      PRINT #filenum2%, SUBNAME$(P%)
      COLOR 15
     END IF
    NEXT
   END IF
   IF LINENR% > 0 THEN
    FOR P% = 1 TO LINENR%
     IF LINENUMBER%(P%) = LNUM% THEN
      HH% = LEN(STR$(LNUM%)) + 1
      HHH% = LEN(LINENUMBER$(P%))
      IF MID$(WRITETXT$, HH%, HHH%) <> LINENUMBER$(P%) THEN
       LINENRINSERT% = LINENRINSERT% + 1
       COLOR 11
       PRINT LINENUMBER$(P%)
       PRINT #filenum2%, LINENUMBER$(P%)
       COLOR 15
      END IF
     END IF
    NEXT
   END IF
   TEMS$ = ""
   LNUM$ = ""
   AD = 0
   HH% = LEN(STR$(LNUM%))
   IF LEN(WRITETXT$) - HH% >= 0 THEN
    LL = LL + 1
    IF LL = 1 THEN
     DO WHILE TEMS$ <> " "
      AD = AD + 1
      IF AD > LEN(WRITETXT$) THEN EXIT DO
      TEMS$ = MID$(WRITETXT$, AD, 1)
     LOOP
     FOR B = AD + 1 TO LEN(WRITETXT$)
      IF MID$(WRITETXT$, B, 1) = " " THEN
       WRITETXT2$ = WRITETXT2$ + " "
      ELSE
       WRITETXT2$ = WRITETXT2$ + CHR$(ASC(MID$(WRITETXT$, B, 1)) + 1)
      END IF
     NEXT
     IF MID$(WRITETXT2$, 3, 8) <> "PASSWORD" THEN
      PRINT MID$(WRITETXT2$, 3, LEN(WRITETXT2$) - 2);
      PRINT #filenum2%, MID$(WRITETXT2$, 3, LEN(WRITETXT2$) - 2);
      COLOR 8
      PRINT " key:"; ENCODE% - 1
      COLOR 15
     ELSE
      PASSWORDFOUND$ = MID$(WRITETXT2$, 11, LEN(WRITETXT2$) - 10)
     END IF
     AD = 0
    END IF
    IF LL > 1 THEN
     IF START% = 1 THEN
      PRINT RIGHT$(WRITETXT$, LEN(WRITETXT$) - HH%);
      PRINT #filenum2%, RIGHT$(WRITETXT$, LEN(WRITETXT$) - HH%)
      COLOR 8
      PRINT " key:"; ENCODE%
      COLOR 15
     END IF
    END IF
   END IF
   WRITETXT$ = ""
   ENCODE% = 0
   temptxt$ = ""
  END IF
  IF TEMP$ = CHR$(27) THEN
   temptxt$ = temptxt$ + TEMP$
   ENCODE% = ENCODE% + 1
  ELSE
   IF TEMP$ <> "" THEN temptxt$ = temptxt$ + TEMP$
  END IF
 WEND
 lbstring$ = ""
 a = 0
 AA = 0
WEND
1
COLOR 13
IF LINENR% > 0 THEN PRINT "REINSERT"; LINENRINSERT%; "MISSING LINENUMBERS OF"; LINENR%; "FOUND IN THE FILE"
IF PASSWORDFOUND$ = "" THEN
 PRINT "NO USERNAME/PASSWORD FOUND IN THE FILE"
ELSE
 PRINT "USERNAME/PASSWORD FOUND!:"; PASSWORDFOUND$
 PRINT #filenum2%, "'"
 PRINT #filenum2%, "' Username and password:"; PASSWORDFOUND$
END IF
COLOR 12
PRINT
PRINT "END OF FILE! -> DECODED FILE SAVED AS 'DECODED.BAS'";
COLOR 7
CLOSE filenum%
CLOSE filenum2%
WHILE INKEY$ = "": WEND
PRINT
END

