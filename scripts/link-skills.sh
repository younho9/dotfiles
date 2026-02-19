#!/usr/bin/env zsh
# link-skills.sh
# Link all skills from public/skills and private/private-skills repos
# to agent skill directories.
#
# Usage:
#   ./scripts/link-skills.sh                  # link to all agents
#   ./scripts/link-skills.sh -a claude        # claude code only
#   ./scripts/link-skills.sh -a openclaw      # openclaw only
#   ./scripts/link-skills.sh --dry-run        # preview without linking

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────

PUBLIC_SKILLS="${HOME}/repositories/github/public/skills/skills"
PRIVATE_SKILLS="${HOME}/repositories/github/private/private-skills/skills"

agent_dir_claude="${HOME}/.claude/skills"
agent_dir_openclaw="${HOME}/.openclaw/skills"
all_agents=(claude openclaw)

# ── Args ──────────────────────────────────────────────────────────────────────

DRY_RUN=false
selected_agents=("${all_agents[@]}")

while [[ $# -gt 0 ]]; do
  case "$1" in
    -a|--agent)
      selected_agents=("$2")
      shift 2
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [-a claude|openclaw] [--dry-run]"
      exit 1
      ;;
  esac
done

# ── Helpers ───────────────────────────────────────────────────────────────────

get_agent_dir() {
  local agent="$1"
  case "$agent" in
    claude)   echo "$agent_dir_claude" ;;
    openclaw) echo "$agent_dir_openclaw" ;;
    *) echo ""; ;;
  esac
}

link_skill() {
  local skill_path="$1"
  local target_dir="$2"
  local name="${skill_path:t}"  # basename in zsh
  local link="${target_dir}/${name}"

  if [[ "$DRY_RUN" == true ]]; then
    echo "  [dry-run] $name → ${skill_path}"
    return
  fi

  mkdir -p "$target_dir"

  if [[ -L "$link" ]]; then
    rm "$link"
  elif [[ -d "$link" ]]; then
    echo "  ⚠ skip: $link is a real directory (not a symlink)"
    return
  fi

  ln -s "$skill_path" "$link"
  echo "  ✓ $name"
}

link_repo() {
  local repo_dir="$1"
  local label="$2"
  local target_dir="$3"

  if [[ ! -d "$repo_dir" ]]; then
    echo "  ⚠ skip: $repo_dir not found"
    return
  fi

  echo "  [$label]"
  for skill in "$repo_dir"/*/; do
    [[ -d "$skill" ]] || continue
    link_skill "$skill" "$target_dir"
  done
}

# ── Main ──────────────────────────────────────────────────────────────────────

echo "🔗 link-skills${DRY_RUN:+ (dry-run)}"
echo ""

for agent in "${selected_agents[@]}"; do
  target=$(get_agent_dir "$agent")
  if [[ -z "$target" ]]; then
    echo "Unknown agent: $agent (valid: ${all_agents[*]})"
    exit 1
  fi

  echo "→ ${agent} (${target})"
  link_repo "$PUBLIC_SKILLS"  "public/skills"          "$target"
  link_repo "$PRIVATE_SKILLS" "private/private-skills" "$target"
  echo ""
done

echo "done."
