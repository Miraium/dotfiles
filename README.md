# dotfiles

Ubuntu / WSL2(Ubuntu) / macOS 向けの dotfiles です。

## 含まれる設定

- fish
- tmux
- WezTerm
- Neovim (LazyVim)
- starship

## 特徴

- `GNU Stow` によるシンボリックリンク管理
- Python 環境は `uv` に一本化
- `zoxide`, `ripgrep`, `eza`, `fzf` を前提にした CLI 体験
- Windows Terminal と WezTerm を併記サポート

## セットアップ

詳細手順は `INSTALL.md` を参照してください。

最短実行:

```bash
./scripts/bootstrap.sh
```

## 参考

- Windows Terminal 設定: <https://github.com/Miraium/windows-terminal-setting>
