print "This program 'compresses' files together. The extraction process if faster then"
print "the compression process. I can reverse this if you'd like."
print "Program copyright (C) 2006 by Adelphos Pro/SmartScript.Inc"
print "All rights reserved"
'Hey guys! In case U.R. wondering, SmartScript.Inc is another name that Im looking at.
prompt "'1' to create and '2' to extract: ";QA$
IF QA$ = "1" THEN [create]
IF QA$ = "2" THEN [extr]
END


[create]
filedialog "Open a file to compress", "*.*", fileName$
comit$ = fileName$
for i = 1 to 10000
filedialog "Open a file to compress", "*.*", fileName$
IF fileName$ = "" THEN exit for
comit$ = comit$ +"@"+fileName$
next i
filedialog "Save new file as", "*.adl", saveName$
IF saveName$ = "" THEN end
call CreatePk comit$,saveName$
notice "Done!"
'print GetShortName$("C:\txt.txt")
end

[extr]
filedialog "Open the file to extract from", "*.*", fileName$
IF fileName$ = "" THEN end
call ExtractPk fileName$
notice "Done!"
end

sub CreatePk usefiles$, saveas$
open saveas$ for output AS #saving
   'usefiles$ = "1.txt@2.txt@my bmp.bmp
     for onf = 1 to 10000
       fn$ = word$(usefiles$,onf,"@")
       IF fn$  = "" THEN exit for
       'else'
        open fn$ for input AS #ctp
         tlof = lof(#ctp)
         ctxt$ = input$(#ctp,tlof)
         close #ctp
         fn$ = GetShortName$(fn$)
         print #saving, fn$
         print #saving, tlof
         print #saving, ctxt$
     next onf
close #saving
end sub

sub ExtractPk Extractfrom$
open Extractfrom$ for input AS #exbmp
  for epk = 1 to 10000
    IF eof(#exbmp) <> 0 THEN exit for
     line input #exbmp, sfile$
     line input #exbmp, slen$
     slen = val(slen$)
     open sfile$ for output AS #openit
     stxt$ = input$(#exbmp,slen)
     print #openit, stxt$
     close #openit
     line input #exbmp, blank$
   next epk
close #exbmp
end sub

function GetShortName$(txt$)
  for gsn = 1 to 10000
   seetxt$ = right$(txt$,1)
    IF seetxt$ = "\" THEN exit for
   fulltxt$ = seetxt$ + fulltxt$
   txt$ = left$(txt$,len(txt$)-1)
  next gsn
 GetShortName$ = fulltxt$
end function
