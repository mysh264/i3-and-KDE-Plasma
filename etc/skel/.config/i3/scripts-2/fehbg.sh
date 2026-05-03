#!/bin/bash

walldir=$HOME/.Wallpapers/*
app=feh
scale=--bg-fill
options="--randomize --recursive"

# Default values
VERBOSE=300 # 5 min

# ':' after a letter means that option requires an argument
while getopts "t:" opt; do
  case $opt in
    t)
      VERBOSE=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

while $app $options $scale $walldir;
do sleep $VERBOSE;
done
