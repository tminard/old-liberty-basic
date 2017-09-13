

                                                                                                                                                                                                                                                                                                                                                              
PASSWORD "Klaus Roemer", "357E8D"
dummyfile$ = "\com314.obx"
constant1 = 9314637
Ca = 2
TimeLimit = 10
OPEN "kernel32" FOR dll AS #kernel
WindowsSys$ = SPACE$( 200 ) + CHR$( 0 )
CALLDLL #kernel , "GetSystemDirectoryA" , WindowsSys$ AS ptr , 200 AS long , result AS long
CLOSE #kernel
SystemPath$ = TRIM$( WindowsSys$ )
OPEN SystemPath$ + dummyfile$ FOR append AS #Registerfile
CLOSE #Registerfile
OPEN SystemPath$ + dummyfile$ FOR INPUT AS #Registerfile
IF EOF( #Registerfile ) = -1 THEN [endregister]
LINE INPUT #Registerfile , name$
INPUT #Registerfile , Regza
RegistrationNo1 = Regza
howmany = RegistrationNo1
GOSUB [encryption]
IF No1 = RegistrationNo1 THEN CLOSE #Registerfile
IF No1 = RegistrationNo1 THEN [ThisGuyHasRegistered]
IF name$ <> DATE$( ) THEN howmany = howmany + 312
dummy = dummy + 3

[endregister]
CLOSE #Registerfile
name$ = DATE$( )
OPEN SystemPath$ + dummyfile$ FOR OUTPUT AS #Registerfile
PRINT #Registerfile , name$
PRINT #Registerfile , howmany
PRINT #Registerfile , dummy * 3.1 ^ 2
CLOSE #Registerfile
IF ( howmany / 312 ) + 1 > TimeLimit THEN [kissoff]
NOMAINWIN
UpperLeftX = 180
UpperLeftY = 130
WindowWidth = 330
WindowHeight = 290
BackgroundColor$ = "buttonface"
ForegroundColor$ = "red"
LOADBMP "info" , "bmp\info.bmp"
GROUPBOX #notice1.group1 , "" , 7 , 240 , 310 , 8
GRAPHICBOX #notice1.graph1 , 5 , 16 , 315 , 178
BUTTON #notice1.b1 , "Register Now" , [Register.Now] , UL , 7 , 208 , 99 , 25
BUTTON #notice1.b2 , "Buy Now" , [Buy.Now] , UL , 112 , 208 , 99 , 25
BUTTON #notice1.b3 , "Register Later" , [Register.Later] , UL , 218 , 208 , 99 , 25
OPEN "Welcome!" FOR dialog AS #notice1
PRINT #notice1 , "trapclose [quit]"
#notice1 , "font ms_sans_serif 9"
#notice1.graph1 "color black;font arial 9"
#notice1.graph1 "place 50, 20,"
#notice1.graph1 "\You are using a 10 days trial version of this"
#notice1.graph1 "place 48, 35,"
#notice1.graph1 "\ program. To continue using this software"
#notice1.graph1 "place 10, 50,"
#notice1.graph1 "\after 10 days, requires registration. To purchase a"
#notice1.graph1 "place 10, 65,"
#notice1.graph1 "\registration key, click on  [Buy Now]. If you allready"
#notice1.graph1 "place 10, 80,"
#notice1.graph1 "\have a registration key, click on  [Register Now]."
#notice1.graph1 "place 10, 95,"
#notice1.graph1 "\If you would like to continue evaluating this software,"
#notice1.graph1 "place 10, 110,"
#notice1.graph1 "\click on  [Register Later]"
#notice1.graph1 "color red;font arial bold 9"
#notice1.graph1 "place 10, 130,"
#notice1.graph1 "\You are now on day " ; INT( howmany / 312 ) + 1 ;
#notice1.graph1 "place 140, 130," ;
#notice1.graph1 "\of your evaluation period."
#notice1.graph1 "place 10, 145,"
#notice1.graph1 "color black;font arial bold 9"
#notice1.graph1 "\This notice will be removed after you register."
#notice1.graph1 "color black;font arial 9"
#notice1.graph1 "place 215, 169,"
#notice1.graph1 "\© 2000 -2003"
PRINT #notice1.graph1 , "drawbmp info 13 10 :flush"
#notice1.graph1 "flush"
WAIT
UNLOADBMP "info"

[Register.Now]
CLOSE #notice1
GOTO [Register]

[Buy.Now]
CLOSE #notice1
pathname$ = MID$( DefaultDir$ , 1 , LEN( DefaultDir$ ) )
registerInfo$ = "notepad.exe " + pathname$ + "\register.txt"
RUN registerInfo$
GOTO [MainLoop]

[Register.Later]
CLOSE #notice1
GOTO [MainProgram]

[quit]
CLOSE #notice1
END

[MainProgram]
IF ( howmany / 312 ) + 1 > TimeLimit THEN [kissoff]

[ThisGuyHasRegistered]
NOMAINWIN
DIM info$( 10 , 10 )
STRUCT ti , cbSize AS long , uFlags AS long , hwnd AS long , uId AS long , left AS long , top AS long , right AS long , bottom AS long , hinst AS long , lpszText AS ptr
ti.cbSize.struct = LEN( ti.struct )
ti.uFlags.struct = 17
NOMAINWIN
WindowWidth = 510
WindowHeight = 347
UpperLeftX = 110
UpperLeftY = 100
BackgroundColor$ = "buttonface"
ForegroundColor$ = "black"
IF ProgramFlag > 0 THEN CLOSE #main
ProgramFlag = 1
LOADBMP "panelLeft" , "Bmp\panelLeft.bmp"
LOADBMP "panelTop" , "BMP\panelTop.bmp"
GRAPHICBOX #main.graph3 , 3 , 280 , 132 , 21
GRAPHICBOX #main.graph2 , -1 , -1 , 515 , 61
GRAPHICBOX #main.graph1 , -1 , -1 , 515 , 350
BUTTON #main.b1 , "" , [clean] , UL , 172 , 80 , 80 , 60
BUTTON #main.b2 , "" , [settings] , UL , 172 , 143 , 80 , 60
BUTTON #main.b3 , "" , [tools] , UL , 172 , 207 , 80 , 60
BUTTON #main.b7 , "" , [recycle] , UL , 440 , 181 , 50 , 73
BUTTON #main.b4 , "&Close" , [close.main] , UL , 431 , 292 , 60 , 20
BUTTON #main.b5 , "&Help" , [main.help] , UL , 365 , 292 , 60 , 20
BUTTON #main.b6 , "&About" , [about] , UL , 299 , 292 , 60 , 20
OPEN "KRDC" FOR window_nf AS #main
PRINT #main , "trapclose [close.main]"
PRINT #main , "font ms_sans_serif 9"
hGbox = HWND( #main.graph3 )
hStyle = GetWindowLong( hGbox , -16 )
hNewStyle = SetWindowLong( hGbox , -16 , hStyle XOR 8388608 )
hGbox = HWND( #main.graph2 )
hStyle = GetWindowLong( hGbox , -16 )
hNewStyle = SetWindowLong( hGbox , -16 , hStyle XOR 8388608 )
BackgroundColor$ = "buttonface"
ForegroundColor$ = ""
STATICTEXT #dummy.1 , "" , -4000 , -2000 , 0 , 0
OPEN "" FOR window AS #dummy.1
PRINT #dummy.1 , "font arial bold 8"
CALL SetParent HWND( #main ) , HWND( #dummy.1 )
CALL ShowWindow HWND( #dummy.1 ) , 0
PRINT #main.graph1 , "down;fill buttonface; flush"
PRINT #main.graph2 , "down;fill 240 184 80; flush"
PRINT #main.graph3 , "down;fill buttonface; flush"
PRINT #main.graph2 , "drawbmp panelTop -4 -5:flush"
PRINT #main.graph1 , "drawbmp panelLeft 1 66:flush"
Section$ = "Options"
Entry$ = "AutoClean"
FileName$ = DefaultDir$ ; "\Dskcln.ini"
Default$ = "no name" + CHR$( 0 )
SizeString = 100
ReturnString$ = SPACE$( SizeString ) + CHR$( 0 )
CALLDLL #kernel32 , "GetPrivateProfileStringA" , Section$ AS ptr , Entry$ AS ptr , Default$ AS ptr , ReturnString$ AS ptr , SizeString AS long , FileName$ AS ptr , result AS long
AutoClean$ = LEFT$( ReturnString$ , result )
IF AutoClean$ = "OFF" THEN
#main.graph3 "color black;font arial 9;backcolor buttonface"
#main.graph3 "place 11 14"
#main.graph3 "\AutoClean is - "
#main.graph3 "color red;font arial 9 bold;backcolor buttonface"
#main.graph3 "place 92 14"
#main.graph3 "\OFF"
ELSE
#main.graph3 "color black;font arial 9;backcolor buttonface"
#main.graph3 "place 11 14"
#main.graph3 "\AutoClean is - "
#main.graph3 "color green;font arial 9 bold;backcolor buttonface"
#main.graph3 "place 92 14"
#main.graph3 "\ON"
END IF
#main.graph3 , "flush"
#main.graph2 , "flush"
#main.graph1 , "flush"
PRINT #main , "refresh"
hParent = HWND( #main )
hTT = CreateTooltip( hParent )
CALL AddTooltip HWND( #main.b1 ) , "Click to Delete Junk Files Now." , hTT
CALL AddTooltip HWND( #main.b2 ) , "Set Cleaning Options." , hTT
CALL AddTooltip HWND( #main.b3 ) , "Click for Extra Windows Tools" , hTT
CALL AddTooltip HWND( #main.b4 ) , "Close Program and Exit." , hTT
CALL AddTooltip HWND( #main.b5 ) , "Click if you need Help." , hTT
CALL AddTooltip HWND( #main.b6 ) , "Click for Information about Program." , hTT
style = 3
xLoc = 141 : yLoc = 65 : eW = 360 : eH = 219
PRINT #main.graph1 , drawEdge$( style , xLoc , yLoc , eW , eH )
style = 6
xLoc = 144 : yLoc = 68 : eW = 354 : eH = 212
PRINT #main.graph1 , drawEdge$( style , xLoc , yLoc , eW , eH )
style = 6
xLoc = -1 : yLoc = 60 : eW = 505 : eH = 1
PRINT #main.graph1 , drawEdge$( style , xLoc , yLoc , eW , eH )
style = 2
xLoc = 1 : yLoc = 066 : eW = 135 : eH = 236
PRINT #main.graph1 , drawEdge$( style , xLoc , yLoc , eW , eH )
style = 1
xLoc = 2 : yLoc = 279 : eW = 133 : eH = 22
PRINT #main.graph1 , drawEdge$( style , xLoc , yLoc , eW , eH )
PRINT #main.graph1 , "flush"
PRINT #main.graph2 , "flush"
hB1 = LoadBitmapSystemColors( "Bmp\brush.bmp" )
h1 = HWND( #main.b1 )
modifyStyle = 128 OR 32768
r = changeStyle( h1 , modifyStyle )
CALLDLL #user32 , "SendMessageA" , h1 AS long , 247 AS long , 0 AS long , hB1 AS long , r AS void
hB2 = LoadBitmapSystemColors( "Bmp\set.bmp" )
h2 = HWND( #main.b2 )
modifyStyle = 128 OR 32768
r = changeStyle( h2 , modifyStyle )
CALLDLL #user32 , "SendMessageA" , h2 AS long , 247 AS long , 0 AS long , hB2 AS long , r AS void
hB3 = LoadBitmapSystemColors( "Bmp\tools.bmp" )
h3 = HWND( #main.b3 )
modifyStyle = 128 OR 32768
r = changeStyle( h3 , modifyStyle )
CALLDLL #user32 , "SendMessageA" , h3 AS long , 247 AS long , 0 AS long , hB3 AS long , r AS void
hB7 = LoadBitmapSystemColors( "Bmp\recycle.bmp" )
h7 = HWND( #main.b7 )
modifyStyle = 128 OR 32768
r = changeStyle( h7 , modifyStyle )
CALLDLL #user32 , "SendMessageA" , h7 AS long , 247 AS long , 0 AS long , hB7 AS long , r AS void
GOSUB [Set.colorText]

[MainLoop]
WAIT

[clean]
STRUCT lpFree , BytesL AS ulong , BytesH AS ulong
STRUCT lpTotal , BytesL AS ulong , BytesH AS ulong
STRUCT lpTotFree , BytesL AS ulong , BytesH AS ulong
CALLDLL #kernel32 , "GetDiskFreeSpaceExA" , "C:\" AS ptr , lpFree AS STRUCT , lpTotal AS STRUCT , lpTotFree AS STRUCT , ret AS long
OPEN "space1.dat" FOR OUTPUT AS #f
PRINT #f , "" ; InUnits$( lpTotFree.BytesH.struct * HEXDEC( "100000000" ) + lpTotFree.BytesL.struct )
CLOSE #f
IF fileExists( DefaultDir$ , "Rcb\flagRCB.dat" ) THEN
RUN "RCB\rcb.exe /HIDE"
ELSE
GOTO [clean.now]
END IF

[clean.now]
RUN "Clean\clean.exe" , HIDE
CALL ProgBar1
WAIT

[tools]
GOSUB [Tools.Window]
WAIT

[close.main]
GOTO [quit.main]

[main.help]
file$ = "Help\dc_help.chm"
result = ShellExecute( hWnd , file$ , "" )
IF result <= 32 THEN NOTICE "Error, Address Failure!"
GOTO [MainLoop]

[about]
GOSUB [AboutBox]
GOTO [MainLoop]

[settings]
GOSUB [cleanSettings]
GOTO [MainLoop]

[recycle]
RUN "RCB\rcb.exe /HIDE"
GOTO [MainLoop]

[quit.main]
UNLOADBMP "panelLeft"
UNLOADBMP "panelTop"
IF RegisterFlag > 0 THEN CLOSE #Register
IF ProgramFlag > 0 THEN CLOSE #main : CLOSE #dummy.1
IF fileExists( DefaultDir$ , "BMP\Pic3.bmp" ) THEN
KILL "BMP\Pic3.bmp"
ELSE
END
END IF
END

[cleanSettings]
NOMAINWIN
WindowWidth = 346
WindowHeight = 295
UpperLeftX = 180
UpperLeftY = 130
hist$ = "Clear 'History Folder'"
trash$ = "Empty 'Recycle Bin'"
auto$ = "If 'AutoClean' is ON" + CHR$( 13 ) + "'KR-DiskClean' will remove Junk Files" + CHR$( 13 ) + "automaticaly each time your computer starts."
BackgroundColor$ = "buttonface"
ForegroundColor$ = "black"
GRAPHICBOX #set.graph2 , -1 , -1 , 405 , 50
GROUPBOX #set.group1 , "Optional items to include during cleaning" , 30 , 60 , 280 , 70
GROUPBOX #set.group2 , "AutoClean" , 30 , 140 , 280 , 70
GROUPBOX #set.group3 , "" , 1 , 220 , 346 , 8
STATICTEXT #set.txt1 , hist$ , 75 , 82 , 220 , 15
STATICTEXT #set.txt3 , trash$ , 75 , 107 , 220 , 15
STATICTEXT #set.txt2 , auto$ , 75 , 162 , 220 , 40
BUTTON #set.b1 , "&Help" , [set.help] , UL , 200 , 239 , 60 , 20
BUTTON #set.b2 , "&Close" , [close.Set] , UL , 270 , 239 , 60 , 20
CHECKBOX #set.cb1 , "" , [cb1set] , [cb1reset] , 50 , 82 , 15 , 15
CHECKBOX #set.cb3 , "" , [cb3set] , [cb3reset] , 50 , 107 , 15 , 15
CHECKBOX #set.cb2 , "" , [cb2set] , [cb2reset] , 50 , 162 , 15 , 15
OPEN "Settings" FOR window_nf AS #set
PRINT #set , "trapclose [close.Set]"
PRINT #set , "font ms_sans_serif bold 8"
PRINT #set.txt1 , "!font ms_sans_serif 8"
PRINT #set.txt2 , "!font ms_sans_serif 8"
PRINT #set.txt3 , "!font ms_sans_serif 8"
PRINT #set.graph2 , "down;fill 240 184 80; flush"
hW = HWND( #set )
h1 = HWND( #set.b1 )
h2 = HWND( #set.b2 )
#set.graph2 "color black;font ms_sans_serif bold 14;backcolor 240 184 80"
#set.graph2 "place 60 30"
#set.graph2 "\Setup Cleaning Options"
PRINT #set.graph2 , "flush"
hw = HWND( #set )
h1 = HWND( #set.b1 )
modifyStyle = 768 OR 8192 OR 32768
r = changeStyle( h1 , modifyStyle )
h2 = HWND( #set.b2 )
modifyStyle = 768 OR 8192 OR 32768
r = changeStyle( h2 , modifyStyle )
PRINT #set.b1 , "!font ms_sans_serif 8"
PRINT #set.b2 , "!font ms_sans_serif 8"
PRINT #set , "refresh"
Section$ = "Options"
Entry$ = "CleanHistory"
FileName$ = DefaultDir$ ; "\Dskcln.ini"
Default$ = "no name" + CHR$( 0 )
SizeString = 100
ReturnString$ = SPACE$( SizeString ) + CHR$( 0 )
CALLDLL #kernel32 , "GetPrivateProfileStringA" , Section$ AS ptr , Entry$ AS ptr , Default$ AS ptr , ReturnString$ AS ptr , SizeString AS long , FileName$ AS ptr , result AS long
History$ = LEFT$( ReturnString$ , result )
IF History$ = "ON" THEN
PRINT #set.cb1 , "set"
ELSE
PRINT #set.cb1 , "reset"
END IF
Section$ = "Options"
Entry$ = "AutoClean"
FileName$ = DefaultDir$ ; "\Dskcln.ini"
Default$ = "no name" + CHR$( 0 )
SizeString = 100
ReturnString$ = SPACE$( SizeString ) + CHR$( 0 )
CALLDLL #kernel32 , "GetPrivateProfileStringA" , Section$ AS ptr , Entry$ AS ptr , Default$ AS ptr , ReturnString$ AS ptr , SizeString AS long , FileName$ AS ptr , result AS long
AutoClean$ = LEFT$( ReturnString$ , result )
IF AutoClean$ = "ON" THEN
PRINT #set.cb2 , "set"
ELSE
PRINT #set.cb2 , "reset"
END IF
Section$ = "Options"
Entry$ = "RecycleBin"
FileName$ = DefaultDir$ ; "\Dskcln.ini"
Default$ = "no name" + CHR$( 0 )
SizeString = 100
ReturnString$ = SPACE$( SizeString ) + CHR$( 0 )
CALLDLL #kernel32 , "GetPrivateProfileStringA" , Section$ AS ptr , Entry$ AS ptr , Default$ AS ptr , ReturnString$ AS ptr , SizeString AS long , FileName$ AS ptr , result AS long
RecycleBin$ = LEFT$( ReturnString$ , result )
IF RecycleBin$ = "ON" THEN
PRINT #set.cb3 , "set"
ELSE
PRINT #set.cb3 , "reset"
END IF
WAIT

[cb1set]
PRINT #set.cb1 , "set"
Section$ = "Options"
Entry$ = "CleanHistory"
String$ = "ON"
FileName$ = DefaultDir$ ; "\Dskcln.ini"
CALLDLL #kernel32 , "WritePrivateProfileStringA" , Section$ AS ptr , Entry$ AS ptr , String$ AS ptr , FileName$ AS ptr , result AS long
RUN "Clean\histON.exe" , HIDE
WAIT

[cb1reset]
PRINT #set.cb1 , "reset"
Section$ = "Options"
Entry$ = "CleanHistory"
String$ = "OFF"
FileName$ = DefaultDir$ ; "\Dskcln.ini"
CALLDLL #kernel32 , "WritePrivateProfileStringA" , Section$ AS ptr , Entry$ AS ptr , String$ AS ptr , FileName$ AS ptr , result AS long
RUN "Clean\histOFF.exe" , HIDE
WAIT

[cb2set]
PRINT #set.cb2 , "set"
Section$ = "Options"
Entry$ = "AutoClean"
String$ = "ON"
FileName$ = DefaultDir$ ; "\Dskcln.ini"
#main.graph3 , "down;fill buttonface; flush"
#main.graph3 "color black;font arial 9;backcolor buttonface"
#main.graph3 "place 11 14"
#main.graph3 "\AutoClean is - "
#main.graph3 "color green;font arial 9 bold;backcolor buttonface"
#main.graph3 "place 92 14"
#main.graph3 "\ON"
#main.graph3 , "flush"
PRINT #main , "refresh"
CALLDLL #kernel32 , "WritePrivateProfileStringA" , Section$ AS ptr , Entry$ AS ptr , String$ AS ptr , FileName$ AS ptr , result AS long
RUN "Clean\autoON.exe" , HIDE
WAIT

[cb2reset]
PRINT #set.cb2 , "reset"
Section$ = "Options"
Entry$ = "AutoClean"
String$ = "OFF"
FileName$ = DefaultDir$ ; "\Dskcln.ini"
#main.graph3 , "down;fill buttonface; flush"
#main.graph3 "color black;font arial 9;backcolor buttonface"
#main.graph3 "place 11 14"
#main.graph3 "\AutoClean is - "
#main.graph3 "color red;font arial 9 bold;backcolor buttonface"
#main.graph3 "place 92 14"
#main.graph3 "\OFF"
#main.graph3 , "flush"
PRINT #main , "refresh"
CALLDLL #kernel32 , "WritePrivateProfileStringA" , Section$ AS ptr , Entry$ AS ptr , String$ AS ptr , FileName$ AS ptr , result AS long
RUN "Clean\autoOFF.exe" , HIDE
PRINT #set.graph2 , "flush"
WAIT

[cb3set]
PRINT #set.cb3 , "set"
Section$ = "Options"
Entry$ = "RecycleBin"
String$ = "ON"
FileName$ = DefaultDir$ ; "\Dskcln.ini"
CALLDLL #kernel32 , "WritePrivateProfileStringA" , Section$ AS ptr , Entry$ AS ptr , String$ AS ptr , FileName$ AS ptr , result AS long
OPEN "Rcb\flagRCB.dat" FOR OUTPUT AS #flagRCB
PRINT "xxxx"
CLOSE #flagRCB
RUN "REGEDIT /S rcb\rcb_ON.reg"
WAIT

[cb3reset]
PRINT #set.cb3 , "reset"
Section$ = "Options"
Entry$ = "RecycleBin"
String$ = "OFF"
FileName$ = DefaultDir$ ; "\Dskcln.ini"
CALLDLL #kernel32 , "WritePrivateProfileStringA" , Section$ AS ptr , Entry$ AS ptr , String$ AS ptr , FileName$ AS ptr , result AS long
IF fileExists( DefaultDir$ , "Rcb\flagRCB.dat" ) THEN
KILL "Rcb\flagRCB.dat"
ELSE
GOTO [MainLoop]
END IF
RUN "REGEDIT /S rcb\rcb_OFF.reg"
WAIT

[set.help]
file$ = "Help\dc_help.chm"
result = ShellExecute( hWnd , file$ , "" )
IF result <= 32 THEN NOTICE "Error, Address Failure!"
WAIT

[close.Set]
CLOSE #set
RETURN

[AboutBox]
NOMAINWIN
WindowWidth = 346
WindowHeight = 350
UpperLeftX = 180
UpperLeftY = 80
abouttxt$ = "KR-DiskClean searches your computer for many types of" + CHR$( 13 ) + "unwanted junk files and removes them. Unlike most" + CHR$( 13 ) + "disk cleaners that require advanced computer knowledge" + CHR$( 13 ) + "to use them, KR-DiskClean was desigend with the " + CHR$( 13 ) + "avarage computer user in mind. The program can be" + CHR$( 13 ) + "used by anyone because it is very easy to use and" + CHR$( 13 ) + "no advanced knowledge is required."
BackgroundColor$ = "buttonface"
ForegroundColor$ = "black"
LOADBMP "about" , "Bmp\about.bmp"
GRAPHICBOX #About.graph1 , 5 , 5 , 330 , 205
GRAPHICBOX #About.graph4 , 4 , 250 , 184 , 19
GRAPHICBOX #About.graph5 , 4 , 274 , 220 , 18
GRAPHICBOX #About.graph6 , -1 , 210 , 351 , 110
GROUPBOX #About.group1 , "" , 2 , 300 , 334 , 8
STATICTEXT #About.txt5 , "" ; abouttxt$ , 13 , 90 , 320 , 110
STATICTEXT #About.txt6 , "Copyright ©2000-2003 Klaus Roemer" , 10 , 226 , 210 , 15
STATICTEXT #About.txt7 , "Windows 95/98/98SE" , 202 , 60 , 125 , 15
BUTTON #About.b1 , "&Close" , [quitAbout] , UL , 250 , 276 , 70 , 23
BUTTON #About.b2 , "&Buy Now" , [buy.now] , UL , 250 , 250 , 70 , 23
BUTTON #About.b3 , "&Register" , [register.now] , UL , 250 , 224 , 70 , 23
OPEN "About" FOR window_nf AS #About
PRINT #About , "trapclose [quitAbout]"
#About , "font ms_sans_serif 8"
#About.txt5 , "!font arial 9 "
#About.txt6 , "!font arial 9 "
#About.txt7 , "!font arial 9 "
hGbox = HWND( #About.graph1 )
hStyle = GetWindowLong( hGbox , -16 )
hNewStyle = SetWindowLong( hGbox , -16 , hStyle XOR 8388608 )
hGbox = HWND( #About.graph4 )
hStyle = GetWindowLong( hGbox , -16 )
hNewStyle = SetWindowLong( hGbox , -16 , hStyle XOR 8388608 )
hGbox = HWND( #About.graph5 )
hStyle = GetWindowLong( hGbox , -16 )
hNewStyle = SetWindowLong( hGbox , -16 , hStyle XOR 8388608 )
hGbox = HWND( #About.graph6 )
hStyle = GetWindowLong( hGbox , -16 )
hNewStyle = SetWindowLong( hGbox , -16 , hStyle XOR 8388608 )
#About.graph1 "down;fill buttonface;backcolor buttonface; flush"
#About.graph4 "down;fill buttonface;backcolor buttonface; flush"
#About.graph5 "down;fill buttonface;backcolor buttonface; flush"
#About.graph6 "down;fill buttonface;backcolor buttonface; flush"
PRINT #About.graph1 , "drawbmp about 0 0 : flush"
BackgroundColor$ = ""
ForegroundColor$ = ""
STATICTEXT #dummy4.1 , "" , 10000 , 0 , 0 , 0
OPEN "" FOR window AS #dummy4
PRINT #dummy4 , "font ms_sans_serif 8"
CALL SetParent HWND( #About ) , HWND( #dummy4.1 )
CALL ShowWindow HWND( #dummy4 ) , 0
#About.graph1 "flush"
PRINT #About.graph4 , "when mouseMove [changeMail]"
PRINT #About.graph5 , "when mouseMove [changeWeb]"
PRINT #About.graph1 , "when mouseMove [changeBack]"
PRINT #About.graph6 , "when mouseMove [changeBack]"
PRINT #About.graph4 , "when leftButtonDown [Mail]"
PRINT #About.graph5 , "when leftButtonDown  [Web]"
hw = HWND( #About )
h1 = HWND( #About.b1 )
modifyStyle = 768 OR 8192 OR 32768
r = changeStyle( h1 , modifyStyle )
h2 = HWND( #About.b2 )
modifyStyle = 768 OR 8192 OR 32768
r = changeStyle( h2 , modifyStyle )
h3 = HWND( #About.b3 )
modifyStyle = 768 OR 8192 OR 32768
r = changeStyle( h3 , modifyStyle )
PRINT #About.b1 , "!font ms_sans_serif 8"
PRINT #About.b2 , "!font ms_sans_serif 8"
PRINT #About.b3 , "!font ms_sans_serif 8"
PRINT #About , "refresh"
#About.graph1 "color black;font arial 9;backcolor 240 184 80"
#About.graph1 "place 260 16"
#About.graph1 "\version 2.1"
#About.graph1 "color black;font arial 9;backcolor buttonface"
#About.graph4 "place 6 12"
#About.graph4 "\Email: "
#About.graph5 "color black;font arial 9"
#About.graph5 "place 6 12"
#About.graph5 "\Website:"
#About.graph4 "color blue;font arial underscore 9"
#About.graph4 "place 56 12"
#About.graph4 "\roemerk@yahoo.com"
#About.graph5 "place 57 12"
#About.graph5 "\www.geocities.com/roemerk"
#About.graph1 "color blue;font arial bold 9"
#About.graph1 "place 30 70"
#About.graph1 "\Welcome!"
#About.graph1 "flush"
#About.graph4 "flush"
#About.graph5 "flush"
#About.graph6 "flush"
style = 4
xLoc = 0 : yLoc = 0 : eW = 327 : eH = 202
PRINT #About.graph1 , drawEdge$( style , xLoc , yLoc , eW , eH )
style = 4
xLoc = 1 : yLoc = 48 : eW = 324 : eH = 1
PRINT #About.graph1 , drawEdge$( style , xLoc , yLoc , eW , eH )

[AboutLoop]
WAIT

[changeMail]
#About.graph4 "color white;font arial underscore 9;backcolor buttonface"
#About.graph4 "place 56 12"
#About.graph4 "\roemerk@yahoo.com"
GOTO [AboutLoop]

[changeWeb]
#About.graph5 "color white;font arial underscore 9;backcolor buttonface"
#About.graph5 "place 56 12"
#About.graph5 "\www.geocities.com/roemerk"
GOTO [AboutLoop]

[changeBack]
#About.graph4 "color blue;font arial underscore 9;backcolor buttonface"
#About.graph4 "place 56 12"
#About.graph4 "\roemerk@yahoo.com"
#About.graph5 "color blue;font arial underscore 9;backcolor buttonface"
#About.graph5 "place 56 12"
#About.graph5 "\www.geocities.com/roemerk"
GOTO [AboutLoop]

[Web]
file$ = "http://www.geocities.com/roemerk/"
result = ShellExecute( hWnd , file$ , "" )
IF result <= 32 THEN NOTICE "Error, Address Failure!"
GOTO [AboutLoop]

[Mail]
file$ = "mailto:roemerk@yahoo.com"
result = ShellExecute( hWnd , file$ , "" )
IF result <= 32 THEN NOTICE "Error, Address Failure!"
GOTO [AboutLoop]

[register.now]
CLOSE #dummy4
CLOSE #About
GOTO [Register]

[buy.now]
CLOSE #dummy4
CLOSE #About
pathname$ = MID$( DefaultDir$ , 1 , LEN( DefaultDir$ ) )
registerInfo$ = "notepad.exe " + pathname$ + "\register.txt"
RUN registerInfo$
GOTO [MainLoop]

[quitAbout]
UNLOADBMP "about"
CLOSE #dummy4
CLOSE #About
GOTO [MainLoop]
SUB ProgBar1
DIM info$( 10 , 10 )
NOMAINWIN
BackgroundColor$ = ""
ForegroundColor$ = ""
WindowWidth = 370
WindowHeight = 155
GRAPHICBOX #Progbar1.gb , 20 , 85 , 320 , 20
STATICTEXT #Progbar1.gb , "Cleaning in Progress...." , 100 , 37 , 340 , 35
OPEN "Please  Wait!" FOR dialog AS #Progbar1
PRINT #Progbar1 , "trapclose [quit2]"
PRINT #Progbar1 , "font ms_sans_serif bold 10"
PRINT #Progbar1.gb , "down; fill Darkblue"
PRINT #Progbar1.gb , "getbmp bar 0 0 196 20"
PRINT #Progbar1.gb , "fill white"
OPEN "Clean\clean.dat" FOR OUTPUT AS #flagFile
PRINT #flagFile , "endClean"
CLOSE #flagFile
CURSOR hourglass

[RunProgBar]
TIMER 2000 , [GO]
WAIT

[GO]
total1 = 1800
total2 = 400
y = 0 : y = 0
WHILE y < total2
x = x + 1 : y = y + 6
IF x <= total1 THEN
progress1 = progress( x , total1 , 1 )
END IF
progress2 = progress( y , total2 , 2 )
WEND
IF fileExists( DefaultDir$ , "Clean\clean.dat" ) THEN
GOSUB [RunProgBar]
ELSE
GOSUB [end]
END IF

[end]
PRINT #Progbar1.gb , "down; fill Darkblue"
TIMER 1000 , [quit2]
WAIT

[quit2]
TIMER 0
CURSOR normal
CLOSE #Progbar1
STRUCT lpFree , BytesL AS ulong , BytesH AS ulong
STRUCT lpTotal , BytesL AS ulong , BytesH AS ulong
STRUCT lpTotFree , BytesL AS ulong , BytesH AS ulong
CALLDLL #kernel32 , "GetDiskFreeSpaceExA" , "C:\" AS ptr , lpFree AS STRUCT , lpTotal AS STRUCT , lpTotFree AS STRUCT , ret AS long
OPEN "space2.dat" FOR OUTPUT AS #f
PRINT #f , "" ; InUnits$( lpTotFree.BytesH.struct * HEXDEC( "100000000" ) + lpTotFree.BytesL.struct )
CLOSE #f
RUN "notice2.tkn"
END SUB
GOTO [MainLoop]
FUNCTION progress( p , t , n )
x = INT( ( p / t ) / .01 )
SELECT CASE n
CASE 1
PRINT #Progbar1.gb , "drawbmp bar " ; ( x * 3 ) - 160 ; " 0"
PRINT #Progbar1.gb , "discard"
END SELECT
progress = x
END FUNCTION

[Set.colorText]
#main.graph1 "color black;font arial bold 8;backcolor buttonface"
#main.graph1 "place 430 86"
#main.graph1 "\Version 2.1"
#main.graph1 "color darkblue;font arial bold underscore 9;backcolor buttonface"
#main.graph1 "place 275 98"
#main.graph1 "\Start Cleaning"
#main.graph1 "color black;font arial 9;backcolor buttonface"
#main.graph1 "place 290 115"
#main.graph1 "\Remove Junk Files from"
#main.graph1 "place 290 127"
#main.graph1 "\your Computer now!"
#main.graph1 "color darkblue;font arial bold underscore 9;backcolor buttonface"
#main.graph1 "place 275 160"
#main.graph1 "\Settings"
#main.graph1 "color black;font arial 9;backcolor buttonface"
#main.graph1 "place 290 176"
#main.graph1 "\Select and set various"
#main.graph1 "place 290 188"
#main.graph1 "\options for cleaning!"
#main.graph1 "color darkblue;font arial bold underscore 9;backcolor buttonface"
#main.graph1 "place 275 225"
#main.graph1 "\Extra Tools"
#main.graph1 "color black;font arial 9;backcolor buttonface"
#main.graph1 "place 290 241"
#main.graph1 "\Extra Windows Tools...."
#main.graph1 "place 290 254"
#main.graph1 "\to optimize your System!"
PRINT #main.b4 , "!font ms_sans_serif 8"
PRINT #main.b5 , "!font ms_sans_serif 8"
PRINT #main.b6 , "!font ms_sans_serif 8"
PRINT #main.graph1 , "flush"
PRINT #main.graph2 , "flush"
GOTO [MainLoop]

[Register]
OPEN SystemPath$ + dummyfile$ FOR INPUT AS #Registerfile
LINE INPUT #Registerfile , name$
INPUT #Registerfile , Regza
RegistrationNo1 = Regza
CLOSE #Registerfile
GOSUB [encryption]
IF No1 = RegistrationNo1 THEN NOTICE "Thank You!" + CHR$( 13 ) + "You Have Already Registered!"
IF No1 = RegistrationNo1 THEN GOTO [MainLoop]
IF RegisterFlag > 0 THEN CLOSE #Register
RegisterFlag = 1
NOMAINWIN
UpperLeftX = 160
UpperLeftY = 160
WindowWidth = 345
WindowHeight = 220
BackgroundColor$ = "buttonface"
ForegroundColor$ = "black"
GROUPBOX #Reg.gp1 , "" , 8 , 8 , 321 , 118
TEXTBOX #Reg.textbox1 , 126 , 40 , 190 , 20
TEXTBOX #Reg.textbox2 , 126 , 80 , 190 , 20
STATICTEXT #Reg.name , "Your Name:" , 20 , 46 , 80 , 20
STATICTEXT #Reg.key , "Registration Key:" , 20 , 85 , 100 , 20
BUTTON #Reg.b1 , "OK" , [AcceptRegistration] , UL , 30 , 154 , 99 , 25
BUTTON #Reg.b2 , "Cancel" , [CancelRegistration] , UL , 210 , 154 , 99 , 25
OPEN "Thank You for registering!" FOR dialog AS #Reg
PRINT #Reg , "trapclose [CancelRegistration]"
#Reg , "font arial 9"
#Reg.name , "!font ms_sans_serif bold 9"
#Reg.key , "!font ms_sans_serif bold 9"
GOTO [MainLoop]

[AcceptRegistration]
PRINT #Reg.textbox1 , "!contents?"
INPUT #Reg.textbox1 , name$
PRINT #Reg.textbox2 , "!contents?"
INPUT #Reg.textbox2 , RegistrationNo1
GOSUB [encryption]
IF No1 <> RegistrationNo1 THEN NOTICE "Notice!" + CHR$( 13 ) + "Please enter correct details!"
IF No1 <> RegistrationNo1 THEN [MainLoop]
OPEN SystemPath$ + dummyfile$ FOR OUTPUT AS #Registerfile
PRINT #Registerfile , name$
PRINT #Registerfile , RegistrationNo1
PRINT #Registerfile , RegistrationNo2
CLOSE #Registerfile
NOTICE "Registration completed!" + CHR$( 13 ) + "Thank You For Registering!" + CHR$( 13 ) + "Please enjoy the program."
CLOSE #Reg
RegisterFlag = 0
GOTO [MainLoop]

[CancelRegistration]
CLOSE #Reg
RegisterFlag = 0
GOTO [MainLoop]

[kissoff]
NOMAINWIN
UpperLeftX = 170
UpperLeftY = 130
WindowWidth = 330
WindowHeight = 280
BackgroundColor$ = "buttonface"
LOADBMP "excl" , "bmp\excl.bmp"
GROUPBOX #EndTrial.group1 , "" , 7 , 230 , 310 , 8
GRAPHICBOX #EndTrial.graph1 , 5 , 16 , 315 , 168
BUTTON #EndTrial.b1 , "Register Now" , [register.program] , UL , 7 , 198 , 99 , 25
BUTTON #EndTrial.b2 , "Buy Now" , [buy.program] , UL , 112 , 198 , 99 , 25
BUTTON #EndTrial.b3 , "Cancel" , [cancelReg] , UL , 218 , 198 , 99 , 25
OPEN "Please Register!" FOR dialog AS #EndTrial
PRINT #EndTrial , "trapclose [cancelReg]"
#EndTrial , "font ms_sans_serif 9 bold"
#EndTrial.graph1 "color red;font arial bold 12"
#EndTrial.graph1 "place 42, 40,"
#EndTrial.graph1 "\Your trial period has expired!"
#EndTrial.graph1 "color black;font arial 9"
#EndTrial.graph1 "place 10, 60,"
#EndTrial.graph1 "\To continue using this program after the 10 Day Trail"
#EndTrial.graph1 "place 10, 75,"
#EndTrial.graph1 "\Period, requires registration.To purchase a"
#EndTrial.graph1 "place 10, 90,"
#EndTrial.graph1 "\registration key, click on [Buy Now]. If you allready"
#EndTrial.graph1 "place 10, 105,"
#EndTrial.graph1 "\have a registration key, click on [Register Now]"
#EndTrial.graph1 "place 10, 125,"
#EndTrial.graph1 "\Thank You for trying this software."
#EndTrial.graph1 "place 220, 155,"
#EndTrial.graph1 "\© 2000 -2003"
PRINT #EndTrial.graph1 , "drawbmp excl 15 20 :flush"
#EndTrial.graph1 "flush"

[EndTrial.Loop]
WAIT

[register.program]
CLOSE #EndTrial
GOTO [Register]

[buy.program]
pathname$ = MID$( DefaultDir$ , 1 , LEN( DefaultDir$ ) )
registerInfo$ = "notepad.exe " + pathname$ + "\register.txt"
RUN registerInfo$
GOTO [MainLoop]

[cancelReg]
UNLOADBMP "excl"
CLOSE #EndTrial
IF RegisterFlag > 0 THEN CLOSE #Reg
END
GOTO [MainLoop]

[encryption]
CodeSum = 0
FOR index = 1 TO LEN( name$ )
CodeSum = CodeSum + ASC( MID$( name$ , index , 1 ) )
NEXT index
No1 = INT( CodeSum * Ca + constant1 )
RETURN

[Tools.Window]
scanDsk$ = "to check your Computer for possible Problems and repair them!"
defrag$ = "to defrag broken and scattered Files and to optimize your System!"
Scanreg$ = "to fix Problems in the Windows Registry and to optimize the Registry!"
NOMAINWIN
WindowWidth = 390
WindowHeight = 335
UpperLeftX = 170
UpperLeftY = 90
BackgroundColor$ = "buttonface"
ForegroundColor$ = "black"
GRAPHICBOX #Tools.graph1 , -1 , -1 , 435 , 50
BUTTON #Tools.b1 , "" , [b1Click] , UL , 29 , 70 , 70 , 55
BUTTON #Tools.b2 , "" , [b2Click] , UL , 29 , 130 , 70 , 55
BUTTON #Tools.b3 , "" , [b3Click] , UL , 29 , 190 , 70 , 55
BUTTON #Tools.b4 , "&Help" , [b4Click] , UL , 220 , 274 , 68 , 24
BUTTON #Tools.b5 , "&Close" , [b5Click] , UL , 305 , 274 , 68 , 24
GROUPBOX #Tools.group1 , "" , 1 , 255 , 388 , 8
STATICTEXT #Tools.txt1 , "Run Scandisk!" , 125 , 78 , 175 , 20
STATICTEXT #Tools.txt2 , "Run Defragmenter!" , 125 , 138 , 175 , 20
STATICTEXT #Tools.txt3 , "Run Scanreg!" , 125 , 198 , 175 , 16
STATICTEXT #Tools.txt7 , "(Win 98 only)" , 210 , 198 , 175 , 16
STATICTEXT #Tools.txt4 , scanDsk$ , 125 , 92 , 175 , 40
STATICTEXT #Tools.txt5 , defrag$ , 125 , 152 , 175 , 40
STATICTEXT #Tools.txt6 , Scanreg$ , 125 , 212 , 175 , 40
OPEN "KRDC" FOR window_nf AS #Tools
PRINT #Tools , "trapclose [quitTools]"
PRINT #Tools , "font ms_sans_serif 8"
PRINT #Tools.txt1 , "!font ms_sans_serif bold 8"
PRINT #Tools.txt2 , "!font ms_sans_serif bold 8"
PRINT #Tools.txt3 , "!font ms_sans_serif bold 8"
PRINT #Tools.txt4 , "!font ms_sans_serif 8"
PRINT #Tools.txt5 , "!font ms_sans_serif 8"
PRINT #Tools.txt6 , "!font ms_sans_serif 8"
PRINT #Tools.txt7 , "!font ms_sans_serif 8"
PRINT #Tools.graph1 , "down;fill 240 184 80; flush"
hW = HWND( #Tools )
h1 = HWND( #Tools.b1 )
h2 = HWND( #Tools.b2 )
h3 = HWND( #Tools.b3 )
h4 = HWND( #Tools.b4 )
h5 = HWND( #Tools.b5 )
File$ = "icons\SCANDSKW0.ico" + NULL$
CALLDLL #user32 , "GetWindowLongA" , hW AS long , -6 AS long , InstH AS long
CALLDLL #shell32 , "ExtractIconA" , InstH AS long , File$ AS ptr , 0 AS long , hI1 AS long
File$ = "icons\DEFRAG0.ico" + NULL$
CALLDLL #user32 , "GetWindowLongA" , hW AS long , -6 AS long , InstH AS long
CALLDLL #shell32 , "ExtractIconA" , InstH AS long , File$ AS ptr , 0 AS long , hI2 AS long
File$ = "icons\SCANREGW0.ico" + NULL$
CALLDLL #user32 , "GetWindowLongA" , hW AS long , -6 AS long , InstH AS long
CALLDLL #shell32 , "ExtractIconA" , InstH AS long , File$ AS ptr , 0 AS long , hI3 AS long
modifyStyle = 64 OR 32768
r = changeStyle( h1 , modifyStyle )
CALLDLL #user32 , "SendMessageA" , h1 AS long , 247 AS long , 1 AS long , hI1 AS long , r AS void
modifyStyle = 64 OR 32768
r = changeStyle( h2 , modifyStyle )
CALLDLL #user32 , "SendMessageA" , h2 AS long , 247 AS long , 1 AS long , hI2 AS long , r AS void
modifyStyle = 64 OR 32768
r = changeStyle( h3 , modifyStyle )
CALLDLL #user32 , "SendMessageA" , h3 AS long , 247 AS long , 1 AS long , hI3 AS long , r AS void
hw = HWND( #Tools )
h5 = HWND( #Tools.b4 )
modifyStyle = 768 OR 8192 OR 32768
r = changeStyle( h5 , modifyStyle )
h6 = HWND( #Tools.b5 )
modifyStyle = 768 OR 8192 OR 32768
r = changeStyle( h6 , modifyStyle )
PRINT #Tools.b4 , "!font ms_sans_serif 8"
PRINT #Tools.b5 , "!font ms_sans_serif 8"
PRINT #Tools , "refresh"
#Tools.graph1 "color black;font ms_sans_serif bold 18;backcolor 240 184 80"
#Tools.graph1 "place 100 34"
#Tools.graph1 "\Windows Tools"
PRINT #Tools.graph1 , "flush"

[ToolsLoop]
WAIT

[b1Click]
OPEN "kernel32" FOR dll AS #kernel
CALLDLL #kernel , "WinExec" , "Scandskw.exe" AS ptr , 8 AS word , result AS word
CLOSE #kernel
WAIT

[b2Click]
OPEN "kernel32" FOR dll AS #kernel
CALLDLL #kernel , "WinExec" , "Defrag.exe" AS ptr , 8 AS word , result AS word
CLOSE #kernel
WAIT

[b3Click]
CLOSE #main
CLOSE #Tools
RUN "notice1.tkn"
END

[b4Click]
file$ = "Help\dc_help.chm"
result = ShellExecute( hWnd , file$ , "" )
IF result <= 32 THEN NOTICE "Error, Address Failure!"
WAIT

[b5Click]
GOTO [quitTools]

[quitTools]
CLOSE #Tools
GOTO [MainLoop]
FUNCTION drawEdge$( style , xLoc , yLoc , eW , eH )
xLoc$ = STR$( xLoc )
yLoc$ = STR$( yLoc )
eH$ = STR$( eH )
eW$ = STR$( eW )

[setStyle]
IF style = 1 OR style = 3 OR style = 5 OR style = 7 THEN c1$ = "85 85 85" : c2$ = "white"
IF style = 2 OR style = 4 OR style = 6 OR style = 8 THEN c1$ = "white" : c2$ = "85 85 85"
GOSUB [createEdge]
IF style > 4 THEN
EdgeHold$ = drawEdge$
xLoc = VAL( xLoc$ ) + 1 : xLoc$ = STR$( xLoc )
yLoc = VAL( yLoc$ ) + 1 : yLoc$ = STR$( yLoc )
eH = VAL( eH$ ) - 2 : eH$ = STR$( eH )
eW = VAL( eW$ ) - 2 : eW$ = STR$( eW )
IF style = 5 THEN c1$ = "white" : c2$ = "85 85 85"
IF style = 6 THEN c1$ = "85 85 85" : c2$ = "white"
IF style = 7 THEN c2$ = "255 241 240" : c1$ = "black"
IF style = 8 THEN c1$ = "255 241 240" : c2$ = "black"
GOSUB [createEdge]
drawEdge$ = EdgeHold$ + ";" + drawEdge$
EdgeHold$ = ""
END IF
GOTO [edgeDone]

[createEdge]
drawEdge$ = "place " ; xLoc$ ; " " ; yLoc$ ; ";" + "color " ; c2$ ; ";" + "size 1;" + "down;" + "north;" + "turn 90;" + "go " ; eW$ ; ";" + "turn 90;" + "color " ; c1$ ; ";" + "go " ; eH$ ; ";" + "turn 90;" + "go " ; eW$ ; ";" + "turn 90;" + "color " ; c2$ ; ";" + "go " ; eH$
RETURN

[edgeDone]
END FUNCTION
FUNCTION changeStyle( h , ms )
CALLDLL #user32 , "GetWindowLongA" , h AS long , -16 AS long , style AS long
style = style OR ms
CALLDLL #user32 , "SetWindowLongA" , h AS long , -16 AS long , style AS long , changeStyle AS long
END FUNCTION
FUNCTION CreateTooltip( hParent )
CALLDLL #user32 , "CreateWindowExA" , 0 AS long , "tooltips_class32" AS ptr , 0 AS long , 0 AS long , 2147483648 AS long , 2147483648 AS long , 2147483648 AS long , 2147483648 AS long , hParent AS long , 0 AS long , 0 AS long , 0 AS long , CreateTooltip AS long
END FUNCTION
SUB AddTooltip hWnd , Text$ , hTT
ti.uId.struct = hWnd
ti.lpszText.struct = Text$
CALLDLL #user32 , "SendMessageA" , hTT AS long , 1028 AS long , 0 AS long , ti AS ptr , ret AS long
END SUB
FUNCTION fileExists( path$ , filename$ )
FILES path$ , filename$ , info$( )
fileExists = VAL( info$( 0 , 0 ) )
END FUNCTION
FUNCTION GetWindowLong( hWin , type )
CALLDLL #user32 , "GetWindowLongA" , hWin AS long , type AS long , GetWindowLong AS long
END FUNCTION
FUNCTION SetWindowLong( hWin , type , newVal )
CALLDLL #user32 , "SetWindowLongA" , hWin AS long , type AS long , newVal AS long , SetWindowLong AS long
END FUNCTION
SUB ShowWindow hWnd , flag
CALLDLL #user32 , "ShowWindow" , hWnd AS long , flag AS long , r AS boolean
END SUB
SUB SetParent hWnd , hWndChild
CALLDLL #user32 , "SetParent" , hWndChild AS long , hWnd AS long , result AS long
END SUB
FUNCTION ShellExecute( hWnd , file$ , dir$ )
parameter = 3
lpszOp$ = "open" + CHR$( 0 )
lpszFile$ = file$ + CHR$( 0 )
lpszDir$ = dir$ + CHR$( 0 )
lpszParams$ = "" + CHR$( 0 )
CALLDLL #shell32 , "ShellExecuteA" , hWnd AS Long , lpszOp$ AS Ptr , lpszFile$ AS Ptr , lpszParams$ AS Ptr , lpszDir$ AS Ptr , parameter AS Long , result AS Long
ShellExecute = result
END FUNCTION
FUNCTION InUnits$( Bytes )
InUnits$ = " " ; USING( "#####.##" , Bytes / ( 1024 * 1024 ) )
END FUNCTION
FUNCTION LoadBitmapSystemColors( bmp$ )
flags = 16 OR 4096 OR 32
CALLDLL #user32 , "LoadImageA" , 0 AS Long , bmp$ AS Ptr , 0 AS Ulong , 0 AS Long , 0 AS Long , flags AS Long , LoadBitmapSystemColors AS Ulong
END FUNCTION
