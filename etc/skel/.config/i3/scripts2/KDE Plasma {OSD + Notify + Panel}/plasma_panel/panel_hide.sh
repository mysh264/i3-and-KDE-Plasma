#!/bin/bash
set -x
ID=$(xdotool search --name "Togglehidepanelplasma" | head -n 1)
[ -z "$ID" ] && exit 1

xdotool windowunmap "$ID"
