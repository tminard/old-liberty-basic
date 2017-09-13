filedialog "Open","*.txt",file$
if file$="" then end

SEEMASKNOCLOSEPROCESS = 64 '0x40

Struct s,_
cbSize as long,_
fMask as long,_
hwnd as long,_
lpVerb$ as ptr,_
lpFile$ as ptr,_
lpParameters$ as ptr ,_
lpDirectory$ as ptr,_
nShow as long,_
hInstApp as long,_
lpIDList as long,_
lpClass as long,_
hkeyClass as long,_
dwHotKey as long,_
hIcon as long,_
hProcess as long

s.cbSize.struct=len(s.struct)
s.fMask.struct=SEEMASKNOCLOSEPROCESS
s.hwnd.struct=0
s.lpVerb$.struct="Open"
s.lpFile$.struct=file$
s.lpParameters$.struct=""
s.lpDirectory$.struct=DefaultDir$
s.nShow.struct=_SW_RESTORE

calldll #shell32 , "ShellExecuteExA",_
s as struct,r as long

if r<>0 then
    hProcess=s.hProcess.struct
else
    print "Error."
    end
end if

waitResult=-1
while waitResult<>0
calldll #kernel32, "WaitForSingleObject",_
hProcess as long,0 as long,_
waitResult as long
wend

print "Launched process has ended"
END
