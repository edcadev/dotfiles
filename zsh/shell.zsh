# Cargar al INICIO de ~/.zshrc: hace compinit (zsh-completions necesita fpath antes).

DOTFILES_ZSH="${${(%):-%x}:A:h}"
BREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

# Historial
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="${HISTFILE:-${ZDOTDIR:-$HOME}/.zsh_history}"
setopt HIST_IGNORE_ALL_DUPS HIST_FIND_NO_DUPS HIST_REDUCE_BLANKS HIST_IGNORE_SPACE
setopt SHARE_HISTORY EXTENDED_HISTORY   # SHARE_HISTORY ya escribe incrementalmente (no combinar con INC_APPEND_HISTORY)

# Opciones
setopt interactive_comments auto_cd auto_pushd pushd_ignore_dups pushdminus
bindkey -e

# ↑/↓ buscan en el historial por prefijo (escribe "git" y pulsa ↑)
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
for _km in emacs viins; do
    bindkey -M $_km '^[[A' up-line-or-beginning-search '^[OA' up-line-or-beginning-search
    bindkey -M $_km '^[[B' down-line-or-beginning-search '^[OB' down-line-or-beginning-search
done
unset _km

# Shift+←/→ seleccionan carácter; Shift+Home/End hasta borde de línea
_sel() { (( REGION_ACTIVE )) || zle set-mark-command; zle "$1"; }
_sel_left()  { _sel backward-char }
_sel_right() { _sel forward-char }
_sel_home()  { _sel beginning-of-line }
_sel_end()   { _sel end-of-line }
zle -N _sel_left; zle -N _sel_right; zle -N _sel_home; zle -N _sel_end
bindkey '^[[1;2D' _sel_left '^[[1;2C' _sel_right '^[[1;2H' _sel_home '^[[1;2F' _sel_end

# Cmd+Backspace (Ghostty/iTerm mandan ^U): borrar hasta inicio, no la línea entera
bindkey '^U' backward-kill-line
bindkey '^?' backward-delete-char '^H' backward-delete-char '^[[3~' delete-char

# Alias
_eza='eza --group-directories-first --icons --color=auto'
alias ls="$_eza" ll="$_eza -l" la="$_eza -la" lt2="$_eza --tree --level=2" lt3="$_eza --tree --level=3"
unset _eza
cd() { builtin cd "$@" && eza --icons=always --color=always --group-directories-first; }   # cd + ls automático
alias zconfig='nvim ~/.zshrc' gconfig='nvim ~/.config/ghostty/config'
alias ...='../..' ....='../../..' .....='../../../..' ......='../../../../..'
alias md='mkdir -p' rd=rmdir
alias grep='grep --color=auto' egrep='grep -E --color=auto' fgrep='grep -F --color=auto'
alias g='git' ga='git add' gaa='git add --all' gb='git branch' gbd='git branch -d'
alias gc='git commit -v' gcmsg='git commit -m' gco='git checkout' gcb='git checkout -b'
alias gd='git diff' gds='git diff --staged' gf='git fetch' gl='git pull' gp='git push'
alias gst='git status' gss='git status -s' glo='git log --oneline --decorate'
alias glg='git log --stat' glgp='git log --stat -p'

# y: yazi y al salir cd al directorio donde quedaste
y() {
    local tmp cwd
    tmp="$(mktemp -t yazi-cwd.XXXXXX)"
    command yazi "$@" --cwd-file="$tmp"
    cwd="$(<"$tmp")"
    [[ -n "$cwd" && "$cwd" != "$PWD" ]] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# Completado: zsh-completions + compinit con caché (regenera si tiene >24h)
fpath=("$BREW_PREFIX/share/zsh-completions" "$DOTFILES_ZSH/plugins/zsh-z" $fpath)
autoload -Uz compinit
() {
    setopt local_options extended_glob
    if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh-24) ]]; then compinit -C; else compinit; fi
}

# z: saltar a directorios frecuentes (historial en ~/.z)
: "${ZSHZ_CASE:=smart}"; export ZSHZ_CASE
source "$DOTFILES_ZSH/plugins/zsh-z/zsh-z.plugin.zsh"

# cd+Tab: si no hay directorio que coincida, sugiere desde el historial de z
_cd_z_fallback() {
    _cd && (( compstate[nmatches] )) && return 0
    [[ -n $PREFIX && $PREFIX != -* ]] || return 1
    local -a m=("${(@f)$(zshz --complete -- "$PREFIX" 2>/dev/null)}")
    m=(${m:#})
    (( $#m )) && compadd -Q -U -X "historial z" -- "${m[@]}"
}
compdef _cd_z_fallback cd

# Autosugerencias (→ o Ctrl+E aceptan)
[[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Resaltado de sintaxis: diferido al primer prompt (arranque más rápido, y queda último)
_fsh_defer() {
    precmd_functions=(${precmd_functions:#_fsh_defer})
    local f="$BREW_PREFIX/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
    [[ -f "$f" ]] || return
    source "$f"
    FAST_HIGHLIGHT_STYLES[comment]='fg=249'      # default fg=8 es ilegible en fondo oscuro
    FAST_HIGHLIGHT_STYLES[path-to-dir]='fg=magenta'
}
precmd_functions+=(_fsh_defer)

# Prompt (config en config/starship.toml)
eval "$(starship init zsh)"
