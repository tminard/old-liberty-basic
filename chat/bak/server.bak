root$ = "C:\chat"
print "Server name will be the name of this computer or it's IP address."
print "The root directoy is: "+root$
print "- Type 'start' to start the service"
input ""+root$+"> ";com$
goto [com]
end


[com]
IF com$ = "exit" then end
IF com$ = "start" then [start]
'IF com$ = "root" then [root]
input ""+root$+"> ";com$
goto [com]
end

[start]
open "setnet.bat" for output AS #setN
print #setN, "net share chat="+root$
close #setN
run "setnet.bat"
end

[root]
input " New root:-> ";cRoot$
IF left$(cRoot$,2) = "\\" THEN print "Error: Cannot change path to network hard disk!":goto [prompt]
doit = mkdir(cRoot$)
IF doit <> 0 THEN print "Error changing folder path!":goto [prompt]:end
print "Path changed!"
root$ = cRoot$
goto [prompt]
end

[prompt]
input ""+root$+"> ";com$
goto [com]
end
