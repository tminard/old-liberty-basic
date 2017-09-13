'//================== c++ style coding for Liberty BASIC =====================
'//This code is the AdelEngine for Liberty BASIC games
'//Copyright (c) 2008 by Tyler Minard
'// ============================= About ======================================
'   This engine is an attempt to utilize some of the more advanced features of C++
'and the work done by other Liberty BASIC programmers in order to put all the features
'together into one engine.
'When finished, this engine will use its own animation system, scripting language, collision system,
'map system, graphics system, advanced methods for file management, and much more.
'// ============================== Progress ==================================
'   * C++ style basic class system (for advanced variable management)
'   * Scripting Language in progress
'   * File management is progress
'   * Animation not started yet
'   * Map system almost finished
'   * Formatting of code and variable management under strict guidelines
'   * Custom timer method that also controls timing of animations so that
' the movement stays the same according to the time progression (fast or slow)
' and the users FPS (frames-per-second)

'//============ First load all globals and virtual classes ====================
dim classes.classes$(100,100) '//For classes engine: this holds the var names (varname,subvar)
dim classes.values$(200, 1000) '// For classes engine: this holds the values. (maxsubvarstotal,valuespersubvar)
global classes.classes.CNT,class.name,class.count,class.nullvalue$ '//For classes engine
class.name = 0
class.count = 1
class.nullvalue$ = chr$(2)
'//above 1 are the vars: ie 1,1 = count; 1,2 = 'tmapchr$(1)1'
global classes.maxclass
classes.maxclass = 100
global classes.totalsubs
classes.totalsubs = 0
global false
false = 0
global true
true = 1

'// ================= Graphics loading tools ================
dim text.draw.msg$(1000)
global text.msg.count
text.msg.count = 0
loadbmp "blank","hide.bmp" '// This is the default bitmap

global MapSizeX,MapSizeY,TList.Count,olist.image,olist.flags,olist.name,TotalO,NEEDUPDATE,fps,realtime,keycheck,NEEDKEYCHECK
keycheck = 100 '// Keycheck per second
fps = 200 '// Frames per second
realtime = 250 '// Controls speed of animations. Keeps consistant speed on all computers or produces lag on slow ones.
NEEDUPDATE = 1
MapSizeX = 512
MapSizeY = 512
dim flags(100)
dim TList$(256)
dim OList$(256,100)
olist.image = 0
olist.flags = 1
olist.name = 2
dim TMap(512,512)
dim OMap(512,512)
dim FMap(512,512)

global lastanimate, lastdraw,lastkeycheck,game.exit
game.exit = false '// When true, then game will stop looping

global WALLHACK
'//Cheats
WALLHACK = 0 '// Allows ignoring of nogo flag (NOTE: you can walk ao

global flags.count,flags.nogo,flags.mortal,flags.spawn
flags.count = 3
flags.nogo = 0
flags.mortal = 1
flags.spawn = 2
flags(flags.nogo) = 2
flags(flags.mortal) = 4
flags(flags.spawn) = 8



global viewR, placeX, placeY, Exitt,realX, realY
viewR = 5
'// Starting points
placeX = 510
placeY = 15
realX = 30*placeX
realY = 30*placeY

global wlkspeed, PLAYER.STILL, PLAYER.WALKS
PLAYER.STILL = 1
PLAYER.WALKS = 2

