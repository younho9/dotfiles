# AGENTS.md

Personal dotfiles for macOS development environment.

## Setup

```bash
git clone https://github.com/younho9/dotfiles.git && cd dotfiles && source .macos
```

The `.macos` script:

1. Creates directory structure
2. Symlinks config files to `~`
3. Installs tools via Homebrew

## Project Structure

- `.zsh/*.zsh` - Modular shell config (one file per tool)
- `.gitconfig.company` / `.mcp.company.json` - Company-specific configs
- `~/.ssl/certs/custom-ca-bundle.pem` - Custom CA bundle path

## Conventions

- Korean locale: `ko_KR.UTF-8`
- Bilingual PR/issue templates (Korean/English)
- Company/personal config separation pattern

## Commit Convention

Format: `<scope>: <description>`

- `<scope>`: file name or folder name (e.g., `.zsh`, `.macos`, `iTerm`)
- `<description>`: lowercase, imperative mood (add, remove, update, fix)

Examples:

- `.zsh: add Python 3.9 bin to PATH`
- `.macos: add argocd and gemini-cli`
- `iTerm: sync settings`
