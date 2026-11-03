#!/bin/bash
# Versión AeroSpace de yabai.sh: icono según layout y color de Borders a juego.

window_state() {
  source "$HOME/.config/sketchybar/colors.sh"
  source "$HOME/.config/sketchybar/icons.sh"

  STATE=$(aerospace list-windows --focused --format '%{window-layout}|%{window-is-fullscreen}' 2>/dev/null)
  LAYOUT=${STATE%%|*}
  FULLSCREEN=${STATE##*|}

  if [ "$FULLSCREEN" = "true" ]; then
    ICON=$YABAI_FULLSCREEN_ZOOM; COLOR=$GREEN
  else
    case "$LAYOUT" in
      floating)      ICON=$YABAI_FLOAT; COLOR=$MAGENTA ;;
      *accordion*)   ICON=$YABAI_STACK; COLOR=$RED ;;
      *)             ICON=$YABAI_GRID;  COLOR=$ORANGE ;;
    esac
  fi

  # Borde: blanco en tiles (como el original), color del estado en el resto
  BORDER=$COLOR
  [ "$ICON" = "$YABAI_GRID" ] && BORDER=0xffe1e3e4
  borders active_color=$BORDER > /dev/null 2>&1 &

  sketchybar --set $NAME icon=$ICON icon.color=$COLOR
}

mouse_clicked() {
  aerospace layout floating tiling
  window_state
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked ;;
  *) window_state ;;
esac
