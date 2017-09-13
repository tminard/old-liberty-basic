

                                                                                                                                                                                                                                                                                                                                                                        
0 udqrhnm < 0-62
discontin = 1.6
editor$ = "Just Basic v1.01 version"
loadedgamename$ = "none"
DefaultDir$ = DefaultDir$ + "\"
MainDir$ = "[DATA]\[GAMES]\"
devemail$ = "heretoserve@bluebottle.com"
SoundDir$ = "[DATA]\[SOUND]\DEFAULT\"
openWinSOUND$ = "openWin.wav"
reloadWinSOUND$ = "refreshWin.wav"
sound = 1
NOMAINWIN
lessnotice = 1
enableblink = 0
IF fileExists( "" , "[DATA]\[BITMAPS]\blank.bmp" ) THEN LOADBMP "blank" , "[DATA]\[BITMAPS]\blank.bmp"
IF fileExists( "" , "[DATA]\[BITMAPS]\blank.bmp" ) = 0 THEN NOTICE "Main Bitmap not found!!!"
selectedtype = 0
selectedg = 0
DIM types$( 1000 , 5 )
DIM type$( 1000 )
GOTO [main.window]
END

[main.window]
installed = 0
mods = 0
notinstalled = 0
enableblink = 0
IF debug = 1 THEN NOTICE "BLINK OFF!"
GOSUB [load.mods]
games = 0
GOSUB [loadGames]
WindowWidth = 535
WindowHeight = 690
UpperLeftX = INT( ( DisplayWidth - WindowWidth ) / 2 )
UpperLeftY = INT( ( DisplayHeight - WindowHeight ) / 2 )
TexteditorColor$ = "white"
GRAPHICBOX #main.bitmap , 185 , 200 , 125 , 150
TEXTEDITOR #main.textedit11 , 10 , 502 , 515 , 100
GROUPBOX #main.groupbox5 , "Select A Game!" , 0 , 17 , 175 , 465
GROUPBOX #main.groupbox6 , "Options" , 185 , 12 , 125 , 180
GROUPBOX #main.groupbox12 , "Discription" , 5 , 487 , 520 , 130
GROUPBOX #main.groupbox13 , "Enabled" , 320 , 17 , 195 , 415
STATICTEXT #main.statictext2 , "Game:" , 5 , 42 , 40 , 20
STATICTEXT #main.types , "Types:" , 5 , 82 , 44 , 20
ComboboxColor$ = "white"
COMBOBOX #main.game , games$( , [gamesClick] , 50 , 37 , 115 , 295
COMBOBOX #main.type , type$( , [typesClick] , 50 , 77 , 115 , 295
ListboxColor$ = "white"
LISTBOX #main.uninst , notinst$( , [notinstClick] , 10 , 117 , 150 , 345
BUTTON #main.button7 , "Enable" , [instSelected] , UL , 200 , 37 , 85 , 25
BUTTON #main.button8 , "Disable" , [uninstSelected] , UL , 200 , 72 , 85 , 25
BUTTON #main.about , "About Backfire" , [about] , UL , 195 , 132 , 102 , 25
STATICTEXT #main.statictext10 , "Select a Mod" , 195 , 167 , 125 , 20
LISTBOX #main.listbox14 , inst$( , [instClick] , 330 , 37 , 175 , 385
MENU #main , "Game" , "Load" , [load.game] , | , "Install Update" , [inst.up] , "Install MultiFile(tm)" , [menu.readmlt]
OPEN "Adelphos Pro(TM) Backfire(TM) Mod Installer v" ; version FOR window AS #main
PRINT #main.game , "select " ; selectedg$
IF selectedg$ = "" THEN PRINT #main.game , "selectindex " ; selectedg
PRINT #main.bitmap , "cls"
PRINT #main , "font ms_sans_serif 10"
PRINT #main , "trapclose [quit.main]"
#main.button7 , "!disable"
#main.button8 , "!disable"
PRINT #main.bitmap , "background blank"
PRINT #main.bitmap , "drawsprites"
PRINT #main.bitmap , "when characterInput [debug.check]"
returnreload = 1
IF selectedg = 0 THEN PLAYWAVE DefaultDir$ + SoundDir$ + openWinSOUND$ , async
GOSUB [gamesClick]
PRINT #main.type , "select " ; selectedtype$
IF selectedtype$ = "" THEN PRINT #main.type , "selectindex " ; selectedtype
startup = 1
GOTO [typesClick]

