# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/damien/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="maran"

plugins=(git tmux fzf)

source $ZSH/oh-my-zsh.sh

alias chisel_template="sbt new seldridge/chisel-template.g8"
alias sshferm="ssh -YC damien@192.168.100.231"

export PATH=/Applications/gtkwave.app/Contents/Resources/bin/:$PATH
export PATH=$HOME/.bin/diagrammer/:$PATH
export PATH=$HOME/.bin/:$PATH
export PATH=$HOME/.svut/:$PATH
export RISCV=$HOME/.bin/riscv-tools
#-------------------------------------
# Setup FZF
#-------------------------------------

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
