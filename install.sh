#!/bin/bash

while true; do

    read -p "Do you want to make backups of your current dotfiles? (y/n) " yn

case $yn in 
	[yY] ) echo making backups...;
        mv -f ~/.zshrc ~/.zshrc.bak;
        mv -f ~/.config/nvim/init.vim ~/.config/nvim/init.vim.bak;
        mv -f ~/.tmux.conf ~/.tmux.conf.bak;
		break;;
	[nN] ) echo Proceeding without backups.;
        break;;
	* ) echo invalid response;;
esac

done

cp -f ./zsh/zshrc ~/.zshrc
cp -f ./nvim/init.vim ~/.config/nvim/init.vim
cp -f ./tmux/tmux.conf ~/.tmux.conf
