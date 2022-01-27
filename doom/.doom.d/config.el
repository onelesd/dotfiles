;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dave Seleno"
  user-mail-address "dseleno@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Iosevka SS04" :size 16 :weight 'light)
  doom-variable-pitch-font (font-spec :family "SF Pro Text" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; start window maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; enable code folding via lsp (for elixir mostly)
;; Enable folding
(setq lsp-enable-folding t)

;; disable lsp file watching
(setq lsp-enable-file-watchers nil)

;; Add origami and LSP integration
(use-package! lsp-origami)
(add-hook! 'lsp-after-open-hook #'lsp-origami-try-enable)

;; format elixir buffers on save
(add-hook 'before-save-hook (lambda () (when (eq 'elixir-mode major-mode)
                                         (lsp-format-buffer))))

;; enable word-wrap in elixir exunit buffers
(add-hook 'exunit-compilation-mode-hook #'+word-wrap-mode)

;; disable suggestion spec annotiations
(setq lsp-elixir-suggest-specs nil)

;; make credo strict
(setq flycheck-elixir-credo-strict t)

;; set scrolloff
(setq scroll-margin 7)

;; set all-the-icons for treemacs
(setq doom-themes-treemacs-theme "doom-colors")

;; enable evil-matchit globally
(global-evil-matchit-mode 1)

;; enable word-wrap (almost) everywhere
(+global-word-wrap-mode +1)

;; enable lsp for tailwindcss
(use-package! lsp-tailwindcss :init (setq! lsp-tailwindcss-add-on-mode t))
(add-to-list 'lsp-language-id-configuration '(".*\\.heex$" . "html"))
(add-hook 'before-save-hook (lambda () (when (eq 'web-mode major-mode)
                                         (lsp-tailwindcss-rustywind))))

;; set footer bar color when zoomed
(custom-set-variables
  '(zoom-window-mode-line-color "purple4"))

;; enable tab mode
(centaur-tabs-mode t)
(centaur-tabs-enable-buffer-alphabetical-reordering)
(setq centaur-tabs-adjust-buffer-order t)

;; prettier for web-mode
;; (add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook #'(lambda ()
                             (unless (and (stringp buffer-file-name)
                                          (string-match "\\.heex\\'" buffer-file-name))
                               (prettier-js-mode))))
(setq prettier-js-args '(
  "--no-semi"
  "--bracket-same-line" "true"
  "--single-quote" "true"
  ;; "--print-width" "120"
))

;; enable evil-leader key "," in all buffers
(global-evil-leader-mode)
;; set leader key
(evil-leader/set-leader ",")

;; format all buffers according to .editorconfig (probably in users home dir)
; (add-hook 'before-save-hook (lambda () (editorconfig-format-buffer)))

(load! "keybindings.el")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
