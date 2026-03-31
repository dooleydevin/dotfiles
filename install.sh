#!/bin/bash
set -euo pipefail

DIR_NAME="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# ── Detect environment profile ────────────────────────────────────────
detect_profile() {
  if [[ "$(uname -s)" == "Darwin" ]]; then
    if [[ "$(uname -m)" == "arm64" ]]; then
      echo "macos-aarch64"
    else
      echo "macos-x86_64"
    fi
  elif [[ -n "${CODESPACES:-}" ]] || [[ -n "${REMOTE_CONTAINERS:-}" ]] || [[ -f "/.dockerenv" ]]; then
    echo "devcontainer"
  else
    echo "linux"
  fi
}

# ── Install Nix (single-user, no daemon) ──────────────────────────────
install_nix() {
  if command -v nix &>/dev/null; then
    echo "Nix is already installed."
    return
  fi

  echo "Installing Nix in single-user mode..."
  sh <(curl -L https://nixos.org/nix/install) --no-daemon --no-channel-add

  # shellcheck disable=SC1091
  if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  fi
}

# ── Enable flakes ─────────────────────────────────────────────────────
enable_flakes() {
  local nix_conf="$HOME/.config/nix/nix.conf"
  mkdir -p "$(dirname "$nix_conf")"
  if ! grep -q "experimental-features" "$nix_conf" 2>/dev/null; then
    echo "experimental-features = nix-command flakes" >>"$nix_conf"
  fi
}

# ── Main ──────────────────────────────────────────────────────────────
PROFILE="$(detect_profile)"
echo "Detected profile: $PROFILE"

install_nix
enable_flakes

echo "Building home-manager configuration for profile: $PROFILE ..."

nix_build_flags=(--no-link --print-out-paths)
if [[ "$PROFILE" == "devcontainer" ]]; then
  nix_build_flags+=(--impure)
fi

ACTIVATION="$(nix build "${nix_build_flags[@]}" "$DIR_NAME#homeConfigurations.$PROFILE.activationPackage")"

echo "Activating configuration..."
HOME_MANAGER_BACKUP_EXT=backup "$ACTIVATION/activate"

echo ""
echo "Installation complete!"
echo ""
echo "To use nix-managed zsh as your login shell:"
echo "  echo \$HOME/.nix-profile/bin/zsh | sudo tee -a /etc/shells"
echo "  chsh -s \$HOME/.nix-profile/bin/zsh"
