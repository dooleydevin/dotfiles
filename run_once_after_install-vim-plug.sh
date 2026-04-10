#!/bin/bash
set -euo pipefail

PLUG_VIM="$HOME/.vim/autoload/plug.vim"

if [ ! -f "$PLUG_VIM" ]; then
  echo "Installing vim-plug..."
  curl -fLo "$PLUG_VIM" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "Installing vim plugins..."
vim +PlugInstall +qall 2>/dev/null || true
