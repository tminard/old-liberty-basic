'############################################
'# UnZipper System                          #
'# UnZipper System by Tyler Minard          #
'# Created in 2005                          #
'# Use at your own risk                     #
'############################################

'bmpsat$ = "pk1.pak" 'Name of file to get files from
'gosub [extract.bmps] 'Do it!
'end

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





[functions]
dim info$(100,10)
FUNCTION fileExists(path$, filename$) ' Does file exist?
    files path$, filename$, info$(
    fileExists = val(info$(0, 0)) > 0
END FUNCTION

