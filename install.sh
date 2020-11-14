#!/usr/bin/env bash

# -e: exit if one command fails
# -u: treat unset variable as an error
# -f: disable filename expansion upon seeing *, ?, ...
# -o pipefail: causes a pipeline to fail if any command fails
set -euf -o pipefail

# Get absolute path of current location for symlink
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Variable used to point the user targeted. Trick for AWS
# or any OS where basic user is root/sudo on the machine
MYHOME=""
# Variable storing the command to install a package
install_cmd=""

# Bash color codes
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
# Reset
Color_Off='\033[0m'       # Text Reset


function printerror {
    echo -e "${Red}ERROR: ${1}${Color_Off}"
}

function printwarning {
    echo -e "${Yellow}WARNING: ${1}${Color_Off}"
}

function printinfo {
    echo -e "${Blue}INFO: ${1}${Color_Off}"
}

function printsuccess {
    echo -e "${Green}INFO: ${1}${Color_Off}"
}

function test {
    printinfo ""
}

function welcome {

    printinfo ""
    printinfo "Welcome! This script is about to install a dev setup relying on Vim,"
    printinfo "Tmux, Git, Zsh & Ctags. PLEASE BACKUP FIRST YOUR ENVIRONMENT!"
    printinfo ""
    printinfo "The script will also install automatically these softwares:"
    printinfo "  - Zinit: https://github.com/zdharma/zinit"
    printinfo "  - Vim-plug: https://github.com/junegunn/vim-plug"
    printinfo "  - FZF: https://github.com/junegunn/fzf"
    printinfo "  - SVUT: https://github.com/damofthemoon/svut.git"
    printinfo "  - Node.js: https://nodejs.org/en/"
    printinfo ""

    read -rp "=> Do you want to continue (y/n)? " answer
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

    read -rp "=> Enter is your HOME path: " path
    export MYHOME=$path
    read -rp "Enter your package manager install command: " cmd
    export install_cmd=$cmd
}

function bye {

    echo ""
    printinfo 'To finish the install, consider to add these folders in your $PATH:'
    echo ""
    echo 'export PATH=~/.dotfiles:$PATH'
    echo 'export PATH=~/.bin:$PATH'
    echo 'export PATH=~/.svut:$PATH'
    echo ""
    echo "For better rendering of NerdTree display in Vim, consider to"
    echo "install nerd-fonts:"
    echo "  https://github.com/ryanoasis/nerd-fonts#font-installation"
    echo ""
    printsuccess "Installation done!"
}

function recommended_install {

    echo "To continue successfully the install, please install first:"
    echo "  - Zsh"
    echo "  - Git"
    echo "  - Vim 8"
    echo "  - Neovim"
    echo "  - Node.js"
    echo "  - Python 3"
    echo "  - Ctags"
    echo ""
    echo "These applications will be installed with your package manager"
    echo ""

    read -rp "=> Do you want to install these recommended applications (y/n)? " answer
    echo ""

    case ${answer:0:1} in
        y|Y )
            install_dep "$install_cmd" "Zsh" "zsh"
            install_dep "$install_cmd" "Git" "git"
            install_dep "$install_cmd" "Vim" "vim"
            install_dep "$install_cmd" "Neovim" "neovim"
            install_dep "$install_cmd" "Ctags" "ctags"
            install_dep "$install_cmd" "GTKWave" "gtkwave"
            install_dep "$install_cmd" "Python 3" "python3"

            printinfo "Install Node.js"
            # Try two different package name
            # node for MacOS, nodejs for Linux
            $install_cmd "node"
            ret=$?
            if [ $ret != 0 ]; then
                $install_cmd "nodejs"
                ret=$?
            fi

            if [ $ret != 0 ]; then
                read -rp  "=> Node.js installation failed. Press enter to continue." any
            else
                printinfo "Update Node.js to latest version"
                sudo npm cache clean -f
                sudo npm install -g n
                sudo n stable
                sudo npm install -g neovim
            fi
        ;;
    esac

    echo "Create ~/.bin folder"
    if [ ! -d "$MYHOME/.bin" ]; then
        mkdir "$MYHOME"/.bin
    fi

    read -rp "=> Try to install latest Neovim appimage? (y/N) " answer
    case ${answer:0:1} in
        y|Y )
            echo "Appimages require FUSE. Install it"
            if [[ $install_cmd =~ "yum" ]]; then
                $install_cmd --enablerepo=epel -y fuse-sshfs fuse-devel
            else
                $install_cmd fuse-sshfs fuse-devel
            fi
            echo "Install Neovim appimage in $MYHOME/.bin"
            curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
            chmod u+x nvim.appimage
            mv nvim.appimage "$MYHOME/.bin/nvim"
        ;;
    esac
}

