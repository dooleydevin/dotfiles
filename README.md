# Dotfiles

Personal development environment managed with [Nix](https://nixos.org/) and [Home Manager](https://github.com/nix-community/home-manager).

## Setup

```sh
bash install.sh
```

To uninstall:

```sh
bash uninstall.sh
```

## Profiles

| Profile | System | Detected when |
|---|---|---|
| `macos-aarch64` | Apple Silicon Mac | `uname -s` = Darwin, `uname -m` = arm64 |
| `macos-x86_64` | Intel Mac | `uname -s` = Darwin |
| `linux` | Linux VM | Default fallback |
| `devcontainer` | Codespaces / devcontainers | `$CODESPACES`, `$REMOTE_CONTAINERS`, or `/.dockerenv` |

`install.sh` auto-detects the profile. To apply a specific one manually:

```sh
nix run home-manager/release-24.11 -- switch --flake .#<profile>
```

## Structure

| Path | Purpose |
|---|---|
| `flake.nix` | Nix flake entry point; defines all profiles |
| `home/common.nix` | Shared packages, shell, git, and vim configuration |
| `home/macos.nix` | macOS-specific packages and Homebrew integration |
| `home/linux.nix` | Linux-specific packages |
| `home/devcontainer.nix` | Devcontainer-specific packages |
| `bash/bashrc` | Bash prompt, vi mode, and tool init |
| `vim/vimrc` | Vim settings (plugins managed in `common.nix`) |
| `zsh/p10k.zsh` | Powerlevel10k prompt configuration |
| `iterm2/material.itermcolors` | iTerm2 color scheme (Material light) |

## Theming

These configurations use light color schemes (PaperColor for vim, Material for iTerm2).
