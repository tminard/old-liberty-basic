dim branch$(100,100)
debug = 1
'CommandLine$ = "openout=C:\save.txt=blue,white,Tyler Minard,YCPWF"
IF trim$(CommandLine$) = "" THEN CommandLine$ = "C=Documents and Settings\Tyler Minard\Desktop\install.set"
IF trim$(CommandLine$) = "" = 0 THEN gosub [load.com]
goto [load.datafile]
end


[load.datafile]
dim name$(1000)
open "chart.txt" for input AS #chart
gosub [load.branches]
'gosub [print.branches]
'gosub [load.stuff]
cls
goto [prompt.goto]
end

[prompt.goto]
IF fgh = 0 THEN input "list goto ([*]):"; goto$
goto [prompt.difcom]
end

[prompt.difcom]
IF lower$(goto$) = "end" THEN end
IF goto$ = "?" THEN goto [show.all]
IF lower$(goto$) = "cls" THEN cls:goto [prompt.goto]
ok = 0
for i = 1 to branches
IF "["+goto$+"]" = branch$(i, 0) THEN ok = 1:exit for
next i
IF ok = 0 THEN print "'["+goto$+"]' is an invalid branch name!":cls:goto [load.datafile]:end
cls
goto$ = "["+goto$+"]"
gosub [goto]
gotoend = 0
for i = 1 to 100000
line input #chart, listext$
IF lower$(word$(listext$ ,1,"=")) = "openout" THEN open word$(listext$,2,"=") for output AS #of:print #of, word$(listext$,3,"="):close #of:print "Command OK!"
IF lower$(word$(listext$ ,1,"=")) = "notice" then notice word$(listext$,2,"=")
IF lower$(word$(listext$ ,1,"=")) = "run" THEN run word$(listext$,2,"=")
IF lower$(word$(listext$,1,"=")) = "comm" THEN goto$ = word$(listext$,2,"="):gotoend = 1:exit for
IF listext$ = "end" THEN exit for
print listext$
next i

IF gotoend = 1 THEN close #chart:print "--Done!--":goto [prompt.difcom]
close #chart
if fgh = 1 then end
print "--Done!--"
goto [prompt.goto]
end




[load.branches]
branches = 0
for i = 1 to 10000
IF eof(#chart) <> 0 THEN exit for
line input #chart, text$
IF right$(text$, 1) = "]" AND left$(text$, 1) = "[" THEN branches = branches + 1: branch$(branches, 0) = text$:branch$(branches,1) = str$(i)
next i
close #chart
return

[print.branches]
for i = 1 to branches
print branch$(i,0)
print branch$(i,1)
next i
return


[goto]
for i = 1 to branches
IF branch$(i,0) = goto$ THEN exit for
next i

IF branch$(i,0) = goto$ = 0 THEN print "Error! Branch ["+goto$+"] not found!"
gt = val(branch$(i,1))
open "chart.txt" for input AS #chart
for i = 1 to gt
line input #chart, blank$
next i

return


[load.stuff]
goto$ = "[people]"
gosub [goto]
line input #chart, num
print "People:"; num
close #chart
goto$ = "[names]"
gosub [goto]
for i = 1 to num
line input #chart, name$(i)
print "Name:"+ name$(i)
next i
close #chart
return


[show.all]
cls
print "--Branches--"
for i = 1 to branches
print branch$(i,0)
next i
print "-----------"
goto [prompt.goto]
end


[load.com]
IF lower$(word$(CommandLine$ ,1,"=")) = "openout" THEN open word$(CommandLine$,2,"=") for output AS #of:print #of, word$(CommandLine$,3,"="):close #of:print "Command OK!":end
IF lower$(word$(CommandLine$,1)) = "add" THEN open "chart.txt" for append AS #1:open word$(CommandLine$,2) for input AS #45:e45e = lof(#45):e$ = input$(#45, e45e):close #45:print #1, word$(CommandLine$,3):print #1, e$:print #1, "end":close #1:print "Command OK!"
IF lower$(word$(CommandLine$,1,"=")) = "comm" THEN goto$ = word$(listext$,2,"="):fgh = 1
return



print word$(CommandLine$, 1,"=")+":\"+word$(CommandLine$, 2,"=")
open word$(CommandLine$, 1,"=")+":\"+word$(CommandLine$, 2,"=") for input AS #1
lenotxt = lof(#1)
gettxt$ = input$(#1, lenotxt)
close #1
open "prog.pak" for output AS #2
print #2, gettxt$
close #2
gosub [extract.data]
return

[functions]
FUNCTION fileExists(path$, filename$) ' Does file exist?
dim info$(1000,10)
    files path$, filename$, info$(
    fileExists = val(info$(0, 0)) > 0
END FUNCTION

[extract.data]
open "prog.pak" for input AS #1
input #1, file
input #1, pass$
goto [top2]
end

[top2]
IF err$ = "on" THEN close #1:err$="":wait
input #1, filename$
IF filename$ = "endall" or lenth$ = "endall" THEN close #1:return
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
goto [top]
end

