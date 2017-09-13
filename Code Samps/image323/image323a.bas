'Added March, 2004:
'Use DeleteObject to remove images from
'memory that were returned by the DLL.
'
'Image323.dll copyright 2003, Alyce Watson
'Freeware, no warantees expressed or implied.
'
'Thanks go to the nice people from [lbexp]
'for help working out the image loading function.
'
'Now loads bmp, jpg, gif, wmf, emf, and ico files.
'
'This program functions as the Liberty BASIC
'documentation for this DLL.  It is not a
'full-featured image editing program.
'The routines simply demonstrate the functions.
'
'The image manipulation functions create a
'new bitmap in memory that holds the modified
'image.  The functions return a handle to this
'bitmap.  It can then be loaded with loadbmp
'and drawn with drawbmp, or it can be saved
'with bmpsave.  This gets past the problem with
'the Liberty BASIC getbmp function that only
'gets visible portions of the graphics, so
'bmpsave will not properly save images larger
'than the viewing area.  IT IS NOW POSSIBLE TO
'SAVE IMAGES LARGER THAN THE VIEWING AREA with the
'bmpsave command, using this DLL.
'
'(hBitmap will be the handle returned by the function)
'To loadbmp with Liberty BASIC from a bitmap handle:
'   loadbmp "bmpname", hBitmap
'
'To drawbmp in a graphics window:
'   #graphics "drawbmp bmpname 0 0 ; flush"
'
'To save the bitmap to disk:
'   bmpsave "bmpname", "filename.bmp"
'
'This demo is constructed so that the effects of
'the functions are cummulative.  That is, if an
'image is colorized, then blurred, it is the colorized
'image that will be blurred.
'
'These routines require a handle to a bitmap.
'Get handle by using loadbmp, then use hbmp()
'Get handle by using getbmp, then use hbmp()
'OR
'Get handle by loading with third party DLL.
'OR
'Get handle by loading with this DLL, which
'returns the hBmp from the LoadImageFile function.
'
'Note that bitmaps will load three times faster
'with the LoadImageFile function than with
'LB's LOADBMP function.
'
'All API functions are wrapped into Liberty BASIC
'functions and gathered together at the bottom of
'the code.
'

nomainwin
open "image323.dll" for dll as #im

menu #1, "&File","&Open Image",[open],"&Revert",[revert],_
    "&Drawn Graphics",[drawngraphics],|,"&Save",[save],_
    "&Convert to 24-bit",[convert],|,"E&xit",[quit]

menu #1, "&Colors","Colori&ze",[colorize],"&Duotone",[duotone],_
    "&Tint",[tint],"S&olarize",[solarize],"&Hue",[hue],_
    "&GrayScale",[grayscale],"&Negative",[negative],_
    "Change &All",[changeall],"Color &Swap",[colorswap],_
    "&Flood Fill",[floodfillit]

menu #1, "&Filters","&Blur",[blur],"&Soften",[soften],_
    "S&harpen",[sharpen],"&Pixelate",[pixelate],"&Diffuse",[diffuse],_
    "&Emboss",[emboss],"B&lend Pictures",[blendpictures], _
    "B&rightness",[brightness],"&Increase Contrast",[contrast],_
    "&Midtone",[midtone]

menu #1, "Transformations","&Rotate",[rotate],"&Flip/Mirror",[flipmirror],_
    "&Scale",[scale],"&Change Size",[size],"&Partial",[partial],_
    "&Add Mask",[mask]

menu #1, "&Information","Bitmap &Width",[bitmapwidth],"Bitmap &Height",[bitmapheight],_
    "Get &Red",[getred],"Get &Green",[getgreen],"Get &Blue",[getblue],_
    "&Make RGB",[makergb], "Get &Pixel Color",[getpixelcolor],_
    "Get Pixel &Information",[getpixelinfo]

