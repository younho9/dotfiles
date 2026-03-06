# 1Password Document Sync
# Syncs gitignored machine-local files with 1Password Personal vault

# Shared sync targets (local_path:1p_doc_title)
OP_SYNC_FILES=(
  "$HOME/.op-sync/personal.env:dotfiles-personal.env"
  "$HOME/.op-sync/smilegate.env:dotfiles-smilegate.env"
  "$HOME/.aliases.local:dotfiles-aliases.local"
)

# Per-machine sync targets (doc title includes hostname)
OP_SYNC_HOST_FILES=(
  "$HOME/.op-sync/op.env-${HOST}:dotfiles-op.env-${HOST}"
)

# Personal vault access (ignore SA token)
_op_personal() { OP_SERVICE_ACCOUNT_TOKEN="" op "$@" }
op-me() { _op_personal "$@" }

# Check if 1P app is unlocked
_op_is_authed() {
  _op_personal account get --format json &>/dev/null
}

# Pull: 1P -> local
op-sync-pull() {
  local all_specs=("${OP_SYNC_FILES[@]}" "${OP_SYNC_HOST_FILES[@]}")
  for spec in "${all_specs[@]}"; do
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
  local all_specs=("${OP_SYNC_FILES[@]}" "${OP_SYNC_HOST_FILES[@]}")
  for spec in "${all_specs[@]}"; do
    local local_path="${spec%%:*}" doc_title="${spec##*:}"
    [[ -f "$local_path" ]] || { echo "✗ $local_path (not found)"; continue }
    # edit (update), fallback to create
    _op_personal document edit "$doc_title" \
      --vault Personal "$local_path" 2>/dev/null && \
      echo "✓ $local_path → $doc_title (updated)" || \
    { _op_personal document create "$local_path" \
        --title "$doc_title" --vault Personal && \
      echo "✓ $local_path → $doc_title (created)" }
  done
}

# Unified command
op-sync() {
  case "$1" in
    push) op-sync-push ;;
    pull) op-sync-pull ;;
    *) echo "Usage: op-sync [push|pull]" ;;
  esac
}

# Auto sync on shell startup
_op_sync_auto() {
  if [[ ! -f "$HOME/.op-sync/op.env-${HOST}" ]]; then
    # New machine: blocking pull (allows auth prompt)
    echo "[op-sync] 로컬 파일 없음. 1Password에서 동기화 중..."
    op-sync-pull
  fi
}

_op_sync_auto
