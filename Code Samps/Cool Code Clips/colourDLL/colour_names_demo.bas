' Predefined Colour Names for Liberty BASIC v3
' rmf (18.11.2001)
'**********************************
' To show the use of predefined colour names in Liberty BASIC.
' To see a completet list of colour names and their values as
' RED/GREEN/BLUE see: "colour_data.txt"
' To see the colours displayed with their R/G/B and HEX values,
' run the app. "colours.bas"

'*******************************
' See 'sub initialise' for details
' of pre-defined colour names
call initialise
'*******************************

nomainwin

'Size window and center
dw = DisplayWidth: dh = DisplayHeight
WindowWidth = 278 : WindowHeight = 170
UpperLeftX=(dw-WindowWidth)/2: UpperLeftY=(dh-WindowHeight)/2

'Place controls
button     #w.bt1, "Exit", [exit],  UL, 110, 110,  50,  20
graphicbox #w.gb,                         6,   6, 260,  90

'Open window
open "Using Predefined Colour Names" for window as #w
#w "trapclose [exit]"

#w.gb "down; size 3;fill ";beige$(0)
#w.gb "color ";indianred$(0)
#w.gb "backcolor ";lightpink$(0)
#w.gb "place 50, 45;circlefilled 15"
#w.gb "color ";steelblue$(0)
#w.gb "backcolor ";powderblue$(0)
#w.gb "place 100 30; boxfilled 130 60"
#w.gb "color ";olive$(0)
#w.gb "backcolor ";darkseagreen$(0)
#w.gb "place 195, 45;ellipsefilled 60 30"

[loop]
wait

[exit]
close #w
end

sub initialise
' Pre-defined colour names with R/G/B values.
' Use array elements to make variables global.
beige$(0)        = "245 245 214"
darkseagreen$(0) = "143 188 143"
indianred$(0)    = "205 092 092"
lightpink$(0)    = "255 182 193"
oldlace$(0)      = "253 245 230"
olive$(0)        = "128 128 000"
powderblue$(0)   = "176 224 230"
steelblue$(0)    = "070 130 180"
' You could copy some of the named colours from "colour_data.txt",
' or include, at this point, the complete file which has all the
' 140 named colours defined as R/G/B values.
end sub
