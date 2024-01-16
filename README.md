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

## Feature Tracker

-   [ ] CLI_overhaul
    -   [ ] Track more files
        -   [ ] nvim
        -   [ ] zsh
        -   [ ] apt
        -   [ ] systemctl
        -   [ ] ssh
        -   [ ] homebrew
        -   [ ] custom scripts
        -   [ ] tmux
        -   [ ] nushell
        -   [ ] alacritty
        -   [ ] shell login MOTD's
    -   [ ] Move system to cli based installer, with better options / more coherent system
    -   [ ] Install all neovim config, bootstrap and make it work out of the box.
    -   [ ] New CLI based installer
        -   [ ] Need portability, so use bash with portable commands
    -   [ ] Update git project flow, get new config and update existing stuff
        -   [ ] (Optional) Show changes to be made before update
    -   [ ] Update local files, use latest git files and update accordingly
        -   [ ] Flow that includes prompts for what scripts to change
            -   [ ] select from many form
                -   [ ] 1. Install this config
                -   [ ] 1a. Ask to install
                -   [ ] 2a. Show changes before update
                -   [ ] 2. Update this config
                -   [ ] 3. Exit
        -   [ ] Do not force install things if possible

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
