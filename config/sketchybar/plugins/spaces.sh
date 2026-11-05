#!/bin/bash
# Equivalente a space.sh + windows_on_spaces de yabai.sh, para AeroSpace.
source "$HOME/.config/sketchybar/plugins/icon_map.sh"

focused=$(aerospace list-workspaces --focused)
windows=$(aerospace list-windows --all --format '%{workspace}|%{app-name}')

args=()
for sid in 1 2 3 4 5 6 7 8 9 W M; do
  icon_strip=" "
  while IFS='|' read -r ws app; do
    [ "$ws" = "$sid" ] || continue
    __icon_map "$app"
    icon_strip+=" $icon_result"
  done <<< "$windows"

  if [ "$sid" = "$focused" ]; then
    # Workspace activo: resaltado en rojo, iconos de apps ocultos (como el original)
    args+=(--set space.$sid drawing=on icon.highlight=true label="$icon_strip" label.drawing=on label.width=0)
  elif [ "$icon_strip" != " " ]; then
    args+=(--set space.$sid drawing=on icon.highlight=false label="$icon_strip" label.drawing=on label.width=dynamic)
  else
    args+=(--set space.$sid drawing=off icon.highlight=false)
  fi
done

sketchybar --animate tanh 20 "${args[@]}"
