#!/bin/bash
set -euo pipefail

BREW_PREFIX="$(brew --prefix)"
CUSTOM_DIR="$HOME/.oh-my-zsh-custom"

echo "Setting up Oh-My-Zsh custom plugins and themes..."

mkdir -p "$CUSTOM_DIR/themes" "$CUSTOM_DIR/plugins"

# Powerlevel10k theme
ln -sfn "$BREW_PREFIX/share/powerlevel10k" "$CUSTOM_DIR/themes/powerlevel10k"

# zsh-vi-mode plugin
ln -sfn "$BREW_PREFIX/share/zsh-vi-mode" "$CUSTOM_DIR/plugins/zsh-vi-mode"
