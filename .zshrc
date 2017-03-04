#------------------------------------------------------------
# Lines configured by zsh-newuser-install
#------------------------------------------------------------

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob
bindkey -e
ZSH_THEME="agnoster"
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

autoload -Uz promptinit
promptinit

plugins=(git tmux)
source ~/.git-prompt.sh
export DISABLE_AUTO_TITLE=true
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

#------------------------------------------------------------
# End of lines added by compinstall
#------------------------------------------------------------

# Lines added by user

export TERM=screen-256color

export CLICOLOR=1
alias ls='ls -G'
alias ll='ls -G -l'
alias lr='ls -G -lR'
alias la='ls -G -la'

alias :e="vim"
alias :q="exit"
alias tmux='tmux -2'
alias cp='cp -r'
alias scp='scp -r'
alias rsync='rsync -aAXWs --progress'
alias ssh='ssh -YC -c blowfish-cbc,arcfour'

