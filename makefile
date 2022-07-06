SHELL=/bin/zsh
update: 
	cp ~/.config/nvim/init.vim nvim/init.vim
	cp ~/.tmux.conf tmux/tmux.conf
	cp ~/.zshrc zsh/zshrc
install:
	sh install.sh
test:
	cp ~/.config/nvim/init.vim nvim/init.vim.test
	cp ~/.tmux.conf tmux/tmux.conf.test
	cp ~/.zshrc zsh/zshrc.test
	sh install.sh
	@- echo "Re-source zshrc with \n source ~/.zshrc"
revert:
	mv nvim/init.vim.test ~/.config/nvim/init.vim 
	mv tmux/tmux.conf.test ~/.tmux.conf 
	mv zsh/zshrc.test ~/.zshrc 
	@- echo "Re-source zshrc with \n source ~/.zshrc"