[main.inputLoop]
WAIT

[debug.check]
IF Inkey$ = "|" AND debug = 0 THEN debug = 1 : NOTICE "Debug On!" : WAIT
IF Inkey$ = "|" AND debug = 1 THEN debug = 0 : NOTICE "Debug Off!" : WAIT
IF Inkey$ = "~" AND debug = 1 THEN NOTICE editor$
IF Inkey$ = "V" AND debug = 1 THEN NOTICE version
IF Inkey$ = "1" AND debug = 1 THEN lessnotice = 0 : NOTICE "Ln on!"
IF Inkey$ = "2" AND debug = 1 THEN lessnotice = 1 : NOTICE "Ln Off!"
IF Inkey$ = "!" AND debug = 1 THEN enableblink = 1 : NOTICE "BLINK ON! MIGHT GET BUGGY!"
IF Inkey$ = "@" AND debug = 1 THEN enableblink = 0 : NOTICE "BLINK OFF!"
WAIT

[about]
WindowWidth = 392
WindowHeight = 300
IF sound = 1 THEN PLAYWAVE DefaultDir$ + SoundDir$ + openWinSOUND$ , async
STATICTEXT #about.statictext1 , "Backfire(tm) was created by Tyler Minard. Thanks to all the mod'ers out there, without your help the world of video gaming would stop in it's tracks! Above all,  Soli Deo Gloria!" , 26 , 16 , 336 , 190
STATICTEXT #about.statictext2 , "_________________________________________________" , 14 , 211 , 392 , 20
BUTTON #about.button3 , "Close!" , [close.about] , UL , 14 , 236 , 58 , 25
BUTTON #about.button4 , "Email Me!" , [email.about] , UL , 278 , 236 , 82 , 25
OPEN "About" FOR dialog_nf_modal AS #about
PRINT #about , "font ms_sans_serif 0 16"
WAIT

[close.about]
PLAYWAVE ""
CLOSE #about
WAIT

[email.about]
RUN "explorer.exe mailto:" + devemail$
WAIT

[typesClick]
fileExt$ = ""
PRINT #main.type , "selection? selectedtype$"
PRINT #main.type , "selectionindex? tmp"
selectedtype = tmp
fileExt$ = types$( tmp , 1 )
IF fileExt$ = "" THEN NOTICE "Error loading types! Select a game!" : WAIT
fileExt$ = "*" + fileExt$
IF returntype = 1 THEN returntype = 0 : RETURN
GOTO [reload.win]
WAIT

[menu.readmlt]
didgameinstall = 0
QA$ = "no"
FILEDIALOG "Open MultiInstall(tm) file" , "*.mlt" , readmlt$
IF TRIM$( readmlt$ ) = "" THEN WAIT
splitit$ = readmlt$
GOSUB [split.dir]
mltdir$ = justdir$
GOSUB [read.mlt]
IF lessnotice = 0 THEN NOTICE "Installed!"
IF didgameinstall = 1 THEN NOTICE "Restart of program required! Please restart to use updates."
IF didgameinstall = 1 THEN CONFIRM "Exit program now?" ; QA$
IF QA$ = "yes" THEN [quit.main]
GOTO [reload.win]
WAIT

[gamesClick]
PRINT #main.game , "selection? selectedg$"
IF selectedg$ = "" THEN WAIT
autoload = 1
gameName$ = DefaultDir$ + MainDir$ + selectedg$
GOTO [load.game]
WAIT

