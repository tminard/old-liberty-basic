'############################################
'# Zipper System                            #
'# Zipper System by Tyler Minard            #
'# Created in 2006                          #
'# Use at your own risk                     #
'############################################

filesfound = 1
open "install.set" for output AS #3
doing = 3
filedialog "Open a file", "*.*", file$
[top]
test$ = right$(file$, (len(file$)-doing))
gosub [isvailedname]
IF testok$="no"then doing=doing+1:goto[top]:end
IF trim$(file$) = "" THEN close #3:end
print #3, "1"
print #3,""
[input]
open file$ for input as #4
file$=test$
doit = lof(#4)
text$ = input$(#4,doit)
close #4

print #3, file$
print #3, doit
print #3, text$
close #3
filesfound = filesfound + 1
confirm "Anymore files?";tmp$
IF tmp$ = "no" THEN open "install.set" for append AS #3:print #3, "endall":close #3:end
open "install.set" for append AS #3
file = file + 1
doing = 3
filedialog "Open a file", "*.*", file$
IF trim$(file$) = "" THEN close #3:end
[top.b]
test$ = right$(file$, (len(file$)-doing))
gosub [isvailedname]
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

