# dotfiles

AeroSpace + SketchyBar + Borders para macOS. SketchyBar basado en
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
| `zsh/sketchybar.zsh`              | cargado desde `~/.zshrc`     |
| `Brewfile`                        | dependencias (`brew bundle`) |

Las configs en `~/.config` son symlinks a este repo: edita normal y haz commit.

## Atajos principales (AeroSpace)

| Atajo                           | Acción                                                  |
| ------------------------------- | ------------------------------------------------------- |
| `alt-1..9`, `alt-w`             | ir a workspace                                          |
| `alt-shift-1..9`, `alt-shift-w` | mover ventana (y seguirla)                              |
| `alt-h/j/k/l`                   | foco                                                    |
| `alt-shift-h/j/k/l`             | mover ventana                                           |
| `alt-/`, `alt-,`                | layout tiles / accordion                                |
| `alt-f`                         | pantalla completa                                       |
| `alt-m`                         | ocultar/mostrar SketchyBar (para usar el menú de macOS) |
| `alt-enter`                     | Terminal                                                |
| `alt-shift-;`                   | modo service (`f` flotante, `r` reset, `esc` recargar)  |

## Notas

- macOS 27: `MenuBarAgent` capta clics en la franja superior, por eso SketchyBar usa `topmost=on` + `alt-m`.
