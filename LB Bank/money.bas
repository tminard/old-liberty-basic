[top]
gosub [start]
goto [print.money]

function fileExists(path$, filename$)
dim info$(1000,10)
'dimension the array info$( at the beginning of your program
files path$, filename$, info$()
fileExists = val(info$(0, 0))  'non zero is true
end function

[start]
open "money.txt" for input AS #gm
for i = 1 to 10000
line input #gm, curmon
close #gm
return


[print.money]
print "---------------"
print "Money in bank: "
print "$";curmon
print "---------------"
input "Command: ";comm$
goto [load.comms]
wait


[load.comms]
IF trim$(comm$) = "" THEN cls:goto [print.money]:end
IF lower$(comm$) = "end" THEN end
IF lower$(comm$) = "+" THEN goto [add]
IF lower$(comm$) = "-" THEN goto [min]
IF lower$(comm$) = "help" or lower$(comm$) = "/?" then goto [help]
notice "Invalid Command!"
cls
goto [print.money]
end

[add]
prompt "Enter money to add: ";addme
IF addme = 0 THEN cls:goto [print.money]
curmon = curmon + addme
cls
open "money.txt" for output As #saveme
print #saveme, curmon
close #saveme
cls
goto [top]
end

[min]
prompt "Enter money to subtracted: ";minme
IF minme = 0 THEN cls:goto [print.money]
curmon = curmon - minme
cls
open "money.txt" for output As #saveme
print #saveme, curmon
close #saveme
cls
goto [top]
end

