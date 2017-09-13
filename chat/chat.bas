'NOTE: This program was created with Just Basic! It will run in LB.
wav1$ = "click20B.wav"' main button clicks
wav2$ = "beep1A.wav"
goto [top]
end

[top]
IF fileExists("","logon.dat") THEN goto [load.dat]
input "Enter server name or IP address: ";cname$
IF trim$(cname$) = "" THEN end
gosub [con.ser]
IF returnval = 0 then input "> "; exit$:end
input "Enter your name: ";name$
IF trim$(name$) = "" THEN end
input "Enter your Address: ";address$
IF trim$(name$) = "" THEN end
input "Save information? 'y' or other: ";saveme$
IF lower$(saveme$) = "y" THEN gosub [save]
server$ = cname$
workingdir$ = "\\"+server$+"\chat"
IF fileExists(workingdir$,address$+".acc") = 0 THEN gosub [add.acc]
print "Chat server located at: "+workingdir$
IF fileExists(workingdir$,address$+".inbox") = 0 THEN gosub [create.in]
gosub [set.online]
gosub [main]
timer 1000, [refresh]
wait

[save]
open "logon.dat" for output AS #gDat
print #gDat, cname$
print #gDat, name$
print #gDat, address$
close #gDat
return

[load.dat]
open "logon.dat" for input AS #gDat
line input #gDat, cname$
line input #gDat, name$
line input #gDat, address$
close #gDat
gosub [con.ser]
IF returnval = 0 then print "A server on "+cname$+" was not found!":gosub [prompt.server]:gosub [save]
server$ = cname$
workingdir$ = "\\"+server$+"\chat"
IF fileExists(workingdir$,address$+".acc") = 0 THEN gosub [add.acc]
print "Chat server located at: "+workingdir$
IF fileExists(workingdir$,address$+".inbox") = 0 THEN gosub [create.in]
gosub [set.online]
gosub [main]
timer 1000, [refresh]
wait

[prompt.server]
input "Enter server name or IP address: ";cname$
IF trim$(cname$) = "" THEN end
gosub [con.ser]
IF returnval = 0 then input "> "; exit$:end
return

[con.ser]
returnval = 0
print "Connecting to server, Please wait..."
IF fileExists("","\\"+cname$+"\chat\server.stat") = 0 THEN print "Chat server not found on remote machine.":returnval = 0:gosub [find]:return
returnval = 1
print "OK!"
return

[find]
print "Scanning for any avalible servers..."
cname$ = "192.168.1."
for gS = 1 to 255
IF fileExists("","\\"+cname$;gS;"\chat\server.stat") THEN returnval = 1:print " - Server found at "+cname$;gS:cname$ = cname$;gS:return
next gS
return

[chHost]
chH$ = cname$
prompt "Enter host name or ip address: \\";chH$
IF fileExists("","\\"+chH$+"\chat\server.stat") = 0 THEN notice "Chat server not found on remote machine.":wait
cname$ = chH$
gosub [save]
confirm "Restart?";yn$
IF yn$ = "no" then wait
timer 0
gosub [clear.set]
close #main
goto [top]
end

[create.in]
open workingdir$+"\"+address$+".inbox" for output AS #cIn
print #cIn, "$%Welcome to LibChat!$%"
print #cIn, "$%Welcome "+name$+"! You are signed in as "+address$+"$%"
close #cIn
return

[add.acc]
print "An account with that name was not found on the server. Creating..."
open workingdir$+"\"+address$+".acc" for output AS #cAc
close #cAc
return

[log.using]
open workingdir$+"\"+address$+".using" for output AS #lUs
close #lUs
return

[rm.using]
kill workingdir$+"\"+address$+".using"
return

