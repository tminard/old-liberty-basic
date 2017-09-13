' IBASIC Headers.

'////Client Functions:
'======================================================================
'Function: TCP_SetOption
'Variables:
' lflag
'     0 -- Specifies TCP/IP Client connections
'     1 -- Specifies UPD Client Connection
'  NOTE: By default, the library assumes TCP/IP connection (i.e., you do not have to use
'  this function if you are using the TCP/IP protocol.  However, you must specify this option
'  before opening a UPD connection.
'Returns:
'   0 -- fail
'   -1 -- success
'=======================================================================
Declare "mesock32.dll", TCP_SetOption (lflag:int), int



'===============================================================
'Function: TCP_Open2
'Variables:
' ip_address: The ip_address to connect to:
' example(s): 127.001.001.000 or
' www.microsoft.com
' lng_Port: This is the port number
' lng_Timeout: Timeout, in milliseconds.
'Return:
' 0 -- failed
' 1> -- TCP/IP Handle
' 0< -- UDP Handle
'===============================================================
DECLARE "mesock32.dll", OpenA(ipAddress:STRING,lng_Port:INT,lng_Timeout:INT),INT


'================================================================
'Function: TCP_Receive2
'Variables:
' tcp_handle: This is the socket handle
' lng_buffer: number of bytes to read
' l_all: This specifices whether all bytes should be returned, or 
' just the specified bytes.   If you want just the bytes specified in 
' lng_buffer returned, set l_all = 0.  If you want the library to handle 
' all the messaging and return all data from the server, set l_all > 0. 
'Return:
' Returns the string read. Returns an empty string if
' nothing is received.
'================================================================
DECLARE "mesock32.dll", ReceiveA(tcp_handle:INT,lng_buffer:INT,lng_All:INT),STRING


'===================================================================
'Function: TCP_Line_Input
'Variables:
' tcp_handle: Socket handle
'Returns:
' String - returns one line of data.
'Note:
' The difference between this and receive is that
' this returns one line from the stream, while
' receive returns up to the specified number of
' bytes.
'===================================================================
DECLARE "mesock32.dll", Line_Input(tcp_handle:INT),STRING


'=================================================================
'Function: TCP_PRINT2
'Variables:
' tcp_handle: Socket Handle
' str_buffer: The string to print
'Returns:
' -1 if successful, 0 if failed
'Notes: The difference between print and send, is that print appends
'and end of line character to the stream, letting the receiving server
'know that all the data has been sent.
'==================================================================
DECLARE "mesock32.dll", PrintA(tcp_handle:INT,sBuffer:STRING), INT


'===================================================================
'Function: TCP_Send2
'Variables:
' tcp_handle: Socket handle
' str_message: String to send
'Returns:
' Long : -1 if successful, 0 if failed
'====================================================================
Declare "mesock32.dll", SendA (tcp_handle:INT,str_message:STRING), INT


'======================================================================
'Function: TCP_Close2
'Variables:
' tcp_handle: Socket handle
'Returns:
' Long: -1 if successful, 0 if failed.
'=======================================================================
DECLARE "mesock32", CloseA(tcp_handle:INT),INT


'///Server Functions:

'======================================================================
'Function: TCPListen
'Variables:
' hwnd: long -- specifies the windows handle: this is required since data is sent to the 'specified window handle.
'sHost:string -- specifies the host address to listen to.  To listen to local host, enter "" To 'listen to multiple hosts, enter data in a comma delimited form: (Example: "",127.000.001.000)
'lPort:long -- Specifies the port to listen on
'lconnection:long -- Specifies the number of connections allowed to the server.
'ltimeout:long -- Specifies the timeout for each connection operation.  Default timeout is 10 'seconds.
'NOTE: ltimeout is represented by milliseconds, so 10 seconds would be represented as '10000
'Returns:
' Long: 0 if successful -- error number if failed.
'=======================================================================
Declare "mesock32.dll", TCPListen (hwnd:int, sHost:string, lPort:int, lConnection:int, lTimeout:int), int


'======================================================================
'Function: TCPClose
'Closes a listening connection
'Variables: none
'Returns:
' int (none specific)
'=======================================================================
Declare "mesock32.dll", TCPClose (), int

'======================================================================
'Function: UDPListen
'Variables:
' hwnd: long -- specifies the windows handle: this is required since data is sent to the 'specified window handle.
'lPort:long -- Specifies the port to listen on
'lconnection:long -- Specifies the number of connections allowed to the server.
'ltimeout:long -- Specified a timeout: If 0, the Timeout will be set to 10 seconds.  
'NOTE: ltimeout is represented by milliseconds, so 10 seconds would be represented as 10000
'Returns:
' Long: 0 if successful -- error number if failed.
'=======================================================================
Declare "mesock32.dll", UDPListen (hwnd:int, lPort:int, lConnection:int, lTimeout:int), int


'======================================================================
'Function: UDPClose
'Closes a listening connection
'Variables: none
'Returns:
' int (none specific)
'=======================================================================
Declare "mesock32.dll", UDPClose (), int


'========================================================================
' These are the messages that the listening functions use to pass data from the library to the app.
'========================================================================
SETID "TCP_MESOCK", 3021
SETID "UPD_MESOCK", 3025
