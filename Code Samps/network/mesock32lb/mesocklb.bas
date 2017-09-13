'** 3/29/2003 10:24:59 AM
'** Mesock32.DLL Demo
'** Port of VB Demo to Liberty BASIC
'**     by Alyce Watson
'
'** DLL by Terry Reese
'** terry.reese@orst.edu
'Disclaimer:  The code or software is provided free,
'in good faith, as-is, use at your own risk, etc. by the author,
'Terry Reese. By downloading and/or using the code you are agreeing
'to hold the author harmless from all effects and side-effects
'of using said code.


[WindowSetup]
    NOMAINWIN
    WindowWidth = 363 : WindowHeight = 321
    UpperLeftX = INT((DisplayWidth-WindowWidth)/2)
    UpperLeftY = INT((DisplayHeight-WindowHeight)/2)

    open "mesock32.dll" for dll as #me

[ControlSetup]

Menu        #main, "&File" , "E&xit", [quit]
statictext  #main, "IP Address:", 5,5,300,20
button      #main.b, "Go",[doGo],UL, 245, 235, 105, 25
textbox     #main.tb, 1, 25, 350, 30
texteditor  #main.te, 1, 55, 350, 170

Open "Mesock32.DLL Demo" for Window as #main
    print #main, "trapclose [quit]"

[loop]
    Wait

[quit]
    close #me : close #main : END

[doGo]
    th = TCPOpen("192.168.1.104", 23, 60000)
    #main.tb "!contents? txt$"
    lret = TCPPrint(th, txt$)
    i = TCPReceive(th, 4096, 1)
    sbuffer$ = winstring(i)
    lret = TCPClose(th)
    print #main.te, sbuffer$
    print #main.te, "!origin 1 1"
    wait

Function TCPOpen(ipaddress$,lng.Port,lng.Timeout)
    calldll #me, "OpenA",ipaddress$ As ptr,_
    lng.Port As Long,_
    lng.Timeout As Long, re As Long
    TCPOpen=re
    End Function

Function TCPReceive(tcp.handle,lng.buffer,l.all)
    calldll #me, "ReceiveA" ,tcp.handle As Long,_
    lng.buffer As Long,_
    l.all As Long, re As long
    TCPReceive=re
    End Function

Function TCPPrint(tcp.handle,buffer$)
    calldll #me, "PrintA", tcp.handle As Long,_
    buffer$ As ptr,re As Long
    TCPPrint=re
    End Function

Function TCPClose(tcp.handle)
    calldll #me, "CloseA",tcp.handle As Long,_
    TCPClose As Long
    End Function

