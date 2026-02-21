#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"

required_commands=(fish tmux nvim rg zoxide starship uv stow)
optional_commands=(wezterm)

is_wsl() {
  grep -qi microsoft /proc/version 2>/dev/null
}

failed=0

for cmd in "${required_commands[@]}"; do
  if ! command -v "${cmd}" >/dev/null 2>&1; then
    echo "[error] missing command: ${cmd}"
    failed=1
  fi
done

if ! is_wsl; then
  for cmd in "${optional_commands[@]}"; do
    if ! command -v "${cmd}" >/dev/null 2>&1; then
      echo "[warn] optional command not found: ${cmd}"
    fi
  done
fi

symlink_targets=(
  "$HOME/.config/fish/config.fish"
  "$HOME/.config/tmux/tmux.conf"
  "$HOME/.config/nvim/init.lua"
  "$HOME/.config/wezterm/wezterm.lua"
  "$HOME/.config/starship.toml"
)

for target in "${symlink_targets[@]}"; do
  if [[ ! -e "${target}" ]]; then
    echo "[error] missing file: ${target}"
    failed=1
  fi
done

if [[ "${failed}" -ne 0 ]]; then
  exit 1
fi

echo "[ok] verification completed"
