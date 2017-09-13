'Code to detect installed games based off registry
'XPKey 1.0
'Cassio Ferreira
'Jan 2006
'Modified by Tyler Minard into a function - Feb 2008


test$ = ReadRegistry$(2,"SOFTWARE\Microsoft\Windows NT\CurrentVersion","DigitalProductID")
'test$ = word$(test$,1,chr$(0)) 'Remove chr$(0) from some keys
'Below is for decoding the win key
print test$
buff$ = mid$(test$, 53, 15)
call DecodeKey buff$, xpKey$
print xpKey$
end

function ReadRegistry$(key, subKey$,value$)
'key can be:
'1 = _HKEY_LOCAL_MACHINE
'2 = _HKEY_CLASSES_ROOT
'3 = _HKEY_CURRENT_USER
cr$ = chr$(13)
'Set up and load array to hold
'all 24 possible key characters.
dim kCh$(23)
data "B","C","D","F","G","H",_
     "J","K","M","P","Q","R",_
     "T","V","W","X","Y","2",_
     "3","4","6","7","8","9"
for x = 0 to 23
    read chars$
    kCh$(x) = chars$
next x
restore
'Set up structs necessary for the
'registry calls. In this instance,
'one to receive a handle to the open
'registry key, and one to receive
'the size of the data, respectively.
struct H,       key     as ulong
struct cbData,  size    as long
'Open "advapi32.dll" to make the query
open "advapi32.dll" for dll as #aa32
aa32.isOpen = 1
'Make the call to open the subkey
'indicated in "subKey$", specifying
'KEY_READ access rights.
errorReturned = 1 'Default to error in case user put in invalid key
IF key = 1 then
calldll #aa32, "RegOpenKeyExA",_
    _HKEY_LOCAL_MACHINE as ulong,_
    subKey$             as ptr,_
    0                   as ulong,_
    _KEY_READ           as ulong,_
    H                   as struct,_
    errorReturned       as long
end if
IF key = 2 then
calldll #aa32, "RegOpenKeyExA",_
    _HKEY_CLASSES_ROOT as ulong,_
    subKey$             as ptr,_
    0                   as ulong,_
    _KEY_READ           as ulong,_
    H                   as struct,_
    errorReturned       as long
end if
IF key = 3 then
calldll #aa32, "RegOpenKeyExA",_
    _HKEY_CURRENT_USER as ulong,_
    subKey$             as ptr,_
    0                   as ulong,_
    _KEY_READ           as ulong,_
    H                   as struct,_
    errorReturned       as long
end if
'If the key was opened successfully...
if not(errorReturned) then

    'Extract the handle from the struct
    hKey = H.key.struct

    'Query the entry once, specifying 0
    'for the data buffer pointer, which
    'places the size of the data into
    'the struct.
    calldll #aa32, "RegQueryValueExA",_
        hKey            as ulong,_
        value$          as ptr,_
        0               as ulong,_
        0               as ulong,_
        0               as ulong,_
        cbData          as struct,_
        errorReturned   as long

    'If the query was successful...
    if not(errorReturned) then

        'Space-fill a variable big enough
        'to hold the entry data.
        dataLen = cbData.size.struct
        buff$ = space$(dataLen)

        'Query the entry again, this time
        'passing it the buffer variable.
        calldll #aa32, "RegQueryValueExA",_
            hKey            as ulong,_
            value$          as ptr,_
            0               as ulong,_
            0               as ulong,_
            buff$           as ptr,_
            cbData          as struct,_
            errorReturned   as long

        'If that was successful...
        if not(errorReturned) then

            'Extract just the relevant bytes
            'and send it off to decode.
            ReadRegistry$ = buff$
           ' buff$ = mid$(buff$, 53, 15)
           ' call DecodeKey buff$, xpKey$

            'Proudly display it
           ' notice "XPKey 1.0" + cr$ + _
           '        "Windows XP Product key: " + _
           '        cr$ + cr$ + xpKey$
        else
           ' notice "Error" + cr$ + "Error retrieving key data"
            ReadRegistry$ = "Error reading key data"
        end if
    else
       ' notice "Error" + cr$ + "Error querying data size"
        ReadRegistry$ = "Error querying data size"
    end if
else
    ReadRegistry$ = "Key does not exist"
end if

close #aa32
aa32.isOpen = 0
    if (aa32.isOpen) then close #aa32
end function

sub DecodeKey buffer$, byref keyString$
    redim binVals(14)
    for x = 1 to 15
        binVals(x - 1) = asc(mid$(buffer$, x, 1))
    next x

    keyString$ = ""
    for i = 24 to 0 step -1
        c = 0
        for k = 14 to 0 step -1
            c = (c * 256) xor binVals(k)
            binVals(k) = int(c / 24)
            c = c mod 24
        next k
        keyString$ = kCh$(c) + keyString$
        if (not(i mod 5) and not(not(i))) then keyString$ = ("-" + keyString$)
    next i
end sub
