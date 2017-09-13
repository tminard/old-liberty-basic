bmpsat$ = "install.set"
'this program shows bmps in frames
'copyright (C) 2005-2007 by Adelphos Pro(TM)
'All rights reserved.


'ABOUT
'This program automaticly detects how many .bmp files there are and will show them
'one at a time from 1.bmp - 100.bmp


'---------------Functions--------------------


'---------------End Functions----------------
'notice "Press
'gosub [command.lines]
gosub [extract.bmps]
gosub [openINFO]
dim info$(100,100)

gosub [seebmps]
nomainwin




'Form created with the help of Freeform 3 v03-27-03
'Generated on Nov 01, 2005 at 16:35:05


[setup.1.Window]

    '-----Begin code for #1

    nomainwin
    WindowWidth = val(bmpwid$)
    WindowHeight = val(bmphigh$)
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)



    '-----Begin GUI objects code

    graphicbox #1.gs,   0,   0, val(bmpwid$), val(bmphigh$)
   ' statictext #1.statictext1, "Name: "+name$,  20, 327, 161,  20
    'notice name$
   ' statictext #1.statictext2, "Frame:0", 215, 327,  80,  20
    'statictext #1.statictext3, "FPS: ";speed, 310, 327, 100,  20

    '-----End GUI objects code

    open name$ for window_popup as #1
    print #1.gs, "down; fill white; flush"
    print #1.gs, "when rightButtonUp [noticequit]"
    print #1, "font ms_sans_serif 10"
    print #1, "trapclose [endall]"
    print #1.gs, "up"
    print #1.gs, "goto ";val(bmpwid$) / 2;" ";val(bmphigh$)/2
    print #1.gs, "down"
    print #1.gs, "\Loading bmp's, Please wait...."


[1.inputLoop]   'wait here for input event
IF fileExists(DefaultDir$, "1.bmp") THEN loadbmp "pic", "1.bmp":print #1.gs, "cls":tim = tim + 1:bmp = 0:loadbmp "pic", "1.bmp":unloadbmp "pic":bmp = bmp + 1
IF bmp = seebmps THEN [bmend]
IF bmp = 0 THEN notice "No file loaded!":close #1:end
loadbmp "pic", str$(bmp)+".bmp":print #1.gs, "drawbmp pic 0 0":print #1.gs, "flush":timer speed, [changebmp]:wait
end





[changebmp]
unloadbmp "pic"
bmp = bmp + 1
IF bmp = seebmps THEN [bmend]  'end of loop, no more bmps found. restart loop.
'print #1.statictext2, "Frame: ";bmp
'print #1.gs, "fill white"
loadbmp "pic", str$(bmp)+".bmp"
print #1.gs, "drawbmp pic 0 0"
print #1.gs, "flush"
wait


[bmend]
IF dotype$ = "loop" THEN
print #1.gs, "cls"
tim = tim + 1
'IF tim = 12 THEN timer 0:wait
bmp = 0
loadbmp "pic", "1.bmp"
unloadbmp "pic"
bmp = bmp + 1
'IF bmp = seebmps THEN [bmend]
'print #1.statictext2, "Frame: ";bmp
'print #1.gs, "fill white"
loadbmp "pic", str$(bmp)+".bmp"
print #1.gs, "drawbmp pic 0 0"
print #1.gs, "flush"
wait
end if
timer 0
print #1.gs, "flush"
wait


[endall]
timer 0
close #1
for i = 1 to 100000
IF fileExists("",i;".bmp") = 0 THEN exit for
  IF fileExists("",i;".bmp") THEN kill i;".bmp"
  next i
  kill "defaults.ini"
end


[seebmps] 'check to see how many bmp files there are.
path$ = DefaultDir$
filenum = filenum + 1
if fileExists(path$,str$(filenum) + ".bmp") then
seebmps = seebmps + 1
goto [seebmps]
end
end if
seebmps = seebmps + 1
return







[openINFO]
    path$ = DefaultDir$
    if fileExists(path$, "defaults.ini") then
  goto [filethere]
