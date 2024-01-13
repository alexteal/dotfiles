# dotfiles

A hacky general cli environment. _Should_ run on anything from a new mac to a
docker container.

Includes:

-   ohmyzsh
    -   p10k
    -   Autocomplete and fuzzy searchable command history
-   nvim
    -   tons of plugins
    -   Largely minimal, optimized for webdev
    -   half broken but still does the job 99% of the time
-   tmux
    -   some solid custom config, with catpuccin themed status line
-   custom bash scripts
    -   available in `./scripts/`
    -   contains neat features like `venv`, which creates a python3 venv and sources it in one command

## Install

**it's been a long time since i've done real damage tests with this script. it might overwrite config files, so back them up in case.**

You need bash to install. Install with `./install`

You may be prompted to press 'y' for some packages. First time installs will
require you to interact with Oh-my-zsh, and exit the shell the first time.

Then `source ~/.zshrc` to enable environment.

## nvim setup

`:PackerSync`
`:TSInstall tsx html`

## Bug Tracker

-   [ ] git blame causing error when scrolling too fast
-   [ ] scripts are softlinked to git directory, not to local `~/.scripts`

### no longer supported

_leaving for documentation_

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