open "Image323 Test" for graphics_fs as #1
    #1 "trapclose [quit]"
    #1 "down; fill lightgray;flush"
    hW=hwnd(#1)   'graphicbox handle
    x=0:y=0 'placement for bmps


wait

[quit]
if hDemo<>0 then
    unloadbmp "demo"
end if
call About
close #1:close #im:end

[open]'open an image file on disk
      'bitmap, jpeg, windows metafile,
      'enhanced metafile, icon
    filter$="*.bmp;*.jpg;*.wmf;*.emf;*.ico;*.gif"
    filedialog "Open Image",filter$,bmp$
    if bmp$="" then wait
    gosub [load]
    wait

[revert]'re-open the image file from disk
    if bmp$="" then
        notice "Please select 'Open' from the 'File' menu."
        wait
    end if
    gosub [load]
    wait

[load]'load image with DLL
    cursor hourglass
    hImage=LoadImageFile(hW,bmp$)
    if hImage=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    gosub [display]
    cursor normal
    return

[display]'loadbmp image and draw on window
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hImage
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ;flush"
    return


[drawngraphics]'draw to window, rather than loading a bitmap
    'use this method to transform any graphics
    'drawn in the graphicbox or graphics window
    if hDemo<>0 then unloadbmp "demo"

    bwide=200
    bhigh=200
    #1 "cls;fill lightgray"
    #1, "backcolor blue;place 0 0"
    #1 "boxfilled ";bwide;" ";bhigh
    #1 "backcolor pink;size 5;color yellow"
    #1 "place 100 100;ellipsefilled 160 90"
    #1 "font arial 0 30;place 70 110;\Hello!"
    #1 "flush"
    #1 "getbmp demo 0 0 ";bwide;" ";bhigh
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    wait


[save]'save the current image, using BmpSave
    if hDemo=0 then
        notice "No image to save."
        wait
    end if
    filedialog "Save As","*.bmp",savebmp$
    if savebmp$="" then wait
    if lower$(right$(savebmp$,4))<>".bmp" then
        savebmp$=savebmp$+".bmp"
    end if
    bmpsave "demo",savebmp$
    wait



[convert]'returns handle to new bitmap
         'that is copy of original, but
         'in 24-bit format
    if hDemo=0 then
        notice "No image to convert."
        wait
    end if

    calldll #gdi32, "DeleteObject",hTemp as long, re as long

    filedialog "Save as 24-bit","*.bmp",convertbmp$
    if convertbmp$="" then wait
    hTemp=ConvertTo24Bit(hDemo,hW)
    loadbmp "converted",hTemp
    bmpsave "converted",convertbmp$
    unloadbmp "converted"
    wait



[colorize]  'changes image to dark shades of color specified
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Colorize(hDemo,hW,1,0,0)  'red
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[tint]  'changes image to light shades of color specified
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Tint(hDemo,hW,0,1,0)  'green
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[solarize]'invert either light or dark colors
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Solarize(hDemo,hW,0) '0=invert dark colors
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[hue]'increases values of hue specified
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Hue(hDemo,hW,0,1,1)  'cyan
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[duotone]'put image together with RGB color
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=DuoTone(hDemo,hW,255,220,190) 'orange
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0; flush"
    wait


[grayscale]'render image in shades of gray
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=GrayScale(hDemo,hW)
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0; flush"
    cursor normal
    wait


[negative]'invert colors
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Negative(hDemo,hW)
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    wait


[changeall]'change all instances of a color to be another color
    #1 "cls;fill lightgray;drawbmp demo 0 0;flush"
    notice "Click mouse on color to change."
    #1 "setfocus;when leftButtonUp [dochange]"
    wait
[dochange]
    if MouseX>BitmapWidth(hDemo) or MouseY>BitmapHeight(hDemo) then wait
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=ChangeAll(hDemo,hW,MouseX,MouseY,255,220,140)'change to orange
    #1, "when leftButtonUp"
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[colorswap]'swap color values as desired, R,G and B
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=ColorSwap(hDemo,hW,1,2,0)'red=green,green=blue,blue=red
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[floodfillit]'flood fill a colored area with a specified color
    if hDemo=0 then wait
    notice "Click mouse on color to change."
    #1 "setfocus;when leftButtonUp [doflood]"
    wait
[doflood]
    if MouseX>BitmapWidth(hDemo) or MouseY>BitmapHeight(hDemo) then wait
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=FloodFillIt(hDemo,hW,MouseX,MouseY,255,220,140)'change to orange
    #1, "when leftButtonUp"
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo", hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    wait


[blur]'blur image
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Blur(hDemo,hW)
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[soften] 'soften edges - mild blur effect
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Soften(hDemo,hW)
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[sharpen] 'sharpen edges
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Sharpen(hDemo,hW)
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[pixelate]'remove detail - make blocks of same-color pixels
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Pixelate(hDemo,hW)
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    wait


[diffuse] 'scatter pixels to diffuse
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Diffuse(hDemo,hW,5)'5 pixel diffuse size
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[emboss]'give pic a gray, embossed look
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Emboss(hDemo,hW)
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "cls;fill lightgray"
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[blendpictures]'blend two images
    cursor hourglass
    filedialog "Blending Bitmap?","*.bmp",blend$
    if blend$="" then wait
    loadbmp "blend",blend$
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hBlend=hbmp("blend")
    hTemp=BlendPictures(hDemo,hBlend,hW)
    unloadbmp "blend"
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "cls;fill lightgray"
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[brightness]'lighten or darken image
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Brightness(hDemo,hW,150)  '150%
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[contrast]'increase contrast between light and dark areas
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Contrast(hDemo,hW)
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[midtone]'decrease contrast between light and dark areas
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Midtone(hDemo,hW)
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[rotate]'rotate number or degrees specified
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=RotateByAngle(hDemo,hW,45,1)  '45 degrees, white background
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[flipmirror]'flip vertically, horizontally, or both
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=FlipMirror(hDemo,hW,1,0)  'mirror, no flip
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    wait


[scale]'choose scale in percent
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=Scale(hDemo,hW,200)  '200%
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    wait


[size]'resize to width, height indicated
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=ChangeSize(hDemo,hW,300,100)  '300x100
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then  unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    wait


[partial]'crop to x,y,width,height indicated
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=PartialBitmap(hDemo,hW,20,20,70,40)  '70x40
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    wait


[mask]'add mask above sprite
    cursor hourglass
    calldll #gdi32, "DeleteObject",hTemp as long, re as long
    hTemp=AddMask(hDemo,hW)
    if hTemp=0 then
        notice "Function failed."
        cursor normal
        wait
    end if
    #1 "cls;fill lightgray"
    if hDemo<>0 then unloadbmp "demo"
    loadbmp "demo",hTemp
    hDemo=hbmp("demo")
    #1 "drawbmp demo 0 0 ; flush"
    cursor normal
    wait


[bitmapwidth]'get width of bitmap
    bw=BitmapWidth(hDemo)
    notice "Bitmap width is ";bw
    wait


[bitmapheight]'get height of bitmap
    bh=BitmapHeight(hDemo)
    notice "Bitmap height is ";bh
    wait


[getred]'just a demo, substitute your own long colorref value
    red=GetRed(220 + (190*256) + (100*256*256))  'should return 220
    notice "Red value is ";red
    wait


[getgreen]'just a demo, substitute your own long colorref value
    green=GetGreen(220 + (190*256) + (100*256*256))  'should return 190
    notice "Green value is ";green
    wait


[getblue]'just a demo, substitute your own long colorref value
    blue=GetBlue(220 + (190*256) + (100*256*256))  'should return 100
    notice "Blue value is ";blue
    wait


[makergb]'make long value from red, green blue
    RGB=MakeRGB(220, 190, 100)
    notice "RGB value is ";RGB
    wait


[getpixelcolor]'get long color value of pixel specified
    notice "Click mouse on desired pixel."
    #1 "setfocus; when leftButtonUp [dopixelcolor]"
    wait
[dopixelcolor]
    #1 "when leftButtonUp"
    pcolor=GetLongPixelColor(hW,MouseX,MouseY)
    notice pcolor
    wait



[getpixelinfo]
    notice "Click mouse on desired pixel."
    #1 "setfocus; when leftButtonUp [dopixelinfo]"
    wait
[dopixelinfo]
    #1 "when leftButtonUp"
    pcolor=GetLongPixelColor(hW,MouseX,MouseY)
    red=GetRed(pcolor)
    green=GetGreen(pcolor)
    blue=GetBlue(pcolor)
    msg$= "Info" + chr$(13) +"Long colorref is "+ str$(pcolor) + chr$(13)
    msg$=msg$+"Red value is "+str$(red)+chr$(13)
    msg$=msg$+"Green value is "+str$(green)+chr$(13)
    msg$=msg$+"Blue value is "+str$(blue)
    notice msg$
    wait


'''''''''''''''''''''''''''''
'''''''''''''''''''''''''''''
''  API FUNCTION WRAPPERS  ''
'''''''''''''''''''''''''''''
'''''''''''''''''''''''''''''

Sub About
    calldll #im, "About", result as void
    End Sub

Function BitmapWidth(hBmp)
    calldll #im, "BitmapWidth",hBmp as long,_
    BitmapWidth as long
    End Function

Function BitmapHeight(hBmp)
    calldll #im, "BitmapHeight",hBmp as long,_
    BitmapHeight as long
    End Function

Function DuoTone(hBmp,hWnd,nRed,nGreen,nBlue)
    'AND bitwise operator, with RGB specified, each 0-255
    calldll #im, "DuoTone",hBmp as Long,hWnd as Long,_
    nRed as Long, nGreen as long, nBlue as long,_
    DuoTone as ulong
    End Function

Function Negative(hBmp, hWnd)
    'invert colors like photo negative
    calldll #im, "Negative", hBmp as long,_
    hWnd as long, Negative as ulong
    End Function

Function ChangeAll(hBmp,hWnd,xSource,ySource,nRed,nGreen,nBlue)
    'change all pixels the same color as pixel at xSource,ySource
    'to be RGB specified
    calldll #im, "ChangeAll",hBmp as long, hWnd as long,_
    xSource as long, ySource as long, nRed as long, nGreen as long,_
    nBlue as long, ChangeAll as ulong
    End Function

Function ColorSwap(hBmp,hWnd,nRed,nGreen,nBlue)
    '0=make this color red,1=make this color green,1=make it blue
    'so nRed=2 means make all red pixels blue, etc.
    calldll #im, "ColorSwap",hBmp as long, hWnd as long,_
    nRed as long, nGreen as long, nBlue as long,_
    ColorSwap as ulong
    End Function

Function FloodFillIt(hBmp,hWnd,xSource,ySource,nRed,nGreen,nBlue)
    'flood fill from xSource,ySource
    'to be RGB specified
    calldll #im, "FloodFillIt",hBmp as long, hWnd as long,_
    xSource as long, ySource as long, nRed as long, nGreen as long,_
    nBlue as long, FloodFillIt as ulong
    End Function

Function GrayScale(hBmp,hWnd)
    calldll #im, "GrayScale",hBmp as long,_
    hWnd as long,GrayScale as ulong
    End Function

Function Colorize(hBmp,hWnd,nRed,nGreen,nBlue)
    'Creates pic in strong tones of color specified
    'if nRed<>0 then use red in colorization,
    'if nRed=0 then don't use red in colorization, etc.
    calldll #im, "Colorize",hBmp as long,hWnd as long,_
    nRed as long, nGreen as long, nBlue as long,_
    Colorize as ulong
    End Function

Function Hue(hBmp,hWnd,nRed,nGreen,nBlue)
    'Creates pic in all colors, but hue of color specified.
    'if nRed<>0 then use red in colorization,
    'if nRed=0 then don't use red in colorization, etc.
    calldll #im, "Hue",hBmp as long,hWnd as long,_
    nRed as long, nGreen as long, nBlue as long,_
    Hue as ulong
    End Function

Function Tint(hBmp,hWnd,nRed,nGreen,nBlue)
    'Creates pic in lighter tones of color specified
    'if nRed<>0 then use red in colorization,
    'if nRed=0 then don't use red in colorization, etc.
    calldll #im, "Tint",hBmp as long,hWnd as long,_
    nRed as long, nGreen as long, nBlue as long,_
    Tint as ulong
    End Function

Function Solarize(hBmp,hWnd,nflag)
    'nflag=0 invert dark colors, don't process light colors
    'nflag=1 invert light colors, don't process dark colors
    calldll #im, "Solarize",hBmp as long,_
    hWnd as long, nflag as long, Solarize as ulong
    End Function

Function Brightness(hBmp,hWnd,nBright)
    'nBright=percent to brighten - 200 is twice as bright
    '50 is half as bright
    calldll #im, "Brightness",hBmp as long, hWnd as long,_
    nBright as long, Brightness as ulong
    End Function

Function Contrast(hBmp,hWnd)
    'increases contrast between light and dark areas
    calldll #im, "Contrast",hBmp as long,_
    hWnd as long,Contrast as ulong
    End Function

Function Midtone(hBmp,hWnd)
    'decreases contrast between light and dark areas
    calldll #im, "Midtone",hBmp as long,_
    hWnd as long,Midtone as ulong
    End Function

Function Soften(hBmp,hWnd)
    'soften edges of objects in image
    calldll #im, "Soften",hBmp as long,_
    hWnd as long,Soften as ulong
    End Function

Function Sharpen(hBmp,hWnd)
    'sharpen edges of objects in image
    calldll #im, "Sharpen",hBmp as long,_
    hWnd as long, Sharpen as ulong
    End Function

Function Pixelate(hBmp,hWnd)
    'remove detail, create blocks of same-color pixels
    calldll #im, "Pixelate",hBmp as long,_
    hWnd as long,Pixelate as ulong
    End Function

Function Diffuse(hBmp,hWnd,nflag)
    'diffuse image by amount in nflag
    calldll #im, "Diffuse",hBmp as long,_
    hWnd as long, nflag as long, Diffuse as ulong
    End Function

Function Emboss(hBmp,hWnd)
    'give objects in image a raised, embossed look
    calldll #im, "Emboss",hBmp as long,_
    hWnd as long,Emboss as ulong
    End Function

Function BlendPictures(hBmp,hBmp2,hWnd)
    'hBmp2 will be blended onto hBmp
    'if hBmp2 is smaller than hBmp, it will be tiled
    calldll #im, "BlendPictures",hBmp as long,hBmp2 as long,_
    hWnd as long,BlendPictures as long
    End Function

Function Blur(hBmp,hWnd)
    'blur image... the more times this function is
    'called, the blurrier the image becomes
    calldll #im, "Blur",hBmp as long,_
    hWnd as long,Blur as ulong
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

Function AddMask(hBmp,hWnd)
    'adds mask above sprite... sprite must have black background
    calldll #im, "AddMask",hBmp as long,hWnd as long,_
    AddMask as ulong
    End Function

Function GetRed(color)
    'gets red component of long color value
    calldll #im, "GetRed",color as long, GetRed as ulong
    End Function

Function GetGreen(color)
    'gets green component of long color value
    calldll #im, "GetGreen",color as long, GetGreen as ulong
    End Function

Function GetBlue(color)
    'gets blue component of long color value
    calldll #im, "GetBlue",color as long, GetBlue as ulong
    End Function

Function MakeRGB(nRed,nGreen,nBlue)
    'makes long colorref from red(0-255),green(0-255),blue(0-255)
    calldll #im, "MakeRGB",nRed as long,nGreen as long,_
    nBlue as long, MakeRGB as ulong
    End Function

Function GetLongPixelColor(hWnd,x,y)
    'gets long color value of pixel specified
    calldll #im, "GetLongPixelColor",hWnd as long,_
    x as long, y as long, GetLongPixelColor as ulong
    End Function

Function ConvertTo24Bit(hBmp,hWnd)
    'returns handle to copy of hBmp in 24-bit color format
    calldll #im, "ConvertTo24Bit",hBmp as long,_
    hWnd as long, ConvertTo24Bit as ulong
    End Function

Function LoadImageFile(hWnd, file$)
    'load an image from file,
    'bmp, jpg, gif, emf, wmf, ico
    'returns handle of memory bmp
    calldll #im, "LoadImageFile",hWnd as ulong,_
    file$ as ptr,LoadImageFile as ulong
    End Function