[refresh]
if fileExists(workingdir$,address$+".using") THEN wait
gosub [log.using]
IF fileExists(workingdir$,address$+".online") = 0 THEN print "You have been disconnected. Good Bye!":open workingdir$+"\"+address$+".online" for output AS #reCon:close #reCon
open workingdir$+"\"+address$+".inbox" for input AS #gMail
gText = lof(#gMail)
text$ = input$(#gMail,gText)
text$ = word$(text$,2,"$%")
IF len(text$) > 13 then text$ = left$(text$,len(text$)-2)
IF trim$(text$) = "" = 0 THEN print #main.g1, word$(text$,1,"-"):print #main.g1, word$(text$,2,"-")
If trim$(text$) = "kick" THEN close #gMail:gosub [clear.in]:gosub [rm.using]:notice "You have been disconnected by the administrator":goto [quit.main]
close #gMail
gosub [clear.in]
gosub [rm.using]
wait

[clear.in]
open workingdir$+"\"+address$+".inbox" for output AS #clearI
close #clearI
return

[clear.set]
if fileExists(workingdir$,address$+".inbox") THEN kill workingdir$+"\"+address$+".inbox"
if fileExists(workingdir$,address$+".using") THEN kill workingdir$+"\"+address$+".using"
if fileExists(workingdir$,address$+".online") THEN kill workingdir$+"\"+address$+".online":print "You have been disconnected"
return

[set.online]
print "Logging in..."
if fileExists(workingdir$,address$+".online") THEN notice "A user with your name is online!":kill workingdir$+"\"+address$+".online":goto [set.online]
open workingdir$+"\"+address$+".online" for output AS #setOn
close #setOn
print " You are online!"
return




[send]
playwave wav1$,async
#main.t1, "!contents? sendtxt$"
IF trim$(sendtxt$) = "%1cls" then print #main.t1, "!cls":wait
IF trim$(sendtxt$) = "%2cls" then print #main.g1, "!cls":wait

#main.tb1, "!contents? sendto$"
IF instr(sendto$,"*") or instr(sendto$,"/") or instr(sendo$,"\") then wait
print " - Sending mail to "+sendto$
IF trim$(sendto$) = "" then wait
IF fileExists(workingdir$,sendto$+".inbox") = 0 THEN notice "No such user was found!":wait
IF fileExists(workingdir$,sendto$+".using") THEN [send]
open workingdir$+"\"+sendto$+".using" for output AS #oM
close #oM
open workingdir$+"\"+sendto$+".inbox" for output as #sMail
print #sMail, "$%"+name$+" says - "+sendtxt$+"$%"
close #sMail
kill workingdir$+"\"+sendto$+".using"
print #main.t1, "!cls"
'print #main.g1, "You said - "+sendtxt$
print "Mail Sent!"
wait

[chName]
chname$ = name$
prompt "Enter a new name: ";chname$
IF trim$(chname$) = "" THEN wait
name$ = chname$
IF fileExists("","logon.dat") then gosub [save]
wait

[main]

    '-----Begin code for #main


    WindowWidth = 430
    WindowHeight = 500
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    texteditor #main.g1,   5,  27, 410, 190
    TexteditorColor$ = "white"
    texteditor #main.t1,  10, 237, 405, 110
    'statictext #main.statictext2, "Chat Window",   5,   5,  78,  20
    statictext #main.statictext3, "-----------------------------------------------------------------------------------------------------------------------------------------",  -5, 222, 490,  15
    button #main.button6,"Send",[send], UL, 320, 357,  82,  25
    statictext #main.statictext7, "Send To:",   5, 360,  60,  20
    TextboxColor$ = "white"
    textbox #main.tb1,  65, 357, 220,  25
    button #main.button9,"Send To All...",[sendall], UL,   0, 417,  89,  25
    button #main.button10,"Quit",[quit.main], UL, 350, 417,  65,  25
    statictext #main.statictext11, "Program Copyright (c) 2006 by Tyler Minard", 100, 422, 230,  20

    '-----End GUI objects code

    '-----Begin menu code

    menu #main, "Edit"  ' <-- Texteditor menu.
    menu #main, "&User", "&Change Name", [chName],|, "&Change Host", [chHost]


    '-----End menu code

    open "LBNC v1.1: Signed in as "+address$ for window as #main
    print #main, "font ms_sans_serif 10"
    print #main.statictext11, "!font ms_serif 8 bold"
    print #main, "trapclose [quit.main]"


[main.inputLoop]   'wait here for input event
    return

[quit.main]
playwave wav2$,async
timer 0
gosub [clear.set]
close #main
end


function fileExists(path$, filename$)
dim info$(1000,10)
files path$, filename$, info$()
fileExists = val(info$(0, 0))  'non zero is true
end function

