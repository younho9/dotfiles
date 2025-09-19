#!/usr/bin/env zsh

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/Users/younho9/.bun/_bun" ] && source "/Users/younho9/.bun/_bun"
