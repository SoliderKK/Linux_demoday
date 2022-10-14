function checkWindows(win) {
    for(i=0;i<10;i++) {
        if(win[i]=="\\/") {
            return i;
        }
    }
    return -1;
}
function checkCoolers(win) {
    for(i=0;i<10;i++) {
        if(win[i]~/[0-9]+/) {
            return i;
        }
    }
    return -1;
}
function checkRoomNumber(num) {
    if((num>=0)&&(num<10)) {
        return 0;
    }
    return -1;
}
function checkTemperature(temp) {
    if((temp>=18)&&(temp<=26)) {
        return 0;
    }
    return -1;
}
BEGIN {
    open="\\/";
    closed="  ";
    alarm=1;
    for(i=0;i<10;i++){
        win[i]=closed;
    }
}
/^stat$/ {
    printf alarm;
    for(i=0;i<10;i++){
        printf "[%s]", win[i];
    }
    print "";
    next;
}
/^alarm (on|off)$/ {
    if($2=="off") {
        if(alarm==0) {
            print "alarm error: already disabled";
        } else {
            alarm=0;
            print "success: alarm disabled";
        }
    } else if($2=="on") {
        if(alarm==1) {
            print "alarm error: already enabled";
        } else {
            openWindow=checkWindows(win);
            if(openWindow==-1) {
                activeCooler=checkCoolers(win);
                if(activeCooler==-1) {
                    alarm=1;
                    print "success: alarm enabled";
                } else {                    
                    printf "alarm error: cooler %d enabled\n", activeCooler;
                }
            } else {
                printf "alarm error: window %d opened\n", openWindow;
            }
        }
    } else {
        print "error: unknown command";
    }
    next;
}
/^window [0-9]+ (open|close)$/ {
    room=+$2;
    if(checkRoomNumber(room)==0) {
        if(alarm==0) {            
                if($3=="open") {
                    if(win[room]!~/[0-9]+/) {
                        if(win[room]==closed) {
                            win[room]=open;
                            print "success: window " room " opened";
                        } else {
                            print "window error: " room " already opened";
                        }
                    } else {
                        print "window error: cooler " room " enabled";
                    }
                } else if($3=="close") {
                    if(win[room]==open) {
                        win[room]=closed;
                        print "success: window " room " closed";
                    } else {
                        print "window error: " room " already closed";
                    }
                } else {
                    print "error: unknown command";
                }            
        } else {
            print "window error: alarm enabled";
        }
    } else {
        print "window error: room must be between 0 and 9";
    }
    next;
}
/^cooler [0-9]+ (-?[0-9]+C|off)$/{
    room=+$2;
    if(checkRoomNumber(room)==0) {
        if($3=="off") {
            if(alarm==0) {
                if(win[room]~/[0-9]+/) {
                    win[room]=closed;
                    print "success: cooler " room " disabled";
                } else {
                    print "cooler error: " room " already off";
                }
            } else {
                print "cooler error: alarm enabled";
            }
        } else {
            if($3~/^-?[0-9]+C$/) {
                temp=substr($3,0,length($3)-1);
                if(checkTemperature(+temp)==0) {
                    if(alarm==0) {
                        if(win[room]==open) {
                            print "cooler error: window " room " opened";
                        } else {
                            win[room]=temp;
                            print "success: cooler " room " set to " temp;
                        }
                    } else {
                        print "cooler error: alarm enabled";
                    }
                } else {
                    print "cooler error: temp must be between 18 and 26";
                }
            } else {
                print "error: unknown command";
            }
        }
    } else {
        print "cooler error: room must be between 0 and 9";
    }
    next;
}
/(^#|^[ ]*$)/ {
    print $0;
    next;
}
{print "error: unknown command";}