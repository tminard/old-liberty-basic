if val(Version$)<3 then
    notice "This program is for LB3 only!"
    end
end if

nomainwin
bmpheight=0     'bitmap height
bmpwidth=0      'bitmap width
bitmap$=""      'bitmap file name
savefile$=""    'save file name
hBitmap=0       'handle for loaded bitmap
hWindow=0       'window handle

menu #1, "&File", "&Open Sprite",[openSprite],_
    "&Save As...",[saveAs],|,"E&xit",[quit]
menu #1, "&Options", "Ab&out", [about]


open "Add Masks to Sprites" for graphics_fs_nsb as #1
    print #1, "trapclose [quit]"
    print #1, "down;place 20 40"
    print #1, "|Open the desired sprite image."
    print #1, "|A mask will be added to the sprite "
    print #1, "|as you watch."
    print #1, "|This might take time for large images."
    print #1, "|Images larger than the window "
    print #1, "|will be cut off."
    print #1, "|If it is satisfactory, choose "
    print #1, "|'Save As...' from the File menu."
    print #1, "flush"

    hWindow=hwnd(#1)


[loop]
    input aVar$

[quit]
    close #1:end

[openSprite]
    if hBitmap<>0 then
        unloadbmp ("bm")
        print #1, "cls"
    end if

    filedialog "Open Sprite","*.bmp",bitmap$
    if bitmap$="" then
        notice "No bitmap chosen!"
        goto [loop]
    end if

    print #1, "cls"
    loadbmp "bm" , bitmap$ 
    hBitmap=hbmp("bm")

    print #1, "down;drawbmp bm 0 0"

    bmpheight=HeightBitmap(bitmap$)

    bmpwidth=WidthBitmap(bitmap$)

    print #1, "drawbmp bm 0 ";bmpheight

    call MakeMask bmpwidth, bmpheight, hWindow
    goto [loop]


[saveAs]
    print #1, "getbmp SpriteMask 0 0 ";bmpwidth;" ";2*bmpheight

    filedialog "Save As... ","*.bmp",savefile$
    if savefile$="" then
        notice "No filename specified!"
        goto [loop]
    end if

    bmpsave "SpriteMask",savefile$
    notice "Sprite and mask saved as ";savefile$
    goto [loop]

'************FUNCTIONS******************
function WidthBitmap(name$)
    open name$ for input as #pic
    pic$=input$(#pic,29)
    close #pic
    WidthBitmap = asc(mid$(pic$,19,1)) + _
        (asc(mid$(pic$,20,1)) * 256)
  end function

function HeightBitmap(name$)

    open name$ for input as #pic
    pic$=input$(#pic,29)
    close #pic
    HeightBitmap = asc(mid$(pic$,23,1)) + _
        (asc(mid$(pic$,24,1)) * 256)
  end function


sub MakeMask wide, high, hWnd

    cursor hourglass
    white=(255*256*256)+(255*256)+255
    black=0

    open "user32" for dll as #user
    Open "gdi32"for DLL as #gdi

    CallDll #user, "GetDC",_
        hWnd as long,_
        hDC as long

    for i = 0 to wide-1
        for j = 0 to high-1

            CallDll #gdi, "GetPixel",_
                hDC as long,_
                i as long,_
                j as long,_
                pColor as long

            if pColor=black then

                newColor=white
            else
                newColor=black
            end if

            CallDll #gdi, "SetPixel",_
                hDC as long,_
                i as long, _
                j as long, _
                newColor as long, _
                r as long
        next j
    next i

    CallDll #user, "ReleaseDC",_
            hWnd as long,_
            hDC as long,_
            r as long

    close #user
    close #gdi
    cursor normal

  end sub


'*************************Part added by Adelphos Pro(TM)*******************
[about]

