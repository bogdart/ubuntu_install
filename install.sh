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
sudo apt install gnome-sushi -y

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
mkdir -p ~/Applications
wget -P ~/Applications https://assets.msty.app/prod/latest/linux/amd64/Msty_x86_64_amd64.AppImage

chmod +x ~/Applications/*.AppImage

mkdir tmp

# Download and install DEBs
cd tmp
wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
sudo dpkg -i appimagelauncher_2.2.0-travis995.0f91801.bionic_amd64.deb
sudo apt install -f -y # Fix any dependencies

sudo apt install python3-nautilus -y
sudo apt install gir1.2-gtk-4.0 -y
wget https://github.com/Stunkymonkey/nautilus-open-any-terminal/releases/download/0.6.0/nautilus-extension-any-terminal_0.6.0-1_all.deb
sudo dpkg -i nautilus-extension-any-terminal_0.6.0-1_all.deb
sudo apt install -f -y # Fix any dependencies
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty
sudo apt remove nautilus-extension-gnome-terminal
nautilus -q


wget https://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_24.10/amd64/albert_0.26.8-0+656.1_amd64.deb
sudo dpkg -i albert_0.26.8-0+656.1_amd64.deb
sudo apt install -f -y # Fix any dependencies

# VS Code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list >/dev/null
rm -f packages.microsoft.gpg

sudo apt update -y
sudo apt install -y code

# lazydocker
LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazydocker.tar.gz lazydocker
sudo install lazydocker /usr/local/bin
rm lazydocker.tar.gz lazydocker

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit

# nerd font

mkdir -p ~/.local/share/fonts

wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip CascadiaMono.zip -d CascadiaFont
cp CascadiaFont/*.ttf ~/.local/share/fonts
rm -rf CascadiaMono.zip CascadiaFont
fc-cache -f


# Run shell scripts

# ohmyzsh exits the whole installation, so run in subwindow
gnome-terminal -- sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
read -p "Press enter after ohmyzsh finishes installing"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

curl -fsSL https://ollama.com/install.sh | sh
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
curl -LsSf https://astral.sh/uv/install.sh | sh

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo apt-get install -y uidmap
dockerd-rootless-setuptool.sh install



#select kitty here
sudo update-alternatives --config x-terminal-emulator

chsh -s $(which zsh)

cd ..

cd dotfiles
# Copy dotfiles to the home directory
cp -f .p10k.zsh .tmux.conf .zshrc ~/

# Copy folders to the .config directory, replacing existing ones
rm -rf ~/.config/flameshot ~/.config/kitty ~/.config/nvim
cp -rf flameshot kitty nvim ~/.config/

cd ..

# Create desktop entries
cd icons
cp -f Activity.png Docker.png ~/Applications

cd ..

cat <<EOF >~/.local/share/applications/Docker.desktop
[Desktop Entry]
Version=1.0
Name=Docker
Comment=Manage Docker containers with LazyDocker
Exec=kitty --class=Docker --title=Docker -e lazydocker
Terminal=false
Type=Application
Icon=/home/$USER/Applications/Docker.png
Categories=GTK;
StartupNotify=false
EOF



cat <<EOF > ~/.local/share/applications/Activity.desktop
[Desktop Entry]
Version=1.0
Name=Activity
Comment=System activity from btop
Exec=kitty --class=Activity --title=Activity -e btop
Terminal=false
Type=Application
Icon=/home/$USER/Applications/Activity.png
Categories=GTK;
StartupNotify=false
EOF



sudo rm -rf /usr/share/applications/nvim.desktop
cat <<EOF > ~/.local/share/applications/Neovim.desktop
[Desktop Entry]
Version=1.0
Name=Neovim
Comment=Edit text files
Exec=kitty --class=Neovim --title=Neovim -e nvim %F
Terminal=false
Type=Application
Icon=nvim
Categories=Utilities;TextEditor;
StartupNotify=false
EOF


# startup apps
AUTOSTART_DIR="$HOME/.config/autostart"
mkdir -p "$AUTOSTART_DIR"
ALBERT_AUTOSTART_FILE="$AUTOSTART_DIR/albert.desktop"

cat <<EOF > "$ALBERT_AUTOSTART_FILE"
[Desktop Entry]
Type=Application
Exec=albert
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Albert
Comment=Launch Albert on startup
EOF

# this takes screenshots of screen regularly


cd scripts
cp -f screen.sh ~/
cd ..


chmod +x ~/screen.sh

cat <<EOF > ~/.config/autostart/screenshot-script.desktop
[Desktop Entry]
Type=Application
Exec=sh -c "/home/$USER/screen.sh &"
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Screenshot Script
Comment=Run the screenshot script at startup in background
EOF



gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaMono Nerd Font 12'
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru')]"

mkdir -p ~/Pictures/Wallpapers

cp icons/disco.png ~/Pictures/Wallpapers/
gsettings set org.gnome.desktop.background picture-uri ~/Pictures/Wallpapers/disco.png
gsettings set org.gnome.desktop.background picture-options 'zoom'
