# SketchyBar (de FelixKratz/dotfiles): refrescar contador de brew y modo zen
function brew() {
  command brew "$@"
  local rc=$?
  [[ $1 == (update|upgrade|outdated) ]] && sketchybar --trigger brew_update
  return $rc
}
function zen () {
  ~/.config/sketchybar/plugins/zen.sh $1
}
