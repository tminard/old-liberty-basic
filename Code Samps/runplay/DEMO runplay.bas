open "runplay" for graphics_nsb as #mrp
print #mrp, "trapclose [end]"
runme$ = "1000 0 0 1.bmp 2.bmp 3.bmp"
gosub [runplay]
wait


[end]
close #mrp
end

[runplay]
rpmany = 0
rpdid = 0
rptime = val(word$(runme$,1))
rpbmps$ = ""
for rp =4 to 1000
IF trim$(word$(runme$,rp)) = "" THEN exit for
rpmany = rpmany + 1
loadbmp word$(runme$,rp), word$(runme$,rp)
rpbmps$ = rpbmps$ + " "+word$(runme$,rp)
next rp

notice rpbmps$
print #mrp, "addsprite rp "+rpbmps$;

rpx = val(word$(runme$,2))
rpy = val(word$(runme$,3))
print #mrp, "spritexy rp ";rpx;" ";rpy
print #mrp, "cyclesprite rp 1 once"
print #mrp, "drawsprites"
timer rptime, [rp.draw]
wait

[rp.draw]
rpdid = rpdid + 1
print #mrp, "drawsprites"
IF rpdid = rpmany THEN timer 0:print #mrp, "removesprite rp":print #mrp, "drawsprites":return
wait

