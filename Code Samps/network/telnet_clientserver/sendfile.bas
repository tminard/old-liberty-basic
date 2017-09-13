'simple smtp client
WindowWidth = 480 : WindowHeight = 500
open "mesock32.dll" for dll as #me

statictext  #main, "To:", 5,5,40,20
statictext  #main, "From:", 5,30,40,20
statictext  #main, "Subject:", 5,55,40,20
button      #main.default, "Send",[send],UL, 345, 420, 105, 25
textbox     #main.to, 50, 5, 350, 20
textbox     #main.fr, 50, 30, 350, 20
textbox     #main.su, 50, 55, 350, 20
texteditor  #main.te, 10, 100, 460, 300

Open "Mesock32.DLL SMTP Demo" for window as #main
print #main, "trapclose [quit]"

wait

[quit]
close #main
close #me
end

[send]
#main.to "!contents? t0$"
#main.fr "!contents? fr$"
#main.su "!contents? su$"
#main.te "!contents? body$"
at=instr(t0$,"@")
server$=right$(t0$,len(t0$)-at)
print "Connecting To Server:"; server$
th = TCPOpen(server$, 25)
print "TCP Handle Opened: ";th
recvd$=TCPReceive$(th)
print "GET: ";recvd$
txt$="HELO "+server$
gosub [put]
txt$="MAIL FROM:<"+fr$+">"
gosub [put]
txt$="RCPT TO:<"+t0$+">"
gosub [put]
txt$="DATA"
gosub [put]
txt$="SUBJECT: "+su$
gosub [put]
txt$=body$
gosub [put]
txt$="."
gosub [put]
wait

[put]
lret = TCPPrint(th, txt$)
print "PUT: ";txt$
recvd$=TCPReceive$(th)
print "GET: ";recvd$
return
