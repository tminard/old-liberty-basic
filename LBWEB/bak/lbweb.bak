'run "explorer.exe http://www.yahoo.com"

gotoit$ = "www.about.inf"
goto [wait.input]
end

[clear.scr]
cls
return

[standard.ip]
IF left$(ip$,1) = "!" then run "explorer.exe http://"+word$(ip$,2,"!"):print$ ="Internet page loading...":goto [print]
lastip$ = word$(ip$,2,"/")
ip$ = word$(ip$,1,"/")
gosub [clear.scr]
first$=word$(ip$,1,".")
IF fileExists(DefaultDir$,first$+".service") = 0 then print$ = "Invalid Service!":goto [print]

open DefaultDir$+"\"+first$+".service" for input AS #loadser

for i = 1 to 10000
line input #loadser, tmp$
IF tmp$ = "EOF" then nopage = 1:exit for
if word$(tmp$,1,"AS") = trim$(word$(ip$,2,".")+"."+word$(ip$,3,".")) then nopage = 0:exit for
next i
close #loadser

location$ = word$(tmp$,1,"AS")
location$ = word$(location$,2,".")
ip$ = location$+"\"+word$(tmp$,2,"AS")
IF fileExists(DefaultDir$+"\"+ip$,"index.ip") = 0 then nopage = 1
if nopage then print$ = "no page found!":goto [print]
open ip$+"\"+"index.ip" for input AS #getdat
gt = lof(#getdat)
print$ = input$(#getdat,gt)
close #getdat
goto [print]
end


[print]
print "You are looking at: "+first$+"."+word$(tmp$,1,"AS")
print ""
print print$
goto [wait.input]
wait

[wait.input]
IF gotoit$ = "" = 0 then ip$ = gotoit$:gotoit$ = "":goto [standard.ip]
input "> ";ip$
IF ip$ = "close" then end
goto [standard.ip]
end

function fileExists(path$, filename$)

  'dimension the array info$( at the beginning of your program
dim info$(1000,10)
  files path$, filename$, info$()

  fileExists = val(info$(0, 0))  'non zero is true

end function


