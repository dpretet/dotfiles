#-----------------------------------------------------------
# Misc. aliases
#-----------------------------------------------------------

alias ls="ls -l --color"
alias l="ls"
alias ll="ls"
alias la="ls -a"

alias rm="rm -r"
alias cp="cp -r"
alias du="du -hs"
alias grep="grep --color=auto --exclude-dir={.git,.gitignore}"

alias ta='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# Enable Git completion
source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh

#-----------------------------------------------------------
# Color and prompt setup
#-----------------------------------------------------------

force_color_prompt=yes
BLUE="\[\e[0;34m\]"
GREY="\[\e[1;30m\]"
PURPLE="\[\e[0;35m\]"
NOCOLOR="\[\e[0m\]"
export PS1="${GREY}\u@\h${NOCOLOR} ${BLUE}\w${NOCOLOR}${GREY}$(__git_ps1)${NOCOLOR} ${PURPLE}❯${NOCOLOR} "

#-----------------------------------------------------------
# Setup from mrzool/bash-sensible
#-----------------------------------------------------------

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
# shopt -s nocaseglob;

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

#-----------------------------------------------------------
# Enable FZF
#-----------------------------------------------------------

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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

source $HOME/.fzf/shell/completion.bash
source $HOME/.fzf/shell/key-bindings.bash

# Source custom local install
export PATH="$HOME/.bin/:$PATH"
export PATH="$HOME/.svut/:$PATH"
export PATH="$HOME/.dotfiles/:$PATH"

# Utility to extract archive
extract ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' Cant't be extracted" ;;
    esac
  else
    echo "'$1' Invalid file"
  fi
}