end
  end if
     notice "Defaults.ini not found! Press [ok] to create it."
     [cinfo]
     open "Defaults.ini" for output AS #makeit
     print #makeit, "Speed to show frames-per-sec, 100"
     print #makeit, "Name of Picture, My File"
     print #makeit, "Largest bmp size in Hight then width, 800,800"
     print #makeit, "loop"
   close #makeit
end

          [filethere]
              open "defaults.ini" for input AS #info
               IF eof(#info) <> 0 THEN errinfo$ = "YES":fileerr$ = "defaults.ini":goto[errread]:end
              input #info, def$
               IF eof(#info) <> 0 THEN errinfo$ = "YES":fileerr$ = "defaults.ini":goto[errread]:end
              input #info, speed
               IF eof(#info) <> 0 THEN errinfo$ = "YES":fileerr$ = "defaults.ini":goto[errread]:end
              input #info, def$
               IF eof(#info) <> 0 THEN errinfo$ = "YES":fileerr$ = "defaults.ini":goto[errread]:end
              input #info, name$
              IF eof(#info) <> 0 THEN errinfo$ = "YES":fileerr$ = "defaults.ini":goto[errread]:end
              input #info, def$
              IF eof(#info) <> 0 THEN errinfo$ = "YES":fileerr$ = "defaults.ini":goto[errread]:end
              input #info, bmphigh$
              IF eof(#info) <> 0 THEN errinfo$ = "YES":fileerr$ = "defaults.ini":goto[errread]:end
              input #info, bmpwid$
              IF eof(#info) <> 0 THEN errinfo$ = "YES":fileerr$ = "defaults.ini":goto[errread]:end
              input #info, dotype$
              close #info
return


         [errread]
         notice "Error reading "+fileerr$+"! Please check that file."
    IF errinfo$ = "YES" THEN close #info:goto [cinfo]: end
          return

[noticequit]
popupmenu "&Exit", [noticequit.quit],_
          "&About", [menuabout]
wait

[noticequit.quit]
confirm "Quit?";qit$
IF qit$ = "yes" THEN goto [endall]
wait

[menuabout]
notice "Program copyright {c} 2005 - 2007 by Tyler Minard)"
wait



[extract.bmps]
IF drivess$ = "quit" then end
IF trim$(drivess$) = "" THEN drivess$ = DefaultDir$
IF right$(drivess$,1) = "\" = 0 THEN drivess$ = drivess$+"\"
IF fileExists("",bmpsat$) = 0 THEN notice "Please insert disk 1. Press 'ok' to continue."
IF fileExists("",bmpsat$) = 0 THEN end
open bmpsat$ for input AS #1
input #1, file
input #1, pass$
goto [top]
end

[top]
IF err$ = "on" THEN close #1:err$="":wait
input #1, filename$
input #1, lenth$
lenth = val(lenth$)
doitnow = mkdir(drivess$)
IF err$ = "on" THEN close #2:close #1:err$="":wait
open drivess$+filename$ for output AS #2
text$ = input$(#1, lenth)
print #2, text$
close #2
IF eof(#1) <> 0 then close #1:return
input #1, blank$
IF blank$ = "NEXT DISK" THEN input #1, nextdisk$:notice "Please insert the next disk to continue setup"
IF blank$ = "NEXT DISK" THEN goto [get.nextdisk]
IF eof(#1) <> 0 then close #1:return
goto [top]
end




[get.nextdisk]
IF err$ = "on" THEN close #1:err$="":wait
if fileExists("",nextdisk$) THEN goto [load.nextdisk]
IF fileExists("",nextdisk$) = 0 THEN notice "Invailed Disk! Please insert next disk! Continue?";cont$
IF cont$ = "no" then close #1:end
goto [get.nextdisk]
end

[load.nextdisk]
close #1
open nextdisk$ for input AS #1
input #1, file
input #1, pass$
goto [top]
end


[command.lines]
IF trim$(CommandLine$) = "" THEN return
 bmpsat$ = chr$(34)+CommandLine$+chr$(34)
return



[functions]
FUNCTION fileExists(path$, filename$) ' Does file exist?
    files path$, filename$, info$(
    fileExists = val(info$(0, 0)) > 0
END FUNCTION
