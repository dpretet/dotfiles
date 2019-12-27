#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Hello! This script is about to install a dev setup relying on Vim, Tmux, Git, Zsh"
echo ""
echo "Make sure Vim, Git, Zsh, or Tmux configuration files exist in your home folder"
echo "All configuration files will be symlinked from this folder. Please backup first your environment before continuing"
echo ""
echo "The script will also install additional softwares"
echo "  - Vundle, Vim plugin manager: https://github.com/VundleVim/Vundle.vim"
echo "  - FZF, a command-line fuzzy finder: https://github.com/junegunn/fzf"
echo "  - Zplugin: https://github.com/zdharma/zplugin"
echo "  - SVUT: git@github.com:damofthemoon/svut.git"
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

echo "Create Ctags symlink"
ln -sf "$DIR/.ctags" "$HOME/.ctags"

echo "Create GtKWaverc symlink"
ln -sf "$DIR/.gtkwaverc" "$HOME/.gtkwaverc"

if [ ! -d "$HOME/.vim/autoload/plug.vim" ]; then
    echo "Vim-plugin is not install. Clone it (Vim8)"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "Install Vim plugins"
    vim +PlugInstall +qall
fi

if [ ! -d ~/.local/share/nvim/site/autoload/plug.vim]; then
    echo "Vim-plugin is not install. Clone it (Neovim)"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "Install Vim coc extensions"
vim +CocInstall coc-highlight coc-python coc-json coc-yaml coc-xml coc-java coc-scala coc-vimlsp coc-tabnine +qall

if [ ! -d "$HOME/.svut" ]; then
    echo "Clone SVUT"
    git clone git@github.com:damofthemoon/svut.git "$HOME/.svut"
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

echo "To use ctrl-t/o in Vim, install Exuberant Ctags to parse easily your source code: http://ctags.sourceforge.net"
echo ""

echo "For better rendering of NerdTree display in Vim, consider to install nerd-fonts:"
echo "https://github.com/ryanoasis/nerd-fonts#font-installation"
echo ""

echo "Install done!"
exit 0
