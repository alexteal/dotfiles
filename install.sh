#!/bin/bash

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

# ensure brew
which brew &> /dev/null
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

which tmux &> /dev/null
if [[ $? != 0 ]] ; then
    brew install tmux
fi

if [ ! -d $HOME/.oh-my-zsh/custom/themes/powerlevel10k ] ; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

which fzf &> /dev/null
if [[ $? != 0 ]] ; then
    brew install fzf
fi

which python3 &> /dev/null
if [[ $? != 0 ]] ; then
    brew install python3
fi

which pip &> /dev/null
if [[ $? != 0 ]] ; then
    python3 -m ensurepip --upgrade
fi

pip show neovim &> /dev/null
if [[ $? != 0 ]]; then
    pip install neovim
fi

which node &> /dev/null
if [[ $? != 0 ]]; then
    brew install node
fi

npm list -g neovim &> /dev/null
if [[ $? != 0 ]]; then
    node install -g neovim
fi

which ruby &> /dev/null
if [[ $? != 0 ]]; then
    which ruby-install &> /dev/null
    if [[ $? != 0 ]]; then
        brew install ruby-install --HEAD
    fi
    ruby-install --latest
    [[ ! -f ~/bin ]] || source ~/bin
    echo 
fi

echo $PATH | grep $USER/bin
if [[ $? != 0 ]]; then
    if [ -d $HOME/bin ]; then
        echo 'export PATH=$PATH:$HOME/bin' >> ~/.path.zsh
    fi
fi

gem list neovim | grep "neovim" &> /dev/null
if [[ $? != 0 ]]; then
    gem install neovim
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
echo "There may still be some broken things around here, just try sourcing the
.zshrc and debugging until it seems like it's fine"
