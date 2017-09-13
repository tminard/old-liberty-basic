'############################################
'# Cryptor.dll demo                         #
'# Cryptor.dll by David Drake               #
'# Updated to use as a sub by Tyler Minard  #
'# in 2005                                  #
'# Released as open-source August, 2002     #
'# Use at your own risk                     #
'#                                          #
'# This DLL produces a very low-level       #
'# encryption using character XOR functions.#
'# Thus, longer encryption keys produce     #
'# stronger encryption.  This would work    #
'# well for encrypting game data, etc.      #
'#                                          #
'# Cryptor.dll is a 32-bit DLL created with #
'# the help of BCX and LCC-WIN32, so it     #
'# is pretty fast.  On my 800MHz machine,   #
'# with a 10-character encryption key,      #
'# crypter.dll will process a 1MB file in   #
'# about five seconds.                      #
'#                                          #
'#                                          #
'# DLL package includes                     #
'# cryptor.dll - 32-bit dll                 #
'# cryptor.bas - BCX source code for DLL    #
'# cryptor.c   - C source code for DLL      #
'# cryptor_demo.bas - This file written for #
'#               Liberty BASIC 3.01         #
'############################################

KEY$ = "Tyler"
INFILE$ = "test.bit"
OUTFILE$ = "ff.bit"
MODE = 1 '1 = encrypt; 2 = decrypt
gosub [encrypt]
IF cryok = 1 THEN notice "Done!"
end

[encrypt]   'Do it!
cryok = 0
   ' #main.key, "!contents? KEY$"
   ' #main.source, "!contents? INFILE$"
   ' #main.destination, "!contents? OUTFILE$"

    cursor hourglass
    RESULT = ENCRYPTION(MODE,INFILE$,OUTFILE$,KEY$)
    cursor normal
    if RESULT = 1 then cryok = 1
    if RESULT = 2 then notice "Mode not properly selected!"
    if RESULT = 3 then notice "Source file does not exist!"
    if RESULT = 4 then notice "Destination file already exists!"
    if RESULT = 5 then notice "No key specified!"
    return


function ENCRYPTION(MODE,INFILE$,OUTFILE$,KEY$)
    open "cryptor.dll" for dll as #en
    calldll #en, "_ENCRYPT",_
        MODE as short,_
        INFILE$ as ptr,_
        OUTFILE$ as ptr,_
        KEY$ as ptr,_
        RESULT as short
    close #en
    ENCRYPTION = RESULT
end function
