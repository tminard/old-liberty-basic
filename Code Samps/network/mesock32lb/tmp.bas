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




    open "mesock32.dll" for dll as #me
ipaddress$ = "dad"
lng.Port = 23
lng.Timeout = 6000
calldll #me, "OpenA",ipaddress$ As ptr,_
    lng.Port As Long,_
    lng.Timeout As Long, re As Long
    TCPOpen=re
    print re
    
    close #me
end

[doGo]
    th = TCPOpen("192.168.0.1", 43, 60000)
    #main.tb "!contents? txt$"
    lret = TCPPrint(th, txt$)
    sbuffer$ = winstring(TCPReceive(th, 4096, 1))
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

