#!/usr/bin/env bash
set -euo pipefail

is_wsl() {
  grep -qi microsoft /proc/version 2>/dev/null
}

install_nvim_appimage() {
  local arch appimage_name url tmpfile extract_dir install_dir
  arch="$(uname -m)"
  case "${arch}" in
    x86_64|amd64)
      appimage_name="nvim-linux-x86_64.appimage"
      ;;
    aarch64|arm64)
      appimage_name="nvim-linux-arm64.appimage"
      ;;
    *)
      echo "[warn] unsupported architecture for Neovim AppImage: ${arch}"
      return
      ;;
  esac

  url="https://github.com/neovim/neovim/releases/latest/download/${appimage_name}"
  tmpfile="$(mktemp /tmp/nvim-appimage.XXXXXX)"
  install_dir="$HOME/.local/opt/nvim-appimage"

  curl -fL "${url}" -o "${tmpfile}"
  chmod u+x "${tmpfile}"

  extract_dir="$(mktemp -d /tmp/nvim-extract.XXXXXX)"
  (
    cd "${extract_dir}"
    "${tmpfile}" --appimage-extract >/dev/null
  )

  rm -rf "${install_dir}"
  mkdir -p "$(dirname "${install_dir}")"
  mv "${extract_dir}/squashfs-root" "${install_dir}"
  rm -rf "${extract_dir}" "${tmpfile}"

  mkdir -p "$HOME/.local/bin"
  ln -snf "${install_dir}/AppRun" "$HOME/.local/bin/nvim"
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
    ripgrep \
    stow \
    tmux \
    unzip \
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

  install_nvim_appimage
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
