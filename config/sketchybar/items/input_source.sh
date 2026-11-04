#!/bin/bash

input_source=(
  script="$PLUGIN_DIR/input_source.sh"
  icon=$KEYBOARD
  icon.font="$FONT:Regular:15.0"
  label.font="$FONT:Semibold:12.0"
  padding_left=5
  padding_right=5
  updates=on
)

sketchybar --add event input_change AppleSelectedInputSourcesChangedNotification \
           --add item input_source right                \
           --set input_source "${input_source[@]}"      \
           --subscribe input_source input_change system_woke
