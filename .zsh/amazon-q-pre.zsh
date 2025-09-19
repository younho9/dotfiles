#!/usr/bin/env zsh

# Amazon Q Shell Integration
# This file contains Amazon Q specific configuration that needs to be loaded
# at specific points in the shell initialization process

# Amazon Q pre block - Load at the beginning of shell initialization
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
