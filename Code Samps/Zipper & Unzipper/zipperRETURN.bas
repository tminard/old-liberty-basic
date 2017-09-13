'############################################
'# Zipper System                            #
'# Zipper System by Tyler Minard            #
'# Created in 2005                          #
'# Use at your own risk                     #
'############################################

open "tmp.log" for output AS #3
print #3, "registration.txt" 'List all files to add to 'game.dat' (see below)
print #3, "box.bmp"
print #3, "en1.bmp"
print #3, "en2.bmp"
print #3, "en3.bmp"
print #3, "man.bmp"
print #3, "mo.bmp"
close #3

open "tmp.log" for input AS #ghjkl
zof$ = "game.dat" 'Zip files to this file
gosub [zipper]
close #ghjkl
kill "tmp.log"
end


[zipper]
filesfound = 1
open zof$ for output AS #3
doing = 3
'filedialog "Open a file", "*.*", file$
word = 1
line input #ghjkl, file$
[top3]
'test$ = right$(file$, (len(file$)-doing))
'gosub [isvailedname]
IF testok$="no"then doing=doing+1:goto[top3]:end
IF trim$(file$) = "" THEN close #3:end
print #3, "1"
print #3,""
[input]
open file$ for input as #4
'file$=test$
doit = lof(#4)
text$ = input$(#4,doit)
close #4

print #3, file$
print #3, doit
print #3, text$
close #3
filesfound = filesfound + 1
'confirm "Anymore files?";tmp$
word = word + 1 :IF eof(#ghjkl) <> 0 THEN tmp$ = "no"
IF tmp$ = "no" THEN open zof$ for append AS #3:print #3, "endall":close #3:tmp$ = "":return
open zof$ for append AS #3
file = file + 1
line input #ghjkl, file$
IF trim$(file$) = "" THEN close #3:end
[top.b]
'test$ = right$(file$, (len(file$)-doing))
'gosub [isvailedname]
IF testok$="no"then doing=doing+1:goto[top.b]:end
'file$ = "noracc";file;".txt"
goto [input]
end

[isvailedname]
testok$ = ""
'IF len(test$) > 1000 THEN notice "Please change your user name so that it is UNDER 1000 characters long!":return
open "i.tmp" for output as #testme
print #testme, test$
close #testme
open "i.tmp" for input as #testme
for i = 1 to 1000
IF eof(#testme) <> 0 then exit for
tmp$ = input$(#testme, 1)
IF tmp$ = "*" or tmp$ = ":" or tmp$ = "/" or tmp$ = "\" or tmp$ = "?" or tmp$ = ">" or tmp$ = "<" or tmp$ = "|" or tmp$ = chr$(34) then testok$ = "no":exit for': notice "Invailed user name! Please change some characters!":exit for
next i
close #testme
kill "i.tmp"
return



[functions]
dim info$(100,10)
FUNCTION fileExists(path$, filename$) ' Does file exist?
    files path$, filename$, info$(
    fileExists = val(info$(0, 0)) > 0
END FUNCTION

