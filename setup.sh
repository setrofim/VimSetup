#!/bin/bash

mkdir -p ~/.vim-backup
mkdir -p ~/.fonts
cp -r .vim/bundle/powerline-fonts/ttf-dejavu-powerline ~/.fonts
sudo fc-cache -fv

cp -r .vim ~/.vim
cp .vimrc ~/.vimrc
