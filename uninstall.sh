#!/bin/bash
set -euo pipefail

echo "Uninstalling dotfiles and Homebrew..."

# ── Remove managed config files and restore backups ──────────────────
echo "Removing config files..."
for f in .bashrc .bash_profile .zshrc .p10k.zsh .vimrc .gitconfig; do
  rm -f "$HOME/$f"
  if [ -f "$HOME/$f.backup" ]; then
    mv "$HOME/$f.backup" "$HOME/$f"
    echo "Restored $f from backup"
  fi
done

# ── Remove oh-my-zsh directories ─────────────────────────────────────
rm -rf "$HOME/.oh-my-zsh"
rm -rf "$HOME/.oh-my-zsh-custom"

# ── Remove vim-plug and plugins ───────────────────────────────────────
rm -rf "$HOME/.vim"

# ── Remove chezmoi state ─────────────────────────────────────────────
rm -rf "$HOME/.config/chezmoi"
rm -rf "$HOME/.local/share/chezmoi"

# ── Remove Homebrew ──────────────────────────────────────────────────
echo "Removing Homebrew..."
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

echo ""
echo "Uninstall complete. Restart your shell or log out and back in."
