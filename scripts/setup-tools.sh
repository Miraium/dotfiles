#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"

if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

if command -v nvim >/dev/null 2>&1; then
  nvim_version="$(nvim --version | head -n1 | awk '{print $2}' | sed 's/^v//')"
  nvim_minor="$(echo "${nvim_version}" | awk -F. '{print $2}')"
  if [[ "${nvim_minor}" -ge 8 ]]; then
    nvim --headless "+Lazy! sync" +qa || true
  else
    echo "[warn] Neovim ${nvim_version} is too old for LazyVim. Upgrade nvim to >= 0.8."
  fi
fi
