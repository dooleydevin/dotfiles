# Dotfiles
## Installation
It's assumed that this repository is cloned to $HOME/.dotfiles.
You can do so with:
```
git clone git@github.com:dooleydevin/dotfiles .dotfiles
```

Then, just run the `install.sh` script to get up-and-running:
```
.dotfiles/install.sh
```

## Conventions
### Shell
This configuration will try to use zsh if it is available.
A minimal `.bashrc` is included, but it will attempt to open
zsh if `$ZSH_VERSION` is set.

### Theming
The color schemes used in these configurations work best when
your terminal emulator uses a light theme. I find the higher-contrast
to be easier on the eyes, especially when outside.
I'm currently using the `Material` color scheme I found on
<https://iterm2colorschemes.com>, a copy of which exists at
`./iterm2/material.itermcolors`.

I don't have any plans to setup dark-mode theming at this time.