global TotalC, PRef$
'// ============ Set some vars ===========
PRef$ = "creature(1)"
animation$ = ".animation(1)"
TotalC = 1 '// Total number of creatures in game counting player
'// ============ Character Classes =======
returncheck = CreateClass("creature(1)") '// Create class
returncheck = AddClassItem("creature(1)","health")
returncheck = AddClassItem("creature(1)","state")
returncheck = AddClassItem("creature(1)","AI")
returncheck = AddClassItem("creature(1)","sprite")
returncheck = AddClassItem("creature(1)","aniStart")
returncheck = AddClassItem("creature(1)","curFrame")
result$ = SetClass$(PRef$+"->health","100")
result$ = SetClass$(PRef$+"->AI","1") 'AI: 1 = the player
result$ = SetClass$(PRef$+"->state",str$(PLAYER.STILL))
result$ = SetClass$(PRef$+"->sprite","player")
'// =========== Animation Data ===========
returncheck = AddClassItem(PRef$+animation$,"aniTime")
returncheck = AddClassItem(PRef$+animation$,"frames")
returncheck = AddClassItem(PRef$+animation$,"fps")
returncheck = AddClassItem(PRef$+animation$,"image")
result$ = SetClass$(PRef$+animation$+"->aniTime","500")
result$ = SetClass$(PRef$+animation$+"->frames","2")
result$ = SetClass$(PRef$+animation$+"->fps","250")
result$ = SetClass$(PRef$+animation$+"->image[1]","man1")
result$ = SetClass$(PRef$+animation$+"->image[2]","man2")
result$ = SetClass$(PRef$+"->aniStart",str$(time$("milliseconds")))
result$ = SetClass$(PRef$+"->curFrame","1")
'// Create the classes for the game
'//=========== Class Map =================
returncheck = CreateClass("map") '// Create class
returncheck = AddClassItem("map","x") '// x
result$ = SetClass$("map->x",str$(MapSizeX))
returncheck = AddClassItem("map","y") '// y
result$ = SetClass$("map->y",str$(MapSizeY))
'// ========== Set some resources =========
TotalO = 1
OList$(1,olist.name) = "Wall1"
OList$(1,olist.image) = "wall1.bmp"
OList$(1,olist.flags) = str$(flags(flags.nogo)) 'flags(flags.nogo), etc
TList$(1) = "grass.bmp"
TList$(2) = "dirt1.bmp"
TList.Count = 2

call game.GenerateMap
call window.main.open
call LoadResources
while true = true
 scan
'============ Check for window close ===============
    if game.exit then EXIT WHILE
'============ Process keyinput =====================
    if time$("milliseconds") - lastkeycheck > keycheck then
        lastkeycheck = time$("milliseconds")
        call game.ProcessUserInput
    end if
'============ Process animation ====================
    if time$("milliseconds") - lastanimate > realtime then
        lastanimate = time$("milliseconds")
        call AnimateCreatures
    end if
'============ Process FPS and draw graphics ========
    if time$("milliseconds") - lastdraw > fps then
        call UpdateScreen
    end if
print #main, "home"
if text.msg.count > 0 then
    for i = 1 to text.msg.count
        call DrawText text.draw.msg$(i), 0, 0
    next i
end if
wend
'// ===================== Shutdown game ================
Print "============== Shutting down ================"
call UnloadResources
close #main
end

'// ====================== Done =========================


'//============ Functions and subs =================
'// ========== Game functions ==================
sub window.main.open
WindowWidth = 1024
WindowHeight = 768
open "Game" for graphics_nsb as #main
print #main, "background blank"
print #main, "trapclose window.main.close"
print #main, "when leftButtonUp game.ProcessMouseClick"
end sub

sub window.main.close handle$
game.exit = true
'// Main game loop should close the window
end sub

sub UpdateScreen
'//This sub simply calls the functions for displaying the current view
    lastdraw = time$("milliseconds")
    '// Only calles 'drawscene' if the ground layout (placeX and placeY) has changed. Otherwise just move AI and drawsprites.
    print #main, "drawsprites"
    if NEEDUPDATE then '// Can be set by AI code if an AI is in view
        call DrawScene
    end if
end sub

sub game.ProcessMouseClick handle$, x, y
'notice "Clicked: x:";(placeX-viewR)+int(x/30);" y:";(placeY-viewR)+int(y/30)
end sub

