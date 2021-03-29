#!/usr/bin/env zsh

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

export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="$HOME/.bin/nvim-osx64/bin:$PATH"

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.bin/:$PATH"
export PATH="$HOME/.svut/:$PATH"
export PATH="$HOME/.dotfiles/:$PATH"
export VIMRC="$HOME/.dotfiles/nvim"
export NOTES="$HOME/.notes"

# Setup C and C++ include path for macOs
# MACOS_C_INCLUDE_PATH="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include"
#
# if [[ -d $MACOS_C_INCLUDE_PATH ]]; then
    # export C_INCLUDE_PATH=$MACOS_C_INCLUDE_PATH:$C_INCLUDE_PATH
# fi
#
# MACOS_CPLUS_INCLUDE_PATH="/Library/Developer/CommandLineTools/usr/include/c++/v1/"
#
# if [[ -d $MACOS_CPLUS_INCLUDE_PATH ]]; then
    # export CPLUS_INCLUDE_PATH=$MACOS_CPLUS_INCLUDE_PATH:$CPLUS_INCLUDE_PATH
# fi

# Setup Rust development environment
export PATH="$HOME/.cargo/bin:$PATH"

# RISCV GNU Toolchain built manually
export PATH="/opt/riscv/bin:$PATH"
export C_INCLUDE_PATH="/opt/riscv/include/:$C_INCLUDE_PATH"

#-------------------------------------
# Setup Zsh
#-------------------------------------

# Misc. aliases

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
fi

# ls aliases relying on k plugin
alias ls="k --no-vcs -h"
alias ll="ls"
alias l="ls"
alias la="ls -A"
alias compress="tar -cjf"
alias uncompress="tar -xjf"
alias j="jobs"

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
export MANPAGER='nvim +Man!'

autoload -Uz compinit && compinit -i

# History setup:

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history

# Completion behavior setup:

setopt COMPLETE_IN_WORD # Complete from both ends of a word
setopt ALWAYS_TO_END    # Move cursor to the end of a completed word
setopt PATH_DIRS        # Perform path search even on command names with slashes
setopt AUTO_LIST        # Automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH # If completed parameter is a directory, add a slash
setopt AUTO_MENU        # Show completion menu on a succesive tab press
unsetopt MENU_COMPLETE  # Do not autoselect the first completion entry
unsetopt FLOW_CONTROL   # Disable ^S/^Q flow contro

# Enable a local cache to setup completion
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Case-insensitive (all), partial-word, and then substring completion.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
unsetopt CASE_GLOB

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

autoload colors; colors

# Vim key binding
bindkey -v

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
zinit light denysdovhan/spaceship-prompt
spaceship_vi_mode_enable

# Enhanced ls utility
zinit load "supercrabtree/k"

# Personal quote printer plugin
zinit load "damofthemoon/zsh-quotify"


#------------------------------------
# Setup FZF
#-------------------------------------

[ -f ~/.fzf.zsh ] && source "$HOME/.fzf.zsh"

# Use ,, as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER=',,'

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'


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
