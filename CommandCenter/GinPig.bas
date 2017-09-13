

                                                                                                                
PASSWORD "Carl Gundel", "9BCDD8"
DIM branch$( 100 , 100 )
debug = 1
CommandLine$ = "openout=C:\save.txt=blue,white,Tyler Minard,YCPWF"
IF TRIM$( CommandLine$ ) = "" THEN CommandLine$ = "C=Documents and Settings\Tyler Minard\Desktop\install.set"
IF TRIM$( CommandLine$ ) = "" = 0 THEN GOSUB [load.com]
GOTO [load.datafile]
END

[load.datafile]
DIM name$( 1000 )
OPEN "chart.txt" FOR INPUT AS #chart
GOSUB [load.branches]
CLS
GOTO [prompt.goto]
END

[prompt.goto]
IF fgh = 0 THEN INPUT "list goto ([*]):" ; goto$
GOTO [prompt.difcom]
END

[prompt.difcom]
IF LOWER$( goto$ ) = "end" THEN END
IF goto$ = "?" THEN GOTO [show.all]
IF LOWER$( goto$ ) = "cls" THEN CLS : GOTO [prompt.goto]
ok = 0
FOR i = 1 TO branches
IF "[" + goto$ + "]" = branch$( i , 0 ) THEN ok = 1 : EXIT FOR
NEXT i
IF ok = 0 THEN PRINT "'[" + goto$ + "]' is an invalid branch name!" : CLS : GOTO [load.datafile] : END
CLS
goto$ = "[" + goto$ + "]"
GOSUB [goto]
gotoend = 0
FOR i = 1 TO 100000
LINE INPUT #chart , listext$
IF LOWER$( WORD$( listext$ , 1 , "=" ) ) = "openout" THEN OPEN WORD$( listext$ , 2 , "=" ) FOR OUTPUT AS #of : PRINT #of , WORD$( listext$ , 3 , "=" ) : CLOSE #of : PRINT "Command OK!"
IF LOWER$( WORD$( listext$ , 1 , "=" ) ) = "notice" THEN NOTICE WORD$( listext$ , 2 , "=" )
IF LOWER$( WORD$( listext$ , 1 , "=" ) ) = "run" THEN RUN WORD$( listext$ , 2 , "=" )
IF LOWER$( WORD$( listext$ , 1 , "=" ) ) = "comm" THEN goto$ = WORD$( listext$ , 2 , "=" ) : gotoend = 1 : EXIT FOR
IF listext$ = "end" THEN EXIT FOR
PRINT listext$
NEXT i
IF gotoend = 1 THEN CLOSE #chart : PRINT "--Done!--" : GOTO [prompt.difcom]
CLOSE #chart
IF fgh = 1 THEN END
PRINT "--Done!--"
GOTO [prompt.goto]
END

