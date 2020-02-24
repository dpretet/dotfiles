#!/usr/bin/env bash

# -e: exit if one command fails
# -u: treat unset variable as an error
# -f: disable filename expansion upon seeing *, ?, ...
# -o pipefail: causes a pipeline to fail if any command fails
set -euf -o pipefail

# Get absolute path of current location for symlink
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Hello! This script is about to install a dev setup relying on Vim, Tmux, Git, Zsh."
echo ""
echo "Make sure to save first Vim, Git, Zsh, or Tmux existing configuration."
echo "All configuration files will be symlinked from this folder."
echo ""
echo "Please backup first your environment before continuing!"
echo ""
echo "The script will also install additional softwares:"
echo "  - FZF, a command-line fuzzy finder: https://github.com/junegunn/fzf"
echo "  - Zplugin: https://github.com/zdharma/zplugin"
echo "  - SVUT: git@github.com:damofthemoon/svut.git"
echo "  - Vim-plug: https://github.com/junegunn/vim-plug"
echo ""
echo "To continue successfully the install, please install first:"
echo "  - Zsh"
echo "  - Vim 8"
echo "  - Neovim"
echo "  - Git"
echo "  - Node.js"
echo "  - Exuberant Ctags"
echo ""

read -rp "Do you want to continue (y/n)? " answer
echo ""

case ${answer:0:1} in
    y|Y )
        echo "Start setup"
    ;;
    * )
        echo "Abort..."
        exit 1
    ;;
esac

echo "Create .bin folder"
if [ ! -d "$HOME/.bin" ]; then
    mkdir $HOME/.bin
fi

echo "Install Neovim"
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage "$HOME/.bin/nvim"

echo "Create Vim symlinks"
ln -sf "$DIR/.vim" "$HOME/.vim"
mkdir -p "$HOME/.config/nvim"
ln -sf "$DIR/.vim/vimrc" "$HOME/.config/nvim/init.vim"

echo "Create Zsh symlink"
ln -sf "$DIR/.zshrc" "$HOME/.zshrc"

echo "Create Tmux symlink"
ln -sf "$DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DIR/.tmux" "$HOME/.tmux"

echo "Create .git files symlinks"
ln -sf "$DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DIR/.git-completion.zsh" "$HOME/.git-completion.zsh"
ln -sf "$DIR/.git-prompt.sh" "$HOME/.git-prompt.sh"

echo "Create Ctags symlink"
ln -sf "$DIR/.ctags" "$HOME/.ctags"

echo "Create GTKWave symlink"
ln -sf "$DIR/.gtkwaverc" "$HOME/.gtkwaverc"

if [ ! -d "$HOME/.zplugin" ]; then
    echo "Install Zplugin"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"
fi

if [ ! -d "$HOME/.vim/autoload/plug.vim" ]; then
    echo "Vim-plugin is not installed. Clone it (Vim8)"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [ ! -d ~/.local/share/nvim/site/autoload/plug.vim ]; then
    echo "Vim-plugin is not installed. Clone it (Neovim)"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "Install Vim plugins"
vim +PlugInstall +qall
echo "Install coc.vim extensions"
vim +CocInstall coc-highlight coc-python coc-json coc-yaml coc-xml coc-java coc-scala coc-vimlsp coc-tabnine +qall

if [ ! -d "$HOME/.svut" ]; then
    echo "Clone SVUT"
    git clone "https://github.com/damofthemoon/svut.git" "$HOME/.svut"
fi

if [ ! -d "$HOME/.fzf" ]; then
    echo "Install FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

echo "To use tags parsing (ctrl-t/o) in Vim, install Exuberant Ctags to parse easily your code: "
echo "  http://ctags.sourceforge.net"
echo ""

echo "For better rendering of NerdTree display in Vim, consider to install nerd-fonts:"
echo "  https://github.com/ryanoasis/nerd-fonts#font-installation"
echo ""

echo "coc.vim requieres further install for language servers. Please visit this page for details:"
echo "  https://github.com/neoclide/coc.nvim"

echo "Install done!"

exit 0