sub game.GenerateMap
print "Generating Map..."
for my = 1 to MapSizeY step 2
    for mx = 1 to MapSizeX step 2
        texvalue = int(rnd(1)*TList.Count) + 1
        TMap(my,mx) = texvalue
        texvalue = int(rnd(1)*TList.Count) + 1
        TMap(my,mx+1) = texvalue
        ovalue = int(rnd(1)*20) + 1
        if ovalue > 13 then
            ovalue = 1
        else
            ovalue = 0
        end if
        OMap(my,mx) = ovalue
        ovalue = int(rnd(1)*20) + 1
        if ovalue > 13 then
            ovalue = 1
        else
            ovalue = 0
        end if
        OMap(my,mx+1) = ovalue
        FMap(my,mx) = 0
        FMap(my,mx+1) = 0

        texvalue = int(rnd(1)*TList.Count) + 1
        TMap(my+1,mx) = texvalue
        texvalue = int(rnd(1)*TList.Count) + 1
        TMap(my+1,mx+1) = texvalue
        ovalue = int(rnd(1)*20) + 1
        if ovalue > 13 then
            ovalue = 1
        else
            ovalue = 0
        end if
        OMap(my+1,mx) = ovalue
        ovalue = int(rnd(1)*20) + 1
        if ovalue > 13 then
            ovalue = 1
        else
            ovalue = 0
        end if
        OMap(my+1,mx+1) = ovalue
        FMap(my+1,mx) = 0
        FMap(my+1,mx+1) = 0
    next mx
next my
print "Done"
end sub

sub game.ProcessUserInput
    if input.keystate(_VK_RIGHT) then
        if CheckPlayerNogo(placeY,placeX+1) = false then
            placeX = placeX + 1
           ' text.msg.count = text.msg.count + 1
            'text.draw.msg$(text.msg.count) = "Hello!"
        end if
    end if
    if input.keystate(_VK_LEFT) then
        if CheckPlayerNogo(placeY,placeX-1) = false then
            placeX = placeX - 1
        end if
    end if
    if input.keystate(_VK_UP) then
        if CheckPlayerNogo(placeY-1,placeX) = false then
            placeY = placeY - 1
        end if
    end if
    if input.keystate(_VK_DOWN) then
        if CheckPlayerNogo(placeY+1,placeX) = false then
            placeY = placeY + 1
        end if
    end if
    if input.keystate(_VK_F1) then
        if WALLHACK = 1 then
            WALLHACK = 0
        else
            WALLHACK = 1
        end if
    end if
    call DrawScene
end sub


sub AnimateCreatures
'if TotalC < 1 then exit sub
    for i = 1 to TotalC
        '// Animate
        select case val(Class$("creature(";i;")->AI"))
            case 1 '// Player
                call AnimatePlayer i
        end select
    next i
end sub

sub AnimatePlayer chnum
    select case val(Class$("creature(";chnum;")->state"))
        case PLAYER.STILL '// Player is standing still
            if time$("milliseconds") > val(Class$("creature(";chnum;")->aniStart")) + val(Class$("creature(";chnum;").animation(1)->fps")) then
                curframe = val(Class$("creature(";chnum;")->curFrame"))
                curframe = curframe + 1
                if curframe > val(Class$("creature(";chnum;".animation(1))->frames")) then curframe = 1
                cursprite$ = Class$("creature(";chnum;".animation(1))->image[";curframe;"]")
                print #main, "spriteimage "+Class$("creature(";chnum;")->sprite")+" "+cursprite$
                result$ = SetClass$("creature(";chnum;")->curFrame",str$(curframe))
                result$ = SetClass$("creature(";chnum;")->aniStart",str$(time$("milliseconds")))
            end if
    end select
end sub

