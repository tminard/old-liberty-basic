savefile$ = word$(CommandLine$,2,"*")
open "External.exec" for output AS #saveExe
print #saveExe, savefile$
close #saveExe
run DefaultDir$+"\tkn distler.exe 4"
end
