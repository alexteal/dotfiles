SHELL=/bin/zsh
update: 
	cp ~/.config/nvim/init.vim nvim/init.vim
	cp ~/.tmux.conf tmux/tmux.conf
	cp ~/.zshrc zsh/zshrc
install:
	sh install.sh
test:
	cp ~/.config/nvim/init.vim init.vim
	cp ~/.tmux.conf tmux.conf
	cp ~/.zshrc zshrc
	sh install.sh
	source ~/.zshrc
revert:
	mv init.vim ~/.config/nvim/init.vim 
	mv tmux.conf ~/.tmux.conf 
	mv zshrc ~/.zshrc 
	source ~/.zshrc
