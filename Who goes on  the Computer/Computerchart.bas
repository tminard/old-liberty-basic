'Form created with the help of Freeform 3 v03-27-03
'Generated on Feb 10, 2006 at 11:32:05
gosub [openfileAndRead]

[setup.main.Window]
IF set$ = "" THEN set$ = "1"
    '-----Begin code for #main

    nomainwin
    WindowWidth = 450
    WindowHeight = 270
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    groupbox #main.groupbox23, "2", 155,  32, 135, 100
    groupbox #main.groupbox16, "1",  20,  32, 135, 100
    groupbox #main.groupbox28, "3", 290,  32, 130, 100
    'day 1
    statictext #main.statictext13, "Tyler S Minard",  35,  47, 100,  20
    statictext #main.statictext14, "Danielle M Minard",  35,  72, 108,  20
    statictext #main.statictext15, "Ryan T Minard",  35,  97, 115,  20
    radiobutton #main.radiobutton17, "Did", [radiobutton17Set], [radiobutton17Reset],  55, 137,  46,  25
    'end

    radiobutton #main.radiobutton6, "Did", [radiobutton6Set], [radiobutton6Reset], 195, 137,  46,  25

   'day 2
    radiobutton #main.radiobutton7, "Did", [radiobutton7Set], [radiobutton7Reset], 340, 137,  46,  25
    statictext #main.statictext8, "Tyler S Minard", 170,  97, 100,  20
    statictext #main.statictext9, "Danielle M Minard", 170,  47, 108,  20
    statictext #main.statictext10, "Ryan T Minard", 170,  72, 115,  20
    'end

    button #main.button24,"Quit/Save",[button24Click], UL, 370, 212,  73,  25

    'day 3
    statictext #main.statictext132, "Danielle M Minard", 305,  97, 108,  20
    statictext #main.statictext142, "Ryan T Minard", 305,  47, 115,  20
    statictext #main.statictext122, "Tyler S Minard", 305,  72, 100,  20
    statictext #main.statictext29, "",  60,  12,  45,  20
    statictext #main.statictext18, "", 200,  12,  45,  20
    statictext #main.statictext19, "", 340,  12,  45,  20

    '-----End GUI objects code
'"font arial 14 italic"
    open "Who goes on the Computer FIRST?" for window_nf as #main
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [quit.main]"
    IF set$ = "1" THEN print #main.radiobutton17, "set":#main.statictext18, "Today!":#main.statictext9,"!font arial 9 bold"
    IF set$ = "2" THEN print #main.radiobutton6, "set":#main.statictext19, "Today!":#main.statictext142, "!font arial 9 bold"
    IF set$ = "3" THEN print #main.radiobutton7, "set":#main.statictext29, "Today!":#main.statictext13, "!font arial 9 bold"


[main.inputLoop]   'wait here for input event
    wait


[radiobutton17Set]   'Perform action for the radiobutton named 'radiobutton17'


set$ = "1"

    wait



[radiobutton17Reset]   'Perform action for the radiobutton named 'radiobutton17'


    wait

[radiobutton6Set]   'Perform action for the radiobutton named 'radiobutton6'


set$ = "2"

    wait



[radiobutton6Reset]   'Perform action for the radiobutton named 'radiobutton6'

    'Insert your own code here

    wait

[radiobutton7Set]   'Perform action for the radiobutton named 'radiobutton7'


set$ = "3"

    wait



[radiobutton7Reset]   'Perform action for the radiobutton named 'radiobutton7'

    'Insert your own code here

    wait


[button24Click]   'Perform action for the button named 'button24'

   goto [quit.main]

    wait

[quit.main] 'End the program
IF set$ = "" THEN notice "Please select a day!":wait
    close #main
    open "chart.dat" for output AS #saveme
    print #saveme, set$
    close #saveme
    end


[openfileAndRead]
 open "chart.dat" for input AS #saveme
    line input #saveme, set$
    close #saveme
    return
