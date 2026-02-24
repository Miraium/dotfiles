#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.local/bin:$PATH"

if ! command -v uv >/dev/null 2>&1; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

if command -v fish >/dev/null 2>&1; then
  fish -c "type -q fisher; or curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"

  if [[ -f "$HOME/.config/fish/fish_plugins" ]]; then
    fish -c "fisher update"
  fi
fi

if command -v tmux >/dev/null 2>&1; then
  tmux_plugins_dir="$HOME/.config/tmux/plugins"
  tpm_dir="${tmux_plugins_dir}/tpm"

  if [[ ! -d "${tpm_dir}/.git" ]]; then
    mkdir -p "${tmux_plugins_dir}"
    git clone https://github.com/tmux-plugins/tpm "${tpm_dir}"
  fi

  if [[ -f "$HOME/.config/tmux/tmux.conf" ]]; then
    tmux start-server
    tmux source-file "$HOME/.config/tmux/tmux.conf" || true
    tmux new-session -d -s dotfiles-tpm >/dev/null 2>&1 || true
    TMUX_PLUGIN_MANAGER_PATH="${tmux_plugins_dir}/" "${tpm_dir}/bin/install_plugins" || true
    tmux kill-session -t dotfiles-tpm >/dev/null 2>&1 || true
  fi
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
