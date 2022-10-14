IN='
stat
alarm off
stat
window 0 open
window 0 close
window 1 open
window 1 close
window 2 open
window 2 close
stat
window 3 open
window 3 close
window 4 open
window 4 close
stat
'

OUT='
1[  ][  ][  ][  ][  ][  ][  ][  ][  ][  ]
success: alarm disabled
0[  ][  ][  ][  ][  ][  ][  ][  ][  ][  ]
success: window 0 opened
success: window 0 closed
success: window 1 opened
success: window 1 closed
success: window 2 opened
success: window 2 closed
0[  ][  ][  ][  ][  ][  ][  ][  ][  ][  ]
success: window 3 opened
success: window 3 closed
success: window 4 opened
success: window 4 closed
0[  ][  ][  ][  ][  ][  ][  ][  ][  ][  ]
'

diff <(echo "$IN" | awk -f demo.awk) <(echo "%OUT")