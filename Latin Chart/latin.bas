'Latin database
dim  latin$(50, 600)
dim realword$(50, 600)
dim latinword$(50, 600)

open "latin.txt" for input AS #db
line input #db, lang$
for i = 1 to 100000
IF onlatin = 0 then onlatin = 1:tochange = 1
IF onlatin = 1 AND tochange = 0 THEN onlatin = 0
tochange = 0
IF eof(#db) <> 0 THEN exit for
line input #db, text$
IF word$(text$, 1) = "*" THEN weeks = weeks + 1: line input #db, text$:word = 0:rword = 0:lword = 0
word = word + 1
latin$(weeks, word) = text$
IF onlatin = 0 then rword = rword + 1:realword$(weeks, rword) = text$
IF onlatin = 1 then lword = lword + 1:latinword$(weeks, lword) = text$
next i

close #db
[prompt]
input "Enter a week and a word number (i.e. '2 3'): ";getme$

IF lower$(getme$) = "cls" THEN cls:goto [prompt]
IF lower$(getme$) = "end" or lower$(getme$) = "quit" THEN end
IF lower$(getme$) = "all" THEN cls:goto [dis.all]

week = val(word$(getme$, 1))
gword = val(word$(getme$,2))
IF week > weeks or gword > 600 THEN cls:print "A word with that address was not found!":goto [prompt]
IF trim$(latinword$(week,gword)) = "" THEN cls:PRINT "Week ";week; ", word ";gword;" NOT found!":goto [prompt]
print lang$+": "+latinword$(week,gword)
print "Translation: "+realword$(week, gword)
goto [prompt]
end


[dis.all]
print "--All words--"
for i = 1 to weeks
print ""
print "---- Week ";i;" ----"
print ""
  for b = 1 to 10000
  IF latinword$(i,b) = "" THEN exit for
  'print latin$(i, b)
  print "( ";i;" , ";b;" ): "+latinword$(i,b)+" = "+ realword$(i, b)
  print "--"
  next b
next i
print "----------------"
goto [prompt]
end
