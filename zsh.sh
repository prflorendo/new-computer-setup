#!/bin/bash

# install stuff that will be used later
sudo apt update
sudo apt install -y git tmux zsh git-all gh ninja-build gettext cmake unzip curl gpg
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
sudo apt install -y desktop-file-utils

# rust stuff
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup override set stable
rustup update stable

gh auth login
git config --global core.editor 'nvim'
git config --global user.name 'prflorendo'
git config --global user.email 'pflorend@purdue.edu'

# directory where stuff will be cloned to
mkdir ~/.zsh

sudo cp MesloLGMDZNerdFontMono-Regular.ttf /usr/share/fonts/
cp .zshrc ~/.zshrc
cp .p10k.zsh ~/.p10k.zsh

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

# change visudo
sudo update-alternatives --config editor

# alacritty stuff
git clone https://github.com/alacritty/alacritty.git
cd alacritty
cargo build --release
sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
sudo mkdir -p /usr/local/share/man/man1
sudo mkdir -p /usr/local/share/man/man5
scdoc < extra/man/alacritty.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
scdoc < extra/man/alacritty-msg.1.scd | gzip -c | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
scdoc < extra/man/alacritty.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty.5.gz > /dev/null
scdoc < extra/man/alacritty-bindings.5.scd | gzip -c | sudo tee /usr/local/share/man/man5/alacritty-bindings.5.gz > /dev/null
cd ..
rm -rf alacritty
git clone https://github.com/prflorendo/pflow-alacritty ~/.config/alacritty

# tmux config stuff
git clone https://github.com/prflorendo/pflow-tmux ~/.config/tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

mkdir -p ${ZDOTDIR:-~}/.zsh_functions

cd ~/Downloads
# install discord
update_url="https://pax.discord.com/api/download?platform=linux&format=deb"
download_url=$(curl -w "%{url_effective}" -ILSs "$update_url" -o /dev/null)
upstream_version=$(awk -F/ '{print $6}' <<<"$download_url")

higher_version=$(
    printf "%s\n" "$upstream_version" "$current_version" \
    | sort --version-sort --reverse | head -1
)

if [[ $current_version != $higher_version ]]; then
        curl -sO "$download_url"
        filename=${download_url##*/}
        sudo apt-get -y --fix-broken install ./"$filename"
fi
rm discord*

# Install spotify
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install -y spotify-client

# Install vivaldi
curl -O https://downloads.vivaldi.com/stable/vivaldi-stable_6.5.3206.63-1_amd64.deb
sudo apt install -y ./vivaldi*
rm vivaldi*

# update the rest of the packages 
sudo apt upgrade

# <group> ALL=(ALL) NOPASSWD: /sbin/poweroff, /sbin/reboot, /sbin/shutdown'
# also install powertop + tlp for laptops

sudo reboot
