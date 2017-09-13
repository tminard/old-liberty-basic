' File decoded with LibertyBASIC TKN Decoder (v1.12) by Folker Fritz
'
Rings = Rings - 00
runcount = runcount - 00
GOSUB [LOsetupMainWindow]
LOADBMP "1.bmp" , "images\1.bmp"
LOADBMP "2.bmp" , "images\2.bmp"
LOADBMP "3.bmp" , "images\3.bmp"
LOADBMP "4.bmp" , "images\4.bmp"
LOADBMP "5.bmp" , "images\5.bmp"
LOADBMP "6.bmp" , "images\6.bmp"
LOADBMP "7.bmp" , "images\7.bmp"
LOADBMP "8.bmp" , "images\8.bmp"
LOADBMP "D1.bmp" , "images\D1.bmp"
LOADBMP "D2.bmp" , "images\D2.bmp"
LOADBMP "sonic_idle.bmp" , "images\sonic_idle.bmp"
LOADBMP "U1.bmp" , "images\U1.bmp"
LOADBMP "U2.bmp" , "images\U2.bmp"
LOADBMP "J1.bmp" , "images\J1.bmp"
LOADBMP "J2.bmp" , "images\J2.bmp"
LOADBMP "J3.bmp" , "images\J3.bmp"
LOADBMP "J4.bmp" , "images\J4.bmp"
LOADBMP "R1.bmp" , "images\R1.bmp"
LOADBMP "R2.bmp" , "images\R2.bmp"
LOADBMP "R3.bmp" , "images\R3.bmp"
LOADBMP "R4.bmp" , "images\R4.bmp"
LOADBMP "B1.bmp" , "images\B1.bmp"
LOADBMP "G1.bmp" , "images\G1.bmp"
LOADBMP "Jump" , "images\jump.bmp"
LOADBMP "yellow_title.bmp" , "images\yellow_title.bmp"
LOADBMP "red_banner.bmp" , "images\red_banner.bmp"
LOADBMP "blue_banner.bmp" , "images\blue_banner.bmp"
LOADBMP "D.bmp" , "images\D.bmp"
LOADBMP "G3.bmp" , "images\G3.bmp"
LOADBMP "G4.bmp" , "images\G4.bmp"
LOADBMP "Ground2" , "images\G2.bmp"
LOADBMP "fall1" , "images\fall1.bmp"
LOADBMP "fall2" , "images\fall2.bmp"
LOADBMP "DI0.bmp" , "images\DI0.bmp"
LOADBMP "DI1.bmp" , "images\DI1.bmp"
LOADBMP "DI2.bmp" , "images\DI2.bmp"
LOADBMP "DI3.bmp" , "images\DI3.bmp"
LOADBMP "DI4.bmp" , "images\DI4.bmp"
LOADBMP "DI5.bmp" , "images\DI5.bmp"
LOADBMP "DI6.bmp" , "images\DI6.bmp"
LOADBMP "DI7.bmp" , "images\DI7.bmp"
LOADBMP "DI8.bmp" , "images\DI8.bmp"
LOADBMP "DI9.bmp" , "images\DI9.bmp"
LOADBMP "DI10.bmp" , "images\DI10.bmp"
LOADBMP "DI11.bmp" , "images\DI11.bmp"
LOADBMP "DI12.bmp" , "images\DI12.bmp"
LOADBMP "DI13.bmp" , "images\DI13.bmp"
LOADBMP "DI14.bmp" , "images\DI14.bmp"
LOADBMP "DI15.bmp" , "images\DI15.bmp"
LOADBMP "DI16.bmp" , "images\DI16.bmp"
LOADBMP "Tree1" , "images\TR.bmp"
LOADBMP "Blocker" , "images\blocker.bmp"
LOADBMP "blocker2" , "images\blocker2.bmp"
LOADBMP "ST1" , "images\ST1.bmp"
LOADBMP "ST2" , "images\ST2.bmp"
LOADBMP "ST3" , "images\ST3.bmp"
LOADBMP "ST4" , "images\ST4.bmp"
LOADBMP "Sp1" , "images\Sp1.bmp"
LOADBMP "Sp2" , "images\Sp2.bmp"
LOADBMP "Sp3" , "images\Sp3.bmp"
LOADBMP "Sp4" , "images\Sp4.bmp"
LOADBMP "Sp5" , "images\Sp5.bmp"
LOADBMP "Sp6" , "images\Sp6.bmp"
LOADBMP "Sp7" , "images\Sp7.bmp"
LOADBMP "RE1" , "images\RE1.bmp"
LOADBMP "RE2" , "images\RE2.bmp"
LOADBMP "RE3" , "images\RE3.bmp"
LOADBMP "RE4" , "images\RE4.bmp"
LOADBMP "RE5" , "images\RE5.bmp"
LOADBMP "grass" , "images\grass.bmp"
LOADBMP "port.bmp" , "images\port.bmp"
LOADBMP "pipe2.bmp" , "images\pipe2.bmp"
LOADBMP "pipe.bmp" , "images\pipe.bmp"
LOADBMP "BU1.bmp" , "images\BU1.bmp"
LOADBMP "BU2.bmp" , "images\BU2.bmp"
LOADBMP "Block" , "images\block.bmp"
LOADBMP "Bord" , "images\bord.bmp"
LOADBMP "boss1.bmp" , "images\boss1.bmp"
LOADBMP "boss2.bmp" , "images\boss2.bmp"
LOADBMP "base_scan" , "images\base_scan.bmp"
LOADBMP "GR0.bmp" , "images\GR0.bmp"
CLOSE #loading
Level$ = "L1.bmp"
wav$ = "S1_81.wav"
GOSUB [startmusicwav]
GOSUB [settexttpramiters]
[setupMainWindow]
NOMAINWIN
WindowWidth = 320
WindowHeight = 224
UpperLeftX = INT( ( DisplayWidth - WindowWidth ) / 2 )
UpperLeftY = INT( ( DisplayHeight - WindowHeight ) / 2 )
BackgroundColor$ = "buttonface"
ForegroundColor$ = "black"
GRAPHICBOX #main.screen , 0 , 0 , 320 , 15
OPEN "Sonic Demo By steven64464@hotmail.com" FOR graphics_nsb_nf AS #main
#main , "when leftButtonDown [menu]"
a$ = STR$( Rings )
#main.screen , "home"
#main.screen , "font Comic_sans_MS 8"
#main.screen , "backcolor 0 0 0"
#main.screen , "down"
#main.screen , "place 0 10" ;
#main.screen , "color yellow"
#main.screen , "fill black"
#main.screen , "\Rings" ;
#main.screen , "place 35 10" ;
#main.screen , "color red"
#main.screen , "\" + a$
#main.screen , "flush"
PRINT #main , "font ms_sans_serif 0 16"
PRINT #main , "trapclose [quit]"
PRINT #main , "drawbmp Bord 0 0; flush"
UNLOADBMP "Bord"
PRINT #main , "addsprite BUG BU1.bmp BU2.bmp" ;
PRINT #main , "spritexy BUG " ; 350 ; " " ; 115
PRINT #main , "addsprite fall fall1 fall1 fall1 fall1 fall1 fall1 fall1 fall1 fall2 fall2 fall2 fall2 fall2 fall2 fall2 fall2" ;
PRINT #main , "addsprite Tree1 Tree1 " ;
PRINT #main , "addsprite Duck D2.bmp" ;
PRINT #main , "addsprite port.bmp port.bmp " ;
PRINT #main , "addsprite pipe2.bmp pipe2.bmp" ;
PRINT #main , "addsprite pipe3.bmp pipe2.bmp" ;
PRINT #main , "addsprite pipe.bmp pipe.bmp" ;
PRINT #main , "spritexy port.bmp " ; 1065 ; " " ; -84
PRINT #main , "spriteorient port.bmp mirror" ;
PRINT #main , "spritexy pipe2.bmp " ; 1177 ; " " ; -18
PRINT #main , "spritexy pipe3.bmp " ; 1177 ; " " ; 55
PRINT #main , "spritexy pipe.bmp " ; 1168 ; " " ; -53
PRINT #main , "spriteorient pipe.bmp flip" ;
PRINT #main , "addsprite Blocker2 Blocker" ;
PRINT #main , "spritexy Blocker2 " ; 1095 ; " " ; 10
PRINT #main , "spritevisible Blocker2 off" ;
PRINT #main , "addsprite look_up U1.bmp U2.bmp" ;
PRINT #main , "addsprite Ground2 Ground2 " ;
PRINT #main , "addsprite BL1 Block " ;
PRINT #main , "addsprite BL2 Block " ;
PRINT #main , "spritevisible BL2 off" ;
PRINT #main , "spritevisible BL1 off" ;
PRINT #main , "spritexy BL2 " ; 555 ; " " ; 110
PRINT #main , "spritexy BL1 " ; 310 ; " " ; 110
PRINT #main , "spritexy Tree1 " ; 10 ; " " ; 13
PRINT #main , "addsprite Sonic 1.bmp 1.bmp 1.bmp 1.bmp 2.bmp 2.bmp 2.bmp 2.bmp 3.bmp 3.bmp 3.bmp 3.bmp 4.bmp 4.bmp 4.bmp 4.bmp 5.bmp 5.bmp 5.bmp 5.bmp 6.bmp 6.bmp 6.bmp 6.bmp 7.bmp 7.bmp 7.bmp 7.bmp 8.bmp 8.bmp 8.bmp 8.bmp" ;
PRINT #main , "addsprite Jump Jump" ;
PRINT #main , "addsprite Spring1 Sp1 Sp2 Sp3 Sp4 Sp5 Sp6 Sp7" ;
PRINT #main , "addsprite Push ST1 ST2 ST3 ST4" ;
PRINT #main , "addsprite R1 RE1 RE1 RE1 RE2 RE2 RE2 RE3 RE3 RE3 RE4 RE4 RE4 RE5 RE5 RE5" ;
PRINT #main , "addsprite R2 RE1 RE1 RE1 RE2 RE2 RE2 RE3 RE3 RE3 RE4 RE4 RE4 RE5 RE5 RE5" ;
PRINT #main , "addsprite R3 RE1 RE1 RE1 RE2 RE2 RE2 RE3 RE3 RE3 RE4 RE4 RE4 RE5 RE5 RE5" ;
PRINT #main , "cyclesprite R1 1"
PRINT #main , "cyclesprite R2 1"
PRINT #main , "cyclesprite R3 1"
PRINT #main , "addsprite Blocker Blocker" ;
PRINT #main , "addsprite grass grass" ;
PRINT #main , "spritexy grass " ; 870 ; " " ; -20
PRINT #main , "addsprite Sonic_spin J1.bmp J2.bmp J3.bmp J4.bmp" ;
PRINT #main , "addsprite Sonic_idle sonic_idle.bmp" ;
PRINT #main , "addsprite Death D.bmp" ;
PRINT #main , "spritexy Death " ; 0 ; " " ; 300
PRINT #main , "spritevisible fall off" ;
PRINT #main , "addsprite Sonic_spin_Dash R1.bmp R2.bmp R3.bmp R4.bmp" ;
PRINT #main , "spritevisible Sonic_spin off" ;
PRINT #main , "spritevisible Push off" ;
PRINT #main , "spritevisible Blocker off" ;
PRINT #main , "spritevisible Sonic_spin_Dash off" ;
PRINT #main , "addsprite G1 G1.bmp" ;
PRINT #main , "addsprite G4 G1.bmp" ;
PRINT #main , "addsprite G2 G1.bmp" ;
PRINT #main , "addsprite G3.1 G3.bmp" ;
PRINT #main , "addsprite G5 G4.bmp" ;
PRINT #main , "addsprite G3.2 G3.bmp" ;
PRINT #main , "spritexy G2 " ; 420 ; " " ; 142
PRINT #main , "spritexy G4 " ; 1130 ; " " ; 190
PRINT #main , "spritexy G5 " ; 1450 ; " " ; 190
PRINT #main , "spritexy R1 " ; 160 ; " " ; 120
PRINT #main , "spritexy R2 " ; 180 ; " " ; 120
PRINT #main , "spritexy R3 " ; 200 ; " " ; 120
PRINT #main , "spritexy G1 " ; 0 ; " " ; 142
PRINT #main , "spritexy G2 " ; 320 ; " " ; 142
PRINT #main , "spritexy Ground2 " ; 620 ; " " ; 142
PRINT #main , "spritexy G3.1 " ; 870 ; " " ; 10
PRINT #main , "spritexy G3.2 " ; 939 ; " " ; 10
PRINT #main , "spritexy Blocker " ; 869 ; " " ; 10
PRINT #main , "spritexy Spring1 " ; 800 ; " " ; 129
PRINT #main , "spritexy Sonic " ; 125 ; " " ; 100
PRINT #main , "spritevisible Duck off" ;
PRINT #main , "spritevisible look_up off" ;
PRINT #main , "spritevisible Sonic_idle off" ;
PRINT #main , "background B1.bmp" ;
PRINT #main , "spritevisible Sonic off" ;
PRINT #main , "spritevisible Jump off" ;
PRINT #main , "spriteorient G3.2 mirror" ;
PRINT #main , "drawsprites" ;
GOTO [intro_screen]
[1]
GOSUB [refreshsprites3]
[scan_keys]
GOSUB [action]
[scan_keys2]
IF duck$ = "1" THEN GOTO [check_duck_status]
IF lookup$ = "1" THEN GOTO [check_up_status]
key = VK.RIGHT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [move_right]
key = VK.LEFT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [move_left]
key = VK.DOWN
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [move_duck]
key = VK.UP
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [move_look_up]
key = VK.SPACE
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [move_jump_up]
GOSUB [scan_gravity]
GOSUB [onesecond0_0]
IF state$ = "idle" THEN PRINT #main , "drawsprites" ;
IF state$ = "idle" THEN GOTO [scan_keys]
IF state$ = "not_idle" THEN GOTO [idle_check]
GOTO [Sonic_idle]
GOSUB [action]
GOTO [scan_keys]
[idle_check]
IF chk1$ = "1" THEN chk1$ = "0" : GOTO [Sonic_idle]
chk1$ = "1"
GOTO [scan_keys]
[check_duck_status]
key = VK.DOWN
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [scan_keys]
GOTO [restore_sonic_upright]
[check_up_status]
key = VK.UP
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [scan_keys]
GOTO [restore_sonic_upright]
[main.inputLoop]
[halt]
WAIT
[quit]
CLOSE #main
GOSUB [stopmusicwav]
GOSUB [closemusicwav]
END
[menu]
PLAYWAVE "pause.wav" , async
IF menu$ = "1" THEN menu$ = "0" : GOSUB [close_menu]
menu$ = "1"
PRINT #main , "addsprite fade GR0.bmp" ;
PRINT #main , "spritevisible fade on" ;
PRINT #main , "spritexy fade 0 0" ;
PRINT #main , "cyclesprite fade 1"
GOSUB [refreshsprites7]
GOTO [halt]
[close_menu]
PRINT #main , "spritevisible fade off" ;
PRINT #main , "spritexy fade 0 600" ;
GOTO [scan_keys]
[reset_sprites]
PRINT #main , "spritexy Duck " ; 0 ; " " ; 0
PRINT #main , "spritexy look_up " ; 0 ; " " ; 0
PRINT #main , "spritexy Sonic_spin " ; 0 ; " " ; 0
PRINT #main , "spritexy Sonic_spin_Dash " ; 0 ; " " ; 0
RETURN
[refreshsprites3]
PRINT #main , "drawsprites" ;
[onesecond3]
TIMER 20 , [threeSeconds3]
WAIT
[threeSeconds3]
TIMER 0
RETURN
[intro_screen]
LOADBMP "level" , "images\" + Level$
PRINT #main , "addsprite red_banner red_banner.bmp" ;
PRINT #main , "spritexy red_banner " ; 0 ; " " ; -224
PRINT #main , "addsprite blue_banner blue_banner.bmp" ;
PRINT #main , "spritexy blue_banner " ; 309 ; " " ; 0
PRINT #main , "addsprite level_name level" ;
PRINT #main , "spritexy level_name " ; 317 ; " " ; 30
PRINT #main , "addsprite yellow_banner yellow_title.bmp" ;
PRINT #main , "spritexy yellow_banner " ; 312 ; " " ; 133
PRINT #main , "spritemovexy red_banner 0 5" ;
PRINT #main , "spritemovexy blue_banner -5 0" ;
PRINT #main , "spritemovexy level_name -5 0" ;
PRINT #main , "spritemovexy yellow_banner -5 0" ;
FOR var = 1 TO 40
GOSUB [refreshsprites7]
NEXT var
GOSUB [onesecond8]
FOR E = 1 TO 41
PRINT #main , "spritemovexy red_banner 0 -5" ;
PRINT #main , "spritemovexy blue_banner 5 0" ;
PRINT #main , "spritemovexy level_name 5 0" ;
PRINT #main , "spritemovexy yellow_banner 5 0" ;
GOSUB [refreshsprites7]
NEXT E
PRINT #main , "spritevisible Sonic on" ;
PRINT #main , "spritemovexy red_banner 0 0" ;
PRINT #main , "spritemovexy blue_banner 0 0" ;
PRINT #main , "spritemovexy yellow_banner 0 0" ;
PRINT #main , "spritemovexy level_name 0 0" ;
GOTO [1]
[onesecond0_0]
TIMER 1 , [threeSeconds0_0]
WAIT
[threeSeconds0_0]
TIMER 0
RETURN
[onesecond0]
TIMER 100 , [threeSeconds0]
WAIT
[threeSeconds0]
TIMER 0
RETURN
[refreshsprites4]
PRINT #main , "drawsprites" ;
[onesecond4]
TIMER 300 , [threeSeconds4]
WAIT
[threeSeconds4]
TIMER 0
RETURN
[refreshsprites5]
PRINT #main , "drawsprites" ;
[onesecond5]
TIMER 45 , [threeSeconds5]
WAIT
[threeSeconds5]
TIMER 0
RETURN
[refreshsprites6]
PRINT #main , "drawsprites" ;
[onesecond6]
TIMER 50 , [threeSeconds6]
WAIT
[threeSeconds6]
TIMER 0
RETURN
[refreshsprites7]
PRINT #main , "drawsprites" ;
[onesecond7]
TIMER 10 , [threeSeconds7]
WAIT
[threeSeconds7]
TIMER 0
RETURN
[onesecond7B]
PRINT #main , "drawsprites" ;
PRINT #main , "drawsprites" ;
PRINT #main , "drawsprites" ;
TIMER 1 , [threeSeconds7B]
WAIT
[threeSeconds7B]
TIMER 0
RETURN
[onesecond8]
TIMER 500 , [threeSeconds8]
WAIT
[threeSeconds8]
TIMER 0
RETURN
[collect_ring]
Rings = Rings + 1
a$ = STR$( Rings )
#main.screen , "home"
#main.screen , "backcolor 0 0 0"
#main.screen , "down"
#main.screen , "place 0 10" ;
#main.screen , "color yellow"
#main.screen , "fill black"
#main.screen , "\Rings" ;
#main.screen , "place 35 10" ;
#main.screen , "color red"
#main.screen , "\" + a$
#main.screen , "flush"
RETURN
[move_sonic_die]
PLAYWAVE "S2_23.wav" , async
GOSUB [onesecond8]
PRINT #main , "addsprite black DI0.bmp DI1.bmp DI2.bmp DI3.bmp DI4.bmp DI5.bmp DI6.bmp DI7.bmp DI8.bmp DI9.bmp DI10.bmp DI11.bmp DI12.bmp DI13.bmp DI14.bmp DI15.bmp DI16.bmp" ;
PRINT #main , "spritexy black " ; -120 ; " " ; -180
PRINT #main , "cyclesprite black 1 once"
FOR var = 1 TO 10
GOSUB [refreshsprites7]
NEXT var
GOSUB [stopmusicwav]
GOTO [halt]
[scan_gravity]
PRINT #main , "spritemovexy Sonic 0 0" ;
PRINT #main , "spritemovexy Jump 0 0" ;
PRINT #main , "spritemovexy Push 0 0" ;
PRINT #main , "spritemovexy Sonic_spin 0 0" ;
PRINT #main , "spritemovexy Sonic_idle 0 0" ;
PRINT #main , "spritecollides Sonic So$" ;
IF So$ = "Sonic_idle" THEN GOTO [move_fall]
IF So$ = "Sonic_spin Sonic_idle" THEN GOTO [move_fall]
IF So$ = "Sonic_idle Senceor2" THEN GOTO [move_fall]
IF So$ = "Sonic_idle Senceor1" THEN GOTO [move_fall]
IF So$ = "Senceor2" THEN GOTO [move_fall]
IF So$ = "Senceor1" THEN GOTO [move_fall]
IF So$ = "Jump Sonic_idle" THEN GOTO [move_fall]
IF So$ = "" THEN GOTO [move_fall]
RETURN
[scan_gravity_J]
PRINT #main , "spritecollides Sonic_spin So$" ; xxxxxxxx
IF So$ = "Sonic_idle" THEN GOTO [move_fall]
IF So$ = "Sonic_spin Sonic_idle" THEN GOTO [move_fall]
IF So$ = "Sonic_idle Senceor2" THEN GOTO [move_fall]
IF So$ = "Sonic_idle Senceor1" THEN GOTO [move_fall]
IF So$ = "Senceor2" THEN GOTO [move_fall]
IF So$ = "Senceor1" THEN GOTO [move_fall]
IF So$ = "" THEN GOTO [move_fall]
RETURN
[check_scroll_L]
GOSUB [scan_gravity]
IF se$ = "" THEN RETURN
IF se$ = "Sonic" THEN GOTO [scroll_L]
IF se$ = "Sonic_idle" THEN GOTO [scroll_L]
se$ = ""
RETURN
GOTO [scroll_L]
RETURN
[scroll_L]
GOSUB [ring_check]
[scroll_L_J]
PRINT #main , "spritecollides Sonic Walk$" ;
IF Walk$ = "Ground2 Blocker Sonic_idle" THEN GOTO [move_blocked]
IF Walk$ = "Ground2 Blocker Sonic_idle G3.1" THEN GOTO [move_blocked]
IF Walk$ = "Ground2 Blocker" THEN GOTO [move_blocked]
PRINT #main , "spritexy? G1 x y"
PRINT #main , "spritexy? G2 Q W"
PRINT #main , "spritexy? Tree1 QQ WW"
PRINT #main , "spritexy? Ground2 QXQ WXW"
PRINT #main , "spritexy? G3.1 QXBQ WXBW"
PRINT #main , "spritexy? G3.2 QXBBQ WXBBW"
PRINT #main , "spritexy? Blocker QXBBCQ WXBBCW"
PRINT #main , "spritexy? Spring1 QXBBCCQ WXBBCCW"
PRINT #main , "spritexy? R1 QXBBCCQQA WXBBCCWWA"
PRINT #main , "spritexy? R2 QXBBCCQQB WXBBCCWWB"
PRINT #main , "spritexy? R3 QXBBCCQQC WXBBCCWWC"
PRINT #main , "spritexy? grass QXBBCCQQCX WXBBCCWWCX"
PRINT #main , "spritexy? port.bmp xY1 yX1"
PRINT #main , "spritexy? pipe2.bmp xY2 yX2"
PRINT #main , "spritexy? pipe.bmp xY3 yX3"
PRINT #main , "spritexy? BUG xY4 yX4"
PRINT #main , "spritexy? BL1 xY5 yX5"
PRINT #main , "spritexy? BL2 xY6 yX6"
PRINT #main , "spritexy? Blocker2 xY7 yX7"
PRINT #main , "spritexy? pipe3.bmp xY8 yX8"
PRINT #main , "spritexy? G4 xY9 yX9"
PRINT #main , "spritexy? G5 xY10 yX10"
PRINT #main , "spritemovexy G1 4 0" ;
PRINT #main , "spritemovexy G2 4 0" ;
PRINT #main , "spritemovexy Tree1 4 0" ;
PRINT #main , "spritemovexy Ground2 4 0" ;
PRINT #main , "spritemovexy G3.1 4 0" ;
PRINT #main , "spritemovexy G3.2 4 0" ;
PRINT #main , "spritemovexy G3.2 4 0" ;
PRINT #main , "spritemovexy  Blocker 4 0" ;
PRINT #main , "spritemovexy  Spring1 4 0" ;
PRINT #main , "spritemovexy  R1 4 0" ;
PRINT #main , "spritemovexy  R2 4 0" ;
PRINT #main , "spritemovexy  R3 4 0" ;
PRINT #main , "spritemovexy  grass 4 0" ;
PRINT #main , "spritemovexy  port.bmp 4 0" ;
PRINT #main , "spritemovexy  pipe2.bmp 4 0" ;
PRINT #main , "spritemovexy  pipe.bmp 4 0" ;
PRINT #main , "spritemovexy  BUG 4 0" ;
PRINT #main , "spritemovexy  BL1 4 0" ;
PRINT #main , "spritemovexy  BL2 4 0" ;
PRINT #main , "spritemovexy  Blocker2 4 0" ;
PRINT #main , "spritemovexy  pipe3.bmp 4 0" ;
PRINT #main , "spritemovexy  G4 4 0" ;
PRINT #main , "spritemovexy  G5 4 0" ;
PRINT #main , "spritexy G1 " ; x ; " " ; y
PRINT #main , "spritexy G2 " ; Q ; " " ; W
PRINT #main , "spritexy Tree1 " ; QQ ; " " ; WW
PRINT #main , "spritexy Ground2 " ; QXQ ; " " ; WXW
PRINT #main , "spritexy G3.1 " ; QXBQ ; " " ; WXBW
PRINT #main , "spritexy G3.2 " ; QXBBQ ; " " ; WXBBW
PRINT #main , "spritexy Blocker " ; QXBBCQ ; " " ; WXBBCW
PRINT #main , "spritexy Spring1 " ; QXBBCCQ ; " " ; WXBBCCW
PRINT #main , "spritexy R1 " ; QXBBCCQQA ; " " ; WXBBCCWWA
PRINT #main , "spritexy R2 " ; QXBBCCQQB ; " " ; WXBBCCWWB
PRINT #main , "spritexy R3 " ; QXBBCCQQC ; " " ; WXBBCCWWC
PRINT #main , "spritexy grass " ; QXBBCCQQCX ; " " ; WXBBCCWWCX
PRINT #main , "spritexy port.bmp " ; xY1 ; " " ; yX1
PRINT #main , "spritexy pipe2.bmp " ; xY2 ; " " ; yX2
PRINT #main , "spritexy pipe.bmp " ; xY3 ; " " ; yX3
PRINT #main , "spritexy BUG " ; xY4 ; " " ; yX4
PRINT #main , "spritexy BL1 " ; xY5 ; " " ; yX5
PRINT #main , "spritexy BL2 " ; xY6 ; " " ; yX6
PRINT #main , "spritexy Blocker2 " ; xY7 ; " " ; yX7
PRINT #main , "spritexy pipe3.bmp " ; xY8 ; " " ; yX8
PRINT #main , "spritexy G4 " ; xY9 ; " " ; yX9
PRINT #main , "spritexy G5 " ; xY10 ; " " ; yX10
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy G1 0 0" ;
PRINT #main , "spritemovexy G2 0 0" ;
PRINT #main , "spritemovexy Tree1 0 0" ;
PRINT #main , "spritemovexy Ground2 0 0" ;
PRINT #main , "spritemovexy G3.1 0 0" ;
PRINT #main , "spritemovexy G3.2 0 0" ;
PRINT #main , "spritemovexy Blocker 0 0" ;
PRINT #main , "spritemovexy Spring1 0 0" ;
PRINT #main , "spritemovexy R1 0 0" ;
PRINT #main , "spritemovexy R2 0 0" ;
PRINT #main , "spritemovexy R3 0 0" ;
PRINT #main , "spritemovexy grass 0 0" ;
PRINT #main , "spritemovexy port.bmp 0 0" ;
PRINT #main , "spritemovexy pipe2.bmp 0 0" ;
PRINT #main , "spritemovexy pipe.bmp 0 0" ;
PRINT #main , "spritemovexy BUG 0 0" ;
PRINT #main , "spritemovexy BL1 0 0" ;
PRINT #main , "spritemovexy BL2 0 0" ;
PRINT #main , "spritemovexy Blocker2 0 0" ;
PRINT #main , "spritemovexy pipe3.bmp 0 0" ;
PRINT #main , "spritemovexy G4 0 0" ;
PRINT #main , "spritemovexy G5 0 0" ;
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy Sonic 0 0" ;
PRINT #main , "cyclesprite Sonic 1"
IF jumpA$ = "1" THEN RETURN
GOSUB [refreshsprites5]
GOSUB [scan_gravity]
GOSUB [action]
key = VK.SPACE
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [move_jump_up]
key = VK.LEFT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [scroll_L]
RETURN
[check_scroll_R]
IF se$ = "" THEN RETURN
IF se$ = "Sonic" THEN GOTO [scroll_R]
IF se$ = "Sonic Sonic_idle" THEN GOTO [scroll_R]
IF se$ = "Sonic Sonic_idle" THEN GOTO [scroll_R]
se$ = ""
RETURN
GOTO [scroll_R]
[ring_check]
PRINT #main , "spritecollides Sonic Ring$" ;
IF Ring$ = "R1 Sonic_idle G1" THEN PRINT #main , "spritevisible R1 off" ; : PLAYWAVE "S3&k_31.wav" , async : PRINT #main , "spritexy R1 0 0" ; : GOTO [collect_ring]
IF Ring$ = "R2 Sonic_idle G1" THEN PRINT #main , "spritevisible R2 off" ; : PLAYWAVE "S3&k_31.wav" , async : PRINT #main , "spritexy R2 0 0" ; : GOTO [collect_ring]
IF Ring$ = "R3 Sonic_idle G1" THEN PRINT #main , "spritevisible R3 off" ; : PLAYWAVE "S3&k_31.wav" , async : PRINT #main , "spritexy R3 0 0" ; : GOTO [collect_ring]
RETURN
[scroll_R]
runcount = runcount + 1
runcount$ = STR$( runcount )
GOSUB [ring_check]
PRINT #main , "spritecollides Sonic Walk$" ;
IF Walk$ = "Ground2 Blocker Sonic_idle" THEN GOTO [move_blocked]
IF Walk$ = "Ground2 Blocker Sonic_idle G3.1" THEN GOTO [move_blocked]
IF Walk$ = "Ground2 Blocker" THEN GOTO [move_blocked]
IF Walk$ = "Ground2 Push Blocker Sonic_idle G3.1" THEN GOTO [move_blocked]
[scroll_move_right]
PRINT #main , "spritevisible Sonic_idle off" ;
PRINT #main , "spritexy? G1 x y"
PRINT #main , "spritexy? G2 Q W"
PRINT #main , "spritexy? Tree1 QQ WW"
PRINT #main , "spritexy? Ground2 QXQ WXW"
PRINT #main , "spritexy? G3.1 QXBQ WXBW"
PRINT #main , "spritexy? G3.2 QXBBQ WXBBW"
PRINT #main , "spritexy? Blocker QXBBCQ WXBBCW"
PRINT #main , "spritexy? Spring1 QXBBCCQ WXBBCCW"
PRINT #main , "spritexy? R1 XXRRA XXRA"
PRINT #main , "spritexy? R2 XXRRB XXRB"
PRINT #main , "spritexy? R3 XXRRC XXRC"
PRINT #main , "spritexy? grass XXRRCX XXRCX"
PRINT #main , "spritexy? port.bmp xY yX"
PRINT #main , "spritexy? pipe2.bmp xY2 yX2"
PRINT #main , "spritexy? pipe.bmp xY3 yX3"
PRINT #main , "spritexy? BUG xY4 yX4"
PRINT #main , "spritexy? BL1 xY5 yX5"
PRINT #main , "spritexy? BL2 xY6 yX6"
PRINT #main , "spritexy? Blocker2 xY7 yX7"
PRINT #main , "spritexy? pipe3.bmp xY8 yX8"
PRINT #main , "spritexy? G4 xY9 yX9"
PRINT #main , "spritexy? G5 xY10 yX10"
PRINT #main , "spritemovexy G1 -4 0" ;
PRINT #main , "spritemovexy G2 -4 0" ;
PRINT #main , "spritemovexy Tree1 -4 0" ;
PRINT #main , "spritemovexy Ground2 -4 0" ;
PRINT #main , "spritemovexy G3.1 -4 0" ;
PRINT #main , "spritemovexy G3.2 -4 0" ;
PRINT #main , "spritemovexy Blocker -4 0" ;
PRINT #main , "spritemovexy Spring1 -4 0" ;
PRINT #main , "spritemovexy R1 -4 0" ;
PRINT #main , "spritemovexy R2 -4 0" ;
PRINT #main , "spritemovexy R3 -4 0" ;
PRINT #main , "spritemovexy grass -4 0" ;
PRINT #main , "spritemovexy  port.bmp -4 0" ;
PRINT #main , "spritemovexy  pipe2.bmp -4 0" ;
PRINT #main , "spritemovexy  pipe.bmp -4 0" ;
PRINT #main , "spritemovexy  BUG -4 0" ;
PRINT #main , "spritemovexy  BL1 -4 0" ;
PRINT #main , "spritemovexy  BL2 -4 0" ;
PRINT #main , "spritemovexy  Blocker2 -4 0" ;
PRINT #main , "spritemovexy  pipe3.bmp -4 0" ;
PRINT #main , "spritemovexy  G4 -4 0" ;
PRINT #main , "spritemovexy  G5 -4 0" ;
PRINT #main , "spritexy G1 " ; x ; " " ; y
PRINT #main , "spritexy G2 " ; Q ; " " ; W
PRINT #main , "spritexy Tree1 " ; QQ ; " " ; WW
PRINT #main , "spritexy Ground2 " ; QXQ ; " " ; WXW
PRINT #main , "spritexy G3.1 " ; QXBQ ; " " ; WXBW
PRINT #main , "spritexy G3.2 " ; QXBBQ ; " " ; WXBBW
PRINT #main , "spritexy Blocker " ; QXBBCQ ; " " ; WXBBCW
PRINT #main , "spritexy Spring1 " ; QXBBCCQ ; " " ; WXBBCCW
PRINT #main , "spritexy R1 " ; XXRRA ; " " ; XXRA
PRINT #main , "spritexy R2 " ; XXRRB ; " " ; XXRB
PRINT #main , "spritexy R3 " ; XXRRC ; " " ; XXRC
PRINT #main , "spritexy grass " ; XXRRCX ; " " ; XXRCX
PRINT #main , "spritexy port.bmp " ; xY ; " " ; yX
PRINT #main , "spritexy? pipe2.bmp xY2 yX2"
PRINT #main , "spritexy? pipe.bmp xY3 yX3"
PRINT #main , "spritexy? BUG xY4 yX4"
PRINT #main , "spritexy? BL1 xY5 yX5"
PRINT #main , "spritexy? BL2 xY6 yX6"
PRINT #main , "spritexy? Blocker2 xY7 yX7"
PRINT #main , "spritexy? pipe3.bmp xY8 yX8"
PRINT #main , "spritexy? G4 xY9 yX9"
PRINT #main , "spritexy? G5 xY10 yX10"
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy G1 0 0" ;
PRINT #main , "spritemovexy G2 0 0" ;
PRINT #main , "spritemovexy Tree1 0 0" ;
PRINT #main , "spritemovexy Ground2 0 0" ;
PRINT #main , "spritemovexy G3.1 0 0" ;
PRINT #main , "spritemovexy G3.2 0 0" ;
PRINT #main , "spritemovexy Blocker 0 0" ;
PRINT #main , "spritemovexy Spring1 0 0" ;
PRINT #main , "spritemovexy R1 0 0" ;
PRINT #main , "spritemovexy R2 0 0" ;
PRINT #main , "spritemovexy R3 0 0" ;
PRINT #main , "spritemovexy grass 0 0" ;
PRINT #main , "spritemovexy port.bmp 0 0" ;
PRINT #main , "spritemovexy pipe2.bmp 0 0" ;
PRINT #main , "spritemovexy pipe.bmp 0 0" ;
PRINT #main , "spritemovexy BUG 0 0" ;
PRINT #main , "spritemovexy BL1 0 0" ;
PRINT #main , "spritemovexy BL2 0 0" ;
PRINT #main , "spritemovexy Blocker2 0 0" ;
PRINT #main , "spritemovexy pipe3.bmp 0 0" ;
PRINT #main , "spritemovexy G4 0 0" ;
PRINT #main , "spritemovexy G5 0 0" ;
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy Sonic 0 0" ;
PRINT #main , "cyclesprite Sonic 1"
GOSUB [refreshsprites5]
GOSUB [scan_gravity]
GOSUB [action]
key = VK.SPACE
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [move_jump_up]
key = VK.RIGHT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [scroll_R]
RETURN
[move_fall]
PRINT #main , "spritexy? Sonic x y"
PRINT #main , "spritemovexy Sonic 0 1" ;
PRINT #main , "spritemovexy Sonic_idle 0 1" ;
PRINT #main , "spritexy Sonic " ; x ; " " ; y
PRINT #main , "drawsprites" ; : PRINT #main , "spritecollides Death E$" ;
PRINT E$
IF E$ = "Sonic" THEN GOTO [move_sonic_die]
IF E$ = "Ground2 Sonic_idle Death" THEN GOTO [move_sonic_die]
IF E$ = "Ground2 Death" THEN GOTO [move_sonic_die]
PRINT #main , "spritexy? Sonic xG yG"
PRINT #main , "spritexy fall " ; xG ; " " ; yG
PRINT #main , "spritevisible fall on" ;
PRINT #main , "spritevisible Sonic off" ;
PRINT #main , "spritevisible Sonic_idle off" ;
PRINT #main , "cyclesprite fall 1"
FOR DIE = 1 TO 47
GOSUB [onesecond0_0]
PRINT E$
PRINT #main , "spritexy? G1 x y"
PRINT #main , "spritexy? G2 Q W"
PRINT #main , "spritexy? Tree1 QQ WW"
PRINT #main , "spritexy? Ground2 QXQ WXW"
PRINT #main , "spritexy? G3.1 QXBQ WXBW"
PRINT #main , "spritexy? G3.2 QXBBQ WXBBW"
PRINT #main , "spritexy? Blocker QXBBCQ WXBBCW"
PRINT #main , "spritexy? Spring1 QXBBCCQ WXBBCCW"
PRINT #main , "spritexy? R1 QXBBCCQQA WXBBCCWWA"
PRINT #main , "spritexy? R2 QXBBCCQQB WXBBCCWWB"
PRINT #main , "spritexy? R3 QXBBCCQQC WXBBCCWWC"
PRINT #main , "spritexy? grass QXBBCCQQCX WXBBCCWWCX"
PRINT #main , "spritexy? port.bmp yH xH"
PRINT #main , "spritexy? pipe2.bmp yH2 xH2"
PRINT #main , "spritexy? pipe.bmp yH3 xH3"
PRINT #main , "spritexy? G4 xY8 yX8"
PRINT #main , "spritexy? pipe3.bmp xY9 yX9"
PRINT #main , "spritexy? G5 xY10 yX10"
PRINT #main , "spritemovexy G1 0 -10" ;
PRINT #main , "spritemovexy G2 0 -10" ;
PRINT #main , "spritemovexy Tree1 0 -10" ;
PRINT #main , "spritemovexy Ground2 0 -10" ;
PRINT #main , "spritemovexy G3.1 0 -10" ;
PRINT #main , "spritemovexy G3.2 0 -10" ;
PRINT #main , "spritemovexy G3.2 0 -10" ;
PRINT #main , "spritemovexy  Blocker 0 -10" ;
PRINT #main , "spritemovexy  Spring1 0 -10" ;
PRINT #main , "spritemovexy  R1 0 -10" ;
PRINT #main , "spritemovexy  R2 0 -10" ;
PRINT #main , "spritemovexy  R3 0 -10" ;
PRINT #main , "spritemovexy  grass 0 -10" ;
PRINT #main , "spritemovexy  port.bmp 0 -10" ;
PRINT #main , "spritemovexy  pipe2.bmp 0 -10" ;
PRINT #main , "spritemovexy  pipe.bmp 0 -10" ;
PRINT #main , "spritemovexy  G4 0 -10" ;
PRINT #main , "spritemovexy  pipe3.bmp 0 -10" ;
PRINT #main , "spritemovexy  G5 0 -10" ;
PRINT #main , "spritexy G1 " ; x ; " " ; y
PRINT #main , "spritexy G2 " ; Q ; " " ; W
PRINT #main , "spritexy Tree1 " ; QQ ; " " ; WW
PRINT #main , "spritexy Ground2 " ; QXQ ; " " ; WXW
PRINT #main , "spritexy G3.1 " ; QXBQ ; " " ; WXBW
PRINT #main , "spritexy G3.2 " ; QXBBQ ; " " ; WXBBW
PRINT #main , "spritexy Blocker " ; QXBBCQ ; " " ; WXBBCW
PRINT #main , "spritexy Spring1 " ; QXBBCCQ ; " " ; WXBBCCW
PRINT #main , "spritexy R1 " ; QXBBCCQQA ; " " ; WXBBCCWWA
PRINT #main , "spritexy R2 " ; QXBBCCQQB ; " " ; WXBBCCWWB
PRINT #main , "spritexy R3 " ; QXBBCCQQC ; " " ; WXBBCCWWC
PRINT #main , "spritexy grass " ; QXBBCCQQCX ; " " ; WXBBCCWWCX
PRINT #main , "spritexy port.bmp " ; yH ; " " ; xH
PRINT #main , "spritexy pipe2.bmp " ; yH2 ; " " ; xH2
PRINT #main , "spritexy pipe.bmp " ; yH3 ; " " ; xH3
PRINT #main , "spritexy pipe3.bmp " ; xY9 ; " " ; yX9
PRINT #main , "spritexy G4 " ; xY8 ; " " ; yX8
PRINT #main , "spritexy G5 " ; xY10 ; " " ; yX10
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy G1 0 0" ;
PRINT #main , "spritemovexy G2 0 0" ;
PRINT #main , "spritemovexy Tree1 0 0" ;
PRINT #main , "spritemovexy Ground2 0 0" ;
PRINT #main , "spritemovexy G3.1 0 0" ;
PRINT #main , "spritemovexy G3.2 0 0" ;
PRINT #main , "spritemovexy Blocker 0 0" ;
PRINT #main , "spritemovexy Spring1 0 0" ;
PRINT #main , "spritemovexy R1 0 0" ;
PRINT #main , "spritemovexy R2 0 0" ;
PRINT #main , "spritemovexy R3 0 0" ;
PRINT #main , "spritemovexy grass 0 0" ;
PRINT #main , "spritemovexy port.bmp 0 0" ;
PRINT #main , "spritemovexy pipe2.bmp 0 0" ;
PRINT #main , "spritemovexy pipe.bmp 0 0" ;
PRINT #main , "spritemovexy G4 0 0" ;
PRINT #main , "spritemovexy pipe3.bmp 0 0" ;
PRINT #main , "spritemovexy G5 0 0" ;
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy Sonic 0 0" ;
PRINT #main , "drawsprites" ; : PRINT #main , "spritecollides Death E$" ;
PRINT #main , "drawsprites" ; : PRINT #main , "spritecollides Death E$" ;
IF E$ = "Sonic Sonic_idle" THEN GOTO [move_sonic_die]
IF E$ = "Sonic_idle" THEN GOTO [move_sonic_die]
NEXT DIE
RETURN
[move_blocked]
PRINT #main , "spritevisible Push on" ;
PRINT #main , "spritevisible Sonic off" ;
PRINT #main , "spritexy? Sonic x y"
PRINT #main , "spritexy Push " ; x ; " " ; y
PRINT #main , "cyclesprite Push 1 once"
PRINT #main , "spritemovexy Sonic 0 0" ;
PRINT #main , "drawsprites" ;
PRINT #main , "spritevisible Push off" ;
PRINT #main , "spritevisible Sonic on" ;
GOSUB [onesecond8]
key = VK.RIGHT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [move_blocked]
GOTO [scan_keys]
[move_right]
IwalkingL$ = "0"
IF state$ = "idle" THEN GOTO [undo_idle]
walkingR$ = "1"
IwalkingR$ = "1"
PRINT #main , "cyclesprite Sonic 1 once"
IF duck$ = "1" THEN GOSUB [restore_sonic_upright]
PRINT #main , "spriteorient Sonic normal" ;
PRINT #main , "spritemovexy Sonic 5 0" ;
GOSUB [onesecond0]
key = VK.SPACE
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [move_jump_up]
GOSUB [check_scroll_R]
GOSUB [scan_gravity]
GOSUB [scroll_R]
GOTO [1]
[move_left]
GOSUB [action]
IwalkingR$ = "0"
IF state$ = "idle" THEN GOTO [undo_idle]
IwalkingL$ = "1"
walkingL$ = "1"
PRINT #main , "cyclesprite Sonic 1 once"
IF duck$ = "1" THEN GOSUB [restore_sonic_upright]
PRINT #main , "spriteorient Sonic mirror" ;
PRINT #main , "spritemovexy Sonic -5 0" ;
GOSUB [onesecond0]
key = VK.SPACE
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [move_jump_up]
GOSUB [check_scroll_L]
GOSUB [scan_gravity]
GOSUB [scroll_L]
GOTO [1]
[move_jump_up]
IF IwalkingR$ = "1" THEN PRINT #main , "spriteorient Sonic_spin normal" ;
IF IwalkingL$ = "1" THEN PRINT #main , "spriteorient Sonic_spin mirror" ;
PRINT #main , "spritexy? Sonic_idle V B"
PRINT #main , "spritevisible Sonic_spin on" ;
PRINT #main , "spritevisible Sonic off" ;
PRINT #main , "spritexy Sonic_spin " ; V ; " " ; B
PRINT #main , "cyclesprite Sonic_spin 1 "
PRINT #main , "spritevisible Sonic_idle off" ;
PRINT #main , "spritemovexy Sonic_spin 0 -20" ;
GOSUB [refreshsprites3]
key = VK.LEFT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [jump_move_left_s]
key = VK.RIGHT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [jump_move_right_s]
key = VK.RIGHT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [jump_move_right_s]
key = VK.LEFT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [jump_move_left_s]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
PRINT #main , "spritemovexy Sonic_spin 0 20" ;
key = VK.RIGHT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [jump_move_right]
key = VK.LEFT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [jump_move_left]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
PRINT #main , "spritevisible Sonic_idle on" ;
PRINT #main , "spritevisible Sonic_spin off" ;
PRINT #main , "spritexy? Sonic_spin N M"
PRINT #main , "spritexy Sonic " ; N ; " " ; M
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
PRINT #main , "spritecollides Sonic jump$" ;
IF jump$ = "Ground2 Spring1 Sonic_spin Sonic_idle" THEN GOSUB [spring_launch]
IF jump$ = "Duck look_up Ground2 Spring1 Sonic_spin Sonic_idle" THEN GOSUB [spring_launch]
IF jump$ = "Ground2 Spring1 Sonic_spin Sonic_idle" THEN GOSUB [spring_launch]
IF jump$ = "look_up Ground2 Spring1 Sonic_spin Sonic_idle" THEN GOSUB [spring_launch]
IF jump$ = "Ground2 Spring1 Push Sonic_spin Sonic_idle" THEN GOSUB [spring_launch]
IF jump$ = "Ground2 Spring1 Push Sonic_spin Sonic_idle" THEN GOSUB [spring_launch]
IF jump$ = "Duck Ground2 Spring1 Push Sonic_spin Sonic_idle" THEN GOSUB [spring_launch]
GOTO [Sonic_idle]
[jump_move_right]
Move2$ = "1"
PRINT #main , "spritemovexy Sonic_spin 15 20" ;
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
PRINT #main , "spritevisible Sonic_idle on" ;
PRINT #main , "spritevisible Sonic_spin off" ;
PRINT #main , "spritexy? Sonic_spin N M"
PRINT #main , "spritexy Sonic " ; N ; " " ; M
GOTO [Sonic_idle]
[spring_launch]
IF IwalkingR$ = "1" THEN PRINT #main , "spriteorient Jump normal" ;
IF IwalkingL$ = "1" THEN PRINT #main , "spriteorient Jump mirror" ;
PRINT #main , "cyclesprite Spring1 1 once"
PRINT #main , "spritevisible Sonic off" ;
PRINT #main , "spritevisible Sonic_idle off" ;
PRINT #main , "spritevisible Jump on" ;
PRINT #main , "spritexy? Sonic x y"
PRINT #main , "spritexy Jump " ; x ; " " ; y
PRINT #main , "spritemovexy Jump 0 0" ;
FOR J = 1 TO 30
GOSUB [onesecond7B]
GOSUB [scan_gravity_J]
key = VK.RIGHT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOSUB [spring_jump_move_right]
key = VK.LEFT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOSUB [spring_jump_move_left]
PRINT #main , "spritexy? G1 x y"
PRINT #main , "spritexy? G2 Q W"
PRINT #main , "spritexy? Tree1 QQ WW"
PRINT #main , "spritexy? Ground2 QXQ WXW"
PRINT #main , "spritexy? G3.1 QXBQ WXBW"
PRINT #main , "spritexy? G3.2 QXBBQ WXBBW"
PRINT #main , "spritexy? Blocker QXBBCQ WXBBCW"
PRINT #main , "spritexy? Spring1 QXBBCCQ WXBBCCW"
PRINT #main , "spritexy? R1 QXBBCCQQA WXBBCCWWA"
PRINT #main , "spritexy? R2 QXBBCCQQB WXBBCCWWB"
PRINT #main , "spritexy? R3 QXBBCCQQC WXBBCCWWC"
PRINT #main , "spritexy? grass QXBBCCQQCX WXBBCCWWCX"
PRINT #main , "spritexy? port.bmp yxH xxH"
PRINT #main , "spritexy? pipe2.bmp yxH2 xxH2"
PRINT #main , "spritexy? pipe.bmp yxH3 xxH3"
PRINT #main , "spritexy? BUG xY4 yX4"
PRINT #main , "spritexy? BL1 xY5 yX5"
PRINT #main , "spritexy? BL2 xY6 yX6"
PRINT #main , "spritexy? pipe3.bmp xY7 yX7"
PRINT #main , "spritexy? G4 xY8 yX8"
PRINT #main , "spritexy? G5 xY9 yX9"
PRINT #main , "spritemovexy G1 0 10" ;
PRINT #main , "spritemovexy G2 0 10" ;
PRINT #main , "spritemovexy Tree1 0 10" ;
PRINT #main , "spritemovexy Ground2 0 10" ;
PRINT #main , "spritemovexy G3.1 0 10" ;
PRINT #main , "spritemovexy G3.2 0 10" ;
PRINT #main , "spritemovexy G3.2 0 10" ;
PRINT #main , "spritemovexy  Blocker 0 10" ;
PRINT #main , "spritemovexy  Spring1 0 10" ;
PRINT #main , "spritemovexy  R1 0 10" ;
PRINT #main , "spritemovexy  R2 0 10" ;
PRINT #main , "spritemovexy  R3 0 10" ;
PRINT #main , "spritemovexy  grass 0 10" ;
PRINT #main , "spritemovexy  port.bmp 0 10" ;
PRINT #main , "spritemovexy  pipe2.bmp 0 10" ;
PRINT #main , "spritemovexy  pipe.bmp 0 10" ;
PRINT #main , "spritemovexy  BUG 0 10" ;
PRINT #main , "spritemovexy  BL1 0 10" ;
PRINT #main , "spritemovexy  BL2 0 10" ;
PRINT #main , "spritemovexy  pipe3.bmp 0 10" ;
PRINT #main , "spritemovexy  G4 0 10" ;
PRINT #main , "spritemovexy  G5 0 10" ;
PRINT #main , "spritexy G1 " ; x ; " " ; y
PRINT #main , "spritexy G2 " ; Q ; " " ; W
PRINT #main , "spritexy Tree1 " ; QQ ; " " ; WW
PRINT #main , "spritexy Ground2 " ; QXQ ; " " ; WXW
PRINT #main , "spritexy G3.1 " ; QXBQ ; " " ; WXBW
PRINT #main , "spritexy G3.2 " ; QXBBQ ; " " ; WXBBW
PRINT #main , "spritexy Blocker " ; QXBBCQ ; " " ; WXBBCW
PRINT #main , "spritexy Spring1 " ; QXBBCCQ ; " " ; WXBBCCW
PRINT #main , "spritexy R1 " ; QXBBCCQQA ; " " ; WXBBCCWWA
PRINT #main , "spritexy R2 " ; QXBBCCQQB ; " " ; WXBBCCWWB
PRINT #main , "spritexy R3 " ; QXBBCCQQC ; " " ; WXBBCCWWC
PRINT #main , "spritexy grass " ; QXBBCCQQCX ; " " ; WXBBCCWWCX
PRINT #main , "spritexy port.bmp " ; yxH ; " " ; xxH
PRINT #main , "spritexy? pipe2.bmp yxH2 xxH2"
PRINT #main , "spritexy? pipe.bmp yxH3 xxH3"
PRINT #main , "spritexy BUG " ; xY4 ; " " ; yX4
PRINT #main , "spritexy BL1 " ; xY5 ; " " ; yX5
PRINT #main , "spritexy BL2 " ; xY6 ; " " ; yX6
PRINT #main , "spritexy BL2 " ; xY7 ; " " ; yX7
PRINT #main , "spritexy G4 " ; xY8 ; " " ; yX8
PRINT #main , "spritexy G5 " ; xY9 ; " " ; yX9
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy G1 0 0" ;
PRINT #main , "spritemovexy G2 0 0" ;
PRINT #main , "spritemovexy Tree1 0 0" ;
PRINT #main , "spritemovexy Ground2 0 0" ;
PRINT #main , "spritemovexy G3.1 0 0" ;
PRINT #main , "spritemovexy G3.2 0 0" ;
PRINT #main , "spritemovexy Blocker 0 0" ;
PRINT #main , "spritemovexy Spring1 0 0" ;
PRINT #main , "spritemovexy R1 0 0" ;
PRINT #main , "spritemovexy R2 0 0" ;
PRINT #main , "spritemovexy R3 0 0" ;
PRINT #main , "spritemovexy grass 0 0" ;
PRINT #main , "spritemovexy port.bmp 0 0" ;
PRINT #main , "spritemovexy pipe2.bmp 0 0" ;
PRINT #main , "spritemovexy pipe.bmp 0 0" ;
PRINT #main , "spritemovexy BUG 0 0" ;
PRINT #main , "spritemovexy BL1 0 0" ;
PRINT #main , "spritemovexy BL2 0 0" ;
PRINT #main , "spritemovexy pipe3.bmp 0 0" ;
PRINT #main , "spritemovexy G4 0 0" ;
PRINT #main , "spritemovexy G5 0 0" ;
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy Sonic 0 0" ;
PRINT #main , "cyclesprite Sonic 1"
NEXT J
key = VK.RIGHT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOSUB [spring_jump_move_right]
key = VK.LEFT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOSUB [spring_jump_move_left]
FOR J2 = 1 TO 30
PRINT #main , "spritecollides Jump sJump$" ;
GOSUB [onesecond7B]
GOSUB [scan_gravity_J]
IF sJump$ = "" THEN GOTO [j]
IF sJump$ = "Sonic Sonic_idle" THEN GOTO [j]
IF sJump$ = "Sonic Spring1 Sonic_idle" THEN GOTO [j]
IF sJump$ = "Ground2 Sonic Spring1 Sonic_idle" THEN GOTO [j]
IF sJump$ = "Sonic Push Sonic_idle" THEN GOTO [j]
IF sJump$ = "Sonic Spring1 Push Sonic_idle" THEN GOTO [j]
IF sJump$ = "Ground2 Sonic Spring1 Push Sonic_idle" THEN GOTO [j]
IF sJump$ = "Ground2" THEN GOTO [j]
IF sJump$ = "Jump Push Sonic_idle" THEN GOTO [j]
PRINT #main , "spritevisible Jump off"
PRINT #main , "spritexy? Jump xl yl"
PRINT #main , "spritexy Sonic_idle " ; xl ; " " ; yl
PRINT #main , "spritexy Sonic " ; xl ; " " ; yl + 5
GOTO [Sonic_idle]
[j]
key = VK.RIGHT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOSUB [spring_jump_move_right]
key = VK.LEFT
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOSUB [spring_jump_move_left]
[scroll_move_down]
PRINT #main , "spritexy? G1 x y"
PRINT #main , "spritexy? G2 Q W"
PRINT #main , "spritexy? Tree1 QQ WW"
PRINT #main , "spritexy? Ground2 QXQ WXW"
PRINT #main , "spritexy? G3.1 QXBQ WXBW"
PRINT #main , "spritexy? G3.2 QXBBQ WXBBW"
PRINT #main , "spritexy? Blocker QXBBCQ WXBBCW"
PRINT #main , "spritexy? Spring1 QXBBCCQ WXBBCCW"
PRINT #main , "spritexy? R1 QXBBCCQQA WXBBCCWWA"
PRINT #main , "spritexy? R2 QXBBCCQQB WXBBCCWWB"
PRINT #main , "spritexy? R3 QXBBCCQQC WXBBCCWWC"
PRINT #main , "spritexy? grass QXBBCCQQCX WXBBCCWWCX"
PRINT #main , "spritexy? port.bmp xY yX"
PRINT #main , "spritexy? pipe2.bmp yxH4 xxH4"
PRINT #main , "spritexy? pipe.bmp yxH5 xxH5"
PRINT #main , "spritexy? BUG xY4 yX4"
PRINT #main , "spritexy? BL1 xY5 yX5"
PRINT #main , "spritexy? BL2 xY6 yX6"
PRINT #main , "spritexy? pipe3.bmp xY7 yX7"
PRINT #main , "spritexy? G4 xY8 yX8"
PRINT #main , "spritexy? G5 xY9 yX9"
PRINT #main , "spritemovexy G1 0 -10" ;
PRINT #main , "spritemovexy G2 0 -10" ;
PRINT #main , "spritemovexy Tree1 0 -10" ;
PRINT #main , "spritemovexy Ground2 0 -10" ;
PRINT #main , "spritemovexy G3.1 0 -10" ;
PRINT #main , "spritemovexy G3.2 0 -10" ;
PRINT #main , "spritemovexy G3.2 0 -10" ;
PRINT #main , "spritemovexy  Blocker 0 -10" ;
PRINT #main , "spritemovexy  Spring1 0 -10" ;
PRINT #main , "spritemovexy  R1 0 -10" ;
PRINT #main , "spritemovexy  R2 0 -10" ;
PRINT #main , "spritemovexy  R3 0 -10" ;
PRINT #main , "spritemovexy  grass 0 -10" ;
PRINT #main , "spritemovexy  port.bmp 0 -10" ;
PRINT #main , "spritemovexy  pipe2.bmp 0 -10" ;
PRINT #main , "spritemovexy  pipe.bmp 0 -10" ;
PRINT #main , "spritemovexy  BUG 0 -10" ;
PRINT #main , "spritemovexy  BL1 0 -10" ;
PRINT #main , "spritemovexy  BL2 0 -10" ;
PRINT #main , "spritemovexy  pipe3.bmp 0 -10" ;
PRINT #main , "spritemovexy  G4 0 -10" ;
PRINT #main , "spritemovexy  G5 0 -10" ;
PRINT #main , "spritexy G1 " ; x ; " " ; y
PRINT #main , "spritexy G2 " ; Q ; " " ; W
PRINT #main , "spritexy Tree1 " ; QQ ; " " ; WW
PRINT #main , "spritexy Ground2 " ; QXQ ; " " ; WXW
PRINT #main , "spritexy G3.1 " ; QXBQ ; " " ; WXBW
PRINT #main , "spritexy G3.2 " ; QXBBQ ; " " ; WXBBW
PRINT #main , "spritexy Blocker " ; QXBBCQ ; " " ; WXBBCW
PRINT #main , "spritexy Spring1 " ; QXBBCCQ ; " " ; WXBBCCW
PRINT #main , "spritexy R1 " ; QXBBCCQQA ; " " ; WXBBCCWWA
PRINT #main , "spritexy R2 " ; QXBBCCQQB ; " " ; WXBBCCWWB
PRINT #main , "spritexy R3 " ; QXBBCCQQC ; " " ; WXBBCCWWC
PRINT #main , "spritexy grass " ; QXBBCCQQCX ; " " ; WXBBCCWWCX
PRINT #main , "spritexy port.bmp " ; xY ; " " ; yX
PRINT #main , "spritexy? pipe2.bmp yxH4 xxH4"
PRINT #main , "spritexy? pipe.bmp yxH5 xxH5"
PRINT #main , "spritexy BUG " ; xY4 ; " " ; yX4
PRINT #main , "spritexy BL1 " ; xY5 ; " " ; yX5
PRINT #main , "spritexy BL2 " ; xY6 ; " " ; yX6
PRINT #main , "spritexy pipe3.bmp " ; xY7 ; " " ; yX7
PRINT #main , "spritexy G4 " ; xY8 ; " " ; yX8
PRINT #main , "spritexy G5 " ; xY9 ; " " ; yX9
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy G1 0 0" ;
PRINT #main , "spritemovexy G2 0 0" ;
PRINT #main , "spritemovexy Tree1 0 0" ;
PRINT #main , "spritemovexy Ground2 0 0" ;
PRINT #main , "spritemovexy G3.1 0 0" ;
PRINT #main , "spritemovexy G3.2 0 0" ;
PRINT #main , "spritemovexy Blocker 0 0" ;
PRINT #main , "spritemovexy Spring1 0 0" ;
PRINT #main , "spritemovexy R1 0 0" ;
PRINT #main , "spritemovexy R2 0 0" ;
PRINT #main , "spritemovexy R3 0 0" ;
PRINT #main , "spritemovexy grass 0 0" ;
PRINT #main , "spritemovexy port.bmp 0 0" ;
PRINT #main , "spritemovexy pipe2.bmp 0 0" ;
PRINT #main , "spritemovexy pipe.bmp 0 0" ;
PRINT #main , "spritemovexy BUG 0 0" ;
PRINT #main , "spritemovexy BL1 0 0" ;
PRINT #main , "spritemovexy BL2 0 0" ;
PRINT #main , "spritemovexy pipe3.bmp 0 0" ;
PRINT #main , "spritemovexy G4 0 0" ;
PRINT #main , "spritemovexy G5 0 0" ;
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy Sonic 0 0" ;
IF Move$ = "1" THEN RETURN
NEXT J2
PRINT #main , "spritevisible Jump off" ;
PRINT #main , "spritevisible Sonic on" ;
PRINT #main , "spritevisible Sonic_idle on" ;
PRINT #main , "spritexy? Sonic_idle xp yp"
PRINT #main , "spritexy? Jump xp yp"
PRINT #main , "spritexy Sonic " ; xp ; " " ; yp
PRINT #main , "spritexy Jump 1 1" ;
PRINT #main , "drawsprites" ;
GOSUB [scan_gravity_J]
GOTO [Sonic_idle]
[spring_jump_move_right]
IwalkingR$ = "1"
IF IwalkingR$ = "1" THEN PRINT #main , "spriteorient Jump normal" ;
PRINT #main , "spritemovexy Jump 2 0" ;
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy Jump 0 0" ;
RETURN
[spring_jump_move_left]
IwalkingL$ = "1"
IF IwalkingL$ = "1" THEN PRINT #main , "spriteorient Jump mirror" ;
PRINT #main , "spritemovexy Jump -2 0" ;
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy Jump 0 0" ;
RETURN
[jump_move_left]
PRINT #main , "spritemovexy Sonic_spin -15 20" ;
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
PRINT #main , "spritevisible Sonic_idle on" ;
PRINT #main , "spritevisible Sonic_spin off" ;
PRINT #main , "spritexy? Sonic_spin N M"
PRINT #main , "spritexy Sonic " ; N - 1 ; " " ; M
GOSUB [scan_gravity_J]
GOTO [Sonic_idle]
[jump_move_right_s]
Move2$ = "1"
J$ = "1"
PRINT #main , "spritemovexy Sonic_spin 15 -20" ;
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
PRINT #main , "spritemovexy Sonic_spin 15 20" ;
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
PRINT #main , "spritevisible Sonic_idle on" ;
PRINT #main , "spritevisible Sonic_spin off" ;
PRINT #main , "spritexy? Sonic_spin N M"
PRINT #main , "spritexy? Sonic_spin N M"
PRINT #main , "spritexy Sonic " ; N ; " " ; M
GOSUB [scan_gravity_J]
GOTO [Sonic_idle]
[jump_move_left_s]
PRINT #main , "spritemovexy Sonic_spin -15 -20" ;
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
PRINT #main , "spritemovexy Sonic_spin -15 20" ;
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
GOSUB [refreshsprites3]
GOSUB [scan_gravity_J]
PRINT #main , "spritemovexy Sonic_spin 0 20" ;
GOSUB [refreshsprites3]
PRINT #main , "spritevisible Sonic_idle on" ;
PRINT #main , "spritevisible Sonic_spin off" ;
PRINT #main , "spritexy? Sonic_spin N M"
PRINT #main , "spritexy Sonic " ; N ; " " ; M
GOSUB [scan_gravity_J]
GOTO [Sonic_idle]
[move_duck]
IF IwalkingR$ = "1" THEN PRINT #main , "spriteorient Duck normal" ;
IF IwalkingL$ = "1" THEN PRINT #main , "spriteorient Duck mirror" ;
IF duck$ = "1" THEN GOTO [scan_keys]
duck$ = "1"
PRINT #main , "spritexy? Sonic x y"
PRINT #main , "spritexy? Sonic B C"
PRINT #main , "spritexy Duck " ; x ; " " ; y
PRINT #main , "spritevisible Sonic off" ;
PRINT #main , "spritevisible Duck on" ;
PRINT #main , "cyclesprite Duck 1 once"
PRINT #main , "spritevisible Sonic_idle off" ;
state$ = "not_idle"
PRINT #main , "drawsprites" ;
GOSUB [refreshsprites4]
GOTO [scan_keys]
[move_spin]
IF IwalkingR$ = "1" THEN PRINT #main , "spriteorient Sonic_spin_Dash normal" ;
IF IwalkingL$ = "1" THEN PRINT #main , "spriteorient Sonic_spin_Dash mirror" ;
PRINT #main , "spritexy? Duck B C"
PRINT #main , "spritevisible Duck off" ;
PRINT #main , "spritevisible Sonic_spin_Dash on" ;
PRINT #main , "spritexy Sonic_spin_Dash " ; B ; " " ; C
PRINT #main , "cyclesprite Sonic_spin_Dash 1"
[02]
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
key = VK.SPACE
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [relece_spin]
GOTO [02]
GOTO [scan_keys]
[move_look_up]
IF lookup$ = "1" THEN GOTO [scan_keys]
lookup$ = "1"
IF IwalkingR$ = "1" THEN PRINT #main , "spriteorient look_up normal" ;
IF IwalkingL$ = "1" THEN PRINT #main , "spriteorient look_up mirror" ;
PRINT #main , "spritexy? Sonic x y"
PRINT #main , "spritexy? Sonic B C"
PRINT #main , "spritexy look_up " ; x ; " " ; y
PRINT #main , "spritevisible Sonic off" ;
PRINT #main , "spritevisible look_up on" ;
PRINT #main , "cyclesprite look_up 1 once"
PRINT #main , "spritevisible Sonic_idle off" ;
state$ = "not_idle"
GOSUB [refreshsprites4]
GOTO [scan_keys]
[relece_spin]
IF IwalkingR$ = "1" THEN [shoot_off_right]
IF IwalkingL$ = "1" THEN [shoot_off_left]
INPUT a$
[shoot_off_right]
PRINT #main , "spritevisible Sonic_spin on" ;
PRINT #main , "spritevisible Sonic_spin_Dash off" ;
PRINT #main , "spritexy? Sonic_spin_Dash x y"
PRINT #main , "spritexy Sonic_spin " ; x ; " " ; y
PRINT #main , "cyclesprite Sonic_spin 1"
PRINT #main , "spritemovexy Sonic_spin 20 0" ;
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
PRINT #main , "spritexy? Sonic_spin W E"
PRINT #main , "spritexy Sonic " ; W ; " " ; E
PRINT #main , "spritevisible Sonic_idle on" ;
PRINT #main , "spritevisible Sonic_spin off" ;
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
bypasside$ = "1"
GOTO [scan_keys]
INPUT a$
[shoot_off_left]
PRINT #main , "spritevisible Sonic_spin on" ;
PRINT #main , "spritevisible Sonic_spin_Dash off" ;
PRINT #main , "spritexy? Sonic_spin_Dash x y"
PRINT #main , "spritexy Sonic_spin " ; x ; " " ; y
PRINT #main , "cyclesprite Sonic_spin 1"
PRINT #main , "spritemovexy Sonic_spin -20 0" ;
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
GOSUB [refreshsprites6]
INPUT a$
[restore_sonic_upright]
key = VK.SPACE
CALLDLL #user32 , "GetAsyncKeyState" , key AS long , r AS long
IF r < 0 THEN GOTO [move_spin]
PRINT #main , "spritevisible Sonic on" ;
PRINT #main , "spritevisible Duck off" ;
PRINT #main , "spritevisible look_up off" ;
PRINT #main , "spritemovexy Sonic -0 -0" ;
PRINT #main , "spritexy Sonic " ; B ; " " ; C
duck$ = "0"
lookup$ = "0"
GOTO [scan_keys]
[Sonic_idle]
GOSUB [scan_gravity]
[Sonic_idleB]
state$ = "idle"
IF bypasside$ = "1" THEN GOTO [bypass01]
IF IwalkingR$ = "1" THEN PRINT #main , "spriteorient Sonic_idle normal" ;
IF IwalkingL$ = "1" THEN PRINT #main , "spriteorient Sonic_idle mirror" ;
PRINT #main , "spritexy? Sonic x y"
PRINT #main , "spritexy Sonic_idle " ; x ; " " ; y
PRINT #main , "spritevisible Sonic off" ;
PRINT #main , "spritevisible Sonic_idle on" ;
[bypass01]
bypasside$ = "0"
GOSUB [refreshsprites4]
GOTO [scan_keys]
[undo_idle]
state$ = "not_idle"
PRINT #main , "spritexy Sonic_idle " ; x ; " " ; y
PRINT #main , "spritexy? Sonic x y"
PRINT #main , "spritevisible Sonic on" ;
PRINT #main , "spritevisible Sonic_idle off" ;
GOSUB [refreshsprites5]
GOSUB [reset_sprites]
GOSUB [action]
GOTO [scan_keys]
[startmusicwav]
OPEN "./wavtoplay.dat" FOR OUTPUT AS #read1
PRINT #read1 , wav$
CLOSE #read1
RETURN
[stopmusicwav]
wav$ = "stop"
OPEN "./wavtoplay.dat" FOR OUTPUT AS #read1
PRINT #read1 , wav$
CLOSE #read1
RETURN
[closemusicwav]
wav$ = "exitplayer"
OPEN "./wavtoplay.dat" FOR OUTPUT AS #read1
PRINT #read1 , wav$
CLOSE #read1
RETURN
[settexttpramiters]
VK.LBUTTON = 1
VK.RBUTTON = 2
VK.CANCEL = 3
VK.MBUTTON = 4
VK.XBUTTON1 = 5
VK.XBUTTON2 = 6
VK.BACK = 8
VK.TAB = 9
VK.CLEAR = 12
VK.RETURN = 13
VK.SHIFT = 16
VK.CONTROL = 17
VK.MENU = 18
VK.PAUSE = 19
VK.CAPITAL = 20
VK.ESCAPE = 27
VK.SPACE = 32
VK.PRIOR = 33
VK.NEXT = 34
VK.END = 35
VK.HOME = 36
VK.LEFT = 37
VK.UP = 38
VK.RIGHT = 39
VK.DOWN = 40
VK.SELECT = 41
VK.PRINT = 42
VK.EXECUTE = 43
VK.SNAPSHOT = 44
VK.INSERT = 45
VK.DELETE = 46
VK.HELP = 47
VK.A = 65
VK.B = 66
VK.C = 67
VK.D = 68
VK.E = 69
VK.F = 70
VK.G = 71
VK.H = 72
VK.I = 73
VK.J = 74
VK.K = 75
VK.L = 76
VK.M = 77
VK.N = 78
VK.O = 79
VK.P = 80
VK.Q = 81
VK.R = 82
VK.S = 83
VK.T = 84
VK.U = 85
VK.V = 86
VK.W = 87
VK.X = 88
VK.Y = 89
VK.Z = 90
VK.F5 = 116
VK.F6 = 117
VK.F7 = 118
VK.F8 = 119
VK.F9 = 120
VK.F10 = 121
VK.F11 = 122
VK.F12 = 123
VK.F13 = 124
VK.F14 = 125
VK.F15 = 126
VK.F16 = 127
VK.F17 = 128
VK.F18 = 129
VK.F19 = 130
VK.F20 = 131
VK.F21 = 132
VK.F22 = 133
VK.F23 = 134
VK.F24 = 135
RETURN.ret = 13
KEYEVENTF.EXTENDEDKEY = HEXDEC( "&H1" )
KEYEVENTF.KEYUP = HEXDEC( "&H2" )
RETURN
[launchaudio]
file$ = "audio.tkn"
SEEMASKNOCLOSEPROCESS = 64
STRUCT s , cbSize AS long , fMask AS long , hwnd AS long , lpVerb$ AS ptr , lpFile$ AS ptr , lpParameters$ AS ptr , lpDirectory$ AS ptr , nShow AS long , hInstApp AS long , lpIDList AS long , lpClass AS long , hkeyClass AS long , dwHotKey AS long , hIcon AS long , hProcess AS long
s.cbSize.struct = LEN( s.struct )
s.fMask.struct = SEEMASKNOCLOSEPROCESS
s.hwnd.struct = 0
s.lpVerb$.struct = "Open"
s.lpFile$.struct = file$
s.lpParameters$.struct = ""
s.lpDirectory$.struct = DefaultDir$
s.nShow.struct = 9
CALLDLL #shell32 , "ShellExecuteExA" , s AS STRUCT , r AS long
RETURN
[LOsetupMainWindow]
WindowWidth = 160
WindowHeight = 30
UpperLeftX = INT( ( DisplayWidth - WindowWidth ) / 2 )
UpperLeftY = INT( ( DisplayHeight - WindowHeight ) / 2 )
BackgroundColor$ = "buttonface"
ForegroundColor$ = "black"
GRAPHICBOX #loading.graphicbox2 , 5 , 2 , 150 , 25
STATICTEXT #loading.statictext1 , "Loading Please Wait..." , 15 , 7 , 135 , 16
OPEN "Loading Sonic" FOR window_popup AS #loading
PRINT #loading.graphicbox2 , "down;fill buttonface; flush"
PRINT #loading , "font ms_sans_serif 0 16"
PRINT #loading , "trapclose [LOloading.inputLoop]"
RETURN
[LOloading.inputLoop]
WAIT
[repos1]
IF bypass1$ = "1" THEN GOTO [bypasss]
PRINT #main , "spritexy? Sonic x y"
IF x > 290 THEN Move2$ = "1" : GOTO [repos1]
Move2$ = "1"
PRINT #main , "spritemovexy Sonic -25 0" ;
GOTO [scroll_move_right]
GOTO [scan_keys2]
[action]
IF boss10$ = "1" THEN GOTO [boss1]
IF bypass1$ = "1" THEN RETURN
PRINT #main , "spritecollides Sonic Sonic1$" ;
IF bugg$ = "0" THEN GOTO [action2]
PRINT #main , "spritecollides BUG Bug$" ;
IF Bug$ = "BL2 G2" THEN BUGGER$ = "0"
IF Bug$ = "BL2 blue_banner yellow_banner" THEN BUGGER$ = "0"
IF Bug$ = "BL1 G2" THEN BUGGER$ = "1"
IF Bug$ = "BL1 blue_banner" THEN BUGGER$ = "1"
IF Bug$ = "BL1 G2 blue_banner yellow_banner" THEN BUGGER$ = "1"
IF Bug$ = "BL1 Sonic Sonic_idle" THEN BUGGER$ = "1"
IF Bug$ = "BL1 Sonic Sonic_idle G2" THEN BUGGER$ = "1"
IF Bug$ = "BL2 Sonic Sonic_idle" THEN BUGGER$ = "1"
IF Bug$ = "BL2 Sonic Sonic_idle G2" THEN BUGGER$ = "1"
IF Sonic1$ = "port.bmp Blocker2 grass Sonic_idle" THEN bypass1$ = "1" : GOTO [warp1]
IF Sonic1$ = "port.bmp Blocker2 Jump grass Sonic_idle" THEN bypass1$ = "1" : GOTO [warp1]
IF BUGGER$ = "0" THEN PRINT #main , "spriteorient BUG normal" ; : PRINT #main , "spritemovexy BUG -3 0" ; : PRINT #main , "drawsprites" ; : PRINT #main , "spritemovexy BUG 0 0" ; : PRINT #main , "drawsprites" ; : RETURN
IF BUGGER$ = "1" THEN PRINT #main , "spriteorient BUG mirror" ; : PRINT #main , "spritemovexy BUG 3 0" ; : PRINT #main , "drawsprites" ; : PRINT #main , "spritemovexy BUG 0 0" ; : PRINT #main , "drawsprites" ; : RETURN
PRINT #main , "spritemovexy BUG -5 0" ;
PRINT #main , "drawsprites" ;
PRINT #main , "spritemovexy BUG 0 0" ;
PRINT #main , "cyclesprite BUG 1 once"
RETURN
[action2]
RETURN
[boss1]
IF bos1added$ = "1" THEN GOTO [bb1]
BUGGER$ = "0"
PRINT #main , "addsprite boss1 boss1.bmp boss2.bmp" ; : bos1added$ = "1"
[bb1]
PRINT #main , "spritexy? boss1 x y"
PRINT #main , "spritecollides boss1 boss1$" ;
IF boss1$ = "fall Duck look_up Push grass Sonic_spin Sonic_spin_Dash G3.1 G3.2 Blocker4" THEN BUGGER$ = "1"
IF boss1$ = "fall Duck look_up Push Blocker grass Sonic_spin Sonic_spin_Dash G3.1 G3.2 Blocker4" THEN BUGGER$ = "1"
IF boss1$ = "fall Duck look_up Push grass Sonic_spin_Dash G3.2 Blocker4" THEN BUGGER$ = "1"
IF boss1$ = "fall Duck look_up Push grass Sonic_spin_Dash G3.1 G3.2 Blocker4" THEN BUGGER$ = "1"
IF boss1$ = "fall Duck look_up Push Sonic_spin Sonic_spin_Dash Blocker4" THEN BUGGER$ = "1"
IF boss1$ = "fall Duck Blocker2 look_up Push grass Sonic_spin Sonic_spin_Dash Blocker4" THEN BUGGER$ = "1"
IF boss1$ = "fall Duck look_up Push Sonic_spin_Dash Blocker4" THEN BUGGER$ = "1"
IF boss1$ = "Blocker4" THEN BUGGER$ = "1"
IF boss1$ = "Blocker3" THEN BUGGER$ = "0"
IF boss1$ = "fall look_up Push Sonic_spin Sonic_spin_Dash Blocker4" THEN BUGGER$ = "0"
IF BUGGER$ = "0" THEN PRINT #main , "spriteorient boss1 mirror" ; : PRINT #main , "spritemovexy boss1 -3 0" ; : PRINT #main , "spritexy base_scan " ; x ; " " ; y + 140 : PRINT #main , "drawsprites" ; : PRINT #main , "spritemovexy boss1 0 0" ; : PRINT #main , "drawsprites" ; : RETURN
IF BUGGER$ = "1" THEN PRINT #main , "spriteorient boss1 normal" ; : PRINT #main , "spritemovexy boss1 3 0" ; : PRINT #main , "spritexy base_scan " ; x + 60 ; " " ; y + 140 : PRINT #main , "drawsprites" ; : PRINT #main , "spritemovexy boss1 0 0" ; : PRINT #main , "drawsprites" ; : RETURN
RETURN
[warp1]
[move_sonic_hit]
bypass1$ = "1"
PRINT #main , "spritevisible Sonic off" ;
PRINT #main , "spritevisible Sonic_spin on" ;
PRINT #main , "spritexy? Sonic x y"
PRINT #main , "spritexy Sonic_spin " ; x ; " " ; y
PRINT #main , "cyclesprite Sonic_spin 1"
PLAYWAVE "S3&k_a8.wav" , async
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
PLAYWAVE "S3&k_a8.wav" , async
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
PLAYWAVE "S3&k_a8.wav" , async
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
PLAYWAVE "S3&k_b3.wav" , async
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
PRINT #main , "spritemovexy Sonic_spin 10 0" ;
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
PRINT #main , "spritevisible Sonic_spin off" ;
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
PRINT #main , "spritemovexy Sonic_spin 4 0" ;
PRINT #main , "spritemovexy Sonic_spin 0 5" ;
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
GOSUB [refreshsprites5]
Move$ = "1"
FOR MV2 = 1 TO 25
GOSUB [scroll_move_right]
NEXT MV2
FOR MV = 1 TO 20
GOSUB [scroll_move_down]
NEXT MV
bugg$ = "0"
Move$ = "0"
PRINT #main , "spritexy Sonic 200 115" ;
PRINT #main , "spritevisible Sonic on" ;
PRINT #main , "spritevisible Sonic_spin off" ;
bypass1$ = "0"
PRINT #main , "addsprite Blocker3 Block" ;
PRINT #main , "spritexy Blocker3 " ; 320 ; " " ; 30
PRINT #main , "addsprite Blocker4 Block" ;
PRINT #main , "spritexy Blocker4 " ; -30 ; " " ; 30
PRINT #main , "addsprite base_scan base_scan" ;
PRINT #main , "spritexy base_scan " ; 60 ; " " ; 90
PRINT #main , "spritevisible base_scan off" ;
boss1$ = "1"
boss10$ = "1"
GOTO [scan_keys]
END
'
' Username and password: "Azrael" , "BE4D1E"
