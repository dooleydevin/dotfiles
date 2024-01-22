#!/bin/bash

# Sourced from https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
DIR_NAME="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

GIT_INSTALLED=$(command -v git)
VIM_INSTALLED=$(command -v vim)
ZSH_INSTALLED=$(command -v zsh)

# bash
ln -sf "$DIR_NAME/bash/bashrc" "$HOME/.bashrc"
ln -sf "$DIR_NAME/bash/bash_profile" "$HOME/.bash_profile"

# zsh
if [ -n "$ZSH_INSTALLED" ]; then
  ## Install oh-my-zsh
  rm -rf "$HOME/.oh-my-zsh"
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh" --quiet
  export ZSH="${HOME}/.oh-my-zsh"
  export ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"

  ## Install powerlevel10k plugin
  rm -rf "$ZSH_CUSTOM/themes/powerlevel10k"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" --quiet

  ## Install zsh-vi-mode plugin
  rm -rf "$ZSH_CUSTOM/plugins/zsh-vi-mode"
  git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode" --quiet

  ## Link zsh config
  ln -sf "$DIR_NAME/zsh/zshrc" "$HOME/.zshrc"
  ln -sf "$DIR_NAME/zsh/p10k.zsh" "$HOME/.p10k.zsh"
fi

# git
if [ -n "$GIT_INSTALLED" ]; then
  git config --global user.name "Devin Dooley"
  git config --global user.email "dooleydevin@github.com"
  git config --global pull.rebase false

  if [ -n "$VIM_INSTALLED" ]; then
    git config --global core.editor vim
  fi
fi

# vim
if [ -n "$VIM_INSTALLED" ]; then
  ## Install vim-plug
  rm -rf ~/.vim/autoload/plug.vim
  curl -fsLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  ## Link vimrc
  ln -sf "$DIR_NAME/vim/vimrc" "$HOME/.vimrc"
  vim -es -u "$HOME/.vimrc" -i NONE -c "PlugInstall" -c "qa"
fi

