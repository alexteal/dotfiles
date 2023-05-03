#!/bin/bash

#TODO
# Use anything other than eval 
# It's unsafe when using user input, but it ~should~ be fine in this specific case
while true; do

    read -p "Do you want to make backups of your current dotfiles? (y/n) " yn

    case $yn in 
        [yY] ) echo making backups...;
            mv -f $HOME/.zshrc $HOME/.zshrc.bak;
            mv -f $HOME/.tmux.conf $HOME/.tmux.conf.bak;
            mv -f $HOME/.p10k.zsh $HOME/.p10k.zsh.bak;
            break;;
        [nN] ) echo Proceeding without backups.;
            break;;
        * ) echo invalid response;;
    esac
done
mkdir -p $HOME/.config/nvim
mkdir -p $HOME/.scripts

if [ -f $HOME/.config/nvim/init.vim ] ; then
    echo "An init.vim was found. Moving it to init.vim.bak"
    mv  $HOME/.config/nvim/init.vim  $HOME/.config/nvim/init.vim.bak
fi


#ensure scripts are up to date
for filename in ./scripts/.scripts/*
do
    [ -e "$filename" ] || continue
    file1=$(cksum "$filename" ) &> /dev/null
    file2=$(cksum $HOME/.scripts/$(basename "$filename") ) &> /dev/null
    file1=$(basename "$file1")
    file2=$(basename "$file2")
    if [ "$file1" != "$file2" ]; then
        relink=1
    fi
done

mkdir -p ~/.config
mkdir -p ~/.config/nvim
mkdir -p ~/.config/alacritty
mkdir -p ~/.scripts

cp -f ./zsh/zshrc $HOME/.zshrc
cp -f ./zsh/alias.sh $HOME/.alias.sh
cp -f ./tmux/tmux.conf $HOME/.tmux.conf
cp -f ./tmux/p10k.zsh $HOME/.p10k.zsh
cp -f ./tmux/tmux.conf.local $HOME/.tmux.conf.local
cp -r -f ./nvim/* $HOME/.config/nvim/
cp -f ./scripts/.scripts/* $HOME/.scripts/
cp -f ./alacritty/alacritty.yaml ~/.config/alacritty/alacritty.yaml


user=$( whoami )
if [[ $user == "root" ]] ; then
    sudo=""
else
    sudo="sudo"
fi

# Use native package manager
function fedora () {
    echo "Executing dnf as sudo. Password may be required."
    install_prefix="$sudo dnf install -y "
    eval "$sudo dnf makecache --refresh"
}
function osx () {
    install_prefix="brew install "
    # ensure brew
    which brew &> /dev/null
    if [[ $? != 0 ]] ; then
        # Install Homebrew
        echo "Homebrew not found, installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.\
            com/Homebrew/install/HEAD/install.sh)"
fi
}
function debian_ubuntu () {
    echo "Executing apt-get as sudo. Password may be required."
    install_prefix="$sudo apt-get install -y "
    eval "$sudo apt-get update"
    eval "$sudo apt-get upgrade"
}
function determine_distro(){
    OS=$(cat /proc/version)
    case $OS in 
        *"Red Hat"*)
            fedora
            ;;
        *"centos"*)
            fedora
            ;;
        *) 
            debian_ubuntu
            ;;
    esac
}
ERRORS=""
OS=$( uname -a )
case $OS in 
    *"arwin"*) # inconsistencies with if first character is capital or not
        osx
        ;;
    *) 
        determine_distro
        ;;
esac

#relink improper files
if [[ "$relink" == 1 ]]; then
    echo "Certain custom scripts have changed and require re-linking"
    for filename in ./scripts/.scripts/*
    do
        [ -e "$filename" ] || continue
        $sudo ln -sf $HOME$(basename "$filename") /usr/local/bin/$(basename "$filename")
    done
fi

#relink to ~/bin too
mkdir -p $HOME/bin
for filename in $HOME/.scripts/*
do
    [ -e "$filename" ] || continue
    ln -sf "$filename" $HOME/bin/$(basename "$filename")
done

function install_using_prefix {
    for program in "$@"; do
        which "$program" &> /dev/null
        if [[ $? != 0 ]] ; then
            echo "$program not found, installing..."
            eval "$install_prefix $program"
        fi
    done
}

install_using_prefix zsh make tmux curl fzf node npm 

which nvim &> /dev/null
if [[ $? != 0 ]] ; then
    echo "neovim not found, installing..."
    eval "$install_prefix neovim"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

if [ ! -f $HOME/.oh-my-zsh/oh-my-zsh.sh  ] ; then
    echo "oh-my-zsh not found, installing..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ] ; then
    echo "powerline10k not found, installing... ( required for bash line styling )"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

which lazygit &> /dev/null
if [[ $? != 0 ]] ; then
    case $OS in 
        *"arwin"*)
            eval "$install_prefix jesseduffield/lazygit/lazygit"
            ;;
        *"edora"*)
            echo "lazygit not found, installing..."
            eval "$sudo dnf copr enable atim/lazygit -y"
            eval "$install_prefix lazygit"
            ;;
        *) 
            ERRORS+="lazygit not available for this distro. Install from source \n"
            ERRORS+="https://github.com/jesseduffield/lazygit#manual"
            ;;
    esac
fi

which python3 &> /dev/null
if [[ $? != 0 ]] ; then
    while true; do
        echo "Python3 not found. This installer assumes you have pip, so this can cause problems."
        echo '(1) install using $install_prefix'
        echo '(2) exit installation, my python path is wierd.' 
        read val

        case $val in 
            [1] ) echo installing...;
                eval "$install_prefix python3"
                break;;
            [2] ) echo EXITING;
                exit 1
                break;;
            * ) echo invalid response;;
        esac
    done


fi

which pip &> /dev/null
if [[ $? != 0 ]] ; then
    echo "pip not found, installing..."
    python3 -m ensurepip --upgrade
    case $OS in 
        *"ebian"*)
            eval "$install_prefix python3-pip"
            ;;
        *"buntu"*)
            eval "$install_prefix python3-pip"
            ;;
        *"arwin"*)
            python3 -m ensurepip --upgrade
            ;;
        *"edora"*)
            eval "$install_prefix python3-pip"
            ;;
        *) 
            ;;
    esac
fi


if [ ! -d $HOME/.config/nvim/venv ] ; then
    echo "Python3 venv for neovim not found. Generating..."
    python3 -m venv $HOME/.config/nvim/venv
    source $HOME/.config/nvim/venv/bin/activate
else
    source $HOME/.config/nvim/venv/bin/activate
fi

if [ -d $HOME/.path.zsh ] ; then 
    which sed &> /dev/null
    nvim_py_venv_path=$HOME/.config/nvim/venv/bin/python
    if [[ $? != 0 ]]; then
        "gnu-sed not found, installing..."
    fi
    case $OS in 
        *"ebian"*)
            eval "$install_prefix sed"
            sed -i "s/NVIM_PY_PATH.*/NVIM_PY_PATH=$nvim_py_venv_path/g" $HOME/.alias.zsh
            ;;
        *"buntu"*)
            eval "$install_prefix sed"
            sed -i "s/NVIM_PY_PATH.*/NVIM_PY_PATH=$nvim_py_venv_path/g" $HOME/.alias.zsh
            ;;
        *"arwin"*)
            eval "$install_prefix gnu-sed"
            gsed -i "s/NVIM_PY_PATH.*/NVIM_PY_PATH=$nvim_py_venv_path/g" $HOME/.alias.zsh
            ;;
        *"edora"*)
            eval "$install_prefix sed"
            sed -i "s/NVIM_PY_PATH.*/NVIM_PY_PATH=$nvim_py_venv_path/g" $HOME/.alias.zsh
            ;;
        *) 
            ;;
    esac

