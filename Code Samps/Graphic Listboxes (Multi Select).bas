'Code Begins
' Just some dummy maintenance items
Global lastselected$
Dim v$(5)
v$(1) = "Fix"
v$(2) = "Repair"
v$(3) = "Replace"
v$(4) = "Reinstall"
v$(5) = "Redo"

Dim n$(10)
n$(1) = " Window"
n$(2) = " Sink"
n$(3) = " Woodwork"
n$(4) = " Doorknob"
n$(5) = " Doorbell"
n$(6) = " Door panel"
n$(7) = " Fire escape"
n$(8) = " Ceiling tiles"
n$(9) = " Shower stall"
n$(10) = " Oven"

Dim item$(100,10)
For i = 1 to 29
v = Int(Rnd(1) * 5) + 1
n = Int(Rnd(1) * 10) + 1
item$(i,0) = i;": ";v$(v);n$(n)
Next i
item$(0,0) = "0"

' Open a window with a graphicbox
WindowWidth = 555
WindowHeight = 690
UpperLeftX = Int((DisplayWidth - WindowWidth) /2)
UpperLeftY = Int((DisplayHeight - WindowHeight) /2)
Graphicbox #demo.g, 10,  117, 170, 345
Statictext #demo.sel, "", 215, 167, 100,  40
Graphicbox #demo.inst,  350,  37, 175, 385
Open "Scrolling Graphic Listbox" for Window as #demo
#demo, "Trapclose XbyTrap"
#demo, "Font Verdana 10 Bold"

' Add vertical scrollbar
#demo.g, "Vertscrollbar On 0 1820"
#demo.inst, "Vertscrollbar On 0 1820"
' Print the array
#demo.g, "Down; Color darkblue; Backcolor darkgray"
#demo.g, "Place 0 0; Boxfilled 280 2040; Flush"
#demo.inst, "Down; Color darkblue; Backcolor darkgray"
#demo.inst, "Place 0 0; Boxfilled 280 2040; Flush"
Call DrawArray
Call DrawInstArray
#demo.g, "Flush"
#demo.inst, "Flush"

' Wait for button click
#demo.g, "When leftButtonUp SelItem"
'#demo.g, "When leftButtonDouble SelItem"
#demo.g, "When leftButtonDouble [instG]"
#demo.g, "When rightButtonUp popItem"
'#demo.inst, "When leftButtonUp SelinItem"
#demo.inst, "When leftButtonUp [test]"
#demo.inst, "When rightButtonUp popItem"
Wait

[test]
'notice "OK"
Call DrawInstArray
yVar = MouseY
xVar = MouseX
yVar = yVar - 1
item = Int(yVar / 20) + 1
#demo.inst, "Color blue"
#demo.inst, "Place 2 ";item * 20
#demo.inst, "\";item$(item,0)
#demo.inst, "Flush"
#demo.sel, item$(item,0)

wait


[instG]
Call DrawArray
'Call SelItem
notice item$(item,0)
wait

Sub XbyTrap handle$
Close #handle$
End
End Sub

Sub SelItem handle$, xVar, yVar
Call DrawArray
#demo.g, "backcolor DARKBLUE"
yVar = yVar - 1
item = Int(yVar / 20) + 1
#demo.g, "Color white"
#demo.g, "Place 2 ";item * 20
#demo.g, "boxfilled ";xVar;" "; yVar
#demo.g, "\";item$(item,0)
#demo.g, "Flush"
#demo.sel, item$(item,0)
'IF item$(item,0) = lastselected$ then notice "Install"
'lastselected$ = item$(item,0)
End Sub

Sub SelinItem handle$, xVar, yVar
Call DrawInstArray
yVar = yVar - 1
item = Int(yVar / 20) + 1
#demo.inst, "Color blue"
#demo.inst, "Place 2 ";item * 20
#demo.inst, "\";item$(item,0)
#demo.inst, "Flush"
#demo.sel, item$(item,0)

End Sub

Sub popItem handle$, xVar, yVar
Call DrawArray
yVar = yVar - 1
item = Int(yVar / 20) + 1
#demo.g, "Color Red"
#demo.g, "Place 2 ";item * 20
#demo.g, "\";item$(item,0)
#demo.g, "Flush"
#demo.sel, item$(item,0)
popupmenu "&Activate Mod", [asSquare], "&Delete Mod", [asTriangle]
End Sub

Sub DrawArray
#demo.g, "Cls; Backcolor darkgray; Color darkblue"
#demo.g, "Place 0 0; Boxfilled 280 2040"
For i = 1 to 100
#demo.g, "Place 2 ";i * 20
#demo.g, "\";item$(i,0)
Next i
End Sub

Sub DrawInstArray
#demo.inst, "Cls; Backcolor darkgray; Color darkblue"
#demo.inst, "Place 0 0; Boxfilled 280 2040"
For i = 1 to 100
#demo.inst, "Place 2 ";i * 20
#demo.inst, "\";item$(i,0)
Next i
End Sub
'Code Ends
