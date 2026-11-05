# dotfiles

AeroSpace + SketchyBar + Borders + shell zsh para macOS. SketchyBar basado en
[FelixKratz/dotfiles@e6288b3](https://github.com/FelixKratz/dotfiles/tree/e6288b3f4220ca1ac64a68e60fced2d4c3e3e20b),
adaptado a AeroSpace (sin Spotify ni gráficas de CPU).

## Instalar en una Mac nueva

```bash
git clone https://github.com/edcadev/dotfiles.git ~/dotfiles   # debe quedar en ~/dotfiles
~/dotfiles/install.sh
```

Luego: dar permiso de Accesibilidad a AeroSpace y ejecutar `gh auth login`.

## Estructura

| Ruta                              | Destino (symlink)            |
| --------------------------------- | ---------------------------- |
| `config/aerospace/aerospace.toml` | `~/.config/aerospace`        |
| `config/sketchybar/`              | `~/.config/sketchybar`       |
| `config/borders/bordersrc`        | `~/.config/borders`          |
| `config/yazi/`                    | `~/.config/yazi`             |
| `config/starship.toml`            | `~/.config/starship.toml`    |
| `config/ghostty/`                 | `~/.config/ghostty`          |
| `zsh/shell.zsh`                   | al inicio de `~/.zshrc`      |
| `zsh/sketchybar.zsh`              | cargado desde `~/.zshrc`     |
| `Brewfile`                        | dependencias (`brew bundle`) |

Las configs en `~/.config` son symlinks a este repo: edita normal y haz commit.

**Alcance:** aquí solo va el entorno (WM, barra, bordes, shell, prompt, estilos). Lo de desarrollo
(fnm, PHP, pnpm, Android SDK…) va en `~/.zshrc`, que es local y no se versiona: tras formatear
se instala a mano solo lo que haga falta.

## Atajos principales (AeroSpace)

| Atajo                           | Acción                                                  |
| ------------------------------- | ------------------------------------------------------- |
| `alt-1..9`, `alt-w`, `alt-m`    | ir a workspace                                          |
| `alt-shift-1..9`, `-w`, `-m`    | mover ventana (y seguirla)                              |
| `alt-h/j/k/l`                   | foco                                                    |
| `alt-shift-h/j/k/l`             | mover ventana                                           |
| `alt-/`, `alt-,`                | layout tiles / accordion                                |
| `alt-f`                         | pantalla completa                                       |
| `ctrl-alt-s`                    | ocultar/mostrar SketchyBar (para usar el menú de macOS) |
| `alt-enter`                     | Terminal                                                |
| `alt-shift-;`                   | modo service (`f` flotante, `r` reset, `esc` recargar)  |

## Shell (`zsh/shell.zsh`)

Replica la integración zsh de [Kaku](https://github.com/tw93/Kaku) sin depender de la app; funciona en cualquier terminal (Ghostty, iTerm, Terminal…).

- Historial 50k, sin duplicados, compartido entre sesiones. `↑/↓` buscan por prefijo.
- Plugins: `z` (vendorizado en `zsh/plugins/zsh-z`, MIT), autosuggestions, completions y fast-syntax-highlighting (Homebrew).
- `auto_cd`, `auto_pushd`, `Shift+←/→` selecciona, `^U` borra hasta inicio de línea.
- `ls`/`ll`/`la`/`lt2`/`lt3` con eza; `cd` lista el directorio al entrar. `zconfig`/`gconfig` editan `.zshrc`/Ghostty. Prompt: starship.
- Alias: `...`, `md`, git (`g`, `gst`, `gco`, `gcb`, `gd`, `gds`, `glo`…). `y` abre yazi y hace cd al salir.
- `git diff`/`log -p`/`show` con [delta](https://github.com/dandavison/delta) (configurado por `install.sh` en `~/.gitconfig`).

## Notas

- Esquema de color: **Catppuccin Macchiato** en todo (SketchyBar, Borders, Ghostty, Starship, yazi, delta).
  `config/sketchybar/colors.sh` es la paleta base; `bordersrc` la carga directamente.

- macOS 27: `MenuBarAgent` capta clics en la franja superior, por eso SketchyBar usa `topmost=on` + `ctrl-alt-s`.
