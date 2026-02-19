#!/usr/bin/env zsh

# ZSH Configuration - Main Entry Point

# Load modules in order
# Each module is responsible for its own configuration

# 1. Environment variables and aliases
source ~/.aliases                                           # Command aliases
source ~/.exports                                           # Public exports (PATH, etc.)
[[ -f ~/.config/op/op.env ]] && source ~/.config/op/op.env  # Machine-local env vars
source ~/.config/op/env.zsh                                 # 1Password environment variables
[[ -f ~/.env ]] && { set -a; source ~/.env; set +a; }       # 1Password op:// references (exported)

# 2. Oh My Zsh and theme
source ~/.zsh/oh-my-zsh.zsh                                  # Oh My Zsh plugins and theme

# 3. Development tools
source ~/.zsh/nvm.zsh                                        # NVM
source ~/.zsh/python.zsh                                     # Python and pyenv
source ~/.zsh/bun.zsh                                        # bun
source ~/.zsh/pnpm.zsh                                       # pnpm
source ~/.zsh/deno.zsh                                       # deno
source ~/.zsh/go.zsh                                         # Go

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

alias claude-mem='bun "~/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'

# OpenClaw Completion
[[ -f ~/.openclaw/completions/openclaw.zsh ]] && source ~/.openclaw/completions/openclaw.zsh
