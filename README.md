# Unix timestamp keyboard shortcut

## Dependencies
1. xdotool
2. xbindkeys

On ubuntu, you can install the dependencies by running the following
```
sudo apt install xdotool xbindkeys
```

## Install with Makefile
1. Clone the repo
2. `cd` into the repo directory
3. Run `make install`

## Install manually
TBD

## Changing the default shortcut
1. Open up ~/.xbindkeysrc
2. Find the line that contains "timestamp_kb_shortcut.sh"
3. On the next line is the shortcut (default is F10). Change this line to whatever you want
