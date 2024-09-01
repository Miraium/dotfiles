# Install

## Font

アイコンフォントが必要なため、Bizin Gothic NFを使っています。
ターミナルのフォントに設定しています。（Windows Terminalを使用）

Bizin Gothic NF
(https://github.com/yuru7/bizin-gothic)[https://github.com/yuru7/bizin-gothic]


## Install Commands

'''shell
sudo apt update
sudo apt upgrade

# インストールの前提として使用するパッケージ
sudo apt install -y curl git wget
# apt-add-repositoryコマンド用
sudo apt install software-properties-common

# dotfilesのクローン、.configなどへの配置
cd ~/
git clone https://github.com/Miraium/dotfiles.git
cp dotfiles/.vimrc ~/
cp -r dotfiles/.config/ ~

# tmux vim fishのインストール
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt install -y tmux vim fish

# Vim-Plugインストールとプラグインのインストール
# (参考) CLIでのVim-Plugのインストールについて https://github.com/junegunn/vim-plug/issues/675
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +'PlugInstall --sync' +qa

# ezaのインストール
sudo apt update
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# fzfのインストール
sudo apt -y install fzf

# asdfのインストール
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1

# Fish環境に入って作業
tmux

# Fisher & Pluign
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install jethrokuan/z
fisher install jethrokuan/fzf

# asdfを使ってPython, Poetryをインストール
sudo apt update
sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev curl git libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
asdf plugin-add poetry
asdf plugin-add python
asdf install poetry latest
asdf install python latest
asdf global poetry latest
asdf global python latest
'''