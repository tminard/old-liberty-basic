goto$ = "d.public.home"
dim info$(100,10)
dim text$(1000)
dim links$(100,100)
dim run$(100,100)
text = 0
links = 0
runit = 0

[input]
IF goto$ = "" then input "> ";goto$
IF lower$(word$(goto$,1)) = "link" then [golink]
if goto$ = "close" then [end]
goto [goto]
end

[end]
end

[golink]
golink$ = word$(goto$,2)
if val(golink$) > 100 or val(golink$) < 0 then print "Broken Link!":goto$ = "":goto [input]
IF golink$ = "close" then [end]
find = val(golink$)
goto$ = links$(find,1)
IF goto$ = "" then goto$ = run$(find,0)
IF goto$ = run$(find,0) then [runit]
goto [goto]
end

[runit]
drive$ = word$(goto$,1,".")+":\"
folder$ = word$(goto$,2,".")+"\"
file$ = word$(goto$,3,".")'+".txt"
ext$ = "."+word$(goto$,4,".")
IF word$(goto$,4,".") = "" then ext$ = ".txt"
fulldir$ = drive$+folder$+file$+ext$
IF fileExists("",fulldir$) then run fulldir$
IF fileExists("",fulldir$) = 0 then print "ERROR: Broken Link!"
goto$ = ""
goto [input]
end

[goto]
drive$ = word$(goto$,1,".")+":\"
folder$ = word$(goto$,2,".")+"\"
file$ = word$(goto$,3,".")'+".txt"
ext$ = "."+word$(goto$,4,".")
IF word$(goto$,4,".") = "" then ext$ = ".txt"

fulldir$ = drive$+folder$+file$+ext$
IF fileExists("",fulldir$) = 0 then print "Page not found":goto$ = "":goto [input]
goto [load]
end

[load]
cls
open fulldir$ for input AS #ldweb
dim text$(1000)
dim links$(100,100)
dim run$(100,100)
text = 0
links = 0


for i = 1 to 100000
IF eof(#ldweb) <> 0 then exit for
line input #ldweb, tmptxt$
IF word$(tmptxt$,1,"^") = "text(" then text = text + 1:text$(text) = word$(tmptxt$,2,"^")
IF word$(tmptxt$,1,"^") = "link(" then links = links + 1:links$(links,0) = word$(tmptxt$,2,"^"):links$(links,1) = word$(tmptxt$,3,"^")
IF word$(tmptxt$,1,"^") = "run(" then links = links + 1:links$(links,0) = word$(tmptxt$,2,"^"):run$(links,0) = word$(tmptxt$,3,"^")

next i
close #ldweb

for i = 1 to text
print text$(i)
next i

print ".: Links :."
for p = 1 to links
print "(";p;") ";links$(p,0)
next p
goto$ = ""
goto [input]
end





function fileExists(path$, filename$)
  files path$, filename$, info$()
  fileExists = val(info$(0, 0))  'non zero is true
end function