fi




if [ ! -d $HOME/.local/share/nvim/site/pack/packer/start ] ; then
    echo "packer.nvim not found, installing..."
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
fi


pip show neovim &> /dev/null
if [[ $? != 0 ]]; then
    echo "neovim python package not found, installing..."
    pip install neovim
fi

pip show  jedi &> /dev/null
if [[ $? != 0 ]]; then
    echo "neovim python package not found, installing..."
    pip install jedi
fi

# install yarn/ neovim for node
# Install neovim using npm, just for compatiblity
npm list --location=global neovim &> /dev/null
if [[ $? != 0 ]]; then
    which yarn &> /dev/null
    if [[ $? != 0 ]]; then
        "yarn not found, installing..."
        $sudo npm install -g yarn
    fi
    yarn global list neovim | grep "neovim" &> /dev/null
    if [[ $? != 0 ]]; then
        echo "installing neovim module with npm..."
        $sudo npm install -g neovim
    fi
fi

which ruby &> /dev/null
if [[ $? != 0 ]]; then
    echo "ruby not found, checking ruby-install..."
    which ruby-install &> /dev/null
    if [[ $? != 0 ]]; then
        case $OS in 
            *"ebian"*)
                echo "ruby-install not available, installing package manager ruby..."
                eval "$install_prefix ruby-full"
                ;;
            *"buntu"*)
                echo "ruby-install not available, installing package manager ruby..."
                eval "$install_prefix ruby-full"
                ;;
            *"arwin"*)
                echo "ruby-install not found, installing..."
                eval "$install_prefix ruby-install --HEAD"
                echo "installing latest ruby using ruby-install..."
                ruby-install --latest
                ;;
            *"edora"*)
                echo "ruby-install not available, installing package manager ruby..."
                eval "$sudo yum install ruby"
                ;;
            *) 
                ;;
        esac
    fi
    echo 
