#!/bin/bash

# git
git config --global user.name "Devin Dooley"
git config --global user.email "dooleydevin@github.com"
git config --global core.editor vim

# bash
ln -sf "$HOME/.dotfiles/bash/bashrc" "$HOME/.bashrc"
ln -sf "$HOME/.dotfiles/bash/bash_profile" "$HOME/.bash_profile"

# zsh
## Install oh-my-zsh
rm -rf "$HOME/.oh-my-zsh"
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

## Install powerlevel10k plugin
rm -rf "$ZSH_CUSTOM/themes/powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/.oh-my-zsh/custom/themes/powerlevel10k"

## Install zsh-vi-mode plugin
rm -rf "$ZSH_CUSTOM/plugins/zsh-vi-mode"
git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"

## Link zsh config
ln -sf "$HOME/.dotfiles/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$HOME/.dotfiles/zsh/p10k.zsh" "$HOME/.p10k.zsh"

# vim
## Install vim-plug
rm -rf ~/.vim/autoload/plug.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## Link vimrc
ln -sf "$HOME/.dotfiles/vim/vimrc" "$HOME/.vimrc"

## Install plugins with vim-plug
vim +'PlugInstall --sync' +qall
