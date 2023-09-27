#!/bin/bash

# Dependencies
# xdotool
# xbindkeys

# Ubuntu Install:
# sudo apt install xdotool xbindkeys

timestamp=$(date +%s)
sleep 0.3
xdotool type "$timestamp"

