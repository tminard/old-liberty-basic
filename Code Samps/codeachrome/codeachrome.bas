nomainwin

WindowWidth=580:WindowHeight=480
on error goto [doError]

menu #1, "&File", "E&xit", [quit]
    
open "CodeAChrome Editor Demo" for window as #1
#1 "trapclose [quit]"

open "CodeAChrome.dll" for dll as #r

hMain = hwnd(#1)

calldll #r, "CreateCodeAChrome", hMain as long, 10 as long, 10 as long, 550 as long, 400 as long, ret as long
if ret=0 then 
    notice "Error loading CodeAChrome. Program ended."
    goto [quit]
end if
#1 "resizehandler [resize]"

'activate resizehandler
calldll #user32, "MoveWindow",hMain as ulong, UpperLeftX as long, UpperLeftY as long,_
730 as long, 590 as long, 1 as long, ret as long

wait

[quit]
    calldll #r, "DestroyCodeAChrome", ret as void
    close #r
    close #1
    end   

[resize]    
ww=WindowWidth-14 : wh=WindowHeight-14
calldll #r, "MoveCodeAChrome",10 as long,10 as long,ww as long,wh as long, re as void
#1 "refresh"
wait
                                                                                                                                                                                                                                                                                                                                                                                                              
            
