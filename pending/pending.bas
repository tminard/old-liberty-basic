prompt "Enter Location of Folder to watch: ";pendingLoc$
prompt "Enter message to show if files exist: ";mesg$

dim info$(1000,10)
nomainwin
timer 6000, [is.found]
wait

[is.found]
IF winopen = 1 then wait
 IF fileExists(pendingLoc$,"*.*") then winopen = 1:goto [open.win]
wait

[open.win]
    nomainwin
    WindowWidth = 295
    WindowHeight = 105
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)
    BackgroundColor$ = "darkblue"
    ForegroundColor$ = "white"


    '-----Begin GUI objects code

    statictext #main.statictext1, mesg$,  30,  22, 218,  20
    checkbox #main.checkbox2, "Dont check again for", [checkbox2Set], [checkbox2Reset],  15,  57, 10,  10
    TextboxColor$ = "white"
    textbox #main.textbox3, 165,  52,  30,  25
    statictext #main.statictext5, "minutes.", 205,  57,  49,  20
    statictext #main.s2, "Dont check again for", 30,  54, 130,  25

    '-----End GUI objects code

    open "" for window_popup as #main
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"


[main.inputLoop]   'wait here for input event
    wait


[checkbox2Set]   'Perform action for the checkbox named 'checkbox2'
dowait = 1
    wait

[checkbox2Reset]   'Perform action for the checkbox named 'checkbox2'
dowait = 0
    wait

[quit.main] 'End the program
    #main.textbox3, "!contents? string$"
    timetowait = val(string$)*60000
    close #main
    winopen = 0
    IF dowait = 1 then timer 0:timer timetowait, [startagain]
    wait

[startagain]
timer 0
dowait = 0
timer 6000, [is.found]
wait












function fileExists(path$, filename$)
  'dimension the array info$( at the beginning of your program
  files path$, filename$, info$()
  fileExists = val(info$(0, 0))  'non zero is true
end function
