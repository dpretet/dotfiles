#!/usr/bin/env zsh

#-------------------------------------
# Setup Zsh
#-------------------------------------

# Misc. aliases

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# ls aliases relying on k plugin
alias ls="k --no-vcs -h"
alias ll="ls"
alias l="ls"
alias la="ls -A"
alias diff="vimdiff"
alias compress="tar -cjf"
alias uncompress="tar -xjf"

alias rm="rm -r"
alias cp="cp -r"
alias du="du -hs"

alias pretty_json="python3 -m json.tool "

# Youtube MP3 Download (brew install youtube-dl
alias youtubeMp3="youtube-dl -f bestaudio $1 --extract-audio --audio-format mp3"

# Tmux aliases
alias ta='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Colorize output and some exclusions
alias grep="grep --color=auto --exclude-dir={.git,.gitignore}"

# Misc. setup
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export CLICOLOR=1
export EDITOR=vim
export KEYTIMEOUT=1
export QUOTING_STYLE=literal
export TERM=xterm-256color

# History setup
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

# Completion
setopt auto_menu
setopt always_to_end
setopt complete_in_word
unsetopt flow_control
unsetopt menu_complete
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

autoload -Uz compinit && compinit
autoload -U promptinit; promptinit
autoload colors; colors

# Vim key binding
bindkey -v
# Restore Emacs-like like navigation
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# -----------------------------------
# Setup zinit (Always source last)
# ----------------------------------

if [ -d '/Users/damien' ]; then
    source '/Users/damien/.zinit/bin/zinit.zsh'
else
    source "/home/$USER/.zinit/bin/zinit.zsh"
fi

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# Apply Pure theme
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# Syntax highlighting
zinit light "zdharma/fast-syntax-highlighting"

# Enhanced ls utility
zinit load "supercrabtree/k"

# Personal quote printer plugin
zinit load "damofthemoon/zsh-quotify"

# Aditional completion
zinit light "zsh-users/zsh-completions"
zinit light "zsh-users/zsh-autosuggestions"

#------------------------------------
# Setup FZF
#-------------------------------------

[ -f ~/.fzf.zsh ] && source "$HOME/.fzf.zsh"

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER=',,'

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Follow symbolic links, and don't want it to exclude hidden files
# Respect Git ignore file setup
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

source $HOME/.fzf/shell/completion.zsh
source $HOME/.fzf/shell/key-bindings.zsh

#-------------------------------------
# Dev environment setup
#-------------------------------------

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# To launch GTKWave with command line on MacOs
if [ -d '/Applications/gtkwave.app' ]; then
    export PATH="/Applications/gtkwave.app/Contents/Resources/bin/:$PATH"
fi

# Setup Java home and max memory during SBT compilation
if [ -d "/usr/libexec/java_home" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.bin/:$PATH"
export PATH="$HOME/.svut/:$PATH"
export PATH="$HOME/.dotfiles/:$PATH"

#-------------------------------------
# Generic function to extract archive
#-------------------------------------

extract ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar)       tar xf $1    ;;
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' Cant't be extracted" ;;
    esac
  else
    echo "'$1' Invalid file"
  fi
}

function pretty_csv {
    column -t -s, "$@" | less -F -S -X -K
}
### End of Zinit's installer chunk
