onmap$ = "map1"
print "Loading map config..."
gosub [load.fileop]
print "OK"
print "Loading Bitmaps..."
gosub [loadbmp]
print "OK"
print "Exicuting Script(s)..."
gosub [exec]
print "OK"
print "Load done."
end

[exec]
for i = 1 to exec
  call runme exec$(i)
next i
return

  sub logToFile logString$
    open "event.log" for append as #event
    print #event, time$()
    print #event, logString$
    close #event
  end sub

  sub runme runme$
    print " Script: Exec script "+runme$
    open runme$ for input AS #rn
    for p = 1 to 100000
      IF eof(#rn) <> 0 THEN exit for
       line input #rn, runtxt$
         select case lower$(word$(runtxt$,1,"*"))
           case "addsprite"
                IF graphopen = 0 then print "Cannot add sprite without a graphic window!"':end select
                print " Script: Added Sprite '"+word$(runtxt$,2,"*")+ "' with bitmap(s): "+word$(runtxt$,3,"*")
                IF graphopen = 1 then print #gw, "addsprite "+word$(runtxt$,2,"*")+ " "+word$(runtxt$,3,"*")
            case "openg"
                   print " Script: Opened main window"
                   IF graphopen = 0 THEN open word$(runtxt$,2,"*") for graphics_nsb AS #gw:graphopen = 1
                   'print #gw, "trapclose [kilgw]"
            case "closeg"
                 IF graphopen = 1 THEN close #gw
                 graphopen = 0
                 print " Script: Closed main window"
            case "wait"
                  print " Script: Waiting on timer for ";val(word$(runtxt$,2,"*"));" seconds..."
                  dotime = val(word$(runtxt$,2,"*")+"000")';"000"
                  timer dotime, [wait.over]
                  wait
                  [wait.over]
                  timer 0
            case else
                IF trim$(lower$(word$(runtxt$,1,"*"))) = "" = 0 AND left$(lower$(word$(runtxt$,1,"*")),2) = "//" = 0 AND left$(lower$(word$(runtxt$,1,"*")),1) = "'" = 0 THEN print "Error: Command "+runtxt$+" not understood!"
             end select
         next p
      close #rn
  end sub



[loadbmp]

for i = 1 to bmp
  bimpname$ = word$(bmp$(i),2,";")
  bimppath$ =  word$(bmp$(i),1,";")
  'notice bimppath$
 loadbmp bimpname$, bimppath$
 print " Loaded '"+bimppath$+ "' as "+bimpname$
next i
return

[load.fileop]
open onmap$+".cfg" for input AS #1
gosub [get.line]
dim object$(1000)
dim bmp$(1000)
dim control$(1000)
dim onhit$(1000)
dim otherhit$(1000)
dim cfile$(1000)
gosub [fill.in]
close #1
'print control$(3)
return

[fill.in]
IF eof(#1) <> 0 THEN return
IF trim$(txtline$) = "" THEN line input #1, txtline$:goto [fill.in]
IF left$(txtline$,1) = "$" THEN obj = obj + 1:object$(obj) = right$(txtline$,len(txtline$)-1):control$(obj) = "NULL":onhit$(obj)   = "NULL":otherhit$(obj)  = "NULL":cfile$(obj)  = "NULL"
select$ = word$(txtline$,1,"=")
select case select$
    case "bmp"
        bmp = bmp + 1
        'IF bmp$(bmp) = "NULL" THEN bmp$(bmp) = ""
        bmp$(bmp) = word$(txtline$,2,"=")
      '  notice word$(txtline$,2,"=")
    case "control"
        control$(obj) = word$(txtline$,2,"=")
    case "onhit"
        onhit$(obj) = word$(txtline$,2,"=")
    case "otherhit"
        otherhit$(obj) = word$(txtline$,2,"=")
    case "cfile"
        cfile$(obj) = word$(txtline$,2,"=")
    case "exec"
    exec = exec + 1
        exec$(exec) = word$(txtline$,2,"=")
     case else
       IF trim$(txtline$) = "" = 0 AND txtline$ = "ENDOBJECT" = 0 AND left$(txtline$,1) = "$" = 0 THEN print "     Load Error: Command "+txtline$+" not understood."
end select
'obj = obj + 1
line input #1, txtline$
goto [fill.in]
end

'notice object$(obj)


[get.line]
line input #1, txtline$
IF left$(txtline$,3) = "REM" or left$(txtline$,2) = "//" THEN goto [get.line]
return

[kilgw]
IF graphopen = 1 THEN close #gw
graphopen = 0
wait
