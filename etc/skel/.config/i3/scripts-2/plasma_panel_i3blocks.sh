#!/bin/bash

## I3blocks colours
# https://unix.stackexchange.com/questions/583409/i3blocks-script-coloring

name=Togglehidepanelplasma

# xwininfo reply (xorg-xwininfo)
hide=IsUnMapped
unhide=IsViewable

# Current panel status
status=$(xwininfo -name $name | grep 'Map State' | awk '{print $3}')

# Check if plasma panel name is set
if xwininfo -name $name &> /dev/null ; then
    if [ $status == $hide ] ; then
        #echo " "
        echo
        #echo \#961c90

    else
        if [ $status == $unhide ] ; then
            echo " "
            echo
            echo \#15ff00
        fi
    fi

else
    echo "  Plasma Panel"
    echo
    echo  \#c20707
fi
