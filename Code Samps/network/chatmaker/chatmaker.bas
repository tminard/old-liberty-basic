

[setup.main.Window]

    '-----Begin code for #main

    nomainwin
    if instr(CommandLine$, ".cht")<>0 then
chatter$=CommandLine$
goto [start]
end if
notice "Select Chatter:" + chr$(13) + "Chat Creator will now ask you to:" + chr$(13) + "a) Open Previous Chatter" + chr$(13) + "b) Create New Chatter"
filedialog "Save or Open Chatter", "*.cht", chatter$
if chatter$<>"" and instr(chatter$, ".cht")=0 then
chatter$=chatter$ + ".cht"
end if
[start]
    WindowWidth = 550
    WindowHeight = 255
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code
menu #main, "File", "Run Chat", [chatrunner], "Quit", [quit.main]
    groupbox #main.groupbox6, "Settings",  65,  87, 125,  65
    button #main.button1,"Create New Command",[button1Click], UL, 175, 182, 170,  25
    radiobutton #main.radiobutton3, "Includes", [radiobutton3Set], [radiobutton3Reset],  75, 127,  75,  25
    radiobutton #main.radiobutton4, "Is Equal To", [radiobutton4Set], [radiobutton4Reset],  75, 102,  93,  25
    TextboxColor$ = "white"
    textbox #main.ask, 135,   7, 300,  25
    statictext #main.statictext8, "Ask:", 105,  12,  26,  20
    statictext #main.statictext9, "Reply:",  95,  37,  36,  20
    textbox #main.reply, 135,  32, 300,  25

    '-----End GUI objects code

    open "Chat Creator" for window as #main
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"


[main.inputLoop]   'wait here for input event
    wait



[button1Click]   'Perform action for the button named 'button1'
if instr(chatter$, ".cht")=0 then
notice "No chatter selected..." + chr$(13) + "No chatter was selected on run..."
wait
end if
open chatter$ for append as #1
    if inc=1 then
    print #1, "inc"
    else
    print #1, "equ"
    end if
print #main.ask, "!contents? ask$"
print #main.reply, "!contents? reply$"
print #1, ask$
print #1, reply$
print #main.ask, ""
print #main.reply, ""
notice "Added command successfully!!!"
close #1
    wait

[radiobutton3Set]   'Perform action for the radiobutton named 'radiobutton3'

inc=1

    wait



[radiobutton3Reset]   'Perform action for the radiobutton named 'radiobutton3'
inc=0

    wait

[radiobutton4Set]   'Perform action for the radiobutton named 'radiobutton4'

equ=1
    wait



[radiobutton4Reset]   'Perform action for the radiobutton named 'radiobutton4'
equ=0

    wait

[quit.main] 'End the program
    close #main
    end

















[chatrunner]
'Form created with the help of Freeform 3 v03-27-03
'Generated on Mar 09, 2004 at 21:04:38

filedialog "Open Chat", "*.cht", chat$
[setup.chattt.Window]

    '-----Begin code for #chattt

    nomainwin
    WindowWidth = 550
    WindowHeight = 410
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    TexteditorColor$ = "white"
    texteditor #chattt.chat,   5,   5, 530, 310
    TextboxColor$ = "white"
    textbox #chattt.mess,   5, 322, 395,  25
    button #chattt.button3,"Send!",[send], UL, 425, 322,  45,  25

    '-----End GUI objects code

    '-----Begin menu code

    menu #chattt, "File",_
                "Open Chat", [open],_
                "Exit"     , [quit.chattt]

    menu #chattt, "Edit"  ' <-- Texteditor menu.


    '-----End menu code

    open "The Chat" for window as #chattt
    print #chattt, "font ms_sans_serif 10"
    print #chattt, "trapclose [quit.chattt]"

[chattt.inputLoop]   'goto [chattt.inputLoop] here for input event
    print #chattt.mess, "!setfocus"
    timer 5, [key.pressed]
 wait


[key.pressed] 'Check to see if key was pressed.

    Timer 0

    CallDLL #user32,"GetAsyncKeyState",_
                             _VK_RETURN as long,_
                             fKeyPress as long

    timer 5, [key.pressed] 'This timer de-bounces the keypress


' if the key is pressed fKeyPress will be less than 0.

    if fKeyPress < 0 then [send]


    wait



[send]   'Perform action for the button named 'button3'

print #chattt.mess, "!contents? mes$"
open chat$ for input as #1
    while eof(#1) = 0
    line input #1, type$
        if type$="equ" then
        line input #1, ask$
            if upper$(mes$)=upper$(ask$) then
         line input #1, tmes$
            end if
        end if
        if type$="inc" then
       line input #1, ask$
            if instr(upper$(mes$), upper$(ask$))<>0 then
           line input #1, tmes$
            end if
        end if
wend
close #1

print #chattt.chat, "YOU:  " + mes$
if tmes$="" then
print #chattt.chat, "CHATTER:  Unfortunately, I don't recogize that string of letters.  I may not be programmed to do so."
print #chattt.mess, ""
print #chattt.mess, "!setfocus"
goto [chattt.inputLoop]
end if

print #chattt.chat, "CHATTER:  " + tmes$
print #chattt.mess, ""
print #chattt.mess, "!setfocus"
tmes$=""
goto [chattt.inputLoop]
[open]   'Perform action for menu File, item Open Chat
filedialog "Open Chat", "*.cht", chat$

    goto [chattt.inputLoop]


[quit.chattt] 'End the program
    close #chattt
wait

