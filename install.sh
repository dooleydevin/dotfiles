#!/bin/bash

# git
git config --global user.name "Devin Dooley"
git config --global user.email "dooleydevin@github.com"
git config --global core.editor vim

# bash
ln -s $HOME/.dotfiles/bash/bashrc $HOME/.bashrc
ln -s $HOME/.dotfiles/bash/bash_profile $HOME/.bash_profile

# zsh
## Install oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

## Install powerlevel10k plugin
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

## Install zsh-vi-mode plugin
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode

## Link zsh config
ln -s $HOME/.dotfiles/zsh/zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/zsh/p10k.zsh $HOME/.p10k.zsh

# neovim
## Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

## Link neovim config
ln -s $HOME/.dotfiles/neovim/init.vim $HOME/.config/nvim/init.vim

## Install plugins with vim-plug
vim +'PlugInstall --sync' +qall
