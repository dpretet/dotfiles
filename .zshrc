#-------------------------------------
# Setup Zsh
#-------------------------------------

# Oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="kennethreitz"
plugins=(git tmux fzf quotify)
source "$ZSH/oh-my-zsh.sh"

# History
HISTSIZE=999999
SAVEHIST=999999
setopt hist_verify             # Show command with history expansion to user before running it
setopt share_history           # Share command history data
setopt extended_history        # Record timestamp of command in HISTFILE
setopt hist_ignore_dups        # Ignore duplicated commands history list
setopt inc_append_history      # Add commands to HISTFILE in order of execution
setopt hist_expire_dups_first  # Delete duplicates first when HISTFILE size exceeds HISTSIZE

# Autocompletion
setopt auto_menu         # Show completion menu on successive tab press
setopt always_to_end     # Move cursor to end of word if completed in-word
setopt complete_in_word
ZSH_CACHE_DIR=$HOME/.cache/zsh
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
autoload -U compinit && compinit -u -d ${XDG_CACHE_HOME:-~/.cache}/zsh/zcompdump-$ZSH_VERSION

# Miscellaneous
bindkey -v
unsetopt flowcontrol       # Disable Ctrl-S + Ctrl-Q
unsetopt menu_complete     # Do not autoselect the first completion entry

export PATH="/Applications/gtkwave.app/Contents/Resources/bin/:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home)

#-------------------------------------
# Setup FZF
#-------------------------------------

[ -f ~/.fzf.zsh ] && source "$HOME/.fzf.zsh"

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER=',,'

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

#-------------------------------------
# Setup Zplugin
#-------------------------------------

source '/Users/damien/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light zdharma/fast-syntax-highlighting

#-------------------------------------
# Miscellaneous
#-------------------------------------

# Function to calculate into the shell
function calc() {
    echo $[$1]
}
