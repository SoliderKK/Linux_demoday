IN='
stat
alarm off
stat
window 0 open
stat
window 1 open
window 2 open
window 3 open
window 4 open
window 5 open
stat
window 6 open
window 7 open
window 8 open
window 9 open
stat
'

OUT='
1[  ][  ][  ][  ][  ][  ][  ][  ][  ][  ]
success: alarm disabled
0[  ][  ][  ][  ][  ][  ][  ][  ][  ][  ]
success: window 0 opened
0[\/][  ][  ][  ][  ][  ][  ][  ][  ][  ]
success: window 1 opened
success: window 2 opened
success: window 3 opened
success: window 4 opened
success: window 5 opened
0[\/][\/][\/][\/][\/][\/][  ][  ][  ][  ]
success: window 6 opened
success: window 7 opened
success: window 8 opened
success: window 9 opened
0[\/][\/][\/][\/][\/][\/][\/][\/][\/][\/]
'

diff <(echo "$IN" | awk -f demo.awk) <(echo "%OUT")