#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Hello! This script is about to install a dev setup relying on Vim, Tmux, Git, Zsh"
echo ""
echo "Make sure Vim, Git, Zsh, or Tmux configuration files exist in your home folder"
echo "All configuration files will be symlinked from this folder. Please backup first your environment before continuing"
echo ""
echo "The script will also install additional softwares"
echo "  - Vundle, Vim plugin manager: https://github.com/VundleVim/Vundle.vim"
echo "  - Oh-My-Zsh, ZSH under steroids: https://github.com/robbyrussell/oh-my-zsh"
echo "  - FZF, a command-line fuzzy finder: https://github.com/junegunn/fzf"
echo "  - Zplugin: https://github.com/zdharma/zplugin"
echo ""

read -rp "Do you want to continue (y/n)? " answer
echo ""

case ${answer:0:1} in
    y|Y )
        echo" Start setup\n"
    ;;
    * )
        echo "Abort..."
        exit 1
    ;;
esac

echo "Create .vim symlink"
ln -sf "$DIR/.vim" "$HOME/.vim"

echo "Create .zshrc symlink"
ln -sf "$DIR/.zshrc" "$HOME/.zshrc"

echo "Create .tmux.conf symlink"
ln -sf "$DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DIR/.tmux" "$HOME/.tmux"

echo "Create .git files symlinks"
ln -sf "$DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DIR/.git-completion.zsh" "$HOME/.git-completion.zsh"
ln -sf "$DIR/.git-prompt.sh" "$HOME/.git-prompt.sh"

echo "Create Ctags sylink"
ln -sf "$DIR/.ctags" "$HOME/.ctags"

if [ ! -d "$HOME/.vim/bundle/Vundle" ]; then
    echo "Vim Vundle plugin is not install. Clone it"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    echo "Install Vim plugins"
    vim +PluginInstall +qall
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Install Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -d "$HOME/.fzf" ]; then
    echo "Install FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

if [ ! -d "$HOME/.zplugin" ]; then
    echo "Install Zplugin"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

echo "To use ctrl-t in Vim, install Ctags to parse easily your source code: http://ctags.sourceforge.net"
echo ""

echo "For better rendering of NerdTree display in Vim, consider to install nerd-fonts:"
echo "https://github.com/ryanoasis/nerd-fonts#font-installation"
echo ""

echo "Install done!"
exit 0
