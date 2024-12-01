#!/bin/bash

# Display the ASCII art
clear
sleep 1
echo "                            __        _______ _     ___   ____ ___  __  __ _____    ____    _    ____ _  __"
sleep 0.1
echo "                            \ \      / / ____| |   / _ \ / ___/ _ \|  \/  | ____|  | __ )  / \  / ___| |/ /"
sleep 0.1
echo "                             \ \ /\ / /|  _| | |  | | | | |  | | | | |\/| |  _|    |  _ \ / _ \| |   | ' / "
sleep 0.1
echo "                              \ V  V / | |___| |__| |_| | |__| |_| | |  | | |___   | |_) / ___ \ |___| . \ "
sleep 0.1
echo "                               \_/\_/  |_____|_____\___/ \____\___/|_|  |_|_____|  |____/_/   \_\____|_|\_"
sleep 0.1
echo ""
sleep 1
echo "                         __  __ ____       ____  ____  _____ _____    ____ _   _    _    ____      _    _   _ "
sleep 0.1
echo "                        |  \/  |  _ \     / ___||  _ \| ____| ____|  / ___| | | |  / \  |  _ \    / \  | \ | | "
sleep 0.1
echo "                        | |\/| | |_) |    \___ \| |_) |  _| |  _|   | |   | |_| | / _ \ | |_) |  / _ \ |  \| |"
sleep 0.1
echo "                        | |  | |  _ < _    ___) |  _ <| |___| |___  | |___|  _  |/ ___ \|  _ <  / ___ \| |\  |"
sleep 0.1
echo "                        |_|  |_|_| \_(_)  |____/|_| \_\_____|_____|  \____|_| |_/_/   \_\_| \_\/_/   \_\_| \_|"
sleep 0.1
echo ""
sleep 1

# Function to simulate loading animation
function loading() {
    local msg="$1"
    echo -ne "\r$msg"
    while true; do
        for i in '.' '..' '...'; do
            echo -ne "$i"
            sleep 1
        done
    done
}

# Function to show a simple progress bar
function progress_bar() {
    local current=0
    local total=$1
    local progress=0

    echo -n "["
    for ((i=0; i<total; i++)); do
        echo -n "="
        sleep 0.1
        ((progress+=1))
    done
    echo "]"
}

function starting_messsage() {
    local current=0
    local total=$1
    local progress=0

    echo -n "# Starting your personal setup script Please wait"
    for ((i=0; i<total; i++)); do
        echo -n "."
        sleep 0.1
        ((progress+=1))
    done
    echo ""
}

starting_messsage 5

#Comment from here to test

# Update and install essential packages with progress bar
echo ""
loading "[Hit -1] : Updating system and installing essential packages"
sudo apt update && sudo apt upgrade -y

echo "Updated"

progress_bar 50


# Install necessary packages
sudo apt install -y \
    brave-browser \
    google-chrome-stable \
    code \
    nodejs \
    python3 \
    docker.io \
    stacer \
    gnome-tweaks \
    gnome-shell-extensions \
    mysql-client \
    libgnomecanvas2-0 \
    fontconfig
progress_bar 70

# Install Apple Fonts
sudo apt install -y fontconfig
progress_bar 80

loading "[Hit -2] : Installing Your favourite WhiteSur Theme"

# Install WhiteSur Dark Theme and Icons
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme
./install.sh
cd ..
progress_bar 90

# Apply the WhiteSur Dark theme and Apple fonts
gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Dark"
gsettings set org.gnome.desktop.interface icon-theme "WhiteSur-Dark"
gsettings set org.gnome.desktop.interface font-name "Apple System"
progress_bar 100

# Set the wallpaper
WALLPAPER_PATH="$(pwd)/wallpaper.png"
gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_PATH"

# Set GNOME Terminal preferences
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'

# Apply NVM (Node Version Manager)
echo "export NVM_DIR=\"$HOME/.nvm\"" >> ~/.bashrc
echo "[ -s \"$NVM_DIR/nvm.sh\" ] && \. \"$NVM_DIR/nvm.sh\"" >> ~/.bashrc
source ~/.bashrc
progress_bar 50

# Install NVM and the latest Node.js version
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
nvm install node
progress_bar 60

# Install Docker (if not already installed)
sudo systemctl enable --now docker
progress_bar 70

# Set up .bashrc customizations
echo "alias python=python3" >> ~/.bashrc
echo "alias plsql=\"docker exec -it oracle-xe sqlplus sys/YourActualPassword as sysdba\"" >> ~/.bashrc
echo "alias sql=\"sudo mysql\"" >> ~/.bashrc
echo "alias ll='ls -alF'" >> ~/.bashrc
echo "alias la='ls -A'" >> ~/.bashrc
echo "alias l='ls -CF'" >> ~/.bashrc
echo "alias clear='clear'" >> ~/.bashrc

# Set prompt customization
echo "PS1='\\[\e[94m\]\W\\[\e[m\]\$ '" >> ~/.bashrc
source ~/.bashrc
progress_bar 80

# Install and set Brave browser and Google Chrome as default
sudo update-alternatives --install /usr/bin/browser browser /usr/bin/brave-browser 1
sudo update-alternatives --install /usr/bin/browser browser /usr/bin/google-chrome-stable 2
progress_bar 90

# Reboot system (optional)
echo "Setup is complete. Rebooting your system in 2 seconds to apply all changes."
sleep 2
# reboot

#uncomment here to deploy