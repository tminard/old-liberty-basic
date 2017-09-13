'******************************************************

CodeAChrome is copyright Alyce Watson, 2005.

'******************************************************

CodeAChrome is free for commercial and non-commercial use. 

A credit to the author and a link to the website must be included in your program's documentation or readme file, and in any source code released to the public.

Alyce Watson
http://alycesrestaurant.com/

'******************************************************

Use this DLL at your own risk. The author bears no responsibility for errors that may occur as the result of its use. 

'******************************************************

You may not reverse-engineer this DLL. You may not claim it as your own work.

'******************************************************
open "CodeAChrome.dll" for dll as #r

The CodeAChrome control has an automatic right-click context menu that contains file, editing and find/replace functions.

CodeAChrome offers two methods of saving and loading files. Save files in plain text to run them in another editor. Save and load files in Rich Text Format (RTF) to preserve formatting and make load times faster. 

'********************************
'CONTROL MANAGEMENT FUNCTIONS
'********************************
calldll #r, "CreateCodeAChrome",_   'create the control
hMain as long,_     'parent window handle
x as long,_         'left x position
y as long,_         'top y position
width as long,_     'width
height as long,_    'height
ret as long         'nonzero=success

calldll #r, "DestroyCodeAChrome",_  'destroy the control
ret as void

calldll #r, "MoveCodeAChrome",_ 'move control
x as long,_         'left x position
y as long,_         'top y position
width as long,_     'width
height as long,_    'height
re as void

calldll #r, "ShowCodeAChrome",_ 'show/hide control
showcontrol as long,_ '1=on, 0=off
re as void

calldll #r, "EnableCodeAChrome",_   'enable/disable control
enable as long,_    '1=enable, 0=disable
re as void

calldll #r, "DoSetFocus",_  'set focus to control
re as void

calldll #r, "DoFindDialog",_    'invoke built-in find/replace dialog
re as void

'********************************
'TEXT RETRIEVAL AND MODIFICATION FUNCTIONS
'********************************
calldll #r, "GetTextLength",_   'get length of all text in control
length as long      'returns number of characters in control

buffer$ = space$(length) + chr$(0)
calldll #r, "GetAllText",_  'place all text into string variable
buffer$ as ptr,_    'string variable to hold text
re as void

calldll #r, "GetLineTextLength",_   'get length of text in line spedified
linenumber as long,_    '0-based index of line
length as long          'returns length of line

buffer$ = space$(length + 1)
calldll #r, "GetLineText",_ 'place text from line into string variable
linenumber as long,_    '0-based index of line
buffer$ as ptr,_        'string variable to hold text
re as void

calldll #r, "GetNumberOfLines",_    'get number of lines of text in control
re as long      'returns number of lines

calldll #r, "ReplaceText",_ 'replace selected text, or insert text if there is no selection
sel$ as ptr,_   'text to replace/insert
re as void

calldll #r, "SetTopLine",_  'scroll specified line to top
linenumber as long,_    '0-based index of line to place at top
re as void

'********************************
'FILE FUNCTIONS
'********************************
calldll #r, "LoadText",_    'replace text in control with string
tx$ as ptr,_        'string of text to load into control
re as void

calldll #r, "DoNew",_   'clear control
re as void

calldll #r, "FileLoad",_    'load file from disk as plain text
filename$ as ptr,_  'name of file 
re as void

calldll #r, "FileLoadAsRTF",_    'load file from disk with rich text formatting
filename$ as ptr,_  'name of file 
re as void

calldll #r, "FileSave",_    'save contents to file as plain text
filename$ as ptr,-  'name of file to save
re as void

calldll #r, "FileSaveAsRTF",_    'save contents to file, preserving rich text formatting
filename$ as ptr,-  'name of file to save
re as void

calldll #r, "DoPrint",_   'print contents of control
re as void

'********************************
'EDIT FUNCTIONS
'********************************
calldll #r, "SetModify",_   'set modified state
modified as long,_  '1=modified, 0=unmodified
re as void

calldll #r, "GetModify",_   'return modified state
re as long  '1=modified, 0=unmodified

calldll #r, "EditCutText",_ 'cut selected text to clipboard
re as void

calldll #r, "EditCopyText",_    'copy selected text to clipboard
re as void

calldll #r, "EditPasteText",_   'paste contents of clipboard at cursor
re as void

calldll #r, "EditSelectAll",_   'select all text in control
re as void

calldll #r, "EditUndo",_    'undo last operation
re as void

'********************************
'SETUP FUNCTIONS
'********************************
calldll #r, "SetLineNumbersOn",_    'line numbers on or off - on by default
linenumberson as long,_ '1=on, 0=off
re as void

calldll #r, "SetSyntaxColorOn",_    'syntax color on or off - on by default
syntaxcolor as long,_ '1=on, 0=off
re as void

calldll #r, "SetContextMenuOn",_    'context menu on or off - on by default
contextmenu as long,_ '1=on, 0=off
re as void

calldll #r, "SetFontSize",_ 'set size of font in points, is 10 by default
nFont as long,_ 'desired font size
re as void

'all color functions require red (0-255), blue (0-255), green (2-255) arguments
calldll #r, "SetDefaultColor",_ 'default text color
red as long, green as long, blue as long, re as void

calldll #r, "SetOperatorColor", _'operator color for =+-()[] etc. - red by default
red as long, green as long, blue as long, re as void

calldll #r, "SetCommentColor",_ 'color of comments following apostrophe - green by default
red as long, green as long, blue as long, re as void

calldll #r, "SetQuoteColor",_   'color of text inside of quotation marks - purple by default
red as long, green as long, blue as long, re as void

calldll #r, "SetKeyColor",_ 'color of keywords - blue by default
red as long, green as long, blue as long, re as void

calldll #r, "SetBackgroundColor",_  'background color of control
red as long, green as long, blue as long, re as void

calldll #r, "ColorAll",_'refresh color -- use after color or font change
re as void

calldll #r, "AddKeyWords",_ 'add words to keyword list
keys$ as ptr,_  'string of keywords, separated by spaces
re as void

calldll #r, "SetKeyWords",_ 'replace keywords with string of new keywords
keys$ as ptr,_  'string of keywords, separated by spaces
re as void

'DEFAULT KEYWORDS
' abs acs append as asc asn atn beep binary boolean button 
' call case checkbox chr$ close cls combobox cos cursor 
' data date$ def dialog dim dll do dword 
' else elseif end eof err error err$ exit exp 
' field end for function get global gosub goto groupboxp 
' hwnd if inkey$ inp input input$ instr int kill
' left$ len let line listbox locate loc lof log long loop lower$ lprint
' max menu mid$ min mod next on open out output playmidi playwave print put 
' radiobutton randomize read redim rem restore resume return right$ rnd run 
' scan seek select shell short sin sort space$ sqr statictext str$ struct sub 
' tab tan textbox then time$ timer trim$ type ulong until upper$ ushort using 
' val void wait wend while window word word$ 


                                                                                                                                                                                                                                                                                                                                                                                                                   
