#!/bin/bash

# install necessary zsh stuff
sudo apt update
sudo apt -y install git guake tmux zsh git-all gh ninja-build gettext cmake unzip curl gpg

gh auth login
git config --global core.editor 'nvim'
git config --global user.name 'prflorendo'
git config --global user.email 'pflorend@purdue.edu'

# directory where stuff will be cloned to
mkdir ~/.zsh

sudo cp MesloLGMDZNerdFontMono-Regular.ttf /usr/share/fonts/
cp .zshrc ~/.zshrc

cd ~/.zsh

# p10k theme + plugins
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ~/.zsh/zsh-you-should-use
git clone https://github.com/MichaelAquilina/zsh-auto-notify.git ~/.zsh/zsh-auto-notify
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.zsh/zsh-vi-mode

# change shell to zsh
chsh -s /bin/zsh

cd ~
# neovim installation + config stuff
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd ..
rm -rf neovim
git clone https://github.com/prflorendo/pflow-nvchad.git ~/.config/nvim

# zoxide stuff
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# eza stuff
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

sudo update-alternatives --config editor

sudo apt upgrade

# <group> ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown'
# also install powertop + tlp for laptops
# TODO: Add stuff to install vivaldi, discord, spotify

sudo reboot
