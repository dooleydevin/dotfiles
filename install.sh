#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# ── Install Homebrew ─────────────────────────────────────────────────
install_homebrew() {
  if command -v brew &>/dev/null; then
    echo "Homebrew is already installed."
    return
  fi

  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# ── Source Homebrew shellenv ─────────────────────────────────────────
source_brew() {
  if command -v brew &>/dev/null; then
    return
  fi

  if [[ "$(uname -s)" == "Darwin" ]]; then
    if [[ "$(uname -m)" == "arm64" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

# ── Main ──────────────────────────────────────────────────────────────
install_homebrew
source_brew

echo "Installing chezmoi..."
brew install chezmoi

echo "Applying dotfiles..."
chezmoi init --source="$SCRIPT_DIR" --apply

echo ""
echo "Installation complete! Restart your shell or run: exec zsh"
