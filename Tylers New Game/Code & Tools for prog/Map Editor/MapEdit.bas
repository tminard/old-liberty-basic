'Form created with the help of Freeform 3 v03-27-03
'Generated on Aug 29, 2005 at 14:34:03
notice "When deleting objects, remember that only the FIRST object selected will be removed."
cursor hourglass
bmpsat$ = "data.pak"
gosub [extract.bmps]


on error goto [resume]
loadbmp "house", "house.bmp"
loadbmp "Clear", "x.bmp"
loadbmp "tree", "tree.bmp"
loadbmp "man", "man.bmp"
loadbmp "block", "wall.bmp"
loadbmp "fin", "fin.bmp"
tn = -1
hn = -1
phn = -1
ptn = -1




[setup.root.Window]

    '-----Begin code for #root

    nomainwin
     WindowWidth = 330
  WindowHeight = 410
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    graphicbox #root.graphicbox1,   5,   2, 310, 340
    button #root.button2,"Make!",[button2subClick], UL,  15, 347,  60,  25
    button #root.button3,"Quit",[button3Click], UL, 245, 347,  65,  25
    statictext #root.statictext4, "Map editor v1.0", 115, 347, 130,  20

    '-----End GUI objects code

    open "Map editor" for window as #root
    print #root.graphicbox1, "down; fill white; flush"
    print #root, "font ms_sans_serif 10"
    print #root.button2, "!font ms_sans_serif 10 bold"
    print #root.button3, "!font ms_sans_serif 10 bold"
    print #root.statictext4, "!font ms_sans_serif 10 bold italic"
    print #root, "trapclose [quit.root]"
print #root.graphicbox1, "when characterInput [inkey$]"
print #root.graphicbox1, "when leftButtonDown [draw]"
print #root.graphicbox1, "when rightButtonDown [options]"
print #root.graphicbox1, "when mouseMove [move.mouse]"
'notice "man set!"
dri$ = "m"
manset = 1
Inkey$ = "m"
print #root.graphicbox1, "addsprite cors man"
'print #root.graphicbox1, "spritexy cors ";MouseX;" ";MouseY
'timer 3000, [move.mouse]
cursor CROSSHAIR
[root.inputLoop]   'wait here for input event
    wait

[move.mouse]
'loadbmp "house", "house.gpf"
'loadbmp "Clear", "clear.bmp"
'loadbmp "tree", "tree.gpf"
'loadbmp "man", "1man.gpf"
'loadbmp "block", "wall.gpf"
'loadbmp "fin", "fin.gpf"
print #root.graphicbox1, "set "; MouseX; " "; MouseY
IF Inkey$ = "c" THEN curbmp$ = "Clear"
IF Inkey$ = "f" THEN curbmp$ = "fin"
IF Inkey$ = "h" THEN curbmp$ = "house"
IF Inkey$ = "" THEN curbmp$ = "Clear"':notice "Clear Set!"
IF Inkey$ = "t" THEN curbmp$ = "tree"
IF Inkey$ = "m" THEN curbmp$ = "man"
IF Inkey$ = "b" THEN curbmp$ = "block"
print #root.graphicbox1, "removesprite cors"
print #root.graphicbox1, "addsprite cors "+curbmp$
'print #root.graphicbox1, "centersprite cors"
print #root.graphicbox1, "spritexy cors ";MouseX;" ";MouseY
print #root.graphicbox1, "spritecollides cors cursor$";
IF cursor$ = "" THEN selected$ = ""
selected$ = cursor$
'IF word$(selected$,2) = "" = 0 THEN selected$ = ""
#root.statictext4, selected$
     print #root.graphicbox1, "drawsprites"
     wait

