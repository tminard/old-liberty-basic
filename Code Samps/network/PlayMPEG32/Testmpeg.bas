'** 4/15/02 1:26:11 PM
'** Test It

    True = 1 : False = 0
    'open the dll file and assign it a handle so we can access the functions.
    Open "plaympeg32.dll" For DLL As #mpeg

[InitColors]
    ForegroundColor$ = "Black"
    BackgroundColor$ = "Buttonface"
    TexteditorColor$ = "White"
    TextboxColor$    = "White"
    ComboboxColor$   = "White"
    ListboxColor$    = "White"

[WindowSetup]
    'NoMainWin
    WindowWidth = 392 : WindowHeight = 143
    UpperLeftX = Int((DisplayWidth-WindowWidth)/2)
    UpperLeftY = Int((DisplayHeight-WindowHeight)/2)

[ControlSetup]

Statictext  #main.result, "Result will go here...", 10, 50, 160, 25
Button      #main.getfile, "...",[getfile],UL, 340, 10, 25, 25
Button      #main.check, "Play It",[check],UL, 185, 45, 85, 30
Button      #main.quit, "Quit",[quit],UL, 280, 45, 85, 30
Textbox     #main.textbox1, 10, 10, 330, 24

Open "Test It" For Window As #main

    Print #main, "trapclose [quit]"
    Print #main, "font ms_sans_serif 10"

[loop]
    Wait

[quit]
    Close #main
    'Must instruct the dll to stop playing so thread can be closed.  Pass null string to do this.
    null$ = Chr$(0)
    CallDLL #mpeg, "PlayMPEG",null$ As ptr, result As long
    Close #mpeg
    End

[getfile]
    'Open a file dialog box and allow user to choose a file.  Put the filename into textbox.
    FileDialog "Locate a MIDI file", "*.mp3", fileName$
    Print #main.textbox1, fileName$
    GoTo [loop]

[check]
    'Get the contents of the textbox (the user might have typed thier own name)
    #main.textbox1 "!contents? fileName$"

    'insure that there is a file name that was read from the textbox
    If fileName$ = "" Then
       Notice "No file selected yet.  Press the button '...' to select a file!"
       GoTo [loop]
    End If

    'Must add a null character to end of string to be passed.
    fileName$ = fileName$ + Chr$(0)

    CallDLL #mpeg, "PlayMPEG",fileName$ As ptr, result As long

    'Report the result of the call to the GUI window.
    If result = 0 or result = -1 Then
       Print #main.result, "MIDI started Successfully"
    Else
       Print #main.result, "Failed to start midi: "+Str$(result)
    End If

    GoTo [loop]

