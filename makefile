SHELL=/bin/zsh
update: 
	cp ~/.config/nvim/init.lua nvim/init.lua
	cp -R ~/.config/nvim/lua nvim/
	cp -R ~/.scripts ./scripts
	cp ~/.tmux.conf tmux/tmux.conf
	cp ~/.zshrc zsh/zshrc
	cp ~/.alias.sh zsh/alias.sh
	cp ~/.p10k.zsh tmux/p10k.zsh
install:
	sh install.sh
test:
	cp ~/.config/nvim/init.vim nvim/init.vim.test
	cp ~/.tmux.conf tmux/tmux.conf.test
	cp ~/.zshrc zsh/zshrc.test
	cp ~/.p10k.zsh tmux/p10k.zsh.test
	sh install.sh
	@- echo "Re-source zshrc with \n source ~/.zshrc"
revert:
	mv nvim/init.vim.test ~/.config/nvim/init.vim 
	mv tmux/tmux.conf.test ~/.tmux.conf 
	mv zsh/zshrc.test ~/.zshrc 
	mv tmux/p10k.zsh.test ~/.p10k.zsh
	@- echo "Re-source zshrc with \n source ~/.zshrc"
