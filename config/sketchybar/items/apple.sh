#!/bin/bash

POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

apple_logo=(
  icon=$APPLE
  icon.font="$FONT:Black:16.0"
  icon.color=$GREEN
  padding_right=15
  label.drawing=off
  click_script="$POPUP_CLICK_SCRIPT"
)

apple_prefs=(
  icon=$PREFERENCES
  label="Preferences"
  click_script="open -a 'System Settings'; $POPUP_OFF"
)

apple_activity=(
  icon=$ACTIVITY
  label="Activity"
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

apple_lock=(
  icon=$LOCK
  label="Lock Screen"
  click_script="pmset displaysleepnow; $POPUP_OFF"
)

apple_sleep=(
  icon=$SLEEP
  label="Sleep"
  click_script="$POPUP_OFF; pmset sleepnow"
)

# Diálogo nativo de confirmación: evita apagar por un clic accidental
apple_power=(
  icon=$POWER
  label="Shut Down"
  click_script="$POPUP_OFF; osascript -e 'tell application \"loginwindow\" to «event aevtrsdn»'"
)

sketchybar --add item apple.logo left                  \
           --set apple.logo "${apple_logo[@]}"         \
                                                       \
           --add item apple.prefs popup.apple.logo     \
           --set apple.prefs "${apple_prefs[@]}"       \
                                                       \
           --add item apple.activity popup.apple.logo  \
           --set apple.activity "${apple_activity[@]}" \
                                                       \
           --add item apple.lock popup.apple.logo      \
           --set apple.lock "${apple_lock[@]}"         \
                                                       \
           --add item apple.sleep popup.apple.logo     \
           --set apple.sleep "${apple_sleep[@]}"       \
                                                       \
           --add item apple.power popup.apple.logo     \
           --set apple.power "${apple_power[@]}"