sub DrawScene
    '========= Draw tiles based on current view port =========
    'This sub updates the current view
    ny = 0
    nx = 0
    for y = (placeY - viewR) to (placeY + viewR)
        for x = (placeX - viewR) to (placeX + viewR)
            nx = nx + 1
            if ny < viewR+viewR and nx <= viewR+viewR and (y < 1 or x < 1 or x > MapSizeX or y > MapSizeY) then
            '// Back edges around the map
                print #main, "spriteimage land";ny;"-";nx;" blank"
                print #main, "spritevisible object";ny;"-";nx;" off"
            end if
            if ny < viewR+viewR and nx <= viewR+viewR and y > 0 and x > 0 and y <= MapSizeY and x <= MapSizeX then
                print #main, "spriteimage land";ny;"-";nx;" ";TMap(y,x)
                if OMap(y,x) > 0 then
                    print #main, "spritevisible object";ny;"-";nx;" on"
                    print #main, "spriteimage object";ny;"-";nx;" object";OMap(y,x)
                else
                    print #main, "spritevisible object";ny;"-";nx;" off"
                end if
                '// Draw player at point
                if y = placeY and x = placeX then
                    print #main, "spritexy? land";ny;"-";nx;" nnx nny"
                    print #main, "spritexy player ";nnx;" ";nny
                end if
            end if
        next x
        nx = 0
        ny = ny + 1
    next y
    '======== Draw humanoids ========================
    print #main, "drawsprites"
end sub

function CheckPlayerNogo(y,x) '// Returns true if you cannot move there
fail = 1
pass = 0
CheckPlayerNogo = pass
'// =============== Check map params ==============
if x < 1 then CheckPlayerNogo = fail
if y < 1 then CheckPlayerNogo = fail
if x > MapSizeX then CheckPlayerNogo = fail
if y > MapSizeY then CheckPlayerNogo = fail
'// =============== Check map flags ================
'// =============== Check objects ==================
'// Only check if point is valid (ie not beyond map range)
if x > 0 and y > 0 and x <= MapSizeX and y <= MapSizeY then
    if isFlagPresent(FMap(y,x),flags(flags.nogo)) then CheckPlayerNogo = fail
    if OMap(y,x) > 0 then
        if isFlagPresent(val(OList$(OMap(y,x),olist.flags)),flags(flags.nogo)) then CheckPlayerNogo = fail
    end if
end if
if WALLHACK then CheckPlayerNogo = pass
end function

function placeToReal(y,x, byref realy, byref realx)
    realy = (y*30)
    realx = (x*30)
end function

function realToPlace(realy,realx, byref y, byref x)
    y = (realy/30)+1
    x = (realx/30)+1
end function

function xyToSpr(y,x)
    ny = y * (WindowHeight/30)
    nx = x * (WindowWidth/30)
    xyToSpr = ny*nx
end function

sub LoadResources
'// ======================= Do all your loading here ===================
    for i = 1 to TList.Count
        loadbmp i,TList$(i)
    next i
        '// ================ Load Objects ==============================
        objectlist$ = ""
    for i = 1 to TotalC
        imagename$ = "object"+str$(i)
        loadbmp imagename$, OList$(i,olist.image)
        objectlist$ = objectlist$+" object"+str$(i)
    next i
        objectlist$ = objectlist$+" blank"
    '// px and py are land offset values. Setting both to (textureImageSideSize)*-1 will set starting point to 0 of axis
    py = (WindowHeight/2) - (((viewR+viewR)*30)/2)
    y = 0
    xoffset = (WindowWidth/2) - (((viewR+viewR)*30)/2)
    px =xoffset
    x = 0
    for i = 1 to (viewR+viewR)*(viewR+viewR)
        px = px + 30
        x = x + 1
        if x > viewR+viewR then
        py = py + 30
        y = y + 1
        x = 1
        px = xoffset+30
        end if
        print #main, "addsprite land";y;"-";x;" blank 1 2"
        print #main, "addsprite object";y;"-";x;""+objectlist$
        print #main, "spritexy land";y;"-";x;" ";px;" ";py
        print #main, "spritexy object";y;"-";x;" ";px;" ";py
        print #main, "spritevisible object";y;"-";x;" off"
    next i
    '// ================== Load the man =========================
    loadbmp "man1", "enemy1.bmp"
    loadbmp "man2", "enemy2.bmp"
    print #main, "addsprite player man1 man2"
    ppx = ((viewR*30)/2) - 60
    ppy = ((viewR*30)/2) - 60
    print #main, "spritexy player ";ppx;" ";ppy
end sub

