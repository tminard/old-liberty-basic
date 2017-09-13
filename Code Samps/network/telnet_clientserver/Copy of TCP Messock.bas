    nomainwin
    WindowWidth = 476
    WindowHeight = 286
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    TexteditorColor$ = "white"
    texteditor #mai.output,   5,   5, 459, 180
    TextboxColor$ = "white"
    textbox #mai.input,   5, 188, 460,  25
    button #mai.button3,"Send",[send], UL,   4, 212, 462,  25
    menu #mai, "File",_
                "Connect To LB Server", [connect],_
                "Exit", [quit.main]
    menu #mai, "Edit"
    open "Kc Instant Messenger" for window as #mai
    print #mai, "font ms_sans_serif 10"
    print #mai, "trapclose [quit.main]"

    print #mai, "resizehandler [resize]"
open "mesock32.dll" for dll as #me

[loop]
scan
    CallDLL #kernel32, "Sleep", _
        10 As Long, _
        rc As Void
scan
if connect = 1 then
scan

let rec$ = ""
scan
let rec$ = TCPReceive$(handle)
scan
if rec$ <> "" then print #mai.output, rec$
        scan
end if
scan
goto [loop]


[connect]
'if connect = 1 then
'func = TCPClose(handle)
'let connect = 0
'end if
Prompt "Screen Name:";sn$
Prompt "Ip Address Of Server:";address$
let port = 23
let handle = TCPOpen(address$,port)
let connect = 1
goto [loop]
[send]

if connect = 1 then
print #mai.input, "!contents? text$"
if text$ <> "" then
print #mai.input, ""
let text$ = trim$(text$)
let text$ = sn$;": ";text$
let func = TCPSend(handle,text$)
end if
end if
goto [loop]
    wait

[resize]
print #mai.output, "!locate 5 5 ";WindowWidth-10;" ";WindowHeight-101
print #mai.input, "!locate 5 ";WindowWidth-7;" ";WindowWidth-10;" 25"
print #mai, "refresh"
goto [loop]



[quit.main]
if connect = 1 then let func = TCPClose(handle)
    close #mai
    close #me
    end




wait
''''Function TCPOpen()''''''''''
Function TCPOpen(address$,Port)
print #mai.output, "Try To Connect To ";address$;"..."
Timeout=1000
calldll #me, "Open", address$ As ptr,_
Port As Long,_
Timeout As Long, re As Long
TCPOpen=re
if re = 0 then print #mai.output, "Connection To Server Failed!"
End Function

''''Function TCPReceive$()''''''''''
Function TCPReceive$(handle)
buffer=4096
all=0
calldll #me, "ReceiveA" ,handle As Long,_
buffer As Long,_
all As Long, re As long
if re<>0 then TCPReceive$ = winstring(re)
End Function

''''Function TCPPrint()''''''''''
Function TCPSend(handle,text$)
calldll #me, "PrintA", handle As Long,_
text$ As ptr,re As Long
TCPPrint=re
End Function

''''Function TCPClose()''''''''''
Function TCPClose(handle)
calldll #me, "CloseA",handle As Long,_
TCPClose As Long
End Function
