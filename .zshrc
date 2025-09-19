#!/usr/bin/env zsh

# ZSH Configuration - Main Entry Point

# Load modules in order
# Each module is responsible for its own configuration

# 1. Setup modules (must be first)
source ~/.zsh/amazon-q-pre.zsh               # Amazon Q pre-block

# 2. Environment variables and aliases
source ~/.aliases                            # Command aliases
source ~/.exports                            # Environment variables
source ~/.secrets                            # Secret environment variables

# 3. Oh My Zsh and theme
source ~/.zsh/oh-my-zsh.zsh                  # Oh My Zsh plugins and theme

# 4. Development tools
source ~/.zsh/nvm.zsh                        # NVM
source ~/.zsh/python.zsh                     # Python and pyenv
source ~/.zsh/bun.zsh                        # bun
source ~/.zsh/pnpm.zsh                       # pnpm
source ~/.zsh/deno.zsh                       # deno

# 5. Done setup (must be last)
source ~/.zsh/amazon-q-post.zsh              # Amazon Q post-block