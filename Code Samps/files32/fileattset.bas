FILE.ATTRIBUTE.ARCHIVE = hexdec("&H20")
FILE.ATTRIBUTE.DIRECTORY = hexdec("&H10")
FILE.ATTRIBUTE.HIDDEN = hexdec("&H2")
FILE.ATTRIBUTE.NORMAL = hexdec("&H80")
FILE.ATTRIBUTE.READONLY = hexdec("&H1")
FILE.ATTRIBUTE.SYSTEM = hexdec("&H4")
FILE.ATTRIBUTE.TEMPORARY = hexdec("&H100")

open "test.txt" for append as #t
print #t, "Sample"
close #t

filename$="test.txt"
atts=FILE.ATTRIBUTE.HIDDEN

open "kernel32" for dll as #kernel
calldll #kernel, "SetFileAttributesA",_
    filename$ as ptr,_
    atts as long,_
    result as boolean
close #kernel

print result
end


