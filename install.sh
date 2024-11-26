#!/bin/bash



# Add repositories
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo add-apt-repository -y ppa:flexiondotorg/quickemu

# Update after adding repos
sudo apt update

# Install apt packages
sudo apt install -y \
    qbittorrent \
    gparted \
    git \
    timeshift \
    fzf \
    ripgrep \
    bat \
    xclip \
    cmake \
    gnome-tweaks \
    zsh \
    vlc \
    kitty \
    neovim \
    tesseract-ocr-rus \
    tesseract-ocr \
    albert \
    fastfetch \
    btop \
    bat \
    build-essential \
    ffmpeg \
    gnome-tweaks \
    chromium-browser \
    flameshot \
    python3-dev \
    tmux \
    quickemu

# Install Flatpak and add Flathub
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Install Flatpak apps
flatpak install flathub dev.zed.Zed
flatpak install -y flathub md.obsidian.Obsidian
flatpak install flathub org.telegram.desktop
flatpak install flathub org.kde.krita
flatpak install flathub com.visualstudio.code


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

.files
#flameshot
#zsh
#ohmysh
#p10k


# Copy dot files
cp -r ~/dotfiles/.config ~/.config
cp ~/dotfiles/.bashrc ~/.bashrc
