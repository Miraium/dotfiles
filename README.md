# dotfiles

## Tool list

- Alacritty
- Vim
- tmux
- fish

## For Ubuntu (WSL2)

Clone this repository

```shell
cd ~/
git clone https://github.com/Miraium/dotfiles.git
```

Copy setting files

```shell
cp dotfiles/.vimrc ~/
cp -r dotfiles/.config/ ~
```

Install Vim-plug
([Link: Vim-plug](https://github.com/junegunn/vim-plug))

```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Launch Vim & Run following command at Vim.

```vim
:PlugInstall
```

## For Windows

```
mkdir /mnt/c/Users/<UserName>/AppData/Roaming/alacritty
cp .config/alacritty/alacritty.yml /mnt/c/Users/<UserName>/AppData/Roaming/alacritty
```
