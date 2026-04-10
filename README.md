# Dotfiles

Personal development environment managed with [chezmoi](https://www.chezmoi.io/) and [Homebrew](https://brew.sh/).

## Setup

```sh
bash install.sh
```

This will:
1. Install Homebrew to the default system prefix
2. Install chezmoi via Homebrew
3. Apply all dotfiles, packages, and plugins via `chezmoi apply`

To uninstall:

```sh
bash uninstall.sh
```

## Environments

| Environment | Detected when |
|---|---|
| `macos` | `uname -s` = Darwin |
| `linux` | Default fallback |
| `devcontainer` | `$CODESPACES`, `$REMOTE_CONTAINERS`, or `/.dockerenv` |

Environment detection is handled by `.chezmoi.toml.tmpl` and stored as `{{ .environment }}` for use in templates.

## Structure

| Path | Purpose |
|---|---|
| `.chezmoi.toml.tmpl` | Chezmoi config; detects platform/environment |
| `.chezmoiignore` | Excludes non-dotfile repo files from deployment |
| `Brewfile` | Homebrew package manifest |
| `dot_gitconfig` | Git configuration → `~/.gitconfig` |
| `dot_bash_profile` | Bash profile → `~/.bash_profile` |
| `dot_bashrc.tmpl` | Bash config → `~/.bashrc` |
| `dot_zshrc.tmpl` | Zsh config → `~/.zshrc` |
| `dot_p10k.zsh` | Powerlevel10k prompt config → `~/.p10k.zsh` |
| `dot_vimrc` | Vim config with vim-plug declarations → `~/.vimrc` |
| `run_onchange_before_install-packages.sh.tmpl` | Installs Homebrew packages when Brewfile changes |
| `run_once_before_install-oh-my-zsh.sh` | Installs Oh-My-Zsh |
| `run_once_after_setup-zsh-plugins.sh` | Symlinks zsh plugins into oh-my-zsh-custom |
| `run_once_after_install-vim-plug.sh` | Installs vim-plug and vim plugins |
| `iterm2/material.itermcolors` | iTerm2 color scheme (Material light) |

## Packages

Packages are declared in `Brewfile` and installed via `brew bundle`. Pre-built bottles are used for fast installation.

## Theming

These configurations use light color schemes (PaperColor for vim, Material for iTerm2).

## Re-running setup scripts

Chezmoi tracks `run_once_` script execution. To force re-execution:

```sh
chezmoi state delete-bucket --bucket=scriptState
chezmoi apply
```