function install_dep {

    # Installs a package:
    #   - $1: install command
    #   - $2: name of the software
    #   - $3: name of the software's package
    # Disable error handling, just prompt the user if an error is issued

    read -rp "Try to install $2? (y/N): " answer
    case ${answer:0:1} in
        y|Y )
            echo "Install $2"
            if ! $1 $3
            then
                read -rp  "=> $2 installation failed. Press enter to continue." any
            fi
        ;;
    esac
}

function create_symlink {

    printinfo "Create Vim symlinks"
    ln -sf "$DIR/nvim/" "$MYHOME/.config/nvim"

    printinfo "Create Zsh symlink"
    ln -sf "$DIR/zshrc" "$MYHOME/.zshrc"

    printinfo "Create Bash symlink"
    ln -sf "$DIR/bashrc" "$MYHOME/.bashrc"
    ln -sf "$DIR/inputrc" "$MYHOME/.inputrc"
    ln -sf "$DIR/git-prompt.sh" "$MYHOME/.git-prompt.sh"
    ln -sf "$DIR/git-completion.bash" "$MYHOME/.git-completion.bash"

    printinfo "Create Tmux symlink"
    ln -sf "$DIR/tmux.conf" "$MYHOME/.tmux.conf"

    printinfo "Create Git symlinks"
    ln -sf "$DIR/gitconfig" "$MYHOME/.gitconfig"
    ln -sf "$DIR/git-completion.zsh" "$MYHOME/.git-completion.zsh"
    ln -sf "$DIR/git-prompt.sh" "$MYHOME/.git-prompt.sh"

    printinfo "Create Ctags symlink"
    ln -sf "$DIR/ctags" "$MYHOME/.ctags"

    printinfo "Create GTKWave symlink"
    ln -sf "$DIR/gtkwaverc" "$MYHOME/.gtkwaverc"
}

function install_vim {

    printinfo "Proceed to (Neo)Vim installation"

    # Create manually the local folder because on AWS F1,
    # centos and root are nearly the same user. Create it
    # then give rights to 'centos' user
    sudo mkdir -p "$MYHOME/.local"
    sudo chown -R "$USER:$USER" "$MYHOME/.local"

    if [ ! -d "$MYHOME/.vim/autoload/plug.vim" ]; then
        echo "Vim-plugin is not installed for Vim. Clone it"
        curl -fLo "$MYHOME/.vim/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    if [ ! -d ~/.local/share/nvim/site/autoload/plug.vim ]; then
        echo "Vim-plugin is not installed for Neovim. Clone it"
        curl -fLo "$MYHOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # Install necessary python module for Neovim
    if [[ ! $(type pip) ]]; then
        pip install neovim
    fi
    if [[ ! $(type pip3) ]]; then
        pip3 install neovim
    fi

    printwarning "Install Vim plugins. Next commands will partially fail"
    printwarning "because Vim is not initialized completly."
    read -rp "Just press enter to continue the install" any

    if [ -e "$MYHOME/.bin/nvim" ]; then
        "$MYHOME/.bin/nvim" +PlugInstall +qall
    else
        vim +PlugInstall +qall
    fi
}

function further_install {

    if [ ! -d "$MYHOME/.zinit" ]; then
        echo "Install Zinit"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
    fi

    if [ ! -d "$MYHOME/.svut" ]; then
        echo "Clone SVUT"
        git clone "https://github.com/damofthemoon/svut.git" "$MYHOME/.svut"
    fi

    if [ ! -d "$MYHOME/.fzf" ]; then
        echo "Install FZF"
        git clone --depth 1 https://github.com/junegunn/fzf.git "$MYHOME/.fzf"
        "$MYHOME/.fzf/install"
    fi
}

welcome

set +e
recommended_install
set -e

create_symlink

install_vim

further_install

bye

exit 0
