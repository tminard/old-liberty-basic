'############################################
'# Reg System                               #
'# Reg System by Tyler Minard               #
'# Created in 2006                          #
'# Use at your own risk                     #
'############################################

l1$ = "My Name" 'your name
gosub [is.activ]
IF regok = 0 THEN gosub [reg.me]
IF regok = 1 THEN notice "Registration OK!"
end

[is.activ]
open "registration.txt" for input AS #2
gregname$ = l1$
gosub [regsys]
l1$ = regnum$
input #2, l2$ 'the registration key used with that name
close #2
goto [no.reg]
end

[no.reg]
IF l1$ = l2$ = 0 THEN notice "Invalid Registration!"+chr$(13)+"This program is not licensed to run on this machine!" :regok = 0:return
regok = 1
return

[reg.me]
IF regok = 1 THEN return
IF regok = 0 THEN confirm "This Program is not yet Registered! Register now?";YN$
IF YN$ = "no" THEN return

gregname$ = l1$
gosub [regsys]
notice "Please provide this number so that you can receive your registration key: ";regnum
prompt "Please enter the Registration Key given to you EXACTLY as shown: ";conID$
gregname$ = str$(regnum)
gosub [regsys]
IF conID$ = regnum$ = 0 THEN notice "Invalid key given!":regok = 0:return
'notice regnum



 'run "regedit /e registration.txt ";_
        'chr$(34);"Hkey_Local_Machine\Software\Microsoft\Windows\CurrentVersion",hide
open "registration.txt" for output AS #344
print #344, l1$
close #344

open "tmp.log" for output AS #3
print #3, "registration.txt"
print #3, "box.bmp"
print #3, "en1.bmp"
print #3, "en2.bmp"
print #3, "en3.bmp"
print #3, "man.bmp"
print #3, "mo.bmp"
close #3

open "tmp.log" for input AS #ghjkl
zof$ = "game.dat"
close #ghjkl
kill "tmp.log"

notice "Thank You for Registering!"+chr$(13)+"Registration Successful!"
gosub [is.activ]

return


[regsys]
open "sys.sys" for output AS #greg
print #greg, gregname$
close #greg
open "sys.sys" for input AS #greg
regnum = 0
for gr = 1 to len(gregname$)
   tmpregn = asc(input$(#greg,1))
   tmpregn = tmpregn / 9426.41
   regnum = regnum + tmpregn
next gr
close #greg
regnum$ = right$(str$(regnum),len(str$(regnum)) - 2)
regnum = val(regnum$)
fregnum$ = ""

open "sys.sys" for output AS #greg
print #greg, regnum$
close #greg
open "sys.sys" for input AS #greg
for gr = 1 to len(regnum$)
   tmpregn$ = input$(#greg,1)
   IF tmpregn$ = "1" THEN fregnum$ = fregnum$ + "A"
   IF tmpregn$ = "2" THEN fregnum$ = fregnum$ + "B"
   IF tmpregn$ = "3" THEN fregnum$ = fregnum$ + "C"
   IF tmpregn$ = "4" THEN fregnum$ = fregnum$ + "1"
   IF tmpregn$ = "5" THEN fregnum$ = fregnum$ + "2"
   IF tmpregn$ = "6" THEN fregnum$ = fregnum$ + "3"
   IF tmpregn$ = "7" THEN fregnum$ = fregnum$ + "4"
   IF tmpregn$ = "8" THEN fregnum$ = fregnum$ + "D"
   IF tmpregn$ = "9" THEN fregnum$ = fregnum$ + "0"
   IF tmpregn$ = "." or tmpregn$ = "e" or tmpregn$ = "-" THEN fregnum$ = fregnum$ + "E"
next gr
regnum$ = fregnum$
close #greg
kill "sys.sys"
return