sub UnloadResources
'// =============== This is where you should unload all old stuff ======================
    for i = 1 to TList.Count
        'bmp$ = str$(i)
        'unloadbmp bmp$
    next i
    unloadbmp "blank"
    unloadbmp "man1"
    unloadbmp "man2"
end sub

function isFlagPresent(flags, theflag)
'// This tests if a flag is present in the value
flagleft = flags
FlagPresent = false
for i = flags.count to 0 step -1
    if flagleft >= flags(i) and flags(i) = 0 = false then
        flagleft = flagleft - flags(i)
        if flags(i) = theflag then
            isFlagPresent = true
            exit for
        end if
    end if
next i
end function

function fail(var)
if var = false then
    fail = true
else
    fail = false
end if
end function

'// ================ Done ============================
'// ================ Class System ====================
function Class$(ClassValue$) '// For reading the class
    '// This returns the variable
    classn$ = word$(ClassValue$,1,"->")
    classn = GetClassValue(classn$)
    subclassT$ = word$(ClassValue$,2,"->")
    isarray = 0
    subint = 0
    Class$ = "{ERROR}: CLASS "+subclassT$+" VAR NOT FOUND"
    if instr(subclassT$,"[") then
        isarray = true
        subint = val(word$(word$(subclassT$,2,"["),1,"]"))
        subclassT$ = word$(subclassT$,1,"[")
    end if
    for i = class.count+1 to val(classes.classes$(classn,class.count))+class.count+1
        if word$(classes.classes$(classn,i),1,chr$(1)) = subclassT$ then
            Class$ = classes.values$(val(word$(classes.classes$(classn,i),2,chr$(1))),subint)
            exit for
        end if
    next i
end function

function SetClass$(ClassValue$,seto$) '// For setting class values
    '// This sets the variable
    classn$ = word$(ClassValue$,1,"->")
    classn = GetClassValue(classn$)
    subclassT$ = word$(ClassValue$,2,"->")
    isarray = 0
    subint = 0
    SetClass$ = "0"
    if instr(subclassT$,"[") then
        isarray = true
        subint = val(word$(word$(subclassT$,2,"["),1,"]"))
        subclassT$ = word$(subclassT$,1,"[")
    end if
    for i = class.count+1 to val(classes.classes$(classn,class.count))+class.count+1
        if word$(classes.classes$(classn,i),1,chr$(1)) = subclassT$ then
            classes.values$(val(word$(classes.classes$(classn,i),2,chr$(1))),subint) = seto$
            SetClass$ = "1"
            exit for
        end if
    next i
end function

function CreateClass(ClassName$) '// For creating the class
    '// Return oK
    if classes.classes.CNT = classes.maxclass = false and len(trim$(ClassName$)) > 0 and instr(ClassName$,".") = false THEN
        classes.classes.CNT = classes.classes.CNT + 1
        classes.classes$(classes.classes.CNT,class.name) = ClassName$
        CreateClass = 1
    else
        CreateClass = 0
    end if
end function

function AddClassItem(ClassName$,subclassvar$) '// For creating item in class
    subvalue = GetClassValue(ClassName$)
    classes.classes$(subvalue,class.count) = str$( val(classes.classes$(subvalue,class.count)) + 1)
    classes.totalsubs = classes.totalsubs+1
    classes.classes$(subvalue,val(classes.classes$(subvalue,class.count))+class.count) = subclassvar$+chr$(1)+str$(classes.totalsubs)
    classes.values$(classes.totalsubs,0) = class.nullvalue$
end function

function GetClassValue(ClassName$)
    for i = 1 to classes.classes.CNT
        if classes.classes$(i,class.name) = ClassName$ then
            GetClassValue = i
            exit for
        end if
    next i
end function
'//================= Done =====================================
'//================= Hardware Subs and Functions ==============
function input.keystate(keycode)
    CallDLL #user32, "GetAsyncKeyState", keycode as Long, result as Long
    input.keystate = result
end function

