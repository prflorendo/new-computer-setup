#!/bin/bash

# install necessary zsh stuff
sudo apt update
sudo apt -y install git guake tmux zsh git-all gh neovim

gh auth login
git config --global core.editor 'nvim'
git config --global user.name 'prflorendo'
git config --global user.email 'pflorend@purdue.edu'

# directory where stuff will be cloned to
mkdir ~/.zsh

sudo mv MesloLGMDZNerdFontMono-Regular.ttf /usr/share/fonts/
mv .zshrc ~/.zshrc

cd ~/.zsh

# p10k theme + plugins
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ~/.zsh/zsh-you-should-use
git clone https://github.com/MichaelAquilina/zsh-auto-notify.git ~/.zsh/zsh-auto-notify
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
git clone https://github.com/jeffreytse/zsh-vi-mode.git ~/.zsh/zsh-vi-mode
git clone https://github.com/eza-community/eza.git ~/.zsh/eza

# change shell to zsh
chsh -s /bin/zsh

sudo echo 'pflow ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown' >> /etc/sudoers
sudo update-alternatives --config editor

sudo apt upgrade

sudo reboot

#sudoers thing broken for some reason, fix later
#also install powertop + tlp for laptops
#TODO add vim config stuff
