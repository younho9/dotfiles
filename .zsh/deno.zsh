#!/usr/bin/env zsh

# Add deno completions to search path
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi

# deno
[[ -f "$HOME/.deno/env" ]] && . "$HOME/.deno/env"

# Initialize zsh completions (added by deno install script)
autoload -Uz compinit
compinit
