#!/bin/bash
# Restaura AeroSpace + SketchyBar + Borders + shell (zsh, starship, yazi) + Ghostty en una Mac nueva.
# Uso: git clone <repo> ~/dotfiles && ~/dotfiles/install.sh
set -euo pipefail
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# 1. Homebrew
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Paquetes (Homebrew 7 exige confiar explícitamente en las fórmulas del tap de FelixKratz)
brew tap felixkratz/formulae
if brew help trust >/dev/null 2>&1; then
  brew trust --formula felixkratz/formulae/sketchybar
  brew trust --formula felixkratz/formulae/borders
fi
brew bundle --file="$DOTFILES/Brewfile"

# 3. Symlinks de configuración (respalda lo que hubiera)
mkdir -p "$HOME/.config"
for c in aerospace sketchybar borders yazi starship.toml; do
  target="$HOME/.config/$c"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    mv "$target" "$target.bak.$(date +%Y%m%d-%H%M%S)"
  fi
  ln -sfn "$DOTFILES/config/$c" "$target"
done

# 4a. Shell base: debe ir al INICIO de ~/.zshrc (hace compinit)
line='[ -f ~/dotfiles/zsh/shell.zsh ] && source ~/dotfiles/zsh/shell.zsh'
if ! grep -qxF "$line" "$HOME/.zshrc" 2>/dev/null; then
  { echo "$line"; cat "$HOME/.zshrc" 2>/dev/null; } > "$HOME/.zshrc.tmp" && mv "$HOME/.zshrc.tmp" "$HOME/.zshrc"
fi

# 4b. Funciones zsh (brew → actualiza contador, zen)
line="[ -f ~/dotfiles/zsh/sketchybar.zsh ] && source ~/dotfiles/zsh/sketchybar.zsh"
grep -qxF "$line" "$HOME/.zshrc" 2>/dev/null || echo "$line" >> "$HOME/.zshrc"

# 5. Ocultar barra de menús de macOS (SketchyBar la sustituye; alt-m la deja ver)
defaults write NSGlobalDomain _HIHideMenuBar -bool true
killall SystemUIServer 2>/dev/null || true

# 6. Arrancar servicios
brew services restart felixkratz/formulae/sketchybar
brew services restart felixkratz/formulae/borders
open -a AeroSpace

cat <<'MSG'

Listo. Pasos manuales:
  1. Ajustes del Sistema → Privacidad y seguridad → Accesibilidad: activar AeroSpace.
  2. `gh auth login` para las notificaciones de GitHub en la barra.
  3. Abrir una terminal nueva (carga las funciones brew/zen).
MSG
