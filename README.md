# dotfiles

## all of my customization files, tracked for posterity

## Use

### Install

Install using bash interpreter with

```bash
make install
```

If this fails, you can run it directly with

```bash
./install.sh
```

Then

```bash
source ~/.zshrc
```

### Testing

If you'd like to test out my environment without permanently changing yours, you
can temporarily use it with

```bash
make test
source ~/.zshrc
```

And undo it with

```bash
make revert
```

This doesn't install necessary packages, it simply copies .zshrc, .init.vim, .tmux.conf.

## What's in it?

### Neovim

TODO
explanations for plugins/keybinds

### Zsh

This uses

-   Oh-my-zsh
-   powerline-p10k

And sources 3 custom files if they exist.

-   .path.zsh
-   .alias.zsh
-   .secrets

path.zsh contains all machine-specific paths and env variables

alias.zsh contains machine-specific aliases

secrets is where sensitive environment variables go

### Lazygit

Lazygit is awesome. Use it in tmux with <Prefix>g

### Tmux

TODO
explanations for tmux config
