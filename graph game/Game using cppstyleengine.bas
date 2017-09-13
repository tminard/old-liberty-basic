'//================== c++ style coding for Liberty BASIC =====================
'//This code is the AdelEngine for Liberty BASIC games
'//Copyright (c) 2008 by Tyler Minard

print "Loading..."
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

global MapSizeX,MapSizeY,TList.Count,olist.image,olist.flags,olist.name,TotalO,NEEDUPDATE
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
TList$(1) = "grass.bmp"
TList$(2) = "dirt1.bmp"
TList.Count = 2

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

TotalO = 1
OList$(1,olist.name) = "Wall1"
OList$(1,olist.image) = "wall1.bmp"
OList$(1,olist.flags) = str$(flags(flags.nogo))


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
wlkspeed = 30

global TotalC, PRef$
PRef$ = "creature(1)"
TotalC = 1 '// Total number of creatures in game counting player
returncheck = CreateClass("creature(1)") '// Create class
returncheck = AddClassItem("creature(1)","health")
returncheck = AddClassItem("creature(1)","state")
returncheck = AddClassItem("creature(1)","AI")
returncheck = AddClassItem("creature(1)","aniStart")
returncheck = AddClassItem("creature(1)","sprite")
result$ = SetClass$(PRef$+"->health","100")
result$ = SetClass$(PRef$+"->AI","1") 'AI: 1 = the player
result$ = SetClass$(PRef$+"->state",str$(PLAYER.STILL))
result$ = SetClass$(PRef$+"->sprite","player")

'// Create the classes for the game
'//=========== Class Map =================
returncheck = CreateClass("map") '// Create class
returncheck = AddClassItem("map","x") '// x
result$ = SetClass$("map->x",str$(MapSizeX))
returncheck = AddClassItem("map","y") '// y
result$ = SetClass$("map->y",str$(MapSizeY))
Print "Generating Map..."
'// Generate the map. Tries to speed up loading by avoiding as many for loops as possible
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
Print "Starting..."
open "image323.dll" for dll as #im '// for image loading

loadbmp "blank","hide.bmp"
gosub [loadWindow]
call LoadResources
timer 1000, [update]
wait

[update]
'// Only calls 'drawscene' if the ground layout (placeX and placeY) has changed. Otherwise just move AI and drawsprites.
call AnimateCreatures
print #main, "drawsprites"
if NEEDUPDATE then '// Can be set by AI code if an AI is in view
    call DrawScene
end if
wait

[loadWindow]
WindowWidth = 1024
WindowHeight = 768
open "Game" for graphics_nsb as #main
print #main, "background blank"
print #main, "trapclose [callclosewin]"
print #main, "when characterInput [inkey]"
print #main, "when leftButtonUp [MouseInkey]"
return
[callclosewin]
timer 0
close #im
call UnloadResources
gosub [closeWindow]
end

[closeWindow]
close #main
return

[MouseInkey]
notice "Clicked: x:";(placeX-viewR)+int(MouseX/30);" y:";(placeY-viewR)+int(MouseY/30)
wait

[inkey]
select case Inkey$
    case "p"
        WALLHACK = 1
    case "d"
        if CheckPlayerNogo(placeY,placeX+1) = false then
        'if OMap(placeY,placeX+1) = 0 then
            placeX = placeX + 1
        end if
    case "a"
        if CheckPlayerNogo(placeY,placeX-1) = false then
            placeX = placeX - 1
        end if
    case "w"
        if CheckPlayerNogo(placeY-1,placeX) = false then
            placeY = placeY - 1
        end if
    case "s"
        if CheckPlayerNogo(placeY+1,placeX) = false then
            placeY = placeY + 1
        end if
end select
call DrawScene
wait
'//============ Functions and subs =================

sub AnimateCreatures
'if TotalC < 1 then exit sub
    for i = 1 to TotalC
        '// Animate
        select case val(Class$("creature(";i;")->AI"))
            case 1
                '// Player
                state = val(Class$("creature(";i;")->state")) + 1
                if state > 2 then state = 1
                print #main, "spriteimage "+Class$("creature(";i;")->sprite")+" man";state
                result$ = SetClass$("creature(";i;")->state",str$(state))
        end select
    next i
end sub

sub DrawScene
    '========= Draw tiles based on current view port =========
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

function Class$(ClassValue$) '// For reading the class
    '// This returns the variable
    classn$ = word$(ClassValue$,1,"->")
    classn = GetClassValue(classn$)
    subclassT$ = word$(ClassValue$,2,"->")
    isarray = 0
    subint = 0
    Class$ = "ERROR: CLASS "+subclassT$+" VAR NOT FOUND"
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


Function AddMask(hBmp,hWnd)
    'adds mask above sprite... sprite must have black background
    calldll #im, "AddMask",hBmp as long,hWnd as long,_
    AddMask as ulong
    End Function

    Function LoadImageFile(hWnd, file$)
    'load an image from file,
    'bmp, jpg, gif, emf, wmf, ico
    'returns handle of memory bmp
    calldll #im, "LoadImageFile",hWnd as ulong,_
    file$ as ptr,LoadImageFile as ulong
    End Function
Function RotateByAngle(hBmp,hWnd,angle,bgColor)
    'use angle between 0 and 360
    'bgColor=0 for black, bgColor=1 for white
    calldll #im, "RotateByAngle",hBmp as long,hWnd as long,_
    angle as long,bgColor as long,RotateByAngle as ulong
    End Function

Function RotateWidth(hBmp,hWnd,angle)
    'width needed to display rotated bmp
    calldll #im, "RotateWidth",hBmp as long,hWnd as long,_
    angle as long,RotateWidth as ulong
    End Function

Function RotateHeight(hBmp,hWnd,angle)
    'height needed to display rotated bmp
    calldll #im, "RotateHeight",hBmp as long,hWnd as long,_
    angle as long,RotateHeight as ulong
    End Function

Function ChangeSize(hBmp,hWnd,nWidth,nHeight)
    'display in pixel size indicated
    calldll #im, "ChangeSize",hBmp as long,hWnd as long,_
    nWidth as long,nHeight as long,ChangeSize as ulong
    End Function

Function FlipMirror(hBmp,hWnd,nMirror,nFlip)
    'nMirror=1 will mirror, nMirror=0 will not mirror
    'nFlip=1 will flip, nFlip=0 will not flip
    'can be flipped and mirrored at same time
    calldll #im, "FlipMirror",hBmp as long,hWnd as long,_
    nMirror as long,nFlip as long,FlipMirror as ulong
    End Function

Function Scale(hBmp, hWnd, nScale)
    'nScale is percentage
    'nScale=50 means half size, 200 means twice size
    calldll #im, "Scale",hBmp as long, hWnd as long,_
    nScale as long, Scale as ulong
    End Function

Function PartialBitmap(hBmp,hWnd,x,y,nWidth,nHeight)
    'crops part of bmp at x,y, width nWidth, height nHeight
    calldll #im, "PartialBitmap",hBmp as long, hWnd as long,_
    x as long, y as long, nWidth as long, nHeight as long,_
    PartialBitmap as ulong
    End Function
