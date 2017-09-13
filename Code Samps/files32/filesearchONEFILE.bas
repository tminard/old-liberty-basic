'search for a file, given a filename alone,
'or partial path and filename.

RootPath$="c:\"
'InputPathName$="bmp\copy.bmp" + chr$(0) 'includes partial path
InputPathName$="liberty.exe" + chr$(0)   'filename only
OutputPathBuffer$=space$(1023)+chr$(0)

print "Searching (c:\) for ";InputPathName$
print "Please wait..."

open "imagehlp" for dll as #ih
calldll #ih, "SearchTreeForFile",_
RootPath$ as ptr,_
InputPathName$ as ptr,_
OutputPathBuffer$ as ptr,_
ret as long
close #ih

if ret=0 then
print InputPathName$;" not found."
else
print "Full path is ";trim$(OutputPathBuffer$)
end if
print "Finished"
end