fi

gem list neovim | grep "neovim" &> /dev/null
if [[ $? != 0 ]]; then
    "neovim gem not found, installing..."
    gem install neovim
fi

if [[ ! $PATH == *"$HOME/bin"* ]]; then
    if [ -d $HOME/bin ]; then
        echo "$HOME/bin not found in path, adding to $HOME/.path.zsh"
        echo 'if [[ ! $PATH == *"$HOME/bin"* ]]; then
        export PATH=$PATH:$HOME/bin
    fi
    ' >> $HOME/.path.zsh
    fi
fi

echo
echo
echo "    ██╗ ██████╗ ███████╗███╗   ██╗███████╗                              ";
echo "   ██╔╝██╔════╝ ██╔════╝████╗  ██║╚══███╔╝                              ";
echo "  ██╔╝ ██║  ███╗█████╗  ██╔██╗ ██║  ███╔╝                               ";
echo " ██╔╝  ██║   ██║██╔══╝  ██║╚██╗██║ ███╔╝                                ";
echo "██╔╝   ╚██████╔╝███████╗██║ ╚████║███████╗                              ";
echo "╚═╝     ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝                              ";
echo "                                                                        ";
echo "███╗   ███╗███████╗███████╗████████╗███████╗                            ";
echo "████╗ ████║██╔════╝██╔════╝╚══██╔══╝██╔════╝                            ";
echo "██╔████╔██║█████╗  █████╗     ██║   ███████╗                            ";
echo "██║╚██╔╝██║██╔══╝  ██╔══╝     ██║   ╚════██║                            ";
echo "██║ ╚═╝ ██║███████╗███████╗   ██║   ███████║                            ";
echo "╚═╝     ╚═╝╚══════╝╚══════╝   ╚═╝   ╚══════╝                            ";
echo "                                                                        ";
echo "████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗         ██╗";
echo "╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║        ██╔╝";
echo "   ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║       ██╔╝ ";
echo "   ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║      ██╔╝  ";
echo "   ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗██╔╝   ";
echo "   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═╝    ";
echo "                                                                        ";
echo "Run checkhealth inside of neovim to ensure plugins installed correctly."
echo $ERRORS