[loadGames]
DIM gamefiles$( 100 , 10 )
DIM allgames$( 1000 , 10 )
FILES DefaultDir$ + MainDir$ , "*.mgm" , gamefiles$(
FOR loadgames = 1 TO VAL( gamefiles$( 0 , 0 ) )
games = games + 1 : allgames$( games , 0 ) = gamefiles$( loadgames , 0 ) : games$( games ) = gamefiles$( loadgames , 0 )
NEXT loadgames
RETURN

[read.mlt]
IF fileExists( "" , readmlt$ ) = 0 THEN RETURN
OPEN readmlt$ FOR INPUT AS #readmlt
FOR mlt = 1 TO 1000
LINE INPUT #readmlt , mlt$
IF EOF( #readmlt ) <> 0 THEN EXIT FOR
IF WORD$( mlt$ , 1 , "=" ) = "name" THEN mltname$ = WORD$( mlt$ , 2 , "=" )
IF WORD$( mlt$ , 1 , "=" ) = "INSTALL" THEN GOSUB [install.mlt]
IF WORD$( mlt$ , 1 , "=" ) = "EOF" THEN EXIT FOR
NEXT mlt
CLOSE #readmlt
RETURN

[install.mlt]
CONFIRM "Install Group " + mltname$ + "?" ; QA$
IF QA$ = "no" THEN mlt$ = "EOF=1" : RETURN
FOR readmlt = 1 TO 10000
LINE INPUT #readmlt , readmlttxt$
IF WORD$( readmlttxt$ , 1 , "=" ) = "mut" THEN openmut$ = mltdir$ + WORD$( readmlttxt$ , 2 , "=" ) : splitit$ = openmut$ : GOSUB [split.dir] : mutdir$ = justdir$ : justmut$ = justfile$ : openmut$ = openmut$ : returnreload = 1 : GOSUB [read.mut]
IF WORD$( readmlttxt$ , 1 , "=" ) = "ENDINSTALL" THEN EXIT FOR
IF WORD$( readmlttxt$ , 1 , "=" ) = "EOF" THEN EXIT FOR
NEXT readmlt
RETURN

[load.mods]
DIM modfiles$( 100 , 10 )
DIM allmods$( 1000 , 10 )
REDIM inst$( 1000 )
REDIM notinst$( 1000 )
FILES DefaultDir$ + modsdir$ , fileExt$ , modfiles$(
FOR loadmods = 1 TO VAL( modfiles$( 0 , 0 ) )
mods = mods + 1 : allmods$( mods , 0 ) = modfiles$( loadmods , 0 )
NEXT loadmods
GOTO [read.mod]
END

[read.mod]
splitit$ = gameexedir$
GOSUB [split.dir]
gameexedir$ = justdir$
REDIM notinst$( 1000 )
REDIM inst$( 1000 )
FOR loadmod = 1 TO 1000
IF allmods$( loadmod , 0 ) = "" THEN EXIT FOR
OPEN DefaultDir$ + modsdir$ + allmods$( loadmod , 0 ) FOR INPUT AS #readmod
isinst = 0
FOR readmod = 1 TO 1000
LINE INPUT #readmod , modtxt$
IF modtxt$ = "EOF" THEN EXIT FOR
IF WORD$( modtxt$ , 1 , "=" ) = "name" THEN tmpname$ = WORD$( modtxt$ , 2 , "=" )
IF WORD$( modtxt$ , 1 , "=" ) = "addfile" THEN tmpfindit$ = WORD$( WORD$( modtxt$ , 2 , "=" ) , 2 , "," ) : IF fileExists( gameexedir$ , tmpfindit$ ) THEN isinst = 1 : IF fileExists( gameexedir$ , tmpfindit$ ) = 0 THEN isinst = 0
NEXT readmod
CLOSE #readmod
IF isinst = 1 THEN installed = installed + 1 : inst$( installed ) = tmpname$ : allmods$( loadmod , 1 ) = allmods$( loadmod , 0 ) : allmods$( loadmod , 0 ) = tmpname$
IF isinst = 0 THEN notinstalled = notinstalled + 1 : notinst$( notinstalled ) = tmpname$ : allmods$( loadmod , 1 ) = allmods$( loadmod , 0 ) : allmods$( loadmod , 0 ) = tmpname$
NEXT loadmod
RETURN

[load.game]
IF autoload = 0 THEN FILEDIALOG "Open game file" , "*.mgm" , gameName$
autoload = 0
IF gameName$ = "" THEN WAIT
openmgm$ = gameName$
GOTO [read.mgm]
END

[read.mgm]
lastselectedg = selectedg
startup = 1
sound = 0
setgameexe = 0
OPEN openmgm$ FOR INPUT AS #loadmgm
FOR readmgm = 1 TO 10000
LINE INPUT #loadmgm , mgmtxt$
IF mgmtxt$ = "EOF" THEN EXIT FOR
IF WORD$( mgmtxt$ , 1 , "=" ) = "gamename" THEN tmploadedgame$ = WORD$( mgmtxt$ , 2 , "=" )
IF WORD$( mgmtxt$ , 1 , "=" ) = "moddir" THEN tmpmodsdir$ = WORD$( mgmtxt$ , 2 , "=" )
IF WORD$( mgmtxt$ , 1 , "=" ) = "gameexe" THEN findexe$ = WORD$( mgmtxt$ , 2 , "=" )
IF WORD$( mgmtxt$ , 1 , "=" ) = "sound" THEN sound = 1 : SoundDir$ = DefaultDir$ + WORD$( mgmtxt$ , 2 , "=" )
IF mgmtxt$ = "TYPES" THEN GOSUB [load.types]
NEXT readmgm
GOSUB [set.gameexe]
CLOSE #loadmgm
IF setgameexe = 0 THEN NOTICE "The game was not loaded because the game could not be found on this system. Please install the game before trying to load this file." : types = 0 : WAIT
loadedgamename$ = tmploadedgame$
modsdir$ = tmpmodsdir$
gameexedir$ = exedir$
selectedtype = 1
GOTO [reload.win]
END

[load.types]
types = 0
FOR ltypes = 1 TO 1000
LINE INPUT #loadmgm , typestxt$
IF typestxt$ = "ENDTYPES" THEN EXIT FOR
IF typestxt$ = "EOF" THEN EXIT FOR
IF WORD$( typestxt$ , 1 , "=" ) = "type" THEN types = types + 1 : types$( types , 0 ) = WORD$( WORD$( typestxt$ , 2 , "=" ) , 2 , "," ) : types$( types , 1 ) = WORD$( WORD$( typestxt$ , 2 , "=" ) , 1 , "," )
NEXT ltypes
filesf = 0
FOR settypes = 1 TO types
DIM tmp$( 100 , 10 )
FILES DefaultDir$ + tmpmodsdir$ , "*" + types$( settypes , 1 ) , tmp$(
filesf = VAL( tmp$( 0 , 0 ) )
type$( settypes ) = types$( settypes , 0 ) + " (" ; filesf ; ")"
NEXT settypes
RETURN

[load.gamewindow]
WindowWidth = 360
WindowHeight = 145
BUTTON #game.lgame , "Load Game Mods!! >" , [ld.mods] , UL , 190 , 86 , 154 , 25
BUTTON #game.ldcan , "Cancel" , [loadgame.cancel] , UL , 6 , 86 , 58 , 25
STATICTEXT #game.statictext3 , "Games supported:" , 22 , 26 , 128 , 20
COMBOBOX #game.ldbox , games$( , [loadgame.choose] , 142 , 21 , 192 , 250
OPEN "Load Game" FOR dialog_nf_modal AS #game
PRINT #game , "font ms_sans_serif 0 16"
RETURN

[set.gameexe]
IF fileExists( "" , findexe$ ) THEN setgameexe = 1 : exedir$ = findexe$ : RETURN
FILEDIALOG "Open " + findexe$ , "*.exe" , exedir$
IF exedir$ = "" THEN selectedg = lastselectedg : RETURN
IF LOWER$( RIGHT$( exedir$ , LEN( findexe$ ) ) ) = LOWER$( findexe$ ) = 0 THEN RETURN
CLOSE #loadmgm
OPEN openmgm$ + ".tmp" FOR OUTPUT AS #savenew
OPEN openmgm$ FOR INPUT AS #getreal
FOR tmptmptmp = 1 TO 1000
LINE INPUT #getreal , tmptxt$
IF LOWER$( tmptxt$ ) = "eof" THEN PRINT #savenew , "EOF" : EXIT FOR
IF WORD$( tmptxt$ , 1 , "=" ) = "gameexe" THEN PRINT #savenew , "gameexe=" + exedir$
IF WORD$( tmptxt$ , 1 , "=" ) = "gameexe" = 0 THEN PRINT #savenew , tmptxt$
NEXT tmptmptmp
CLOSE #getreal
CLOSE #savenew
KILL openmgm$
NAME openmgm$ + ".tmp" AS openmgm$
OPEN openmgm$ FOR INPUT AS #loadmgm
setgameexe = 1
RETURN

[inst.up]
FILEDIALOG "Open update file" , "*.mut" , fileName$
IF fileName$ = "" THEN WAIT
splitit$ = fileName$
GOSUB [split.dir]
mutdir$ = justdir$
justmut$ = justfile$
openmut$ = fileName$
GOTO [read.mut]
WAIT

[split.dir]
FOR tmp = 1 TO 1000
justfile$ = RIGHT$( splitit$ , tmp )
IF INSTR( justfile$ , "\" ) THEN EXIT FOR
NEXT tmp
justfile$ = RIGHT$( justfile$ , LEN( justfile$ ) - 1 )
justdir$ = LEFT$( splitit$ , LEN( splitit$ ) - LEN( justfile$ ) )
RETURN

[read.mut]
OPEN openmut$ FOR INPUT AS #readmut
mutrequired$ = ""
FOR readmut = 1 TO 10000
LINE INPUT #readmut , muttmp$
IF muttmp$ = "EOF" THEN EXIT FOR
IF WORD$( muttmp$ , 1 , "=" ) = "name" THEN mutname$ = WORD$( muttmp$ , 2 , "=" )
IF WORD$( muttmp$ , 1 , "=" ) = "type" THEN muttype$ = WORD$( muttmp$ , 2 , "=" ) : didgameinstall = 1
IF WORD$( muttmp$ , 1 , "=" ) = "uptext" THEN mutabout$ = WORD$( muttmp$ , 2 , "=" )
IF WORD$( muttmp$ , 1 , "=" ) = "version" THEN mutversion = VAL( WORD$( muttmp$ , 2 , "=" ) )
IF WORD$( muttmp$ , 1 , "=" ) = "data" THEN mutdata$ = WORD$( muttmp$ , 2 , "=" )
IF WORD$( muttmp$ , 1 , "=" ) = "endnotice" THEN mutfinished$ = WORD$( muttmp$ , 2 , "=" )
IF WORD$( muttmp$ , 1 , "=" ) = "required" THEN mutrequired$ = WORD$( WORD$( muttmp$ , 1 , "," ) , 2 , "=" ) : mutrequiredprog$ = WORD$( WORD$( muttmp$ , 2 , "," ) , 2 , "=" )
IF muttmp$ = "INSTALL" THEN GOSUB [read.mut.install]
NEXT readmut
CLOSE #readmut
GOSUB [close.instwin]
IF returnreload = 0 THEN NOTICE "Finished!" + CHR$( 13 ) + "Done! " + mutfinished$
IF returnreload = 1 THEN returnreload = 0 : RETURN
WAIT

[read.mut.install]
IF mutversion > version THEN NOTICE "ERROR! Please upgrade to version " ; mutversion ; " before installing this update!" : RETURN
IF mutversion < discontin THEN NOTICE "ERROR! Support for v" ; mutversion ; " has been discontinued! Please get updated mod file from creator!" : RETURN
IF mutrequired$ = "" = 0 AND fileExists( "" , mutrequired$ ) = 0 THEN NOTICE "The update requires " + mutrequiredprog$ + ". Please install all required files before continuing." : RETURN
CONFIRM "Install " + mutname$ + "?" ; QA$
IF QA$ = "no" THEN RETURN
instwintext$ = "Please wait... " + CHR$( 13 ) + "    installing " + mutname$
GOSUB [open.instwin]
FOR mutinstall = 1 TO 1000
LINE INPUT #readmut , insttmp$
IF insttmp$ = "ENDINSTALL" THEN EXIT FOR
IF WORD$( insttmp$ , 1 , "=" ) = "mkdir" THEN mktmp$ = WORD$( insttmp$ , 2 , "=" ) : doit = MKDIR( mktmp$ )
IF WORD$( insttmp$ , 1 , "=" ) = "cpfile" THEN copyfile$ = mutdir$ + mutdata$ + WORD$( WORD$( insttmp$ , 2 , "=" ) , 1 , "," ) : copyto$ = DefaultDir$ + WORD$( WORD$( insttmp$ , 2 , "=" ) , 2 , "," ) : GOSUB [copy.file]
IF WORD$( insttmp$ , 1 , "=" ) = "rmfile" AND fileExists( "" , WORD$( insttmp$ , 2 , "=" ) ) THEN KILL WORD$( insttmp$ , 2 , "=" )
IF WORD$( insttmp$ , 1 , "=" ) = "rmdir" THEN try = 0 : GOSUB [rmdir]
IF WORD$( insttmp$ , 1 , "=" ) = "wait" THEN GOSUB [wait.timer]
NEXT mutinstall
RETURN

[wait.timer]
PRINT "Timer hit, waiting " ; VAL( WORD$( insttmp$ , 1 , "=" ) ) ; " seconds..."
TIMER VAL( WORD$( insttmp$ , 1 , "=" ) ) , [done.timer]
WAIT

[done.timer]
TIMER 0
RETURN

[copy.file]
instwintext$ = "Copying files..."
GOSUB [update.instwin]
OPEN copyfile$ FOR INPUT AS #copyfile
copytxt = LOF( #copyfile )
copytxt$ = INPUT$( #copyfile , copytxt )
CLOSE #copyfile
OPEN copyto$ FOR OUTPUT AS #copyto
PRINT #copyto , copytxt$
CLOSE #copyto
RETURN

[rmdir]
rmtmp$ = WORD$( insttmp$ , 2 , "=" ) : doit = RMDIR( rmtmp$ ) : PRINT "  - Removing Directory " + rmtmp$ + "... Returned " ; doit
IF doit <> 0 AND try = 100 THEN PRINT "ERROR!" : RETURN
IF doit <> 0 THEN try = try + 1 : GOTO [rmdir]
RETURN

[notinstClick]
PRINT #main.uninst , "selection? selected$"
IF TRIM$( selected$ ) = "" THEN WAIT
PRINT #main.statictext10 , selected$
FOR i = 1 TO 1000
IF allmods$( i , 0 ) = "" THEN EXIT FOR
IF allmods$( i , 0 ) = selected$ THEN clickMod = i : EXIT FOR
NEXT i
OPEN modsdir$ + allmods$( clickMod , 1 ) FOR INPUT AS #readmod
FOR i = 1 TO 1000
LINE INPUT #readmod , modtxt$
IF modtxt$ = "EOF" THEN EXIT FOR
IF LOWER$( modtxt$ ) = "starttext" THEN GOSUB [starttext]
IF WORD$( modtxt$ , 1 , "=" ) = "bitmap" THEN GOSUB [displayBitmap]
NEXT i
CLOSE #readmod
PRINT #main.textedit11 , fulltext$
PRINT #main.textedit11 , "!origin 1 1" ;
#main.button7 , "!enable"
#main.button8 , "!disable"
WAIT

[starttext]
fulltext$ = ""
PRINT #main.textedit11 , "!cls"
FOR starttext = 1 TO 1000
LINE INPUT #readmod , starttext$
IF LOWER$( starttext$ ) = "endtext" THEN EXIT FOR
IF fulltext$ = "" = 0 THEN fulltext$ = fulltext$ + CHR$( 13 ) + starttext$
IF fulltext$ = "" THEN fulltext$ = fulltext$ + starttext$
NEXT starttext
RETURN

[displayBitmap]
PRINT #main.bitmap , "cls"
IF fileExists( "" , WORD$( modtxt$ , 2 , "=" ) ) = 0 THEN RETURN
LOADBMP "tmp" , DefaultDir$ + WORD$( modtxt$ , 2 , "=" )
PRINT #main.bitmap , "background tmp"
PRINT #main.bitmap , "drawsprites"
RETURN

[instSelected]
IF selected$ = "" THEN NOTICE "ERROR! Selected object not found in database! Please reselect." : WAIT
FOR i = 1 TO 1000
IF allmods$( i , 0 ) = "" THEN EXIT FOR
IF allmods$( i , 0 ) = selected$ THEN clickMod = i : EXIT FOR
NEXT i
instwintext$ = "Installing " + allmods$( clickMod , 1 )
GOSUB [open.instwin]
OPEN modsdir$ + allmods$( clickMod , 1 ) FOR INPUT AS #readmod
FOR readmod = 1 TO 1000
LINE INPUT #readmod , modtxt$
IF modtxt$ = "EOF" THEN EXIT FOR
IF WORD$( modtxt$ , 1 , "=" ) = "mkdir" THEN mktmp$ = WORD$( modtxt$ , 2 , "=" ) : doit = MKDIR( gameexedir$ + mktmp$ ) : IF debug = 1 THEN NOTICE gameexedir$ + mktmp$ + CHR$( 13 ) + "MKDIR RETURNED: " ; doit
IF WORD$( modtxt$ , 1 , "=" ) = "moddir" THEN moddir$ = DefaultDir$ + WORD$( modtxt$ , 2 , "=" )
IF WORD$( modtxt$ , 1 , "=" ) = "addfile" THEN copyfile$ = moddir$ + WORD$( WORD$( modtxt$ , 2 , "=" ) , 1 , "," ) : copyto$ = gameexedir$ + WORD$( WORD$( modtxt$ , 2 , "=" ) , 2 , "," ) : GOSUB [copy.file]
IF WORD$( modtxt$ , 1 , "=" ) = "rmdir" THEN mktmp$ = WORD$( modtxt$ , 2 , "=" ) : doit = RMDIR( gameexedir$ + mktmp$ ) : IF debug = 1 THEN NOTICE gameexedir$ + mktmp$ + CHR$( 13 ) + "RMDIR RETURNED: " ; doit
IF WORD$( modtxt$ , 1 , "=" ) = "rmfile" THEN GOSUB [does.kill]
NEXT readmod
CLOSE #readmod
IF lessnotice = 0 THEN NOTICE "Mod successfully installed!"
GOSUB [close.instwin]
GOSUB [load.mods]
GOTO [reload.win]
END

[uninstSelected]
IF selected$ = "" THEN NOTICE "ERROR! Selected object not found in database! Please reselect." : WAIT
FOR i = 1 TO 1000
IF allmods$( i , 0 ) = "" THEN EXIT FOR
IF allmods$( i , 0 ) = selected$ THEN clickMod = i : EXIT FOR
NEXT i
instwintext$ = "Uninstalling " + allmods$( clickMod , 1 )
GOSUB [open.instwin]
OPEN modsdir$ + allmods$( clickMod , 1 ) FOR INPUT AS #readmod
FOR readmod = 1 TO 1000
LINE INPUT #readmod , modtxt$
IF modtxt$ = "EOF" THEN EXIT FOR
IF WORD$( modtxt$ , 1 , "=" ) = "moddir" THEN moddir$ = DefaultDir$ + WORD$( modtxt$ , 2 , "=" )
IF WORD$( modtxt$ , 1 , "=" ) = "uninst.moddir" THEN moddir$ = DefaultDir$ + WORD$( modtxt$ , 2 , "=" )
IF WORD$( modtxt$ , 1 , "=" ) = "uninst.rmdir" THEN mktmp$ = WORD$( modtxt$ , 2 , "=" ) : doit = RMDIR( gameexedir$ + mktmp$ ) : IF debug = 1 THEN NOTICE gameexedir$ + mktmp$ + CHR$( 13 ) + "RMDIR RETURNED: " ; doit
IF WORD$( modtxt$ , 1 , "=" ) = "uninst.rmfile" THEN GOSUB [does.kill]
IF WORD$( modtxt$ , 1 , "=" ) = "uninst" THEN GOSUB [does.kill]
IF WORD$( modtxt$ , 1 , "=" ) = "uninst.addfile" THEN copyfile$ = moddir$ + WORD$( WORD$( modtxt$ , 2 , "=" ) , 1 , "," ) : copyto$ = gameexedir$ + WORD$( WORD$( modtxt$ , 2 , "=" ) , 2 , "," ) : GOSUB [copy.file]
NEXT readmod
CLOSE #readmod
FOR killing = 1 TO killit
IF fileExists( "" , killit$( killing ) ) THEN KILL killit$( killing )
NEXT killing
killit = 0
IF lessnotice = 0 THEN NOTICE "Mod was successfully uninstalled!"
GOSUB [close.instwin]
GOSUB [load.mods]
GOTO [reload.win]
END

[does.kill]
IF fileExists( gameexedir$ , WORD$( modtxt$ , 2 , "=" ) ) THEN killit = killit + 1 : killit$( killit ) = gameexedir$ + WORD$( modtxt$ , 2 , "=" )
RETURN

[instClick]
PRINT #main.listbox14 , "selection? selected$"
IF TRIM$( selected$ ) = "" THEN WAIT
PRINT #main.statictext10 , selected$
FOR i = 1 TO 1000
IF allmods$( i , 0 ) = "" THEN EXIT FOR
IF allmods$( i , 0 ) = selected$ THEN clickMod = i : EXIT FOR
NEXT i
OPEN modsdir$ + allmods$( clickMod , 1 ) FOR INPUT AS #readmod
FOR i = 1 TO 1000
LINE INPUT #readmod , modtxt$
IF modtxt$ = "EOF" THEN EXIT FOR
IF LOWER$( modtxt$ ) = "starttext" THEN GOSUB [starttext]
IF WORD$( modtxt$ , 1 , "=" ) = "bitmap" THEN GOSUB [displayBitmap]
NEXT i
CLOSE #readmod
PRINT #main.textedit11 , fulltext$
PRINT #main.textedit11 , "!origin 1 1" ;
#main.button7 , "!disable"
#main.button8 , "!enable"
WAIT

[reload.win]
IF startup = 1 AND sound = 1 THEN PLAYWAVE SoundDir$ + openWinSOUND$ , async
IF sound = 1 AND startup = 0 THEN PLAYWAVE SoundDir$ + reloadWinSOUND$ , async
startup = 0
installed = 0
mods = 0
notinstalled = 0
GOSUB [load.mods]
games = 0
selected$ = ""
GOSUB [loadGames]
PRINT #main.bitmap , "background blank"
PRINT #main.button7 , "!disable"
PRINT #main.button8 , "!disable"
PRINT #main.textedit11 , "!cls"
PRINT #main.listbox14 , "reload"
PRINT #main.uninst , "reload"
PRINT #main.game , "reload"
PRINT #main.type , "reload"
PRINT #main.statictext10 , "Select a Mod"
PRINT #main.bitmap , "drawsprites"
PRINT #main.type , "selectindex " ; selectedtype
PRINT #main.groupbox5 , loadedgamename$
returntype = 1
GOSUB [typesClick]
IF returnreload = 1 THEN returnreload = 0 : RETURN
IF enableblink = 1 THEN CLOSE #main
IF enableblink = 1 THEN GOTO [main.window]
WAIT

[quit.main]
CLOSE #main
PLAYWAVE ""
END

[open.instwin]
IF instwinopen = 1 THEN CLOSE #instwin : instwinopen = 0
WindowWidth = 240
WindowHeight = 125
STATICTEXT #instwin.statictext1 , instwintext$ , 6 , 11 , 224 , 75
OPEN "Installing now..." FOR dialog_nf_modal AS #instwin
PRINT #instwin , "trapclose [close.instwin.cancel]"
PRINT #instwin , "font ms_sans_serif 0 16"
instwinopen = 1
RETURN

[update.instwin]
IF instwinopen = 0 THEN RETURN
PRINT #instwin.statictext1 , instwintext$
RETURN

[close.instwin.cancel]
NOTICE "Sorry, You can't cancel any file operations yet!"
WAIT

[close.instwin]
IF instwinopen = 0 THEN RETURN
instwinopen = 0
CLOSE #instwin
RETURN
FUNCTION fileExists( path$ , filename$ )
DIM info$( 100 , 10 )
FILES path$ , filename$ , info$( )
fileExists = VAL( info$( 0 , 0 ) )
END FUNCTION
