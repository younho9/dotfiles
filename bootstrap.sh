#!/usr/bin/env bash

export DOTFILES_DIR="$HOME/repositories/github/public/dotfiles"

if [ -d $DOTFILES_DIR ]; then
	cd "$(dirname "${BASH_SOURCE}")";
	git pull origin main
else
	git clone git@github.com:younho9/dotfiles.git $DOTFILES_DIR
fi

ln -sf "$DOTFILES_DIR/.aliases" "$HOME/.aliases"
ln -sf "$DOTFILES_DIR/.exports" "$HOME/.exports"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.gitconfig.company" "$HOME/.gitconfig.company"
ln -sf "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
ln -sf "$DOTFILES_DIR/.gitmessage.txt" "$HOME/.gitmessage.txt"
ln -sf "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
