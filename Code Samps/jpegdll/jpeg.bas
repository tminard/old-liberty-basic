'jpeg.dll by Alyce Watson, 2003
'
'Thanks go to the nice people from [lbexp]
'for pointing me in the right direction!
'
'This DLL loads an image and returns a handle
'to a 24-bit memory bitmap of the image.
'
'Supported types: .jpg, .bmp, .ico, .emf, .wmf, .gif
'= jpeg, bitmap, icon, enhanced metafile,
'windows metafile, and GIF
'
'There are also functions to retrieve the
'width and height of the image.
'
'This software is presented as is, with no
'warrantees expressed or implied.
'
'This software is FREEWARE.  You may use it
'any way you want, including in commercial
'applications.  A credit to the author is
'not necessary, but can be included if you like.
'
'It ought to work on all 32-bit versions
'of Windows.
'
'Benchmark tests show that loading a bmp with
'this DLL is nearly three times as fast as
'loading it with LOADBMP.
'
'The three functions in the DLL are documented
'at the bottom of this code.
'
'Added March, 2004:
'be sure to delete images with DeleteObject!

nomainwin
open "jpeg.dll" for dll as #j

menu #1, "&File","&Open Image",[open],_
    "&Save",[save],|,"E&xit",[quit]
menu #1, "&Help","&About",[about]

open "JPEG.DLL Test" for graphics_fs as #1
    #1 "trapclose [quit]"
    #1 "down; fill lightgray;flush"
    hW=hwnd(#1)   'graphicbox handle

wait

[quit]
    'unload image opened by DLL
    if hPic<>0 then
        calldll #gdi32, "DeleteObject",_
        hPic as long, re as long
    end if
    'unload image loaded by LB
    if hDemo<>0 then
        unloadbmp "demo"
    end if
    close #1:close #j:end

[open]
    'allow user to choose an image:
    filter$="*.jpg;*.bmp;*.ico;*.emf;*.wmf;*.gif"
    filedialog "Open Image",filter$,jname$
    if jname$="" then wait
    cursor hourglass

    'unload image opened by DLL
    if hPic<>0 then calldll #gdi32, "DeleteObject",_
        hPic as long, re as long

    'call DLL to load image
    hPic=LoadImageFile(hW,jname$)
    if hPic=0 then
        notice "Function failed."
        cursor normal
        wait
    end if

    'clear old graphics
    #1 "cls;fill lightgray"

    'unload previous bmp, if there is one
    if hDemo<>0 then unloadbmp "demo"

    'load image with LOADBMP
    loadbmp "demo",hPic
    hDemo=hbmp("demo")

    'display with DRAWBMP
    #1 "drawbmp demo 0 0 ;flush"
    cursor normal

    'retrieve dimensions and inform user
    m$="Dimensions are "
    m$=m$+str$(ImageWidth(hDemo))
    m$=m$+" x "
    m$=m$+str$(ImageHeight(hDemo))
    notice m$
    wait


[save]'save the current image, using BmpSave
    'no bmp loaded, abort save:
    if hDemo=0 then
        notice "No image to save."
        wait
    end if

    'allow user to choose filename:
    filedialog "Save As","*.bmp",savebmp$
    if savebmp$="" then wait

    'add extension bmp if it is not present
    if lower$(right$(savebmp$,4))<>".bmp" then
        savebmp$=savebmp$+".bmp"
    end if

    'save to disk with bmpsave command
    bmpsave "demo",savebmp$
    wait


[about]
    m$="JPEG.DLL copyright Alyce Watson, 2003. "
    m$=m$+"Freeware.  No warrantees expressed or implied. "
    m$=m$+"Thanks to the [lbexp] group for helping to make this possible."
    notice m$
    wait

Function LoadImageFile(hWnd, file$)
    'Supported types; bmp,emf,wmf,jpg,ico,gif
    'Requires window handle,
    'and disk file name of image.
    'Returns handle to bmp in memory
    calldll #j, "LoadImageFile",_
    hWnd as ulong,_
    file$ as ptr,_
    LoadImageFile as ulong
    End Function

Function ImageWidth(hImage)
    'input handle of memory bmp
    'returns width of image
    calldll #j, "ImageWidth",hImage as long,_
    ImageWidth as ulong
    End Function

Function ImageHeight(hImage)
    'input handle of memory bmp
    'returns height of image
    calldll #j, "ImageHeight",hImage as long,_
    ImageHeight as ulong
    End Function



