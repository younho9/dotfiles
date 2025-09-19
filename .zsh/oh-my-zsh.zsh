#!/usr/bin/env zsh

# Oh My Zsh Configuration

# Set theme
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Configure plugins
plugins=(
  autoupdate
  git
  git-open
  zsh-syntax-highlighting
  zsh-autosuggestions
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Enable Powerlevel10k instant prompt
# See https://github.com/romkatv/powerlevel10k#how-do-i-enable-instant-prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Powerlevel10k configuration
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh