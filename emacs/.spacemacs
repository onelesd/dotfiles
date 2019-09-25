;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(perl5
     csv
     sql
     html
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; (auto-completion :variables
     ;;                  auto-completion-return-key-behavior 'complete
     ;;                  auto-completion-tab-key-behavior 'cycle
     ;;                  auto-completion-complete-with-key-sequence nil
     ;;                  auto-completion-enable-sort-by-usage t
     ;;                  auto-completion-enable-help-tooltip t
     ;;                  auto-completion-enable-snippets-in-popup nil)
     better-defaults
     emacs-lisp
     git
     helm
     markdown
     multiple-cursors
     ;; org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     syntax-checking
     treemacs
     ;; version-control

     ;; dseleno added below here
     elixir
     html
     (javascript :variables node-add-modules-path t)
     lsp
     node
     react
     yaml
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(
                                      beacon
                                      ;; company-box
                                      company-flx
                                      company-ycmd
                                      company-quickhelp
                                      flycheck-ycmd
                                      dimmer
                                      exec-path-from-shell
                                      elixir-yasnippets
                                      exunit
                                      forge
                                      git-gutter-fringe
                                      ;; helm-smex
                                      ;; helm-swoop-edit is broken, see: https://github.com/ShingoFukuyama/helm-swoop/issues/133
                                      (helm-swoop :location (recipe :fetcher github :repo "ashiklom/helm-swoop"))
                                      magithub
                                      minions
                                      mode-icons
                                      moody
                                      popup-kill-ring
                                      prettier-js
                                      pt
                                      rjsx-mode
                                      zoom
                                      )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(alchemist)

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; File path pointing to emacs 27.1 executable compiled with support
   ;; for the portable dumper (this is currently the branch pdumper).
   ;; (default "emacs-27.0.50")
   dotspacemacs-emacs-pdumper-executable-file "emacs-27.0.50"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-per(custom-set-variables
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa t

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default nil)
   dotspacemacs-verify-spacelpa-archives nil

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; If non-nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(doom-dracula
                         doom-one
                         spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(vanilla :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   ;; dotspacemacs-default-font '("Dank Mono"
   ;; dotspacemacs-default-font '("Fira Code Retina"
   ;; dotspacemacs-default-font '("Hack Nerd Font"
   ;; dotspacemacs-default-font '("Hermit Regular"
   ;; dotspacemacs-default-font '("Office Code Pro"
   dotspacemacs-default-font '("Iosevka Nerd Font Mono"
                               :size 20
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ";"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts t

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location nil

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 98

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 98

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers t

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("pt" "ag" "rg" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  ;;(create-fontset-from-ascii-font "M+ 1mn:pixelsize=14:weight=normal:slant=normal:spacing=m" nil "mplus1mn")
  ;;(set-fontset-font "fontset-mplus1mn" 'unicode
  ;;                  (font-spec :family "M+ 1mn" :spacing 'm :size 20)
  ;;                  nil 'prepend)
  ;;(add-to-list 'default-frame-alist '(font . "fontset-mplus1mn"))
  ;;(set-face-font 'default "fontset-mplus1mn")
  ;;(set-face-attribute 'default nil :font "fontset-mplus1mn")
  ;;(set-default-font "fontset-mplus1mn")

  ;; sloppy focus
  (setq focus-follows-mouse t
        mouse-autoselect-window t)

  (global-hl-line-mode -1)

  ;; enable transparency
  (spacemacs/enable-transparency)

  ;; savehist-mode will ause high cpu usage without these limits
  (setq history-length 100)
  (put 'minibuffer-history 'history-length 50)
  (put 'evil-ex-history 'history-length 50)
  (put 'kill-ring 'history-length 25)

  ;; Symbolic link to Git-controlled source file; follow link? (y or n)
  ;; don't ask me this question - pretend i said yes
  ;; this allows me to easily edit my dotfiles which are managed by stow via symlinks
  (setq vc-follow-symlinks t)

  ;; enable fira code ligatures
  (defun fira-code-mode--make-alist (list)
    "Generate prettify-symbols alist from LIST."
    (let ((idx -1))
      (mapcar
       (lambda (s)
         (setq idx (1+ idx))
         (let* ((code (+ #Xe100 idx))
                (width (string-width s))
                (prefix ())
                (suffix '(?\s (Br . Br)))
                (n 1))
           (while (< n width)
             (setq prefix (append prefix '(?\s (Br . Bl))))
             (setq n (1+ n)))
           (cons s (append prefix suffix (list (decode-char 'ucs code))))))
       list)))

  (defconst fira-code-mode--ligatures
    '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
      "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
      "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
      "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
      ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
      "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
      "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
      "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
      ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
      "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
      "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
      "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
      "x" ":" "+" "+" "*"))

  (defvar fira-code-mode--old-prettify-alist)

  (defun fira-code-mode--enable ()
    "Enable Fira Code ligatures in current buffer."
    (setq-local fira-code-mode--old-prettify-alist prettify-symbols-alist)
    (setq-local prettify-symbols-alist (append (fira-code-mode--make-alist fira-code-mode--ligatures) fira-code-mode--old-prettify-alist))
    (prettify-symbols-mode t))

  (defun fira-code-mode--disable ()
    "Disable Fira Code ligatures in current buffer."
    (setq-local prettify-symbols-alist fira-code-mode--old-prettify-alist)
    (prettify-symbols-mode -1))

  (define-minor-mode fira-code-mode
    "Fira Code ligatures minor mode"
    :lighter " Fira Code"
    (setq-local prettify-symbols-unprettify-at-point 'right-edge)
    (if fira-code-mode
        (fira-code-mode--enable)
      (fira-code-mode--disable)))

  (defun fira-code-mode--setup ()
    "Setup Fira Code Symbols"
    ;; (set-fontset-font t '(#Xe100 . #Xe16f) "Dank Mono"))
    ;; (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol"))
    (set-fontset-font t '(#Xe100 . #Xe16f) "Iosevka Nerd Font Mono"))


  (provide 'fira-code-mode)
  ;; ligatures cause weird problems
  ;; (add-hook 'prog-mode-hook (lambda () (fira-code-mode)))

  (use-package helm
    :config
    ;; disable ligatures for helm cuz it freezes on them
    (add-hook 'helm-major-mode-hook
              (lambda ()
                (setq auto-composition-mode nil)))
    ;; disable persistent follow because it makes emacs laggy
    ;; save last used follow mode value
    ;; (setq helm-follow-mode-persistent t)

    ;; fixes broken helm follow mode when treemacs pane is open
    ;; see: https://github.com/syl20bnr/spacemacs/issues/7446#issuecomment-417376425
    (defun helm-persistent-action-display-window (&optional split-onewindow)
      "Return the window that will be used for persistent action.
If SPLIT-ONEWINDOW is non-`nil' window is split in persistent action."
      (with-helm-window
        (setq helm-persistent-action-display-window (get-mru-window))))
    )

  ;; (use-package golden-ratio
  ;;   :config
  ;;   ;; turn on golden-ratio-mode
  ;;   (golden-ratio-mode 1))

  ;; turns out we need these pesky .tern-port files
  ;; (use-package tern
  ;;   :config
  ;;   ;; tell tern not to create those pesky .tern-port files everywhere
  ;;   (setq tern-command (append tern-command '("--no-port-file"))))

  (use-package company
    :config
    (company-flx-mode +1)
    ;; (add-hook 'after-init-hook #'global-ycmd-mode)
    (global-company-mode))

  ;; (use-package company-ycmd
  ;;   :config
  ;;   (company-ycmd-setup))

  ;; (use-package company-box
  ;;   :hook (company-mode . company-box-mode))

  (use-package evil-matchit
    :config
    ;; enable matchit
    (global-evil-matchit-mode 1))

  (use-package projectile
    :config
    ;; open helm find-file dialog when switching projects
    (setq projectile-switch-project-action 'helm-projectile-find-file))

  (use-package mode-icons
    :config
    ;; show file type icons in mode line
    (mode-icons-mode))

  (use-package flycheck
    :config
    ;; use flycheck everywhere
    (add-hook 'after-init-hook #'global-flycheck-mode))

  (use-package lsp-mode
    :commands lsp
    :ensure t
    :diminish lsp-mode
    :hook
    (elixir-mode . lsp)
    :init
    (add-to-list 'exec-path "/home/dseleno/work/elixir-ls/release"))

  (use-package elixir-mode
    :config
    ;; workaround for: https://github.com/elixir-editors/emacs-elixir/issues/431#issuecomment-486127817
    (defun elixir-format--from-mix-root (elixir-path errbuff format-arguments)
      "Run mix format where `mix.exs' is located, because mix is
meant to be run from the project root. Otherwise, run in the
current directory."
      (let ((original-default-directory default-directory)
            (mix-dir (locate-dominating-file buffer-file-name "mix.exs")))

        (when mix-dir
          (setq default-directory (expand-file-name mix-dir)))

        (message (concat "Run "
                         (abbreviate-file-name default-directory) ": "
                         (mapconcat 'identity format-arguments " ")))

        (let* ((formatter-executable (car format-arguments))
               (formatter-arguments (cdr format-arguments))
               (result (apply #'call-process
                              formatter-executable nil errbuff nil formatter-arguments)))
          (setq default-directory original-default-directory)
          result)))
    ;; (add-hook 'elixir-mode-hook
    ;;           (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))
    (add-hook 'elixir-mode-hook 'flycheck-mode)
    (with-eval-after-load 'elixir-mode
      (spacemacs/declare-prefix-for-mode 'elixir-mode
        "mt" "tests" "testing related functionality")
      (spacemacs/set-leader-keys-for-major-mode 'elixir-mode
        "tb" 'exunit-verify-all
        "ta" 'exunit-verify
        "tk" 'exunit-rerun
        "tt" 'exunit-verify-single)))

  (use-package prettier-js
    :config
    (eval-after-load "prettier-js"
      '(diminish 'prettier-js-mode "p")))

  (use-package rjsx-mode
    :config
    ;; @see https://github.com/felipeochoa/rjsx-mode/issues/33
    (progn (define-key rjsx-mode-map "<" nil))
    (add-to-list 'auto-mode-alist '(".*\\.js\\'" . rjsx-mode))
    (setq-default js2-mode-show-parse-errors nil)
    (setq-default js2-mode-show-strict-warnings nil)
    (setq-default js-indent-level 2)
    (setq-default js2-basic-offset 2)
    (add-hook 'rjsx-mode-hook #'add-node-modules-path)
    (add-hook 'rjsx-mode-hook 'prettier-js-mode)
    (add-hook 'rjsx-mode-hook 'flycheck-mode))

  (use-package lsp-ui
    :config
    (add-hook 'lsp-mode-hook 'lsp-ui-mode))

  ;; (use-package helm-smex
  ;;   :config
  ;;   (global-set-key [remap execute-extended-command] #'helm-smex)
  ;;   (global-set-key (kbd "M-X") #'helm-smex-major-mode-commands))

  (use-package beacon
    :config
    (beacon-mode 1)
    (setq beacon-blink-delay '0.2)
    (setq beacon-blink-when-focused 't)
    (setq beacon-dont-blink-commands 'nil)
    (setq beacon-push-mark '1))

  (use-package popup-kill-ring
    :config
    (spacemacs/set-leader-keys "." 'popup-kill-ring))

  (use-package forge
    :after magit)

  (use-package magithub
    :after magit
    :config
    ;; there is currently a bug in magithub about auto injecting the pull request feature
    (magithub-feature-autoinject t)
    (setq magithub-clone-default-directory "~/work"))

  (use-package moody
    :config
    (setq x-underline-at-descent-line t)
    (moody-replace-mode-line-buffer-identification)
    (moody-replace-vc-mode))

  (use-package minions
    :config
    (setq minions-mode-line-lighter "¯\\_(ツ)_/¯")
    (setq minions-mode-line-delimiters '("" . ""))
    (minions-mode 1))

  (use-package git-gutter
    :config
    (global-git-gutter-mode t))

  (use-package treemacs
    :config
    ;; ignore files that are git-ignored
    (add-to-list 'treemacs-pre-file-insert-predicates #'treemacs-is-file-git-ignored?)
    ;; ignore/hide some files
    (defun treemacs-ignore-gitignore (file _)
      (string= file ".tern-port"))
    (defun treemacs-ignore-elixir_ls (file _)
      (string= file ".elixir_ls"))
    (push #'treemacs-ignore-gitignore treemacs-ignored-file-predicates)
    (push #'treemacs-ignore-elixir_ls treemacs-ignored-file-predicates)
    ;; put the buffer on the right
    (setq treemacs-position 'right)
    ;; even if follow mode is disabled, follow when we init treemacs
    (setq treemacs-follow-after-init t)
    ;; show modified dirs and files
    (treemacs-git-mode 'deferred)
    ;; don't highlight current active buffer in tree cuz it's slow
    (treemacs-follow-mode -1))

  ;; (use-package git-gutter-fringe
  ;;   :config
  ;;   (setq git-gutter-fr:side 'left-fringe))

  ;; we're using rjsx-mode since it derives from js2-mode and adds some stuff for jsx
  ;; (use-package js2-mode
  ;;   :config
  ;;   (setq-default js2-mode-show-parse-errors nil)
  ;;   (setq-default js2-mode-show-strict-warnings nil)
  ;;   (setq-default js-indent-level 2)
  ;;   (setq-default js2-basic-offset 2)
  ;;   (add-hook 'js2-mode-hook #'add-node-modules-path)
  ;;   (add-hook 'js2-mode-hook 'prettier-js-mode)
  ;;   (add-hook 'js2-mode-hook 'flycheck-mode))

  ;; web-mode is cool but smart parens isn't working. probably just need to add the mode to the config.
  ;; (use-package web-mode
  ;;   :config
  ;;   (add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . web-mode))
  ;;   (setq web-mode-code-indent-offset 2)
  ;;   (setq web-mode-markup-indent-offset 2)
  ;;   (setq web-mode-css-indent-offset 2)
  ;;   (add-hook 'web-mode-hook #'add-node-modules-path)
  ;;   (add-hook 'web-mode-hook 'prettier-js-mode)
  ;;   (add-hook 'web-mode-hook 'flycheck-mode))

  (use-package dimmer
    :config
    (setq dimmer-exclusion-regexp "\*helm")
    (dimmer-mode))

  (use-package ycmd
    :config
    (progn
      (global-ycmd-mode)
      (set-variable 'ycmd-server-command
                    '("python3" "/home/dseleno/work/ycmd/ycmd/"))
      (set-variable 'ycmd-extra-conf-whitelist '("~/work/*"))
      (setq ycmd-extra-conf-handler 'load)))

  (use-package company-ycmd
    :config
    (defun add-to-hooks (hooks function)
      "Add a callback to multiple hooks.
   Example: (add-to-hooks '(c-mode-common-hook lisp-mode-hook) 'do-something)"
      (dolist (hook hooks)
        (add-hook hook function)))
    (progn
      (setq company-backends (delete 'company-clang company-backends))
      (setq company-idle-delay 0)
      (global-company-mode)
      (company-ycmd-setup)

      (define-key company-active-map (kbd "TAB") 'company-select-next)
      (define-key company-active-map [tab] 'company-select-next)
      (setq company-selection-wrap-around t)

      ; Company + fci is fucked
      ; https://github.com/company-mode/company-mode/issues/180
      (defvar-local company-fci-mode-on-p nil)
      (defun company-turn-off-fci (&rest ignore)
        (when (boundp 'fci-mode)
          (setq company-fci-mode-on-p fci-mode)
          (when fci-mode (fci-mode -1))))
      (defun company-maybe-turn-on-fci (&rest ignore)
        (when company-fci-mode-on-p (fci-mode 1)))
      (add-hook 'company-completion-started-hook 'company-turn-off-fci)
      (add-to-hooks '(company-completion-finished-hook
                      company-completion-cancelled-hook)
                    'company-maybe-turn-on-fci)

      (use-package company-quickhelp
        :config
        (progn
          (company-quickhelp-mode 1)))))

  (use-package flycheck-ycmd
    :config
    (progn
      (flycheck-ycmd-setup)
      (global-flycheck-mode)))

  (provide 'init-autocomplete)
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#3c4c55" "#DF8C8C" "#A8CE93" "#DADA93" "#83AFE5" "#c9b4cf" "#7FC1CA" "#c5c8c6"])
 '(custom-safe-themes
   (quote
    ("6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "9954ed41d89d2dcf601c8e7499b6bb2778180bfcaeb7cdfc648078b8e05348c6" "151bde695af0b0e69c3846500f58d9a0ca8cb2d447da68d7fbf4154dcf818ebc" "10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" "75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "6b289bab28a7e511f9c54496be647dc60f5bd8f9917c9495978762b99d8c96a0" "8aca557e9a17174d8f847fb02870cb2bb67f3b6e808e46c0e54a44e3e18e1020" "43c808b039893c885bdeec885b4f7572141bd9392da7f0bd8d8346e02b2ec8da" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "f0dc4ddca147f3c7b1c7397141b888562a48d9888f1595d69572db73be99a024" "7eded71a68f518d9e4d4580b477a3fb03bf2d0ecc1234ff361a7fdc1591b1c9d" default)))
 '(evil-want-Y-yank-to-eol nil)
 '(fci-rule-color "#556873")
 '(hl-todo-keyword-faces
   (quote
    (("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX" . "#dc752f")
     ("XXXX" . "#dc752f"))))
 '(jdee-db-active-breakpoint-face-colors (cons "#0d0f11" "#7FC1CA"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d0f11" "#A8CE93"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d0f11" "#899BA6"))
 '(lsp-ui-doc-enable nil)
 '(lsp-ui-sideline-show-symbol t)
 '(lsp-ui-sideline-update-mode (quote line))
 '(objed-cursor-color "#DF8C8C")
 '(package-selected-packages
   (quote
    (elixir-yasnippets realgud test-simple loc-changes load-relative company-plsense nimbus-theme csv-mode indium company-ycmd company-flx company-box helm-swoop wgrep ivy-yasnippet ivy-xref ivy-purpose ivy-hydra counsel-css sqlup-mode sql-indent zoom yasnippet-snippets yaml-mode ws-butler writeroom-mode winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package unfill treemacs-projectile treemacs-evil toc-org tagedit symon symbol-overlay string-inflection spaceline-all-the-icons smeargle slim-mode scss-mode sass-mode rjsx-mode restart-emacs rainbow-delimiters pug-mode pt prettier-js popwin popup-kill-ring persp-mode pcre2el password-generator paradox overseer org-bullets open-junk-file ob-elixir nameless mwim move-text moody mode-icons mmm-mode minions markdown-toc magithub magit-svn magit-gitflow macrostep lsp-ui lsp-treemacs lorem-ipsum livid-mode link-hint json-navigator json-mode js2-refactor js-doc indent-guide impatient-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-xref helm-themes helm-smex helm-purpose helm-projectile helm-mode-manager helm-make helm-lsp helm-gitignore helm-git-grep helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe gh-md fuzzy forge font-lock+ flycheck-pos-tip flycheck-package flycheck-mix flycheck-credo flx-ido fill-column-indicator fancy-battery eyebrowse exunit expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-textobj-line evil-surround evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu emmet-mode elisp-slime-nav editorconfig dumb-jump dotenv-mode doom-themes doom-modeline dimmer diminish define-word counsel-projectile company-web company-tern company-statistics company-quickhelp company-lsp column-enforce-mode clean-aindent-mode centered-cursor-mode beacon auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent add-node-modules-path ace-link ace-jump-helm-line ac-ispell)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e")))
 '(vc-annotate-background "#3c4c55")
 '(vc-annotate-color-map
   (list
    (cons 20 "#A8CE93")
    (cons 40 "#b8d293")
    (cons 60 "#c9d693")
    (cons 80 "#DADA93")
    (cons 100 "#e2d291")
    (cons 120 "#eaca90")
    (cons 140 "#F2C38F")
    (cons 160 "#e4bea4")
    (cons 180 "#d6b9b9")
    (cons 200 "#c9b4cf")
    (cons 220 "#d0a6b8")
    (cons 240 "#d799a2")
    (cons 260 "#DF8C8C")
    (cons 280 "#c98f92")
    (cons 300 "#b39399")
    (cons 320 "#9e979f")
    (cons 340 "#556873")
    (cons 360 "#556873")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-error ((t (:underline (:color "#ff5555" :style wave)))))
 '(font-lock-builtin-face ((t (:foreground "#ffb86c" :slant italic))))
 '(font-lock-comment-face ((t (:foreground "#6272a4" :slant italic))))
 '(font-lock-keyword-face ((t (:foreground "#ff79c6" :slant italic))))
 '(highlight-numbers-number ((t (:foreground "#ff5555"))))
 '(mode-line ((t (:background "dark violet" :box nil)))))
)
