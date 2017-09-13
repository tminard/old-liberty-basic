input "Enter how many FPS (feet-per-second)that you are running at: ";fps
'IF fps = 0 THEN print "Invalid choice!":end
'x = 201.17 / 0.3048
'x = x * 8
mile = 5280.05249 'This is ABOUT how many feet are in 1 mile
fpm = fps * 60 'get how many feet-per-minute
fph = fpm * 60'get how many feet-per-hour

'b / mile = how many miles can go into this!

MPH = fph / mile 'Get Miles-per-Hour
MPM = fpm / mile 'Get Miles-per-Minute
MPS = fps / mile 'Get Miles-Per-Second

print "You are traveling at ";MPH;" MPH!"
print "You are traveling at ";MPM;" MPM!"
print "You are traveling at ";MPS;" MPS!"
print "---"
input "Enter how many MPH that you are traveling at: ";getmph
showfps = getmph / .6818114 'This number is not exact but it's darn close! (It's off by .0000000x!)
print "You are traveling at ";showfps;" FPS!"
print "--"
'This converts MPH to FPS (Note: This is NOT exact!):  print getmph / .6818114

'NOTE: You can also do this with MUCH less code!!!:
'notice .6818114 * fps 'That's ALL!!!!!!!!
