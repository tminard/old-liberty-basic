Set objArgs = WScript.Arguments
url = objArgs(0)
pix = objArgs(1)
With CreateObject("MSXML2.XMLHTTP")
 .open "GET", url, False
 .send
 a = .ResponseBody
 End With
 With CreateObject("ADODB.Stream")
 .Type = 1 'adTypeBinary
 .Mode = 3 'adModeReadWrite
 .Open
 .Write a
 .SaveToFile pix, 2 'adSaveCreateOverwrite
 .Close
 End With
