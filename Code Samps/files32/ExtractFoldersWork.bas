'Used with zip code
zipstartvar$ = "nel/folder/"
IF right$(zipstartvar$,1) = "/" = 0 then gosub [zippath.fix]:gosub [zipmk.file]
IF right$(zipstartvar$,1) = "/" then gosub [zipmk.folder]
end

[zippath.fix]
givenvar$ = zipstartvar$
zipfulltxt$ = ""
for i = 1 to len(givenvar$)
   printzip$ = mid$(givenvar$, i,1 )
   IF printzip$ = "/" then printzipit$ = "\"
   IF printzip$ = "/" = 0 then printzipit$ = printzip$
   zipfulltxt$ = zipfulltxt$ + printzipit$
next i
zipendvar$ = zipfulltxt$
return

[zipmk.file]
fileBuffer$ = Trim$(fileBuffer$)
open savezippath$+zipendvar$ for output as #savefile
print #savefile, fileBuffer$
close #savefile
return

[zipmk.folder]
gosub [zippath.fix]
doit = mkdir(savezippath$+zipendvar$)
return

