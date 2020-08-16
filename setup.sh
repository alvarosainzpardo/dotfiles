#!/bin/bash

main_menu()
{
  whiptail --title 'Main menu' --menu 'Choose an option' 20 60 10 \
    'Deps'  'Install software this script depends on' \
    'Vim'   'Install vim 8 and Ubuntu powerline font' \
    'Other' 'Install other software' \
    'Exit'  'Exit script' \
    3>&1 1>&2 2>&3
}

setup_gitconfig()
{
  if [ -f ~/.gitconfig ]
  then
    cp ~/.gitconfig ~/.gitconfig.save
  fi
  cat >~/.gitconfig <<EOF
[user]
	name = Alvaro Sainz-Pardo
	email = alvarosainzpardo@gmail.com
EOF
}

install_deps()
{
  sudo apt update
  sudo apt install -y git wget curl build-essential
  setup_gitconfig
}

install_vim()
{
  sudo add-apt-repository ppa:jonathonf/vim
  sudo apt update
  sudo apt install -y vim-gtk3
  git clone https://github.com/powerline/fonts.git ~/powerline-fonts
  cd ~/powerline-fonts
  ./install.sh Ubuntu
  cd
  git clone git@github-alvarosainzpardo.com:alvarosainzpardo/.vim.git
  vim
  whiptail --msgbox 'Vim and Ubuntu powerline font installed' 6 60
}

install_other()
{
  sudo apt install ubuntu-restricted-extras
  curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" | sudo tee /etc/apt/sources.list.d/teams.list
  sudo apt update
  sudo apt install teams
  local message='The following packages were installed: 

teams'
  whiptail --msgbox "$message" 10 60
}

while true
do
  choice=$(main_menu)
  case $choice in
    'Deps')
      install_deps
      ;;
    'Vim')
      install_vim
      ;;
    'Other')
      install_other
      ;;
    'Exit')
      exit 0
      ;;
    *)
      exit 1
      ;;
  esac
done
