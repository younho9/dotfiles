# 1Password environment variable loader
# op:// references are resolved at runtime via `op run --env-file`.
# No op:// values are exported to the shell environment.

op-me() { op "$@" }
op-me-run() { op run --env-file ~/.config/op/personal.env -- "$@" }
op-sg() { OP_SERVICE_ACCOUNT_TOKEN="$(op read op://Personal/SMILEGATE_SA_TOKEN/credential)" op "$@" }
op-sg-run() { OP_SERVICE_ACCOUNT_TOKEN="$(op read op://Personal/SMILEGATE_SA_TOKEN/credential)" op run --env-file ~/.config/op/smilegate.env -- "$@" }

# Machine-local settings
[[ -f ~/.config/op/env.local.zsh ]] && source ~/.config/op/env.local.zsh
