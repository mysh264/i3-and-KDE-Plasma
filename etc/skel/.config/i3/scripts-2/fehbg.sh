#!/bin/bash

walldir=$HOME/.Wallpapers/*
app=feh
scale=--bg-fill
options="--randomize --recursive"

# Default values
SLEEP_TIME=300 # 5 min

# ':' after a letter means that option requires an argument
while getopts "t:" opt; do
  case $opt in
    t)
      SLEEP_TIME=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

while $app $options $scale $walldir;
do sleep $SLEEP_TIME;
done
