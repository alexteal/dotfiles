# dotfiles

A hacky general cli environment. _Should_ run on anything from a new mac to a
docker container.

Includes:

-   zsh
-   nvim
    -   tons of plugins
-   tmux
-   ohmyzsh
    -   p10k
-   custom bash scripts

## Install

You need bash to install. Install with `./install`

You may be prompted to press 'y' for some packages. First time installs will
require you to interact with Oh-my-zsh, and exit the shell the first time.

Then `source ~/.zshrc` to enable environment.

### no longer supported

### Testing

`no longer supported`

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
