#!/bin/bash

sudo apt update

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

# Basics
install coreutils
install ranger
install xsel
install xclip
install chromium-browser
install curl
install exfat-utils
install file
install git
install htop
install nmap
install tmux
install vim
install ctags
install dtach
install dstat
install silversearcher-ag
