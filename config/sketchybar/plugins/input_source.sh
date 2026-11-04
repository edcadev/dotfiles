#!/bin/bash

SRC=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources)

case "$SRC" in
  *Zhuyin*)           LABEL="注" ;;
  *"Latin American"*) LABEL="LA" ;;
  *'"U.S."'*)         LABEL="US" ;;
  *)                  LABEL="??" ;;
esac

sketchybar --set "$NAME" label="$LABEL"
