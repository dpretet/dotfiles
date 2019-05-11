#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Hello! This script is about to install a dev setup relying on Vim, Tmux, Git, Zsh, Spacemacs"
echo ""
echo "Make sure Vim, Git, Zsh, bash profile, TMux or Spacemacs configuration files exist in your home folder"
echo "All configuration files will be symlinked from this folder. Please backup first your environment before continuing"
echo ""
echo "The script will also install Oh-My-Zsh (Zsh under steroids) and Spacemacs (Assuming Emacs is ready to use)"
echo "  - Vundle: https://github.com/VundleVim/Vundle.vim"
echo "  - Oh-My-Zsh: https://github.com/robbyrussell/oh-my-zsh"
echo "  - Spacemacs: http://spacemacs.org/"

read -rp "Do you want to continue(y/n)? " answer

case ${answer:0:1} in
    y|Y )
        echo" Start setup"
    ;;
    * )
        echo "Abort..."
        exit 0
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
echo "Create .spacemacs symlink"
ln -sf "$DIR/.spacemacs" "$HOME/.spacemacs"

if [ ! -d "$HOME/.vim/bundle/Vundle" ]; then
    echo "Vim Vundle plugin is not install. Clone it"
    echo "Then run ':PlugInstall' into Vim"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Install Oh-My-Zsh"
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -d "$HOME/.emacs.d" ]; then
    echo "Install Spacemacs"
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

if [ ! -d "$HOME/.fzf" ]; then
    echo "Install FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

echo "Install done!"
exit 0
