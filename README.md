# Dotfiles
## Installation
Run the `install.sh` script to get up-and-running.
Make sure you want to use all of the dotfiles in the
repo before running the installation script, as it
will overwrite any dotfiles it finds without warning.

The installation script will symlink the files from this
repository into the home directory.

Re-running `install.sh` is a safe operation if the
repository is moved and symlinks are broken.

## Conventions
### Shell
These dotfiles assume you are using `zsh` as your shell.
A minimalistic `.bashrc` file is included, but it is
not actively maintained.

### Theming
The color schemes used in these configurations work best when
your terminal emulator uses a light theme. I find the higher contrast
to be easier on the eyes, especially when outside.

I'm currently using the `Material` color scheme I found on
<https://iterm2colorschemes.com>, a copy of which exists at
`./iterm2/material.itermcolors`.

I don't have any plans to setup dark-mode theming at this time.
