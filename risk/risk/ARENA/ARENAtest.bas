'Form created with the help of Freeform 3 v03-27-03
'Generated on Jul 01, 2006 at 14:36:50
dim fighter$(1000,10) '(x,0) = name; (x,1) = team; (x,2) = health; (x,3) = chance [i.e. 1/6];
'(x,4) = data file
dim location$(1000)

fighters = 2

'--config.dat--
fighter$(1,0) = "Tyler"
fighter$(1,1) = "Minard"
fighter$(1,2) = "100"
fighter$(1,3) = "1/6" '1 out of 6 good
fighter$(1,4) = "tyler.bmp"
location$(1) = "50 34"

fighter$(2,0) = "Ryan"
fighter$(2,1) = "Min"
fighter$(2,2) = "100"
fighter$(2,3) = "1/6" '1 out of 6 good
fighter$(2,4) = "tyler.bmp"
location$(2) = "100 100"
'--EOF--


[setup.main.Window]

    '-----Begin code for #main

    nomainwin
    WindowWidth = 550
    WindowHeight = 410
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    graphicbox #main.g,   5,   5, 505, 305
    statictext #main.statictext2, "Debug text:",   5, 322,  600,  20

    '-----End GUI objects code

    open "untitled" for window as #main
    print #main.g, "down; fill white; flush"
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"


[main.inputLoop]   'wait here for input event
  for i = 1 to fighters
  loadbmp fighter$(i,4),fighter$(i,4)
     print #main.g, "addsprite "+fighter$(i,0)+" "+fighter$(i,4)
     print #main.g, "spritexy "+fighter$(i,0)+" "+location$(i)
 next i
 timer 85, [draw]
    wait

[draw]
print #main.g, "drawsprites"
wait

[quit.main] 'End the program
timer 0
    close #main
    end

