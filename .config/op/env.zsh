# 1Password environment variable loader
# op:// references are resolved at runtime via `op run --env-file`.
# No op:// values are exported to the shell environment.

# Symlink OP_ENV_FILE → .env for op run
[[ -n "${OP_ENV_FILE}" ]] && ln -sf "${OP_ENV_FILE}" ~/.env

# Account wrappers
op-me() { OP_SERVICE_ACCOUNT_TOKEN="" op "$@" }
