#!/bin/bash

name=Togglehidepanelplasma

# xwininfo reply (xorg-xwininfo)
hide=IsUnMapped
unhide=IsViewable

# Check if plasma panel name is set
if xwininfo -name $name ; then
    echo " All set"
else
    #xdotool selectwindow set_window --name "$name"
    ## Auto select the panel by mouse
    xdotool mousemove 500 15 ; xdotool selectwindow set_window --name "$name" & sleep 0.2 ;  xdotool click 1
fi

# Current panel status
status=$(xwininfo -name $name | grep 'Map State' | awk '{print $3}')

# Toggle the panel

## if the panel is hidden then show it
if [ $status == $hide ] ; then

    if xdotool search -all --class "plasmashell" search --name "^$name"  windowmap ; then
        echo "Plasma Panel is unhidden now"
    fi
else

## is the panel is not hidden then hide it.
    if [ $status == $unhide ] ; then
        if xdotool search -all --class "plasmashell" search --name "^$name"  windowunmap ; then
            echo "Plasma Panel is hidden now"
            fi
        fi

fi
