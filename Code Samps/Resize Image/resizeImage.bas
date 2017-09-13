open "user32" for dll as #user
width = 100
height = 100
imagePath$ = "C:\Documents and Settings\Tyler Minard\My Documents\My Pictures\My Photos\kuvin.bmp"
    calldll #user, "LoadImageA", 0 as long, imagePath$ as Ptr, 0 as long, width as long, height as long, 16 as long, hImage as ulong
loadbmp "display", hImage
