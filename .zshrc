#!/usr/bin/env zsh

#-------------------------------------
# Setup Zsh
#-------------------------------------

# Misc. aliases

# ls aliases relying on k plugin
alias ls="k --no-vcs -h"
alias ll="ls"
alias l="ls"
alias la="ls -A"

alias compress="tar -cjf"
alias uncompress="tar -xjf"

alias rm="rm -r"
alias cp="cp -r"

alias pretty_json="python3 -m json.tool "

# Tmux aliases
alias ta='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Colorize output and some exclusions
alias grep="grep --color=auto --exclude-dir={.git,.gitignore,.metals}"

# Misc. setup

export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export CLICOLOR=1
export EDITOR=vim
export KEYTIMEOUT=1
export QUOTING_STYLE=literal
export TERM=xterm-256color

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

autoload -U compinit && compinit
zmodload -i zsh/complist

unsetopt menu_complete
unsetopt flowcontrol

autoload colors; colors
setopt prompt_subst
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt interactivecomments
setopt share_history

# Vim key binding
bindkey -v
# Restore Emacs-like line navigation
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line


# -----------------------------------
# Setup Zplugin (Always source last)
# ----------------------------------

source '/Users/damien/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# Apply Pure theme
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

# Some completions
zplugin ice wait"0" blockf
zplugin light "zsh-users/zsh-completions"
zplugin light "zsh-users/zsh-autosuggestions"
zplugin load "zdharma/history-search-multi-word"

# Syntax highlighting
zplugin light "zdharma/fast-syntax-highlighting"

# Enhanced ls
zplugin load "supercrabtree/k"

# Personal quote printer plugin
source "$HOME/.dotfiles/quotify/quotify.plugin.zsh"


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


#-------------------------------------
# Miscellaneous
#-------------------------------------

# Function to calculate into the shell
function calc() {
    echo $[$1]
}

# TMux alias (similar to Tmux plugin)
alias ta='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Youtube MP3 Download (brew install youtube-dl
alias youtubeMp3="youtube-dl -f bestaudio $1 --extract-audio --audio-format mp3"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# To launch GTKWave with command line
export PATH="/Applications/gtkwave.app/Contents/Resources/bin/:$PATH"

# Setup Java home and max memory during SBT compilation
export JAVA_HOME=$(/usr/libexec/java_home)
export SBT_OPTS="-XX:+CMSClassUnloadingEnabled -Xss256M -Xmx2G -Duser.timezone=GMT"
