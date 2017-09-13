nomainwin
open "Startup.txt" for input AS #startall
while eof(#startall) <> 0
 line input #startall, startme$
 run startme$
wend
close #startall
end
