alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias lr='ls --color=auto -lR'
alias la='ls --color=auto -la'
alias :q='exit'
alias :e='vim'

export SVUNIT_INSTALL=$HOME"/.bin/svunit"
export PATH=$SVUNIT_INSTALL"/bin":$PATH

export LC_ALL=en_US.UTF-8
export LANG="$LC_LANG"

bindkey -e
ZSH_THEME="agnoster"
CASE_SENSITIVE="true"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -U compinit
compinit

autoload -U promptinit
promptinit

plugins=(git tmux)

source ~/.git-prompt.sh
setopt PROMPT_SUBST ; PROMPT='%n@%m: %{$PR_BOLD_RED%}${${(%):-%~}//\//${PR_BOLD_RED}/%f}%f '
export DISABLE_AUTO_TITLE=true
export ZSH=~/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

