## This is my config. There are many like it, but this one is mine.

This repo uses GNU stow to manage dotfiles. Each top-level directory represents an application, and any files in it will be symlinked to the root of your home directory. So, rather than placing config files in your home directory, place them in ~/dotfiles instead, and then `stow some-app-name` will symlink them.

The easy way to install the files is:

```
sudo apt-get install stow && \
git clone ssh://git@github.com/onelesd/dotfiles.git ~/dotfiles && \
stow *
```

```
├── README.md
├── emacs
│   ├── .spacemacs
│   └── .spacemacs.env
├── git
│   ├── .gitconfig
│   └── .gitignore
├── hammerspoon
│   └── .hammerspoon
│       └── init.lua
├── i3
│   ├── .compton.conf
│   ├── .config
│   │   ├── dunst
│   │   │   ├── dunstrc
│   │   │   └── reload
│   │   ├── i3
│   │   │   └── config
│   │   ├── libinput-gestures.conf
│   │   ├── rofi
│   │   │   └── config
│   │   └── tilix
│   │       └── schemes
│   │           └── Dracula.json
│   └── .Xresources
├── tmux
│   └── .tmux.conf
├── vim
│   └── .vimrc
└── zsh
    └── .zshrc
```
