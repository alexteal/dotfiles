#!/bin/bash

# THEME AUTOCOMPLETE
# Define available themes
themes=("frappe" "latte" "macchiato" "mocha")
# Define function for tab completion
_theme_completion() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=($(compgen -W "${themes[*]}" -- "$cur"))
}

# Register tab completion function for the script
complete -F _theme_completion theme

# VENV CREATION

function venv() {
    _create_venv
    source "$(pwd)/venv/bin/activate"
}
