nomainwin
open "Change Cursor" for window as #1
#1 "trapclose [quit]"

h=hwnd(#1) 'window handle
cursor$ = DefaultDir$ + "\liberty.cur"
'load cursor
calldll #user32, "LoadImageA",_
0 as long,_            'instance - use 0 for image from file
cursor$ as ptr,_       'path and filename of image
_IMAGE_CURSOR as long,_'type of image
0 as long,_            'desired width
0 as long,_            'desired height
_LR_LOADFROMFILE as long,_  'load flag = load-from-file
hCursor as ulong        'handle of cursor

calldll #user32,"SetClassLongA",_
h as ulong,_            'window handle
_GCL_HCURSOR as long,_ 'flag to change cursor
hCursor as ulong,_     'handle of cursor
r as long

wait

[quit] close #1:end
