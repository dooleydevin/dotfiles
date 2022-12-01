#!/bin/bash

# This script is used for testing configuration installs.
# It does not do a comprehensive cleanup of everything
#  installed with the `install.sh` script. Only enough
#  to accurately test a configuration installation.

# Delete bash configuration
rm "$HOME/.bashrc"
rm "$HOME/.bash_profile"

# Delete zsh configuration
rm -rf "$HOME/.oh-my-zsh"
rm "$HOME/.zshrc"
rm "$HOME/.p10k.zsh"

# Delete vim configuration
rm -rf "$HOME/.vim"
rm "$HOME/.vimrc"
