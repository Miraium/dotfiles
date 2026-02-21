#!/usr/bin/env bash
set -euo pipefail

is_wsl() {
  grep -qi microsoft /proc/version 2>/dev/null
}

install_eza_apt_repo() {
  if command -v eza >/dev/null 2>&1; then
    return
  fi

  sudo apt install -y gpg
  sudo mkdir -p /etc/apt/keyrings
  wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list >/dev/null
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  sudo apt update
  sudo apt install -y eza
}

install_ubuntu() {
  sudo apt update
  sudo apt install -y software-properties-common
  sudo apt-add-repository -y ppa:fish-shell/release-3
  sudo apt update
  sudo apt install -y \
    curl \
    fish \
    fzf \
    git \
    gpg \
    neovim \
    ripgrep \
    stow \
    tmux \
    wget \
    zoxide

  install_eza_apt_repo

  if apt-cache show wezterm >/dev/null 2>&1; then
    sudo apt install -y wezterm
  else
    echo "[warn] wezterm package is not available via apt on this distro. Install it manually if needed."
  fi

  if ! command -v starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
  fi

  local nvim_version nvim_minor
  nvim_version="$(nvim --version | head -n1 | awk '{print $2}' | sed 's/^v//')"
  nvim_minor="$(echo "${nvim_version}" | awk -F. '{print $2}')"
  if [[ -z "${nvim_minor}" || "${nvim_minor}" -lt 8 ]]; then
    echo "[info] Upgrading neovim via ppa:neovim-ppa/unstable for LazyVim compatibility."
    sudo add-apt-repository -y ppa:neovim-ppa/unstable
    sudo apt update
    sudo apt install -y neovim
  fi
}

install_macos() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "[error] Homebrew is required on macOS."
    echo "Install from: https://brew.sh"
    exit 1
  fi

  brew bundle --file Brewfile
}

main() {
  local uname_s
  uname_s="$(uname -s)"

  case "${uname_s}" in
    Linux)
      install_ubuntu
      if is_wsl; then
        echo "[info] WSL2 detected. Configure font from Windows side (WezTerm/Windows Terminal)."
      fi
      ;;
    Darwin)
      install_macos
      ;;
    *)
      echo "[error] Unsupported OS: ${uname_s}"
      exit 1
      ;;
  esac
}

main "$@"
