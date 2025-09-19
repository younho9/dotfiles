#!/usr/bin/env zsh

# pnpm
export PNPM_HOME="/Users/younho9/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
