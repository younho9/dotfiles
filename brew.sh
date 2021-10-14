#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install fonts.
brew tap homebrew/cask-fonts
brew install --cask font-fira-code

# Install tools.
brew install bat
brew install fasd
brew install fzf
brew install gh
brew install git
brew install jq
brew install nvm
brew install tree
brew install neofetch

# Install apps.
brew install --cask alfred
brew install --cask cleanmymac
brew install --cask discord
brew install --cask figma
brew install --cask firefox
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask iterm2
brew install --cask karabiner-elements
brew install --cask keka
brew install --cask macs-fan-control
brew install --cask microsoft-edge
brew install --cask notion
brew install --cask openinterminal
brew install --cask postman
brew install --cask slack
brew install --cask spotify
brew install --cask typora
brew install --cask visual-studio-code

# Remove outdated versions from the cellar.
brew cleanup
