'############################################
'# Reg System                               #
'# Reg System by Tyler Minard               #
'# Created in 2006                          #
'# Use at your own risk                     #
'############################################

gregname$ = "Tyler"'Type registration name to get numbers/letters from
Print "Starting Regsys..."
gosub [regsys]
print "Highlight all the text and press 'Ctrl+C' to copy."
prompt "Here's your Registration Key: "; regnum$
end

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
print "Translating key: "+gregname$
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

'regnum$ = letter form
'regnum = number form
print "Key Translated!"
close #greg
kill "sys.sys"
return
