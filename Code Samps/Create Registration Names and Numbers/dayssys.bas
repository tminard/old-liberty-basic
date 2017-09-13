




'This system checks to see if a programs run time (in days) has expired!
[see.tim]
WinSysDir$ = GetSystemDirectory$()

gotim$ = ""
timtimeup$ = ""
oktimdo$ = ""
IF fileExists(WinSysDir$, "\ciadvde.ocx") THEN [skip.seetim]
open WinSysDir$+"\ciadvde.ocx" for output AS #lefttim
print #lefttim, date$("days")
close #lefttim
goto [skip.seetim]
end
[skip.seetim]
open WinSysDir$+"\ciadvde.ocx" for input AS #lefttim
input #lefttim, today$
close #lefttim
itim = val(today$) + 12
IF date$("days") > itim THEN notice "Your Time has expired!":goto [print.end.trick.tim]:end
IF fileExists(WinSysDir$, "\CFFtpinc.dll") = 0 THEN gosub [tim.wel]
open WinSysDir$+ "\CFFtpinc.dll" for input AS #isoktim
IF eof(#isoktim) <> 0 THEN notice "Your Time has expired!":close #isoktim:goto [print.end.trick.tim]:end
input #isoktim, olddate
close #isoktim
IF olddate > date$("days") THEN notice "Your Time has expired!":goto [print.end.trick.tim]:end   'Check to see if com's time has been edited!
[print.end.tim]
'If program gets here, then the user has time left!
timstring$ = "You have "+ str$(itim - date$("days"))+" days left for evaluation!"
gosub [notice.days.tim]
open WinSysDir$+ "\CFFtpinc.dll" for output AS #rectim
print #rectim, date$("days")
close #rectim
IF gotim$ = "NO" THEN end
'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!Link here to your program!!!!!!!!!!!!!!!!!!!
'goto [myprog]
end

[print.end.trick.tim]
open WinSysDir$+ "\CFFtpinc.dll" for output AS #rectim
print #rectim, val(date$("days")) + 100
close #rectim
timtimeup$ = "YES"
gosub [notice.days.tim]
end
'print "D"
end

[notice.days.tim]
IF timtimeup$ = "YES" THEN timstring$ = "Time up!"
IF timtimeup$ = "YES" THEN timbutton$ = "Register!": breglen = 70
IF timtimeup$ = "YES" = 0 THEN timbutton$ = "O&k!": breglen = 55
nomainwin
    WindowWidth = 380
    WindowHeight = 155
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
statictext #noticetim.statictext1, timstring$, 110,  42, 9944,  20
    button #noticetim.button2,timbutton$,[days2Clicktim], UL, 260,  87,  breglen,  25
    button #noticetim.button3,"Cancel",[days3Clicktim], UL,  15,  87,  60,  25
stylebits #noticetim, _DS_CENTER, 0, 0, 0
open "Evaluation" for dialog_modal as #noticetim
IF timtimeup$ = "YES" THEN oktimdo$ = "regme"
    print #noticetim, "font ms_sans_serif 10"
    print #noticetim, "trapclose [quit.noticetim]"
[noticetim.inputLoop]   'wait here for input event
    wait

[days2Clicktim]   'Perform action for the button named 'button2'
close #noticetim
IF oktimdo$ = "regme" THEN goto [timdoreg]
   return

[days3Clicktim]   'Perform action for the button named 'button3'
gotim$ = "NO"
close #noticetim
return
[quit.noticetim] 'End the program
    close #noticetim
gotim$ = "NO"
    return

[timdoreg] 'link this to your 'doregistration' program
gotim$ = "NO"

'timtimeup$ = "YES"  = Times Up!
'timtimeup$ = "" = More time!

return

[tim.wel]
open WinSysDir$+ "\CFFtpinc.dll" for output AS #rectim
print #rectim, date$("days")
close #rectim
return



dim info$(100,100)
FUNCTION fileExists(path$, filename$) ' Does file exist?
'1 = yes; 0 = no
    files path$, filename$, info$(
    fileExists = val(info$(0, 0)) > 0
END FUNCTION

Function GetSystemDirectory$()
    WindowsSys$=Space$(200)+Chr$(0)
    CallDLL #kernel32, "GetSystemDirectoryA", WindowsSys$ As Ptr, 200 As Long, result As Long
    GetSystemDirectory$=Trim$(WindowsSys$)
    End Function

'!!!!!!!!!!!!!!!!!!!!!!!!!FIRST TIME RUN!!!!!!!!!!!!!!!!!!!!!!!!!!!!