[functions]
dim info$(100,10)
FUNCTION fileExists(path$, filename$) ' Does file exist?
    files path$, filename$, info$(
    fileExists = val(info$(0, 0)) > 0
END FUNCTION

[inkey$]
IF Inkey$ = "f" THEN [addfin]
IF Inkey$ = "b" THEN [addfenc]
IF Inkey$ = "m" THEN [addman]
IF Inkey$ = "t" THEN [addtree]
IF Inkey$ = "h" THEN [addhouse]
IF Inkey$ = "c" THEN [clear]
wait

[addhouse]
'notice "House set!"
dri$ = "h"
wait

[addfenc]
'notice "Block set!"
dri$ = "b"
wait


[addman]
'notice "man set!"
dri$ = "m"
manset = 1
wait

[addfin]
'notice "Finish set!"
dri$ = "f"
finset = 1
wait


[addtree]
'notice "Tree set!"
dri$ = "t"
wait


[draw]
'IF selected$ = "" = 0 THEN gosub [confirm1]
'IF fg$ = "no" THEN wait
lInkey$ = Inkey$
IF Inkey$ = "b" THEN [drawfence]
IF Inkey$ = "m" THEN [drawman]
IF Inkey$ = "f" THEN [drawfin]
IF Inkey$ = "t" THEN [drawtree]
IF Inkey$ = "h" THEN [drawhouse]
IF Inkey$ = "" THEN [root.inputLoop]
If Inkey$ = "c" THEN [drawclear]
wait

[confirm1]
confirm "You are about to put an object over an object. Are you sure you want to do this?";fg$
IF fg$ = "no" THEN return
return
[drawman]
IF manlay = 1 THEN
  print #root.graphicbox1, "removesprite man"
           print #root.graphicbox1, "drawsprites"
           goto [drawmanr1]
           end
else
goto [drawmanr1]
end

[drawfin]
IF finlay = 1 THEN
  print #root.graphicbox1, "removesprite fin"
           print #root.graphicbox1, "drawsprites"
           goto [drawfinr1]
           end
else
goto [drawfinr1]
end

[drawfinr1]
fin$ = "Y"
print #root.graphicbox1, "addsprite fin fin"
'print #root.graphicbox1, "centersprite fin"
    print #root.graphicbox1, "spritexy fin ";MouseX;" ";MouseY
     print #root.graphicbox1, "drawsprites"
     finlay = 1
     wait

[drawmanr1]
man$ = "Y"
print #root.graphicbox1, "addsprite man man"
'print #root.graphicbox1, "centersprite man"
    print #root.graphicbox1, "spritexy man ";MouseX;" ";MouseY
     print #root.graphicbox1, "drawsprites"
     manlay = 1
     wait


[drawhouse]
hn = hn + 1
house$ = "Y"
print #root.graphicbox1, "addsprite house";hn;" house"
'print #root.graphicbox1, "centersprite house";hn
    print #root.graphicbox1, "spritexy house";hn;" ";MouseX;" ";MouseY
     print #root.graphicbox1, "drawsprites"
     wait

     [drawtree]
tn = tn + 1
tree$ = "Y"
print #root.graphicbox1, "addsprite tree";tn;" tree"
'print #root.graphicbox1, "centersprite tree";tn
    print #root.graphicbox1, "spritexy tree";tn;" ";MouseX;" ";MouseY
     print #root.graphicbox1, "drawsprites"
     wait

          [drawfence]
fn = fn + 1
fence$ = "Y"
print #root.graphicbox1, "addsprite fence";fn;" block"
'print #root.graphicbox1, "centersprite fence";fn
    print #root.graphicbox1, "spritexy fence";fn;" ";MouseX;" ";MouseY
     print #root.graphicbox1, "drawsprites"
     wait




[button2Click]   'Perform action for the button named 'button2'
cursor hourglass
IF man$ = "Y" THEN [printman]
IF fin$ = "Y" THEN [printfin]
IF fence$ = "Y" AND fid$ = "" AND fn > 0 THEN [printfence]
IF house$ = "Y" AND hid$ = "" AND hn > 0 THEN [printhouses]
IF tree$ = "Y" AND tid$ = "" AND tn > 0 THEN [printtrees]
confirm "Add mines?";addm$
IF addm$ = "yes" THEN
goto [addmines]
end
else
[r1]
confirm "Add coins?";addc$
IF addc$ = "yes" THEN
goto [addcoins]
end
else
[r2]
print #fileo, "wall"
print #fileo, "-1"
print #fileo, "-1"
print #fileo, "wallb"
print #fileo, "0"
print #fileo, "330"
print #fileo, "wallr"
print #fileo, "310"
print #fileo, "-1"
print #fileo, "walll"
print #fileo, "0"
print #fileo, "-1"
print #fileo, "endr"
    close #fileo
    cursor normal
    cursor CROSSHAIR
    notice "Done!"
    phn = 0
    hid$ = ""
    tid$ = ""
    ptn = 0
    wait

[printman]
print #fileo, "man"
print #root.graphicbox1, "spritexy? man nmpx$ nmpy$"
#root.graphicbox1, "removesprite man"
#root.graphicbox1, "drawsprites"
print #fileo, nmpy$
print #fileo, nmpx$
man$ = "N"
goto [button2Click]
end

[printfin]
print #fileo, "fin"
print #root.graphicbox1, "spritexy? fin nmfx$ nmfy$"
print #fileo, nmfy$
print #fileo, nmfx$
fin$ = "N"
#root.graphicbox1, "removesprite fin"
#root.graphicbox1, "drawsprites"
goto [button2Click]
end


[addmines]
confirm "Add mine sweeper?"; hvms$
IF hvms$ = "yes" THEN
print #fileo, "sweeper"
goto [addmr1]
end
else
[addmr1]
mbmpname$ = "bm.gpf"
prompt "Mines data file: "; mdataf$
prompt "Bmp file: "; mbmpname$
prompt "How many mines: ";howman$
print #fileo, "mines"
print #fileo, mdataf$
open mdataf$ for output AS #mdataf
print #mdataf, "mines"
print #mdataf, mbmpname$
print #mdataf, howman$
print #mdataf, "10"
print #mdataf, "400"
print #mdataf, "10"
print #mdataf, "297"
close #mdataf
goto [r1]
end

[addcoins]
cbmpname$ = "c.gpf"
prompt "Coins data file: "; cdataf$
prompt "Bmp file: "; cbmpname$
prompt "How many coins: ";howman$
print #fileo, "coins"
print #fileo, cdataf$
open cdataf$ for output AS #mdataf
print #mdataf, "coins"
print #mdataf, cbmpname$
print #mdataf, howman$
print #mdataf, "10"
print #mdataf, "400"
print #mdataf, "10"
print #mdataf, "297"
close #mdataf
goto [r2]
end

[printhouses]
phn = phn + 1
IF phn > hn THEN
hid$ = "Y"
how$ = "no"
goto [button2Click]
end
else
how$ = "yes"
print #fileo, "house"
[printhouseser]
print #root.graphicbox1, "spritexy? house";phn;" px$ py$"
#root.graphicbox1, "removesprite house";phn
#root.graphicbox1, "drawsprites"
print #fileo, px$
print #fileo, py$
goto [printhouses]
end

[printtrees]
ptn = ptn + 1
IF ptn > tn THEN
tid$ = "Y"
trw$ = "no"
goto [button2Click]
end
else
trw$ = "yes"
print #fileo, "tree"
[printtreeser]
print #root.graphicbox1, "spritexy? tree";ptn;" tx$ ty$"
#root.graphicbox1, "removesprite tree";ptn
#root.graphicbox1, "drawsprites"
print #fileo, tx$
print #fileo, ty$
goto [printhouses]
end

[printfence]
pfn = pfn + 1
IF pfn > fn THEN
fid$ = "Y"
frw$ = "no"
goto [button2Click]
end
else
frw$ = "yes"
print #fileo, "block"
[printfenceser]
print #root.graphicbox1, "spritexy? fence";pfn;" fx$ fy$"
#root.graphicbox1, "removesprite fence";pfn
#root.graphicbox1, "drawsprites"
print #fileo, fx$
print #fileo, fy$
goto [printfence]
end


[button3Click]   'Perform action for the button named 'button3'

goto[quit.root]
end

[quit.root] 'End the program
'timer 0
open "data.pak.log" for input AS #kf
for i = 1 to 100000
IF eof(#kf) <> 0 THEN exit for
line input #kf, killme$
IF fileExists("",killme$) THEN kill killme$
next i

close #kf
kill "data.pak.log"
    close #root
    end

[clear]
'notice "Clear set!"
wait

[drawclear]
print #root.graphicbox1, "addsprite Clear Clear"
''print #root.graphicbox1, "centersprite Clear"
    print #root.graphicbox1, "spritexy Clear ";MouseX;" ";MouseY
    print #root.graphicbox1, "spritecollides Clear clearcom$";
      IF clearcom$ = " " THEN [root.inputLoop]
      IF left$(clearcom$, 2) = "ma" THEN [mvm]
      IF left$(clearcom$, 2) = "ho" THEN [hvm]
      IF left$(clearcom$, 2) = "tr" THEN [tvm]
      IF left$(clearcom$, 2) = "fe" THEN [fvm]
      IF left$(clearcom$, 2) = "fi" THEN [fivm]
      print #root.graphicbox1, "removesprite Clear"
      print #root.graphicbox1, "drawsprites"
     ' notice "Invaled sprite!"
      wait

      [remsprite]
      print #root.graphicbox1, "removesprite "+clearcom$
      print #root.graphicbox1, "removesprite Clear"
           print #root.graphicbox1, "drawsprites"
    '  notice "Done!"
      wait

      [hvm]
      hn = hn - 1
      goto [remsprite]
      end

 [fvm]
      fn = fn - 1
      goto [remsprite]
      end

       [mvm]
      man$ = "N"
      manlay = 0
      goto [remsprite]
      end

          [fivm]
      fin$ = "N"
      finlay = 0
      goto [remsprite]
      end

       [tvm]
      tn = tn - 1
      goto [remsprite]
      end

[button2subClick]
prompt "What NUMBER would you like to name this map?: ";mapn
 open "map";mapn;".map" for output AS #fileo
 mapn$ = str$(mapn)
 goto [button2Click]
 end


[resume]
IF how$ = "yes" THEN [erhouse]
IF trw$ = "yes" THEN [ertree]
IF frw$ = "yes" THEN [erfence]
notice "Error!"+chr$(13)+Err$
end

[ertree]
ptn = ptn + 1
goto [printtreeser]
end

[erhouse]
phn = phn + 1
goto [printhouseser]
end


[erfence]
phn = phn + 1
goto [printfenceser]
end




[extract.bmps]
IF drivess$ = "quit" then end
IF trim$(drivess$) = "" THEN drivess$ = DefaultDir$
IF right$(drivess$,1) = "\" = 0 THEN drivess$ = drivess$+"\"
IF fileExists("",bmpsat$) = 0 THEN notice "Please insert next disk"+chr$(13)+"Please insert the disk that contains the file '"+bmpsat$+"' Press 'ok' to continue."
IF fileExists("",bmpsat$) = 0 THEN end
open bmpsat$ for input AS #1
input #1, file
input #1, pass$
goto [top2]
end

[top2]
IF err$ = "on" THEN close #1:err$="":wait
input #1, filename$
IF filename$ = "endall" THEN close #1:print "Done!":return

open bmpsat$+".log" for append AS #sn
print #sn, filename$
close #sn

input #1, lenth$
lenth = val(lenth$)
doitnow = mkdir(drivess$)
IF err$ = "on" THEN close #2:close #1:err$="":wait
open drivess$+filename$ for output AS #2
text$ = input$(#1, lenth)
print #2, text$
close #2
'IF eof(#1) <> 0 then close #1:return
input #1, blank$
IF blank$ = "NEXT DISK" THEN input #1, nextdisk$:notice "Please insert the next disk to continue setup"
IF blank$ = "NEXT DISK" THEN goto [get.nextdisk]
'IF eof(#1) <> 0 then close #1:return
goto [top2]
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
goto [top2]
end







[options]
'notice "Not yetZ!":wait
print #root.graphicbox1, "spritecollides cors cursor$";
IF cursor$ = "" THEN WAIT
selected$ = cursor$
IF word$(selected$,2) = "" = 0 THEN selected$ = ""
#root.statictext4, selected$
wait
