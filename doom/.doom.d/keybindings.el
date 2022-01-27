;;; keybindings.el -*- lexical-binding: t; -*-

(map! :leader
      :desc "pull from current branch"
      "g p" #'magit-pull-from-upstream)

(map! :leader
      :desc "push to current branch"
      "g P" #'magit-push-current-to-upstream)

(map! :leader
      :desc "toggle zoom on window"
      "w z" #'zoom-window-zoom)

(map! :n "g t" #'centaur-tabs-forward-tab
      :n "g T" #'centaur-tabs-backward-tab)

(map! :leader
      :desc "delete next parens"
      "d p" #'sp-unwrap-sexp)

;; remap : to ; so no need to press shift all the time
;; remap cursor keys to move windows
(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd ";") 'evil-ex)
  (define-key evil-visual-state-map (kbd ";") 'evil-ex)
  (define-key evil-motion-state-map (kbd ";") 'evil-ex)
  (define-key evil-motion-state-map (kbd "C-w <left>") 'evil-window-left)
  (define-key evil-motion-state-map (kbd "C-w <down>") 'evil-window-down)
  (define-key evil-motion-state-map (kbd "C-w <up>") 'evil-window-up)
  (define-key evil-motion-state-map (kbd "C-w <right>") 'evil-window-right)
  )
