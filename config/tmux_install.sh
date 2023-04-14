#!/bin/bash

tpm_installer(){
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}
zsh_installer(){
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> $HOME/.zsh.rc
}
my_conf(){
    cp ../tmux/tmux.conf $HOME/.tmux.conf
    cp ../tmux/tmux-powerlinerc $HOME/.tmux-powerlinerc
    cp ../tmux/p10k.zsh $HOME/p10k.zsh
}
main(){
    # Check if tmux is already installed
    if command -v tmux &> /dev/null
    then
        echo "tmux is already installed"
    else
        # Install tmux based on the system type
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            # Install on Linux
            sudo apt-get update -y
            sudo apt-get install tmux zsh -y
            tpm
            zsh_installer
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            # Install on macOS
            brew install tmux zsh
        else
            echo "Unsupported system type"
        fi
    fi
}
main
