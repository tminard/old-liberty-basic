FILE.ATTRIBUTE.ARCHIVE = hexdec("&H20")
FILE.ATTRIBUTE.DIRECTORY = hexdec("&H10")
FILE.ATTRIBUTE.HIDDEN = hexdec("&H2")
FILE.ATTRIBUTE.NORMAL = hexdec("&H80")
FILE.ATTRIBUTE.READONLY = hexdec("&H1")
FILE.ATTRIBUTE.SYSTEM = hexdec("&H4")
FILE.ATTRIBUTE.TEMPORARY = hexdec("&H100")

[again]
filedialog "Open","*.*",filename$
if filename$="" then end

open "kernel32" for dll as #kernel
calldll #kernel, "GetFileAttributesA",_
    filename$ as ptr,_
    ret as long
close #kernel

print "Filename is ";filename$
print "Attributes are:"
if ret and FILE.ATTRIBUTE.ARCHIVE then print "Archive"
if ret and FILE.ATTRIBUTE.DIRECTORY then print "Directory"
if ret and FILE.ATTRIBUTE.HIDDEN then print "Hidden"
if ret and FILE.ATTRIBUTE.NORMAL then print "Normal"
if ret and FILE.ATTRIBUTE.READONLY then print "Readonly"
if ret and FILE.ATTRIBUTE.SYSTEM then print "System"
if ret and FILE.ATTRIBUTE.TEMPORARY then print "Temporary"




