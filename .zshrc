#!/usr/bin/env zsh

# ZSH Configuration - Main Entry Point

# Load modules in order
# Each module is responsible for its own configuration

# 1. Environment variables and aliases
source ~/.aliases                            # Command aliases
source ~/.exports                            # Environment variables
source ~/.secrets                            # Secret environment variables

# 2. Oh My Zsh and theme
source ~/.zsh/oh-my-zsh.zsh                  # Oh My Zsh plugins and theme

# 3. Development tools
source ~/.zsh/nvm.zsh                        # NVM
source ~/.zsh/python.zsh                     # Python and pyenv
source ~/.zsh/bun.zsh                        # bun
source ~/.zsh/pnpm.zsh                       # pnpm
source ~/.zsh/deno.zsh                       # deno
source ~/.zsh/go.zsh                         # Go                        # nlm (NotebookLM CLI)

