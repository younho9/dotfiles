# cmux ↔ VS Code workspace 동기화 launcher.
# cmux surface 안의 zsh 에서만 (CMUX_WORKSPACE_ID 정의됨) 1회 띄움.
# nohup + disown 으로 zsh 가 종료돼도 살아있고, cmux app 종료 시 같이 죽음.
# socketControlMode=cmuxOnly 정책 때문에 cmux 의 자식이어야 socket 접근 가능 — launchd 우회 사유.

# 데몬 스크립트는 이 launcher 와 같은 디렉토리에 둠 (${0:A:h} 가 symlink 까지 resolve).
local sync_bin="${0:A:h}/cmux-vscode-sync"

if [[ -n "$CMUX_WORKSPACE_ID" ]] \
  && [[ -x "$sync_bin" ]] \
  && ! pgrep -f "cmux-vscode-sync$" >/dev/null 2>&1; then
  nohup "$sync_bin" </dev/null >/dev/null 2>&1 &!
fi
