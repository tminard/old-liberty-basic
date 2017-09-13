    global textcolor$ 'Allow sub to read textcolor$
    global backcolor$ 'Allow sub to read backcolor$

    list1$(1) = "Click me!"
    list1$(2) = "& Me Too!"
    list1$(3) = "OO ME ME!"

    textcolor$ = "green" 'Default color of items
    backcolor$ = "darkgray" 'background color of graphic box

    loadbmp "cbox","checkbox.bmp"
    loadbmp "ccbox", "CLICKcheckbox.bmp"

    nomainwin
    
    WindowWidth = 370
    WindowHeight = 445
    UpperLeftX=int((DisplayWidth-WindowWidth)/2)
    UpperLeftY=int((DisplayHeight-WindowHeight)/2)


    '-----Begin GUI objects code

    graphicbox #main.list1,  70,  12, 200, 290
    statictext #main.statictext2, "Select items", 130, 312,  73,  20
    button #main.show,"Show Selected",[show.selected], UL, 250, 352, 100,  25
    button #main.close,"Close",[close], UL,   5, 352,  70,  25
    button #main.toggle,"Toggle All",[toggle.all], UL, 130, 382,  72,  25

    '-----End GUI objects code

    open "Graphic Listbox with Checkboxes" for window as #main
    print #main.list1, "down; fill darkgray; flush"
    print #main, "font ms_sans_serif 10"
    print #main, "trapclose [close]"
    print #main.list1, "when leftButtonUp [Click.List1]"
    'You can drap mouse movement and highlight text when the mouse moves over it!
    call DrawList1 'Draw listbox
    print #main.list1, "flush"
wait

[show.selected]
show$ = ""
selected = 0
for i = 1 to 10000
    IF list1$(i) = "" then exit for
    IF instr(list1$(i),"&&SELECTED&&") then
    show$ = show$ + chr$(13) + word$(list1$(i),1,"&&SELECTED&&")
    selected = selected + 1
    end if
next i
notice show$
notice "Items selected: ";selected
wait

[close]
close #main
unloadbmp "cbox"
unloadbmp "ccbox"
end

[toggle.all]
for i = 1 to 10000
 IF list1$(i) = "" then exit for
  select case instr(list1$(i),"&&SELECTED&&")
    case 0 'If not checked, check it!
    list1$(i) = list1$(i) + "&&SELECTED&&"
    case else 'If checked, uncheck it!
    list1$(i) = word$(list1$(i),1,"&&SELECTED&&")
  end select
next i
call DrawList1
wait

[Click.List1] 'Go here when user clicks in graphic box
call DrawList1 'Update list
yVar = MouseY
xVar = MouseX
yVar = yVar - 1
item = Int(yVar / 20) + 1
IF list1$(item) = "" then wait 'Heres the bug. This prevents the code from creating new items lol

selected$ = word$(list1$(item),1,"&&SELECTED&&") 'Using this varible and the item varible,
'you can have the program make the selected item a different color, like yellow.
select case instr(list1$(item),"&&SELECTED&&")
case 0 'If not checked, check it!
    list1$(item) = list1$(item) + "&&SELECTED&&"
case else 'If checked, uncheck it!
    list1$(item) = word$(list1$(item),1,"&&SELECTED&&")
end select

call DrawList1
wait

Sub DrawList1
ii = 0 'I don't remember what this does lol
#main.list1, "Cls; Backcolor "+backcolor$+"; Color "+textcolor$
#main.list1, "Place 0 0; Boxfilled 280 2040"
For i = 1 to 10000 'Supports upto 10000 items in the list
didclick = 0 'Default to not clicked
IF list1$(i) = "" then exit for
'txtfilter$
#main.list1, "Color "+textcolor$ 'If the item is NOT selected then text is this color
    IF instr(list1$(i),"&&SELECTED&&") then 'If the item is selected then...
        #main.list1, "Color Blue" 'Set the color of the text to blue
       'IF doingdelete = 1 then #main.list1, "Color Black" 'You can have the listbox change the color of the item based on different varibles. This was set in my program to make the item black if 'Delete' is toggled.
        didclick = 1'Tell program the item is selected
    end If
IF didclick = 0 then print #main.list1, "drawbmp cbox 2 ";(i * 20) - 10 'If not checked, print notchecked bitmap
IF didclick = 1 then print #main.list1, "drawbmp ccbox 2 ";(i * 20) - 10 'If checked, print yeschecked bitmap
print #main.list1, "Place 20 ";i * 20
#main.list1, "\";word$(list1$(i),1,"&&SELECTED&&")'Print the item, but don't print the &&SELECTED&& part
Next i

'"pop" is the value that makes sure the scroolbar is just the right lenth to
'support all the objects in the listbox.
'Change around the '380' number everytime you change the length of the
'graphicbox
pop = int(i*20) - 380 'get how many pixels are needed to show all the items in the graphic box
IF pop < 0 then pop = 0
#main.list1, "Vertscrollbar On 0 ";pop 'Resize the scrollbar based on how many pixels need to be shown
End Sub
