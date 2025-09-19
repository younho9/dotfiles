#!/usr/bin/env zsh

# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/younho9/completions:"* ]]; then export FPATH="/Users/younho9/completions:$FPATH"; fi

# deno
. "/Users/younho9/.deno/env"