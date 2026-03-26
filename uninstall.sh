#!/bin/bash
set -euo pipefail

echo "Uninstalling dotfiles and nix..."

# ── Remove home-manager generation and profile ────────────────────────
if command -v home-manager &>/dev/null; then
  echo "Removing home-manager profile..."
  home-manager expire-generations "-1 second" 2>/dev/null || true
fi
nix profile remove '.*home-manager.*' 2>/dev/null || true

# ── Remove managed config files ──────────────────────────────────────
echo "Removing config files..."
rm -f "$HOME/.bashrc"
rm -f "$HOME/.bash_profile"
rm -f "$HOME/.profile"
rm -f "$HOME/.zshrc"
rm -f "$HOME/.zshenv"
rm -f "$HOME/.p10k.zsh"
rm -f "$HOME/.vimrc"
rm -f "$HOME/.gitconfig"

# ── Remove oh-my-zsh directories ─────────────────────────────────────
rm -rf "$HOME/.oh-my-zsh"
rm -rf "$HOME/.oh-my-zsh-custom"

# ── Remove vim-plug and plugins ───────────────────────────────────────
rm -rf "$HOME/.vim"

# ── Remove home-manager and nix state ─────────────────────────────────
rm -rf "$HOME/.local/state/home-manager"
rm -rf "$HOME/.local/state/nix"

# ── Remove Nix ────────────────────────────────────────────────────────
echo "Removing Nix..."
rm -rf "$HOME/.nix-profile"
rm -rf "$HOME/.nix-defexpr"
rm -rf "$HOME/.nix-channels"
rm -rf "$HOME/.config/nix"
rm -rf "$HOME/.cache/nix"
rm -rf "$HOME/.local/share/nix"

if [ -d "/nix" ]; then
  echo "Removing /nix (may require sudo)..."
  rm -rf /nix 2>/dev/null || sudo rm -rf /nix
fi

# ── Clean up nix-installer lines from shell profiles ──────────────────
for rc_file in "$HOME/.profile" "$HOME/.bash_profile" "$HOME/.bashrc" "$HOME/.zshrc"; do
  if [ -f "$rc_file" ]; then
    sed -i.bak '/# added by Nix installer/,/^$/d' "$rc_file" 2>/dev/null || true
    rm -f "${rc_file}.bak"
  fi
done

echo ""
echo "Uninstall complete. Restart your shell or log out and back in."
