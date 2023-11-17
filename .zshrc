
# ███████  ██████   ██████  ███    ███ ███████ ██████  
#    ███  ██    ██ ██    ██ ████  ████ ██      ██   ██ 
#   ███   ██    ██ ██    ██ ██ ████ ██ █████   ██████  
#  ███    ██    ██ ██    ██ ██  ██  ██ ██      ██   ██ 
# ███████  ██████   ██████  ██      ██ ███████ ██   ██ 
#                                                      
#                                                      
# ███████ ██   ██ ███████ ██      ██      
# ██      ██   ██ ██      ██      ██      
# ███████ ███████ █████   ██      ██      
#      ██ ██   ██ ██      ██      ██      
# ███████ ██   ██ ███████ ███████ ███████ by l1amsi 
#                                         


# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# The user's variables
BROWSER='brave'
TERMINAL='alacritty'

export PATH="$HOME/.local/bin:$PATH"
export QT_QPA_PLATFORMTHEME=qt5ct="qt5ct"

# Aliases
alias ls='exa -a --group-directories-first --icons'
alias ..='cd ..'
alias chx='chmod +x'
alias gc='git clone'
alias gdf='/usr/bin/git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'
alias sv='sudo sv'
alias sudoedit='sudo $HOME/.local/bin/lvim'
alias cat='batcat'
alias grep='rg'
alias nf='neofetch'
alias lv='$HOME/.local/bin/lvim'
alias dot='/usr/bin/git --git-dir=$HOME/Github/dotfiles/ --work-tree=$HOME'

## Dirs


# ZSH Auto Notify
export AUTO_NOTIFY_THRESHOLD=20
export AUTO_NOTIFY_TITLE="Hey $USER! %command has just finished"
export AUTO_NOTIFY_BODY="It completed in %elapsed seconds with exit code %exit_code"
export AUTO_NOTIFY_EXPIRE_TIME=5000
AUTO_NOTIFY_IGNORE+=("pipes" "nano" "bat" "more" "less" "cat" "docker" "man" "sleep" "vim" "nvim" "lvim" "htop" "top" "newsboat" "ncmpcpp" "cava")

# ZSH You Should Use
#export YSU_MESSAGE_POSITION="before"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'

bindkey -s '^a' '^ubc -lq\n'

bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# ZSH Plugins; should be last.
source /home/liamsi/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/liamsi/.config/zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh
source /home/liamsi/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
#source /home/liamsi/.config/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
