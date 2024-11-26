#!/bin/bash



# Add repositories
sudo add-apt-repository -y ppa:neovim-ppa/stable
# sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo add-apt-repository -y ppa:flexiondotorg/quickemu

# Update after adding repos
sudo apt update

# Install apt packages
sudo apt install curl -y
sudo apt install qbittorrent -y
sudo apt install gparted -y
sudo apt install git -y
sudo apt install timeshift -y
sudo apt install fzf -y
sudo apt install ripgrep -y
sudo apt install bat -y
sudo apt install xclip -y
sudo apt install cmake -y
sudo apt install gnome-tweaks -y
sudo apt install zsh -y
sudo apt install vlc -y
sudo apt install kitty -y
sudo apt install neovim -y
sudo apt install tesseract-ocr-rus -y
sudo apt install tesseract-ocr -y
sudo apt install albert -y
sudo apt install fastfetch -y
sudo apt install btop -y
sudo apt install bat -y
sudo apt install build-essential -y
sudo apt install ffmpeg -y
sudo apt install gnome-tweaks -y
sudo apt install chromium-browser -y
sudo apt install flameshot -y
sudo apt install python3-dev -y
sudo apt install tmux -y
sudo apt install quickemu -y

# Install Flatpak and add Flathub
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak apps
flatpak install flathub dev.zed.Zed
flatpak install -y flathub md.obsidian.Obsidian
flatpak install flathub org.telegram.desktop
flatpak install flathub org.kde.krita

# Snaps
sudo snap install bitwarden

# Create directory for AppImages and download them
mkdir -p ~/.apps
wget -P ~/.apps https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=appimage
wget -P ~/.apps https://assets.msty.app/prod/latest/linux/amd64/Msty_x86_64_amd64.AppImage

chmod +x ~/.apps/*.AppImage

# Download and install DEBs
cd /tmp
wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
sudo dpkg -i appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
sudo apt install -f -y # Fix any dependencies



# VS Code
cd /tmp
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
rm -f packages.microsoft.gpg
cd -

sudo apt update -y
sudo apt install -y code

# lazydocker
cd /tmp
LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazydocker.tar.gz lazydocker
sudo install lazydocker /usr/local/bin
rm lazydocker.tar.gz lazydocker
cd -

# lazygit
cd /tmp
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit
cd -

# nerd font

mkdir -p ~/.local/share/fonts

cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip CascadiaMono.zip -d CascadiaFont
cp CascadiaFont/*.ttf ~/.local/share/fonts
rm -rf CascadiaMono.zip CascadiaFont
fc-cache -f


# Run shell scripts
curl -fsSL https://ollama.com/install.sh | sh
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
curl -LsSf https://astral.sh/uv/install.sh | sh

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt-get install -y uidmap
dockerd-rootless-setuptool.sh install




git config --global user.email "git@bogdart.com"
git config --global user.name "Art Bogdanov"

curl https://raw.githubusercontent.com/ohmysh/ohmysh/main/install.sh > OMSInstaller.sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k




#select kitty here
sudo update-alternatives --config x-terminal-emulator


# compile alternative terminal
git clone https://github.com/Stunkymonkey/nautilus-open-any-terminal.git
cd nautilus-open-any-terminal
sudo apt-get install gettext -y
make
sudo make install schema
nautilus -q
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty
nautilus -q
sudo apt remove nautilus-extension-gnome-terminal


# Copy dot files
# Copy dotfiles to the home directory
cp -f .p10k.zsh .tmux.conf .zshrc ~/

# Copy folders to the .config directory, replacing existing ones
cp -rf flameshot kitty nvim ~/.config/
