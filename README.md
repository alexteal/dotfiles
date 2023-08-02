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

`it's been a long time since i've done real damage tests with this script. it might overwrite config files, so back them up in case.`
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
