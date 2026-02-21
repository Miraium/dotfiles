# Install

## Prerequisites

- Ubuntu / WSL2(Ubuntu) / macOS
- `git`
- Nerd Font (推奨: Bizin Gothic NF)

## Clone

```bash
cd ~
git clone https://github.com/Miraium/dotfiles.git
cd dotfiles
```

## Bootstrap (Recommended)

```bash
./scripts/bootstrap.sh
```

このコマンドは以下を実行します。

- OS別の依存導入 (`apt` / `brew`)
- 既存設定のバックアップ
- `stow` による設定反映
- `uv` と Neovim(LazyVim) 初期化
- 最低限の動作検証

## Manual Steps

### 1. Install dependencies only

```bash
./scripts/install-deps.sh
```

### 2. Deploy dotfiles with Stow

```bash
stow --target="$HOME" --restow home
```

### 3. Setup tools

```bash
./scripts/setup-tools.sh
```

### 4. Verify

```bash
./scripts/verify.sh
```

## Notes

- WSL2 ではフォント設定を Windows 側のターミナルで行ってください。
- WezTerm 設定は `home/.config/wezterm/wezterm.lua` にあります。
- Windows Terminal は継続利用できます。
