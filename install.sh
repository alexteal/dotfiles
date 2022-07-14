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

sleep 2
# ensure brew
which brew &> /dev/null
if [[ $? != 0 ]] ; then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# ensure neovim
which nvim &> /dev/null
if [[ $? != 0 ]] ; then
    #install nvim
    brew install neovim
fi
# ensure neovim pip
pip list | grep 'neovim' &> /dev/null
if [[ $? != 0 ]]; then
    pip install neovim
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
