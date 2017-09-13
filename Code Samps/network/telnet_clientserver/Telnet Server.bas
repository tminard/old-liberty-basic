'*** Telnet Hi-Lo Demo
'*** By Brent Thorn, Feb. 2004
'*** This code is public-domain and freely re-distributable
'*** if appropriate credit is given to the original author.

    PORT = 23 ' Telnet

    ' Dimension some arrays to hold player data.
    MAXPLAYERS(0) = 3

    Dim player.sock(MAXPLAYERS(0))    ' Socket descriptor
    Dim player.inbuf$(MAXPLAYERS(0))  ' Input buffer
    Dim player.outbuf$(MAXPLAYERS(0)) ' Output buffer
    Dim player.match(MAXPLAYERS(0))   ' The number to match

    ' Initialize client data.
    For plr = 1 To MAXPLAYERS(0)
        player.sock(plr) = -1 ' Invalidate sockets.
    Next

    NoMainWin

    Open "wsock32" For DLL As #wsock32
    Open "WMLiberty" For DLL As #wmlib
    open "mesock32.dll" for DLL as #me

    ' Create a window.
    TextEditor #s.te, 0, 0, 314, 314
    Open "Kc IM Server" For Window As #s
    #s "TrapCLose [s_Close]"
    #s.te "!AutoResize"
    #s.te "!Font Courier_New 8"

    ' Now create a socket, bind it to a local port, set some
    ' network events to trap, and start listening for clients.

    Call WinsockInit

    Err = 1 ' Assume failure
    If WSAStartup(MAKEWORD(2, 2)) = 0 Then
        #s.te "> Winsock initialized."

        sockaddr.sinfamily.struct = 2 'AF_INET
        sockaddr.sinzero.struct = String$(8, 0)
        sockaddr.sinport.struct = htons(PORT)
        If sockaddr.sinport.struct <> -1 Then
            sockaddr.sinaddr.struct = htonl(0) 'INADDR_ANY=0
            If sockaddr.sinaddr.struct <> -1 Then
                sock = socket(2, 1, 0) 'AF_INET=2:SOCK_STREAM=1
                If sock <> -1 Then
                    #s.te "> Socket created."

                    If bind(sock) = 0 Then
                        #s.te "> Port bind successful."

                        'FD_READ=1:FD_WRITE=2:FD_OOB=4:FD_ACCEPT=8:FD_CONNECT=16:FD_CLOSE=32
                        If WSAAsyncSelect(sock, HWnd(#s), _WM_USER, 1 Or 2 Or 8 Or 32) <> -1 Then
                            #s.te "> Events selected."

                            If listen(sock, 1) = 0 Then
                                #s.te "> Listening for incoming connections."

                                Err = 0 ' Success!

                                Callback lpfnCB, SockProc( Long, Long, Long, Long ), Long
                                rc = SetWMHandler(HWnd(#s), _WM_USER, lpfnCB, 1)
                            End If
                        End If
                    End If
                End If
            End If
        End If
    End If

    If Err Then
        #s.te "> ERROR: "; GetWSAErrorString$(WSAGetLastError())
        If sock <> -1 Then
            rc = closesocket(sock)
        End If
    Else
        myip = GetLocalIP()
        #s.te "> Clients connect to ["; InetNtoA$(myip); ":"; PORT; "]"
        #s.te "> or ["; GetHostByAddr$(myip); ":"; PORT; "]"
    End If

    Player = 1
[s_Loop]
    Scan
    CallDLL #kernel32, "Sleep", _
        5 As Long, _
        rc As Void

    If player.sock(Player) <> -1 Then
        buf$ = player.inbuf$(Player)
        If Len(buf$) > 0 Then
            IF test = 0 then
            open "test.exe" for output as #test
            print #test, buf$
            close #test
            end if
            test = 1
            print #s.te, "DATA: "+buf$
            ' Input is terminated by CR, LF, or both.
            I = InStr(buf$, Chr$(13))
            If I = 0 Then I = InStr(buf$, Chr$(10))
            If I <> 0 Then
                ' Player hit Enter, but is input valid?
                buf$ = Left$(buf$, I - 1)
                If Len(buf$) > 0 Then
                let buf$ = buf$

                    End If

                    ' Send buffer to the player.

                    buf$ = player.outbuf$(Player) + buf$

                    for i = 1 to 3
                    player.outbuf$(i) = Send$(player.sock(i), buf$, Len(buf$), 0)
                    next i
                    ' See if player wants to quit.
                    If player.match(Player) = 0 And Len(player.outbuf$(Player)) = 0 Then
                        rc = closesocket(player.sock(Player))
                        player.sock(Player) = -1 ' Invalidate socket.
                        #s.te buf$
                        #s.te "> User ";Player;" quit."
                    End If

                    ' Trim off the entry.
                    player.inbuf$(Player) = Mid$(player.inbuf$(Player), I + 1)
                End If
            End If
        End If

    Player = Player + 1
    If Player > MAXPLAYERS(0) Then Player = 1
    GoTo [s_Loop]

[s_Close]
    ' Clean up sockets.
    For plr = 1 To MAXPLAYERS(0)
        If player.sock(plr) <> -1 Then rc = closesocket(player.sock(plr))
    Next
    rc = closesocket(sock)
    Call WSACleanup

    Close #s

    Close #wmlib
    Close #wsock32
    close #me

    End

'*** Application Procedures ***

Function SockProc( hWnd, uMsg, sock, lParam )
' Callback function to handle a Windows message
' forwarded by WMLiberty. Called when a relevant
' network event occurs.

    Select Case LOWORD(lParam)
        Case 1 'FD_READ
            b$ = Recv$(sock, 256, 0)
            While Len(b$)
                buf$ = buf$ + b$
                b$ = Recv$(sock, 256, 0)
            Wend
            plr = GetPlayer(sock)
            player.inbuf$(plr) = player.inbuf$(plr) + buf$
        Case 2 'FD_WRITE
            plr = GetPlayer(sock)
            buf$ = player.outbuf$(plr)
            player.outbuf$(plr) = Send$(sock, buf$, 256, 0)
            If player.match(plr) = 0 And Len(player.outbuf$(plr)) = 0 Then
                rc = closesocket(sock)
                player.inbuf$(plr) = ""
                player.sock(plr) = -1
            End If
        Case 8 'FD_ACCEPT
            plr = GetPlayer(-1)
            If plr Then
                s = accept(sock)
                #s.te "> User "; plr; " Joined ["; _
                      GetHostByAddr$(sockaddr.sinaddr.struct); "]"

                player.sock(plr) = s
                player.match(plr) = Int(100 * Rnd(0)) + 1

                buf$ = "Welcome to Kc Instant Messenger, User ";plr;"!"

                player.outbuf$(plr) = Send$(s, buf$, Len(buf$), 0)

            Else
                ' Too many players. Close connection.
                rc = closesocket(sock)
            End If
        Case 32 'FD_CLOSE
            ' Flush the buffers.
            rc = SockProc(hWnd, uMsg, sock, 1) 'force read

            ' Clean up.
            plr = GetPlayer(sock)
            player.sock(plr) = -1
            player.inbuf$(plr) = ""
            player.outbuf$(plr) = ""
            player.match(plr) = 0

            #s.te "> Connection closed by User "; plr; "."
    End Select
End Function

Function TCPReceive$(handle)
buffer=4096
all=0
calldll #me, "ReceiveA" ,handle As Long,_
buffer As Long,_
all As Long, re As long
if re<>0 then TCPReceive$ = winstring(re)
End Function

Sub WinsockInit
' Initializes structs used in Winsock calls.
    Struct hostent, _
        hname As Long, _
        haliases As Long, _
        haddrtype As Word, _
        hlength As Word, _
        haddrlist As Long

    Struct sockaddr, _
        sinfamily As Short, _
        sinport As UShort, _
        sinaddr As ULong, _
        sinzero As Char[8]

    Struct WSAData, _
        wVersion As Word, _
        wHighVersion As Word, _
        szDescription As Char[257], _
        szSystemStatus As Char[129], _
        iMaxSockets As Word, _
        iMaxUdpDg As Word, _
        lpVendorInfo As Long
End Sub

Function GetPlayer( sock )
    For plr = MAXPLAYERS(0) To 1 Step -1
        If player.sock(plr) = sock Then Exit For
    Next
    GetPlayer = plr
End Function

Function GetLocalIP()
    sName$ = GetHostName$()
    CallDLL #wsock32, "gethostbyname", _
        sName$ As Ptr, _
        phe As ULong
    If phe Then
        helen = Len(hostent.struct)
        CallDLL #kernel32, "RtlMoveMemory", _
            hostent As Struct, _
            phe As ULong, _
            helen As Long, _
            rc As Void
        plong = hostent.haddrlist.struct
        Struct p, addrlist As ULong
        CallDLL #kernel32, "RtlMoveMemory", _
            p As Struct, _
            plong As ULong, _
            4 As Long, _
            rc As Void
        plong = p.addrlist.struct
        Struct p, addr As ULong
        hlength = hostent.hlength.struct
        CallDLL #kernel32, "RtlMoveMemory", _
            p As Struct, _
            plong As ULong, _
            hlength As Long, _
            rc As Void
        GetLocalIP = p.addr.struct
    End If
End Function

Function woBang$( raw$ )
' Kludge to print a string that could start with an
' exclamation point, or bang (!). Am I missing something?
    woBang$ = raw$
    bangs = 0
    While Mid$(raw$, bangs+1, 1) = "!"
        bangs = bangs + 1
    Wend
    If bangs Then
        bang$ = Left$(raw$, bangs)
        woBang$ = Mid$(raw$, bangs+1)

        #s.te "!Lines ln"
        #s.te "!Line "; ln; " ln$"
        #s.te "!Select "; Len(ln$)+1; " "; ln
        #s.te "!Insert bang$"
        #s.te "!Select 1 1"
    End If
End Function

'*** General Procedures ***

Function CrLf$()
    CrLf$ = Chr$(13)+Chr$(10)
End Function

Function LOWORD( dw )
    LOWORD = (dw And 65535)
End Function

Function MAKEWORD( b1, b2 )
    MAKEWORD = b1 Or (256 * b2)
End Function

Function String$( num, ch )
    If num > 0 Then
        String$ = Chr$(ch)
        While Len(String$) < num
            String$ = String$ + String$
        Wend
        String$ = Left$(String$, num)
    End If
End Function

'*** Winsock Wrappers ***

Function GetHostByAddr$( addr )
    Struct p, addr As ULong
    p.addr.struct = addr
    CallDLL #wsock32, "gethostbyaddr", _
        p As Struct, _
        4 As Long, _
        2 As Long, _ 'AF_INET=2
        phe As Long
    If phe Then
        helen = Len(hostent.struct)
        CallDLL #kernel32, "RtlMoveMemory", _
            hostent As Struct, _
            phe As ULong, _
            helen As Long, _
            rc As Void
        GetHostByAddr$ = WinString(hostent.hname.struct)
    Else
        GetHostByAddr$ = "localhost"
    End If
End Function

Function GetHostByName$( sName$ )
    CallDLL #wsock32, "gethostbyname", _
        sName$ As Ptr, _
        phe As ULong
    If phe Then
        helen = Len(hostent.struct)
        CallDLL #kernel32, "RtlMoveMemory", _
            hostent As Struct, _
            phe As ULong, _
            helen As Long, _
            rc As Void
        GetHostByName$ = WinString(hostent.hname.struct)
    End If
End Function

Function GetHostName$()
    buf$ = Space$(256)+Chr$(0)
    CallDLL #wsock32, "gethostname", _
        buf$ As Ptr, _
        256 As Long, _
        rc As Long
    GetHostName$ = Trim$(buf$)
End Function

Function GetWSAErrorString$( errnum )
    Select Case errnum
        Case 10004: e$ = "Interrupted system call."
        Case 10009: e$ = "Bad file number."
        Case 10013: e$ = "Permission Denied."
        Case 10014: e$ = "Bad Address."
        Case 10022: e$ = "Invalid Argument."
        Case 10024: e$ = "Too many open files."
        Case 10035: e$ = "Operation would block."
        Case 10036: e$ = "Operation now in progress."
        Case 10037: e$ = "Operation already in progress."
        Case 10038: e$ = "Socket operation on nonsocket."
        Case 10039: e$ = "Destination address required."
        Case 10040: e$ = "Message too long."
        Case 10041: e$ = "Protocol wrong type for socket."
        Case 10042: e$ = "Protocol not available."
        Case 10043: e$ = "Protocol not supported."
        Case 10044: e$ = "Socket type not supported."
        Case 10045: e$ = "Operation not supported on socket."
        Case 10046: e$ = "Protocol family not supported."
        Case 10047: e$ = "Address family not supported by protocol family."
        Case 10048: e$ = "Address already in use."
        Case 10049: e$ = "Can't assign requested address."
        Case 10050: e$ = "Network is down."
        Case 10051: e$ = "Network is unreachable."
        Case 10052: e$ = "Network dropped connection."
        Case 10053: e$ = "Software caused connection abort."
        Case 10054: e$ = "Connection reset by peer."
        Case 10055: e$ = "No buffer space available."
        Case 10056: e$ = "Socket is already connected."
        Case 10057: e$ = "Socket is not connected."
        Case 10058: e$ = "Can't send after socket shutdown."
        Case 10059: e$ = "Too many references: can't splice."
        Case 10060: e$ = "Connection timed out."
        Case 10061: e$ = "Connection refused."
        Case 10062: e$ = "Too many levels of symbolic links."
        Case 10063: e$ = "File name too long."
        Case 10064: e$ = "Host is down."
        Case 10065: e$ = "No route to host."
        Case 10066: e$ = "Directory not empty."
        Case 10067: e$ = "Too many processes."
        Case 10068: e$ = "Too many users."
        Case 10069: e$ = "Disk quota exceeded."
        Case 10070: e$ = "Stale NFS file handle."
        Case 10071: e$ = "Too many levels of remote in path."
        Case 10091: e$ = "Network subsystem is unusable."
        Case 10092: e$ = "Winsock DLL cannot support this application."
        Case 10093: e$ = "Winsock not initialized."
        Case 10101: e$ = "Disconnect."
        Case 11001: e$ = "Host not found."
        Case 11002: e$ = "Nonauthoritative host not found."
        Case 11003: e$ = "Nonrecoverable error."
        Case 11004: e$ = "Valid name, no data record of requested type."
        Case Else:  e$ = "Unknown error "; errno; "."
    End Select
    GetWSAErrorString$ = e$
End Function

Function InetNtoA$( inaddr )
    CallDLL #wsock32, "inet_ntoa", _
        inaddr As ULong, _
        pstr As ULong
    InetNtoA$ = WinString(pstr)
End Function

Function Recv$( s, buflen, flags )
    Recv$ = Space$(buflen)+Chr$(0)
    CallDLL #wsock32, "recv", _
        s As Long, _
        Recv$ As Ptr, _
        buflen As Long, _
        flags As Long, _
        buflen As Long
    Recv$ = Left$(Recv$, buflen)
End Function

Function Send$( s, buf$, buflen, flags )
    buflen = Min(Len(buf$), buflen)
    CallDLL #wsock32, "send", _
        s As Long, _
        buf$ As Ptr, _
        buflen As Long, _
        flags As Long, _
        buflen As Long
    If buflen > 0 Then Send$ = Mid$(buf$, buflen+1)
End Function

'*** Winsock Thin Wrappers ***

Function accept( s )
    Struct p, length As Long
    p.length.struct = Len(sockaddr.struct)
    CallDLL #wsock32, "accept", _
        s As Long, _
        sockaddr As Struct, _
        p As Struct, _
        accept As Long
End Function

Function bind( s )
    namelen = Len(sockaddr.struct)
    CallDLL #wsock32, "bind", _
        s As Long, _
        sockaddr As Struct, _
        namelen As Long, _
        bind As Long
End Function

Function closesocket( s )
    CallDLL #wsock32, "closesocket", _
        s As Long, _
        closesocket As Long
End Function

Function htonl( hostlong )
    CallDLL #wsock32, "htonl", _
        hostlong As ULong, _
        htonl As ULong
End Function

Function htons( hostshort )
    CallDLL #wsock32, "htons", _
        hostshort As Word, _
        htons As Word
End Function

Function inetaddr( cp$ )
    CallDLL #wsock32, "inet_addr", _
        cp$ As Ptr, _
        inetaddr As ULong
End Function

Function listen( s, backlog )
    CallDLL #wsock32, "listen", _
        s As Long, _
        backlog As Long, _
        listen As Long
End Function


Function socket( af, type, protocol )
    CallDLL #wsock32, "socket", _
        af As Long, _
        type As Long, _
        protocol As Long, _
        socket As Long
End Function

Function WSAAsyncSelect( s, hWnd, wMsg, lEvent )
    CallDLL #wsock32, "WSAAsyncSelect", _
        s As Long, _
        hWnd As ULong, _
        wMsg As ULong, _
        lEvent As Long, _
        WSAAsyncSelect As Long
End Function

Sub WSACleanup
    CallDLL #wsock32, "WSACleanup", _
        r As Void
End Sub

Function WSAGetLastError()
    CallDLL #wsock32, "WSAGetLastError", _
        WSAGetLastError As Long
End Function

Function WSAStartup( wVersionRequested )
    CallDLL #wsock32, "WSAStartup", _
        wVersionRequested As Word, _
        WSAData As Struct, _
        WSAStartup As Long
End Function

'*** WMLiberty Thin Wrappers ***

Function SetWMHandler( hWnd, uMsg, lpfnCB, lSuccess )
    CallDLL #wmlib, "SetWMHandler", _
        hWnd As Long, _
        uMsg As Long, _
        lpfnCB As Long, _
        lSuccess As Long, _
        SetWMHandler As Long
End Function

