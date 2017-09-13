'*********************************************
' To test rmfDLLv02.dll
'*********************************************
' Demo to test a richedit control using a dll.
' The control is a single line input box.
' The background can be set to any colour.
' The font can be set to any colour.
' This version has two functions, one uses HEX
' and the other RGB colour values as input.
' The position and size can be set.
' The maximum number of chars entered can be set.
' The ESC key can be used to tab between controls.
' rmf (18.11.2002)

nomainwin

'Size window and center
dw = DisplayWidth: dh = DisplayHeight
WindowWidth = 300 : WindowHeight = 180
UpperLeftX=(dw-WindowWidth)/2: UpperLeftY=(dh-WindowHeight)/2

'Place controls
statictext #w.st1, "",               67,  10, 280, 25
button #w.bt1, "Exit", [exit],  UL, 120, 115,  50, 25

'Open window
open "Test rmfDLLv02" for window as #w
print #w, "trapclose [exit]"
print #w.st1, "!font System 14"
print #w.st1, "Use ESC to tab controls"
print #w.bt1, "!font System 14"

open "user32" for dll as #user

h = hwnd(#w)

' Create one instance of the custom control
' by calling the LB function InputBoxHEX().
' This function uses two HEX colour values
' as parameters.
hTB1 = InputBoxHEX(h, "&H008000", "&HCCFFCC", 88, 35, 110, 25, 10)
' Create one instance of the custom control
' by calling the LB function InputBoxRGB().
' This function uses six R/G/B colour values
' as parameters.
hTB2 = InputBoxRGB(h, 255, 020, 147, 255, 248, 220, 88, 75, 110, 25, 10)

'Array of handles to controls which will be used for tabbing.
'Place them in tabbing order.
index = 3
dim handle(index)
    handle(1) = hTB1          'Custom control
    handle(2) = hTB2          'Custom control
    handle(3) = hwnd(#w.bt1)  'LB control
'Set focus on first control
call focus, handle(1)

[loop]
'check for the ESC key being pressed
scan
if getKey(_VK_ESCAPE) then call focusNext, index
goto [loop]

[exit]
close #user
close #w
end
'*****************************************************
'*****************************************************
sub focus handle
'give focus to control
'handle is handle to control to receive focus
  calldll #user32, "SetFocus",_
    handle as word,_
    result as short
end sub
'*****************************************************
sub focusNext index
'index is number of elements in handle() array
  'get handle to control with focus
  calldll #user32, "GetFocus",_
    result as short
  'get handle to next control in array
  for j = 1 to index
    if handle(j) = result then
      x = j + 1: if x = index+1 then x = 1
      newHandle = handle(x)
      j = index
    end if
  next j
  'give focus to next control
  call focus, newHandle
end sub
'*****************************************************
function getKey(key)
'key is symbolic name of virtual keycode of key to be trapped
  calldll #user32, "GetAsyncKeyState", _      'check for key down
    key    as long, _
    result as long
  if result < 0 then                          'if key down wait for 1/20 sec.
    timer 50, [restart]
    wait
    [restart]
    timer  0                                  'deactivate the timer
    calldll #user32, "GetAsyncKeyState", _    'check for key up
      key    as long, _
      result as long
    'return 1 if key pressed and released
    'otherwise return 0
    if result = 0 then getKey = 1 else getKey = 0
  end if
end function
'***********************************************
'***********************************************
' The calls to the dll functions are made from
' inside these LB functions. This keeps the code
' inside the main part of the programme simpler,
' especially if there are multiple instances of
' the control.
'***********************************************
' This function uses HEX values for the colours.
'***********************************************
function InputBoxHEX(handle, ink$, paper$, x, y, w, h, max)
  open "rmfDLLv02.dll" for dll as #rmfdll
  calldll #rmfdll, "InputBoxHEX", _
    handle as long, _ ' handle of parent window
    ink$   as ptr, _  ' ink colour
    paper$ as ptr, _  ' paper colour
    x      as long, _ ' x co-ord
    y      as long, _ ' y co-ord
    w      as long, _ ' width
    h      as long, _ ' height
    max    as long, _ ' max chars
    hTB    as long    ' returns handle to new control
  close #rmfdll
  InputBoxHEX = hTB
end function
'***********************************************
' This function uses R/G/B values for the colours.
'***********************************************
function InputBoxRGB(handle, iRed, iGreen, iBlue, pRed, pGreen, pBlue, x, y, w, h, max)
  open "rmfDLLv02.dll" for dll as #rmfdll
  calldll #rmfdll, "InputBoxRGB", _
    handle  as long, _ ' handle of parent window
    iRed    as long, _ ' ink red
    iGreen  as long, _ ' ink green
    iBlue   as long, _ ' ink blue
    pRed    as long, _ ' paper red
    pGreen  as long, _ ' paper green
    pBlue   as long, _ ' paper blue
    x       as long, _ ' x co-ord
    y       as long, _ ' y co-ord
    w       as long, _ ' width
    h       as long, _ ' height
    max     as long, _ ' max chars
    hTB     as long    ' returns a handle to the new control
  close #rmfdll
  InputBoxRGB = hTB
end function
'*****************************************************