'//================= Script Engine: uses classes engine =======
'// Copyright (c) 2008 by Tyler Minard
function script.init()
'//================ Loads the engine ==========================
returncheck = CreateClass("script_engine") '// Create class
returncheck = AddClassItem("script_engine_GLOBALS","engine.init")
returncheck = AddClassItem("script_engine_GLOBALS","engine.count")
result$ = SetClass$("script_engine_GLOBALS->engine.init","1")
result$ = SetClass$("script_engine_GLOBALS->engine.count","2")
script.init = 1
end function


sub script.exec ScriptCommand$
'// Example Usuage: call ExecScript "D:\Myscript.ini->start:tylerminard"
'// Copyright (c) 2008 by Tyler Minard
srf$ = word$(ScriptName$,1,"->") '// ----------------> File Name
srb$ = word$(word$(ScriptName$,2,"->"),1,":") '// ---> Branch Name
src$ = word$(word$(ScriptName$,2,"->"),2,":") '// ---> Script Command Line
if len(srf$) = 0 then exit sub
if len(srb$) = 0 then srb$ = "default" '//Default branch name
if file.exists(srf$) = false then exit sub
'//================= Now Open Script =================
open srf$ for input as #scriptFH
'//================= Find and execute code in named branch(s) ====
while eof(#scriptFH) = 0
    line input #scriptFH, script.exec.line$
    script.exec.command$ = word$(script.exec.line$,1)
    script.exec.code$ = right$(script.exec.line$,len(script.exec.line$)-len(script.exec.command$))
    if script.exec.command$ = srb$ and trim$(script.exec.code$) = "{" then
        result = script.dobranch()
    end if
wend
close #scriptFH
end sub

function script.dobranch()
'// ============= This code executes the current branch =======
'// Depends on #scriptFH being open!!!
script.exec.line$ = ""
script.dobranch = 1
while eof(#scriptFH) = false and trim$(script.exec.line$) = "}" = false
    line input #scriptFH, script.exec.line$
    script.exec.command$ = word$(script.exec.line$,1)
    script.exec.code$ = right$(script.exec.line$,len(script.exec.line$)-len(script.exec.command$))
    select case script.exec.command$
    '// ============= Add Custom Commands Here ===================
        case "global"
            '//=== Set Global Variable ===
            thevar$ = trim$(word$(script.exec.code$,1,"="))
            thevalue$ = script.extractvar$(trim$(word$(script.exec.code$,2,"=")))
            result = script.setglobal(scriptvar$,thevalue$)
    end select
wend
end function

function script.extractvar$(string$)
'// ============== This takes the string and extracts the value from it (like globalvar = "hello" returns hello, globalvar = myvar returns the value of myvar, etc) =============
script.extractvar$ = ""
if instr(string$,chr$(34)) then
    'is a string
    script.extractvar$ = word$(string$,2,chr$(34))
    exit function
end if
if instr(string$,"[") then
    'is an array
end if
if instr(string$,chr$(34)) = false and instr(string$,"[") = false then
    'Maybe a value
    script.extractvar$ = str$(eval(string$))
    exit function
end if
end function

function script.getglobal$(scriptvar$)
result = script.isrunning()
if result = false then
    script.getglobal$ = "{ERROR}GetGlobal -> Script Engine not running"
    print script.getglobal$
    exit function
end if
result$ = Class$("script_engine_GLOBALS->"+scriptvar$)
if instr(result$,"{ERROR}") then
    script.getglobal$ = ""
else
    script.getglobal$ = result$
end if
end function

function script.setglobal(scriptvar$,thevalue$)
result = script.isrunning()
if result = false then
    script.setglobal = 0
    exit function
end if
'// Scan through globals to find existing global to set....
script.setgobal.totalg = val(Class$("script_engine_GLOBALS->engine.count"))
if script.setgobal.totalg = 0 then
    script.setglobal = 0
    exit function
end if
result$ = Class$("script_engine_GLOBALS->"+scriptvar$)
if instr(result$,"{ERROR}") then
    '// Means variable wasn't found: create it
    result = AddClassItem("script_engine_GLOBALS",scriptvar$)
    result$ = SetClass$("script_engine_GLOBALS->"+scriptvar$,thevalue$)
    result$ = SetClass$("script_engine_GLOBALS->engine.count", str$( val(Class$("script_engine_GLOBALS->engine.count")) + 1))
    script.setglobal = true
else
    result$ = SetClass$("script_engine_GLOBALS->"+scriptvar$,thevalue$)
    script.setglobal = true
end if
end function

function script.isrunning()
result$ = Class$("script_engine_GLOBALS->engine.init")
if val(result$) = 1 then
    script.isrunning = true
else
    script.isrunning = false
    print "========= Script Engine Error ==========: Engine was never started!"
end if
end function
'// ============= End of Script Engine ==================
'// ============= File Usuage Commands ==================
function file.exists(filename$)
  dim file.info$(10,10)
  path$ = ""
  files path$, filename$, file.info$()
  file.exists = val(file.info$(0, 0))  'non zero is true
end function

function file.delete(fname$)
file.delete = 0
    if file.exists(fname$) then
        kill fname$
        file.delete = 1
    end if
end function

function file.directoryExists(dirname$)
    dim file.info$(10, 10)
    files DefaultDir$, "*", file.info$()
    if (file.info$(0, 1)) <> "0" then
        fileCount = val(file.info$(0, 0))
        dirCount = val(file.info$(0, 1))
        for x = fileCount+1 to fileCount+dirCount
            if file.info$(x, 1) = dirname$ then file.directoryExists = 1
        next x
    end if
end function

'// ================= Graphics Engine ==================
' Note sure who did the original code, but this has been modified
'by Tyler Minard to fit in easy to use subs
sub graphics.init itemhnd,byref devicehnd, byref maindev
'get a device context for graphicbox
CallDLL #user32, "GetDC",_
itemhnd As long,_ 'handle of graphicbox/handle
devicehnd As long 'returns device context (Used to 'print to' and 'get from')

CallDLL #gdi32,"CreateCompatibleDC",_
devicehnd As long,_   'device context of graphicbox
maindev As long   'returns memory device context
end sub

sub graphics.place memoryDC, x, y, byref r
struct tPoint, x as long, y as long
CallDLL #gdi32, "MoveToEx",_
memoryDC As long,_     'memory DC
x As long,_        'x
y As long,_        'y
tPoint As struct,_   'returns previous x and y
r As boolean
end sub

sub graphics.goto memoryDC, x, y, byref r
CallDLL #gdi32, "LineTo",_
memoryDC As long,_     'memory DC
x As long,_       'x
y As long,_        'y
r As boolean
end sub

'HBITMAP CreateCompatibleBitmap(
 ' HDC hdc, 
  'int nWidth, 
 ' int nHeight
'); 
sub graphics.loadbmp mainDC, lpBitmapName$, byref bmpH
callDLL #gdi32, "LoadBitmap",_
  mainDC as long,_
  lpBitmapName$ as ptr,_
  bmpH as long
end sub


sub graphics.drawtext memoryDC, x, y, t$, ln, byref r
'draw the text
CallDLL #gdi32, "TextOutA",_
memoryDC As long,_     'memory DC
x As long,_        'x location
y As long,_       'y location
t$ As ptr,_         'string of text
ln As long,_        'length of string
r As long
end sub

sub graphics.selectobject memoryDC, byref thMem, byref tohMem
CallDLL #gdi32,"SelectObject",_
memoryDC As long,_
thMem As long,_
tohMem As long
end sub

sub graphics.shutdown mainH, dcH, byref result,memoryDC,byref otherr
'release the DC for the graphicbox
call graphics.release mainH, dcH, result

'delete the memory DC from memory
call graphics.deleteDC memoryDC, otherr
end sub

sub graphics.release mainH, dcH, byref result
    CallDLL#user32,"ReleaseDC",_
    mainH As long,_     'graphicbox handle
    dcH As long,_   'DC handle
    result As long
end sub

sub graphics.deleteDC memoryDC, byref result
CallDLL #gdi32, "DeleteDC",_
memoryDC As long,_ 'memory DC handle
otherr As boolean
end sub
'// ================ Done =====================
