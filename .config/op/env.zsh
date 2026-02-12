# 1Password environment variable loader
# Exports op:// references. Resolved at runtime via `op run -- <cmd>`.

# Personal dev API keys (Personal vault, resolved with personal account)
source ~/.config/op/personal.env

# Company environment variables (smilegate vault, resolved with smilegate SA)
source ~/.config/op/smilegate.env

# SA tokens are not exported to the environment.
# Use helper functions below to switch context:
op-sg() { OP_SERVICE_ACCOUNT_TOKEN="$(op read op://Personal/SMILEGATE_SA_TOKEN/credential)" op run --env-file ~/.config/op/smilegate.env -- "$@" }
# Machine-local settings
[[ -f ~/.config/op/env.local.zsh ]] && source ~/.config/op/env.local.zsh
