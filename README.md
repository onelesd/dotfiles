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
│   │   ├── akregatorrc
│   │   ├── albert
│   │   │   ├── albert.conf
│   │   │   ├── core.db
│   │   │   ├── last_used_version
│   │   │   ├── org.albert.extension.snippets
│   │   │   │   └── snippets.db
│   │   │   ├── org.albert.extension.websearch
│   │   │   │   └── engines.json
│   │   │   └── org.albert.frontend.qmlboxmodel
│   │   │       └── style_properties.ini
│   │   ├── autostart
│   │   │   ├── org.gnome.Calendar.desktop
│   │   │   └── psensor.desktop
│   │   ├── autostart-scripts
│   │   ├── baloofilerc
│   │   ├── bluedevilglobalrc
│   │   ├── breezerc
│   │   ├── bumblebee-status
│   │   ├── clipit
│   │   │   └── clipitrc
│   │   ├── configstore
│   │   │   ├── nodemon.json
│   │   │   ├── update-notifier-nodemon.json
│   │   │   └── update-notifier-npm.json
│   │   ├── dconf
│   │   │   └── user
│   │   ├── dunst
│   │   │   ├── dunstrc
│   │   │   └── reload
│   │   ├── emaildefaults
│   │   ├── enchant
│   │   │   ├── en_US.dic
│   │   │   └── en_US.exc
│   │   ├── eog
│   │   ├── evolution
│   │   │   └── sources
│   │   │       ├── 49caed1b3e6f98548957a9f02d586a00b472f9f3.source
│   │   │       ├── 8301b9555020a12ea014d7ba0af2a5c950dddbc1.source
│   │   │       ├── 8f6d412811e1c164cf63968f89d719f53618c907.source
│   │   │       ├── birthdays.source
│   │   │       ├── dc461be2b23a6994e679e658cb329774071d3de4.source
│   │   │       ├── system-calendar.source
│   │   │       └── system-proxy.source
│   │   ├── fontconfig
│   │   │   └── fonts.conf
│   │   ├── geary
│   │   │   ├── goa_account_1553029840_0
│   │   │   │   └── geary.ini
│   │   │   └── goa_account_1553030094_0
│   │   │       └── geary.ini
│   │   ├── gedit
│   │   │   └── accels
│   │   ├── gnome-control-center
│   │   │   └── backgrounds
│   │   │       ├── last-edited-lock.xml
│   │   │       └── last-edited.xml
│   │   ├── gnome-gmail
│   │   │   └── gnome-gmail.conf
│   │   ├── gnome-initial-setup-done
│   │   ├── gnome-session
│   │   │   └── saved-session
│   │   ├── goa-1.0
│   │   │   └── accounts.conf
│   │   ├── gtk-2.0
│   │   │   └── gtkfilechooser.ini
│   │   ├── gtk-3.0
│   │   │   ├── bookmarks
│   │   │   └── settings.ini
│   │   ├── gtk-4.0
│   │   │   └── settings.ini
│   │   ├── gtkrc
│   │   ├── gtkrc-2.0
│   │   ├── htop
│   │   │   └── htoprc
│   │   ├── i3
│   │   │   └── config
│   │   ├── ibus
│   │   │   └── bus
│   │   │       ├── 5bc8dde65c340f2fa5336d425c9159aa-unix-0
│   │   │       ├── 5bc8dde65c340f2fa5336d425c9159aa-unix-1
│   │   │       ├── ff3330224ac80051c64766385cbd2e79-unix-0
│   │   │       └── ff3330224ac80051c64766385cbd2e79-unix-1
│   │   ├── kaccessrc
│   │   ├── kactivitymanagerdrc
│   │   ├── kactivitymanagerd-statsrc
│   │   ├── kateschemarc
│   │   ├── kcmfonts
│   │   ├── kcminputrc
│   │   ├── kconf_updaterc
│   │   ├── kded5rc
│   │   ├── kded_device_automounterrc
│   │   ├── kdeglobals
│   │   ├── kfontinstuirc
│   │   ├── kgammarc
│   │   ├── kglobalshortcutsrc
│   │   ├── khotkeysrc
│   │   ├── kmixrc
│   │   ├── knotifyrc
│   │   ├── krunnerrc
│   │   ├── kscreenlockerrc
│   │   ├── ksmserverrc
│   │   ├── ksplashrc
│   │   ├── ktimezonedrc
│   │   ├── kupfer
│   │   ├── kwalletmanager5rc
│   │   ├── kwalletrc
│   │   ├── kwinrc
│   │   ├── kwinrulesrc
│   │   ├── kxkbrc
│   │   ├── libfm
│   │   │   └── libfm.conf
│   │   ├── libinput-gestures.conf
│   │   ├── mimeapps.list
│   │   ├── monitors.xml
│   │   ├── mono.addins
│   │   │   ├── addin-db-001
│   │   │   │   ├── addin-data
│   │   │   │   │   └── 1
│   │   │   │   │       ├── DefaultEffects,1.6.maddin
│   │   │   │   │       ├── DefaultTools,1.6.maddin
│   │   │   │   │       └── Pinta,1.6.maddin
│   │   │   │   ├── addin-dir-data
│   │   │   │   │   └── usr_lib_pinta_d4a7042e.data
│   │   │   │   ├── fdb-lock
│   │   │   │   ├── fdb-update-lock
│   │   │   │   ├── host-index
│   │   │   │   └── hosts
│   │   │   │       └── Pinta.addins
│   │   │   ├── addins-setup.config
│   │   │   └── repository-cache
│   │   ├── nautilus
│   │   │   ├── desktop-metadata
│   │   │   └── search-metadata
│   │   ├── neofetch
│   │   │   ├── config.conf
│   │   │   └── neofetch
│   │   │       └── config.conf
│   │   ├── nvim
│   │   │   ├── init.vim
│   │   │   ├── .netrwhist
│   │   │   └── plugs
│   │   │       ├── Colorizer
│   │   │       ├── gruvbox
│   │   │       ├── indentpython.vim
│   │   │       ├── nerdtree
│   │   │       ├── SimpylFold
│   │   │       ├── syntastic
│   │   │       ├── tmuxline.vim
│   │   │       ├── vim-airline
│   │   │       ├── vim-airline-themes
│   │   │       ├── vim-flake8
│   │   │       ├── vim-fugitive
│   │   │       ├── vim-hyperstyle
│   │   │       └── YouCompleteMe
│   │   ├── pcmanfm
│   │   │   └── default
│   │   │       └── pcmanfm.conf
│   │   ├── Pinta
│   │   │   ├── layouts.xml
│   │   │   ├── palette.txt
│   │   │   └── settings.xml
│   │   ├── plasma-localerc
│   │   ├── plasma-org.kde.plasma.desktop-appletsrc
│   │   ├── plasmarc
│   │   ├── plasmashellrc
│   │   ├── plasma-workspace
│   │   │   ├── env
│   │   │   └── shutdown
│   │   ├── polybar
│   │   │   ├── config
│   │   │   └── launch.sh
│   │   ├── powerdevilrc
│   │   ├── powermanagementprofilesrc
│   │   ├── procps
│   │   ├── pulse
│   │   │   ├── 5bc8dde65c340f2fa5336d425c9159aa-card-database.tdb
│   │   │   ├── 5bc8dde65c340f2fa5336d425c9159aa-default-sink
│   │   │   ├── 5bc8dde65c340f2fa5336d425c9159aa-default-source
│   │   │   ├── 5bc8dde65c340f2fa5336d425c9159aa-device-manager.tdb
│   │   │   ├── 5bc8dde65c340f2fa5336d425c9159aa-device-volumes.tdb
│   │   │   ├── 5bc8dde65c340f2fa5336d425c9159aa-stream-volumes.tdb
│   │   │   ├── cookie
│   │   │   ├── ff3330224ac80051c64766385cbd2e79-card-database.tdb
│   │   │   ├── ff3330224ac80051c64766385cbd2e79-default-sink
│   │   │   ├── ff3330224ac80051c64766385cbd2e79-default-source
│   │   │   ├── ff3330224ac80051c64766385cbd2e79-device-volumes.tdb
│   │   │   └── ff3330224ac80051c64766385cbd2e79-stream-volumes.tdb
│   │   ├── ranger
│   │   ├── rofi
│   │   │   └── config
│   │   ├── session
│   │   │   └── kwin_1014111213799000155570937000000063020004_1555711744_133899
│   │   ├── startupconfig
│   │   ├── startupconfigfiles
│   │   ├── startupconfigkeys
│   │   ├── s-tui
│   │   │   └── hooks.d
│   │   ├── systemsettingsrc
│   │   ├── terminator
│   │   │   ├── config
│   │   │   └── plugins
│   │   │       ├── terminator-themes.py
│   │   │       └── terminator-themes.pyc
│   │   ├── Thunar
│   │   │   ├── accels.scm
│   │   │   └── uca.xml
│   │   ├── tilix
│   │   │   └── schemes
│   │   │       └── Dracula.json
│   │   ├── totem
│   │   │   └── state.ini
│   │   ├── touchpadrc
│   │   ├── Trolltech.conf
│   │   ├── ukuu.json
│   │   ├── ukuu-notify.sh
│   │   ├── ulauncher
│   │   │   ├── extensions.json
│   │   │   ├── settings.json
│   │   │   └── shortcuts.json
│   │   ├── Unknown Organization
│   │   │   └── zoom.conf
│   │   ├── user-dirs.dirs
│   │   ├── user-dirs.locale
│   │   ├── vlc
│   │   │   ├── vlc-qt-interface.conf
│   │   │   └── vlcrc
│   │   ├── xfce4
│   │   │   └── xfconf
│   │   │       └── xfce-perchannel-xml
│   │   │           └── thunar.xml
│   │   ├── Zeal
│   │   │   └── Zeal.conf
│   │   └── zoomus.conf
│   ├── .local
│   │   └── bin
│   │       ├── barista
│   │       ├── chrome
│   │       ├── dpi.pl
│   │       ├── i3exit
│   │       ├── monitors.sh
│   │       ├── natural_scrolling.sh
│   │       └── xbanish
│   ├── .screenlayout
│   │   └── oc_originate_office.sh
│   └── .Xresources
├── tmux
│   └── .tmux.conf
├── vim
│   └── .vimrc
└── zsh
    └── .zshrc
```
