'// Some default commands in main data files
dim load$(1000)
dim frame$(1000)

'// Frame commands and stuff
dim walk$(100,10) 'supports up to 10 images
dim jump$(100,10)
dim plain$(100,5)
dim die$(100,10)
dim grave$(100,10)
dim still$(100,5)
dim other$(100,1)
'//EODIM\\
mainwcf$ = "main.wsf"

open mainwcf$ for input AS #mainf
line input #mainf, loadwcf$
close #mainf

open "WORMS" for graphics_nsb as #worms

open loadwcf$ for input AS #loadwcf
for tmp = 1 to 1000
 line input #loadwcf, tmp$
  'show/load/frame
    IF tmp$ = ":frame" then gosub [load.frame]
    IF tmp$ = ":load" then gosub [load.load]
    IF tmp$ = ":show" then gosub [load.show]
    IF tmp$ = "EOF" then exit for
next tmp
close #loadwcf
gosub [save.loaded]
gosub [load.everything]
'//READY!!
wait

[save.loaded]
open "load.log" for output AS #logworms
print #logworms, ":FRAME"
 for logit = 1 to 1000
  IF frame$(logit) = "" then exit for
  print #logworms, frame$(logit)
 next logit
print #logworms, ":LOAD"
 for logit = 1 to 1000
  IF load$(logit) = "" then exit for
  print #logworms, load$(logit)
 next logit
close #logworms
print "Saved list to load.log"
return

[load.frame]
for framlo = 1 to 1000
 line input #loadwcf, frameload$
 IF instr(frameload$,"EOF") or instr(frameload$,":") then exit for
 IF trim$(frameload$) = "" = 0 then framefiles = framefiles + 1:frame$(framefiles) = frameload$
next framlo
return

[load.show]
line input #loadwcf, loadingbmp$
loadbmp loadingbmp$, loadingbmp$
print #worms, "drawbmp "+loadingbmp$
print #worms, "flush"
unloadbmp loadingbmp$
return

[load.load]
for loadload = 1 to 1000
 line input #loadwcf, loadload$
 IF trim$(loadload$) = "" then exit for
 IF instr(loadload$,"EOF") or instr(loadload$,":") then exit for
 IF trim$(loadload$) = "" = 0 then loadfiles = loadfiles + 1:load$(loadfiles) = loadload$
next loadload
return

'// OK! We now have a list of files to be processed! Now lets begin!
[load.everything]'sub
'load$/frame$
for loadload = 1 to 1000
 IF load$(loadload) = "" then exit for
 loadbmps$ = load$(loadload)
 gosub [loadbmps]
next loadload
return

[loadbmps]
open loadbmps$ for input AS #loadbmps
for loadbmps = 1 to 1000
 IF eof(#loadbmps) <> 0 then exit for
 line input #loadbmps, loadbmpst$
 IF loadbmpst$ = "EOF" THEN exit for
  spritename$ = word$(loadbmpst$,1,"=")
  spritebit$ = word$(loadbmpst$,2,"=")
  loadbmp spritename$, spritebit$
next loadbmps
close #loadbmps
return