[load.branches]
branches = 0
FOR i = 1 TO 10000
IF EOF( #chart ) <> 0 THEN EXIT FOR
LINE INPUT #chart , text$
IF RIGHT$( text$ , 1 ) = "]" AND LEFT$( text$ , 1 ) = "[" THEN branches = branches + 1 : branch$( branches , 0 ) = text$ : branch$( branches , 1 ) = STR$( i )
NEXT i
CLOSE #chart
RETURN

[print.branches]
FOR i = 1 TO branches
PRINT branch$( i , 0 )
PRINT branch$( i , 1 )
NEXT i
RETURN

[goto]
FOR i = 1 TO branches
IF branch$( i , 0 ) = goto$ THEN EXIT FOR
NEXT i
IF branch$( i , 0 ) = goto$ = 0 THEN PRINT "Error! Branch [" + goto$ + "] not found!"
gt = VAL( branch$( i , 1 ) )
OPEN "chart.txt" FOR INPUT AS #chart
FOR i = 1 TO gt
LINE INPUT #chart , blank$
NEXT i
RETURN

[load.stuff]
goto$ = "[people]"
GOSUB [goto]
LINE INPUT #chart , num
PRINT "People:" ; num
CLOSE #chart
goto$ = "[names]"
GOSUB [goto]
FOR i = 1 TO num
LINE INPUT #chart , name$( i )
PRINT "Name:" + name$( i )
NEXT i
CLOSE #chart
RETURN

[show.all]
CLS
PRINT "--Branches--"
FOR i = 1 TO branches
PRINT branch$( i , 0 )
NEXT i
PRINT "-----------"
GOTO [prompt.goto]
END

[load.com]
IF LOWER$( WORD$( CommandLine$ , 1 , "=" ) ) = "openout" THEN OPEN WORD$( CommandLine$ , 2 , "=" ) FOR OUTPUT AS #of : PRINT #of , WORD$( CommandLine$ , 3 , "=" ) : CLOSE #of : PRINT "Command OK!" : END
IF LOWER$( WORD$( CommandLine$ , 1 ) ) = "add" THEN OPEN "chart.txt" FOR append AS #1 : OPEN WORD$( CommandLine$ , 2 ) FOR INPUT AS #45 : e45e = LOF( #45 ) : e$ = INPUT$( #45 , e45e ) : CLOSE #45 : PRINT #1 , WORD$( CommandLine$ , 3 ) : PRINT #1 , e$ : PRINT #1 , "end" : CLOSE #1 : PRINT "Command OK!"
IF LOWER$( WORD$( CommandLine$ , 1 , "=" ) ) = "comm" THEN goto$ = WORD$( listext$ , 2 , "=" ) : fgh = 1
RETURN
PRINT WORD$( CommandLine$ , 1 , "=" ) + ":\" + WORD$( CommandLine$ , 2 , "=" )
OPEN WORD$( CommandLine$ , 1 , "=" ) + ":\" + WORD$( CommandLine$ , 2 , "=" ) FOR INPUT AS #1
lenotxt = LOF( #1 )
gettxt$ = INPUT$( #1 , lenotxt )
CLOSE #1
OPEN "prog.pak" FOR OUTPUT AS #2
PRINT #2 , gettxt$
CLOSE #2
GOSUB [extract.data]
RETURN

[functions]
FUNCTION fileExists( path$ , filename$ )
DIM info$( 1000 , 10 )
FILES path$ , filename$ , info$(
fileExists = VAL( info$( 0 , 0 ) ) > 0
END FUNCTION

[extract.data]
OPEN "prog.pak" FOR INPUT AS #1
INPUT #1 , file
INPUT #1 , pass$
GOTO [top2]
END

[top2]
IF err$ = "on" THEN CLOSE #1 : err$ = "" : WAIT
INPUT #1 , filename$
IF filename$ = "endall" OR lenth$ = "endall" THEN CLOSE #1 : RETURN
INPUT #1 , lenth$
lenth = VAL( lenth$ )
doitnow = MKDIR( drivess$ )
IF err$ = "on" THEN CLOSE #2 : CLOSE #1 : err$ = "" : WAIT
OPEN drivess$ + filename$ FOR OUTPUT AS #2
text$ = INPUT$( #1 , lenth )
PRINT #2 , text$
CLOSE #2
IF EOF( #1 ) <> 0 THEN CLOSE #1 : RETURN
INPUT #1 , blank$
IF blank$ = "NEXT DISK" THEN INPUT #1 , nextdisk$ : NOTICE "Please insert the next disk to continue setup"
IF blank$ = "NEXT DISK" THEN GOTO [get.nextdisk]
IF EOF( #1 ) <> 0 THEN CLOSE #1 : RETURN
GOTO [top2]
END

[get.nextdisk]
IF err$ = "on" THEN CLOSE #1 : err$ = "" : WAIT
IF fileExists( "" , nextdisk$ ) THEN GOTO [load.nextdisk]
IF fileExists( "" , nextdisk$ ) = 0 THEN NOTICE "Invailed Disk! Please insert next disk! Continue?" ; cont$
IF cont$ = "no" THEN CLOSE #1 : END
GOTO [get.nextdisk]
END

[load.nextdisk]
CLOSE #1
OPEN nextdisk$ FOR INPUT AS #1
INPUT #1 , file
INPUT #1 , pass$
GOTO [top]
END
