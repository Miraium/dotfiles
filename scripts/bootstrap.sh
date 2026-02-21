#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"

backup_path() {
  local path="$1"
  if [[ -e "${path}" && ! -L "${path}" ]]; then
    local backup="${path}.bak.$(date +%Y%m%d%H%M%S)"
    mv "${path}" "${backup}"
    echo "[info] backed up ${path} -> ${backup}"
  fi
}

backup_existing_configs() {
  backup_path "$HOME/.config/fish/config.fish"
  backup_path "$HOME/.config/tmux/tmux.conf"
  backup_path "$HOME/.config/nvim"
  backup_path "$HOME/.config/wezterm"
  backup_path "$HOME/.config/starship.toml"
}

main() {
  cd "${ROOT_DIR}"

  ./scripts/install-deps.sh
  backup_existing_configs

  mkdir -p "$HOME/.config"
  stow --target="$HOME" --restow home

  ./scripts/setup-tools.sh
  ./scripts/verify.sh
}

main "$@"
