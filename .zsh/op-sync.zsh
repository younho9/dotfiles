# 1Password Document Sync
# Syncs gitignored machine-local files with 1Password Personal vault

# Sync targets (local_path:1p_doc_title)
OP_SYNC_FILES=(
  "$HOME/.aliases.local:.aliases.local"
  "$HOME/.dotfiles/.config/op/${HOST}.env:.${HOST}.env"
  "$HOME/.dotfiles/.aws/credentials:.aws-credentials"
  "$HOME/.dotfiles/.aws/config:.aws-config"
)

# Personal vault access (ignore SA token)
_op_personal() { OP_SERVICE_ACCOUNT_TOKEN="" op "$@" }
op-me() { _op_personal "$@" }

# Pull: 1P -> local
op-sync-pull() {
  for spec in "${OP_SYNC_FILES[@]}"; do
    local local_path="${spec%%:*}" doc_title="${spec##*:}"
    mkdir -p "$(dirname "$local_path")"
    _op_personal document get "$doc_title" \
      --vault Personal --out-file "$local_path" --force 2>/dev/null && \
      echo "✓ $doc_title → $local_path" || \
      echo "✗ $doc_title (not found or auth failed)"
  done
}

# Push: local -> 1P
op-sync-push() {
  for spec in "${OP_SYNC_FILES[@]}"; do
    local local_path="${spec%%:*}" doc_title="${spec##*:}"
    [[ -f "$local_path" ]] || { echo "✗ $local_path (not found)"; continue }
    _op_personal document edit "$doc_title" \
      --vault Personal "$local_path" 2>/dev/null && \
      echo "✓ $local_path → $doc_title (updated)" || \
    { _op_personal document create "$local_path" \
        --title "$doc_title" --vault Personal && \
      echo "✓ $local_path → $doc_title (created)" }
  done
}

op-sync() {
  case "$1" in
    push) op-sync-push ;;
    pull) op-sync-pull ;;
    *) echo "Usage: op-sync [push|pull]" ;;
  esac
}

# Auto sync on shell startup
if [[ ! -f "$HOME/.dotfiles/.config/op/${HOST}.env" ]]; then
  echo "[op-sync] local files not found. syncing from 1Password..."
  op-sync-pull
fi
