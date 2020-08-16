#!/bin/bash

main_menu()
{
  whiptail --title 'Menú principal' --menu 'Choose an option' 20 40 7 \
    'Vim' 'Install vim 8 and powerline fonts' \
    3>&1 1>&2 2>&3
}

install_vim()
{
  sudo add-apt-repository ppa:jonathonf/vim
  sudo apt update
  sudo apt install vim-gtk3
  sudo apt install fonts-powerline
  whiptail --msgbox 'Vim and Powerline fonts installed' 7 40
}

while true
do
  choice=$(main_menu)
  case $choice in
    'Vim')
      setup_vim
      ;;
    *)
      exit 0
      ;;
  esac
done
