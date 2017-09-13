'Test for SMART renaming!
SMARTstring$ = "C:\GameDir\mohaa\"
SMARTblock$ = "%gamedir%"
SMARTreplace$ = "[DATA]\[GAMES]\"
gosub [SMART]
print SMARTfulltxt$
end

[SMART]
SMARTfulltxt$ = ""
smarttmp = 0
fulltxt$ = ""
SMARTexitLoop = 0
while SMARTexitLoop = 0
 smarttmp = smarttmp + 1
  SMARTtmp$ = word$(SMARTstring$,smarttmp,"\")
   IF SMARTtmp$ = "" then SMARTexitLoop = 1
   IF SMARTtmp$ = SMARTblock$ then SMARTcopytxt$ = SMARTreplace$
   IF SMARTtmp$ = SMARTblock$ = 0 then SMARTcopytxt$ = SMARTtmp$
   SMARTfulltxt$ = SMARTfulltxt$ + SMARTcopytxt$
      IF right$(SMARTfulltxt$,1) = "\" = 0 then SMARTfulltxt$ = SMARTfulltxt$ +"\"
wend
return
