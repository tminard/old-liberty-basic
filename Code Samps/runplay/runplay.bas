'############################################
'# Runplay System                           #
'# Runplay System by Tyler Minard           #
'# Created in 2005                          #
'# Use at your own risk                     #
'############################################

[runplay]'This clip runs a 'script' to display a series of bitmaps at the fps given!!!!
'runme$ = "1000 0 0 1.bmp 2.bmp 3.bmp"
'------ =  fps x y bmp1 bmp2 bmp3 etc

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
print #game, "addsprite rp "+rpbmps$;

rpx = val(word$(runme$,2))
rpy = val(word$(runme$,3))
print #game, "spritexy rp ";rpx;" ";rpy
print #game, "cyclesprite rp 1 once"
print #game, "drawsprites"
timer rptime, [rp.draw]
wait

[rp.draw]
rpdid = rpdid + 1
print #game, "drawsprites"
IF rpdid = rpmany THEN timer 0:print #game, "removesprite rp":print #game, "drawsprites":return
wait


