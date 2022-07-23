#!/bin/bash

#TODO
# Use anything other than eval 
# It's unsafe when using user input, but it ~should~ be fine in this specific case

while true; do

    read -p "Do you want to make backups of your current dotfiles? (y/n) " yn

    case $yn in 
        [yY] ) echo making backups...;
            mv -f ~/.zshrc ~/.zshrc.bak;
            mv -f ~/.config/nvim/init.vim ~/.config/nvim/init.vim.bak;
            mv -f ~/.tmux.conf ~/.tmux.conf.bak;
            mv -f ~/.p10k.zsh ~/.p10k.zsh.bak;
            break;;
        [nN] ) echo Proceeding without backups.;
            break;;
        * ) echo invalid response;;
    esac
done

cp -f ./zsh/zshrc ~/.zshrc
cp -f ./nvim/init.vim ~/.config/nvim/init.vim
cp -f ./tmux/tmux.conf ~/.tmux.conf
cp -f ./tmux/p10k.zsh ~/.p10k.zsh

install_prefix=('brew' 'install')

# Use native package manager
function fedora () {
    echo "Executing dnf as sudo. Password may be required."
    install_prefix="sudo dnf install -y "
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
    install_prefix="sudo apt-get install -y "
}

OS=$( uname -a )
case $OS in 
    *"Debian"*)
        debian_ubuntu
        ;;
    *"Darwin"*)
        osx
        ;;
    *"Fedora"*)
        fedora
        ;;
esac

which tmux &> /dev/null
if [[ $? != 0 ]] ; then
    echo "tmux not found, installing..."
    eval "$install_prefix tmux"
fi

if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ] ; then
    echo "powerline10k not found, installing... ( required for bash line styling )"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

which fzf &> /dev/null
if [[ $? != 0 ]] ; then
    echo "fzf not found, installing... ( required for neovim )"
    eval "$install_prefix fzf"
fi

which python3 &> /dev/null
if [[ $? != 0 ]] ; then
    while true; do
    
        read -p "Python3 not found. This installer assumes you have pip, so this can cause problems.' \n (1) install using brew \n (2) exit installation, my python path is wierd. \n" val
    
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
fi

pip show neovim &> /dev/null
if [[ $? != 0 ]]; then
    echo "neovim python package not found, installing..."
    pip install neovim
fi

which node &> /dev/null
if [[ $? != 0 ]]; then
    "node not found, installing..."
    eval "$install_prefix node"
fi

# install yarn/ neovim for node
# Install neovim using npm, just for compatiblity
npm list --location=global neovim &> /dev/null
if [[ $? != 0 ]]; then
    which yarn &> /dev/null
    if [[ $? != 0 ]]; then
        "yarn not found, installing..."
        npm install --location=global yarn
    fi
    yarn global list neovim | grep "neovim" &> /dev/null
    if [[ $? != 0 ]]; then
        echo "installing neovim module with npm..."
        npm install --location=global neovim
    fi
fi

which ruby &> /dev/null
if [[ $? != 0 ]]; then
    echo "ruby not found, checking ruby-install..."
    which ruby-install &> /dev/null
    if [[ $? != 0 ]]; then
        echo "ruby-install not found, installing..."
        eval "$install_prefix ruby-install --HEAD"
    fi
    echo "installing latest ruby using ruby-install..."
    ruby-install --latest
    echo 
fi

gem list neovim | grep "neovim" &> /dev/null
if [[ $? != 0 ]]; then
    "neovim gem not found, installing..."
    gem install neovim
fi

if [[ ! $PATH == *"$HOME/bin"* ]]; then
    if [ -d $HOME/bin ]; then
        echo "$HOME/bin not found in path, adding to ~/.path.zsh"
        echo 'if [[ ! $PATH == *"$HOME/bin"* ]]; then
    export PATH=$PATH:$HOME/bin
fi
        ' >> ~/.path.zsh
    fi
fi


echo
echo "    ██╗ ██████╗ ███████╗███╗   ██╗███████╗                                  
   ██╔╝██╔════╝ ██╔════╝████╗  ██║╚══███╔╝                                  
  ██╔╝ ██║  ███╗█████╗  ██╔██╗ ██║  ███╔╝                                   
 ██╔╝  ██║   ██║██╔══╝  ██║╚██╗██║ ███╔╝                                    
██╔╝   ╚██████╔╝███████╗██║ ╚████║███████╗                                  
╚═╝     ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝                                  
                                                                            
    ███╗   ███╗███████╗███████╗████████╗███████╗                            
    ████╗ ████║██╔════╝██╔════╝╚══██╔══╝██╔════╝                            
    ██╔████╔██║█████╗  █████╗     ██║   ███████╗                            
    ██║╚██╔╝██║██╔══╝  ██╔══╝     ██║   ╚════██║                            
    ██║ ╚═╝ ██║███████╗███████╗   ██║   ███████║                            
    ╚═╝     ╚═╝╚══════╝╚══════╝   ╚═╝   ╚══════╝                            
                                                                            
    ████████╗███████╗██████╗ ███╗   ███╗██╗███╗   ██╗ █████╗ ██╗         ██╗
    ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║████╗  ██║██╔══██╗██║        ██╔╝
       ██║   █████╗  ██████╔╝██╔████╔██║██║██╔██╗ ██║███████║██║       ██╔╝ 
       ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║██║╚██╗██║██╔══██║██║      ██╔╝  
       ██║   ███████╗██║  ██║██║ ╚═╝ ██║██║██║ ╚████║██║  ██║███████╗██╔╝   
       ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝╚═╝    
                                                                            "
echo 
echo "Run checkhealth inside of neovim to ensure plugins installed correctly."
echo
