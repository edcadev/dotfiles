# SketchyBar (de FelixKratz/dotfiles): refrescar contador de brew y modo zen
function brew() {
  command brew "$@"
  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}
function zen () {
  ~/.config/sketchybar/plugins/zen.sh $1
}
