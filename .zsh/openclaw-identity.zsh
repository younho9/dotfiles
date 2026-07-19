# openclaw bot git identity (opt-in)
#
# GIT_AUTHOR_* / GIT_COMMITTER_* are environment variables, and git ranks them
# ABOVE `git config`. Exporting them unconditionally (as ~/.env used to) silently
# re-attributes every commit made on the machine to the bot — including your own.
#
# So the identity lives here, gated behind an explicit opt-in, instead of in the
# op-synced ~/.env where it applied to every interactive shell.

OPENCLAW_BOT_NAME="younho9-openclaw[bot]"
OPENCLAW_BOT_EMAIL="261238312+younho9-openclaw[bot]@users.noreply.github.com"

# Session-wide: openclaw sets OPENCLAW_BOT_IDENTITY=1 in the environment it
# launches agent sessions with. Normal user shells leave it unset and keep the
# `[user]` identity from ~/.gitconfig.
if [[ -n "${OPENCLAW_BOT_IDENTITY:-}" ]]; then
  export GIT_AUTHOR_NAME="$OPENCLAW_BOT_NAME"
  export GIT_AUTHOR_EMAIL="$OPENCLAW_BOT_EMAIL"
  export GIT_COMMITTER_NAME="$OPENCLAW_BOT_NAME"
  export GIT_COMMITTER_EMAIL="$OPENCLAW_BOT_EMAIL"
fi

# Ad-hoc: run a single command as the bot, e.g.
#   as-openclaw git commit -m "🤖 automated bump"
as-openclaw() {
  GIT_AUTHOR_NAME="$OPENCLAW_BOT_NAME" \
  GIT_AUTHOR_EMAIL="$OPENCLAW_BOT_EMAIL" \
  GIT_COMMITTER_NAME="$OPENCLAW_BOT_NAME" \
  GIT_COMMITTER_EMAIL="$OPENCLAW_BOT_EMAIL" \
  "$@"
}
