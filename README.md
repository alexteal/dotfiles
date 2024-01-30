# dotfiles

## demo

![demo video](./media/demo.gif "demo of my setup")

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

_try starting nvim and just waiting. There's a first time install script that
**should** bootstrap everything._

Neovim should bootstrap itself ootb. If it doesn't, run these scripts. Currently,
the paths it's trying to bootstrap itself from don't always exist, so critical
errors are expected on a first time run.

`:PackerSync`
`:TSInstall tsx html`

## scripts documentation

| script          | function                                                                                                            |
| --------------- | ------------------------------------------------------------------------------------------------------------------- |
| docker-shell    | Creates and attaches to a Bash instance inside of a docker VM                                                       |
| ha              | Toggle devices using the HomeAssistant API                                                                          |
| lockd           | a diary tool i use to lock a diary with my gpg key                                                                  |
| nettest         | Tests some random aspects of a network for sanity                                                                   |
| opac            | toggle the opacity in Alacritty from 20% to 80%. Optionally use an argument to set the opacity between 0-100        |
| power           | Check if a mac is charging                                                                                          |
| rm2web          | Use a Remarkable's hostname and forward the address to your localhost at :8689                                      |
| ssh-portforward | forward a remote port to yours. Simple syntax. Abstracts the ssh -L command.                                        |
| theme           | swap a catpuccin theme. Syncs themes between Neovim and Alacritty                                                   |
| ulockd          | unlock tool for my diary                                                                                            |
| updf2rm         | upload a pdf to a remarkable notebook - given a hostname                                                            |
| venv            | create and source a Python3 virtual environment in your current directory. Or, just source the existing virtualenv. |

## Feature Tracker

-   [ ] CLI_overhaul
    -   [ ] Track more files
        -   [x] nvim
        -   [x] zsh
        -   [ ] apt
        -   [ ] systemctl
        -   [ ] ssh
        -   [ ] homebrew
        -   [x] custom scripts
        -   [x] tmux
        -   [ ] nushell
        -   [x] alacritty
        -   [ ] shell login MOTD's
    -   [x] Move system to cli based installer, with better options / more coherent system
    -   [-] Install all neovim config, bootstrap and make it work out of the box.
    -   [x] New CLI based installer
        -   [x] Need portability, so use bash with portable commands
    -   [ ] Update git project flow, get new config and update existing stuff
        -   [ ] (Optional) Show changes to be made before update
    -   [x] Update local files, use latest git files and update accordingly
        -   [ ] Flow that includes prompts for what scripts to change
            -   [ ] select from many form
                -   [x] 1. Install this config
                -   [x] 1a. Ask to install
                -   [ ] 2a. Show changes before update
                -   [x] 2. Update this config
                -   [x] 3. Exit
        -   [ ] Do not force install things if possible

## Bug Tracker

-   [ ] git blame causing error when scrolling too fast
-   [ ] scripts are softlinked to git directory, not to local `~/.scripts` ( is this a bug? it saves time...)

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
