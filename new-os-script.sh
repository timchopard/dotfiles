#!/bin/bash

# Custom echo
setupEcho () { echo "[SETUP] $1"; }

# Check OS
os=$(uname)
if [ "$os" = "Linux" ]; then
    if [[ -f /etc/debian_version ]]; then
        setupEcho "Debian based OS."
        setupEcho "Installing using apt."
    else
        setupEcho "Not a Debian based OS. Exiting."
        exit 1
    fi
else
    setupEcho "Not a Linux OS. Exiting."
    exit 1
fi

# Update apt
setupEcho "Update apt.."
sudo apt update
sudo apt upgrade -y

# Install Git
if ! command -v git 2>&1 >/dev/null; then
    setupEcho "Git is not installed. Installing.."
    sudo apt install git -y
fi
setupEcho "Git is installed."

# Install curl
if ! command -v curl 2>&1 >/dev/null; then
    setupEcho "Curl is not installed. Installing.."
    sudo apt install curl -y
fi
setupEcho "Curl is installed."

# Install Rust
if ! command -v rustup 2>&1 >/dev/null; then
    setupEcho "Rust is not installed. Installing.."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
setupEcho "Rust is installed."

# Alacritty
read -p "Install Alacritty and Starship? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    setupEcho "Installing Alacritty"
    cargo install alacritty
    curl https://raw.githubusercontent.com/timchopard/dotfiles/refs/heads/main/.alacritty.toml >> ~/.alacritty.toml
    setupEcho "Installing Fonts"
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraMono.zip
    mkdir temp-fonts
    if [ ! -d ~/.fonts ]; then
        mkdir ~/.fonts
    fi
    unzip FiraMono.zip -d temp-fonts
    cp temp-fonts/*.oft ~/.fonts/
    rm FiraMono.zip
    rm -r temp-fonts
    fc-cache -f -v
    setupEcho "Installing Starship"
    curl -sS https://starship.rs/install.sh | sh
    if [ ! -d ~/.config ]; then
        mkdir ~/.config
    fi
    curl https://raw.githubusercontent.com/timchopard/dotfiles/refs/heads/main/starship.toml -o ~/.config/starship.toml
fi

# Set up vim
read -p "Set up Vim? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if ! command -v vim 2>&1 >/dev/null; then
        setupEcho "Vim is not installed. Installing.."
        sudo apt install vim -y
    fi
    mkdir -p ~/.vim/bundle
    cd ~/.vim/bundle
    git clone https://github.com/VundleVim/Vundle.vim.git Vundle.vim
    cd -
    curl https://raw.githubusercontent.com/timchopard/dotfiles/refs/heads/main/.vimrc -o ~/.vimrc
    curl https://raw.githubusercontent.com/timchopard/dotfiles/refs/heads/main/.vimrc-start -o ~/.vimrc-start
    vim +PluginInstall +qall
fi 

# Update .bashrc
read -p "Update .bashrc (required for starship etc.)? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "
if [ -f ~/.bashrc_extra ]; then
    . ~/.bashrc_extra
fi" >> ~/.bashrc
    curl https://raw.githubusercontent.com/timchopard/dotfiles/refs/heads/main/.bashrc_extra -o ~/.bashrc_extra
fi

