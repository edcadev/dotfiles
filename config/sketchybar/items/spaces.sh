#!/bin/bash
# AeroSpace: workspaces fijos (ver aerospace.toml). Clic izquierdo = ir al workspace.
SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "W")

sketchybar --add event aerospace_workspace_change

for sid in "${SPACE_ICONS[@]}"
do
  space=(
    icon=$sid
    icon.padding_left=10
    icon.padding_right=15
    padding_left=2
    padding_right=2
    label.padding_right=20
    icon.highlight_color=$RED
    label.font="sketchybar-app-font:Regular:16.0"
    label.background.height=26
    label.background.drawing=on
    label.background.color=$BACKGROUND_2
    label.background.corner_radius=8
    label.drawing=off
    drawing=off
    click_script="aerospace workspace $sid"
  )

  sketchybar --add item space.$sid left    \
             --set space.$sid "${space[@]}"
done

# Un solo script actualiza todos los workspaces por evento
sketchybar --add item spaces_ctl left \
           --set spaces_ctl drawing=off updates=on script="$PLUGIN_DIR/spaces.sh" \
           --subscribe spaces_ctl aerospace_workspace_change front_app_switched space_windows_change system_woke

spaces=(
  background.color=$BACKGROUND_1
  background.border_color=$BACKGROUND_2
  background.border_width=2
  background.drawing=on
)

separator=(
  icon=􀆊
  icon.font="$FONT:Heavy:16.0"
  padding_left=15
  padding_right=15
  label.drawing=off
  associated_display=active
  icon.color=$WHITE
)

sketchybar --add bracket spaces '/space\..*/' \
           --set spaces "${spaces[@]}"        \
                                              \
           --add item separator left          \
           --set separator "${separator[@]}"
