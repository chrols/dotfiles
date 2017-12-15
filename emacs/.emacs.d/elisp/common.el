;; Common emacs setup

(menu-bar-mode -1)
(toggle-scroll-bar -1)
(add-hook 'after-make-frame-functions 'never-scroll-bars)
(tool-bar-mode -1)
(setq inhibit-splash-screen t)
(setq-default indent-tabs-mode nil)

;; Perform GC less often
(setq gc-cons-threshold 100000000)

(load-theme 'molokai t)

(global-set-key [f2] 'visit-ansi-term)
(global-set-key [f11] 'toggle-frame-fullscreen)

(display-time)

(global-set-key [f2] 'visit-ansi-term)
(setq org-export-latex-tables-centered nil)

(setq-default show-trailing-whitespace t)

(require 'powerline)
(powerline-default-theme)

(setq initial-scratch-message nil)

(global-linum-mode 1)
(ispell-change-dictionary "english")

(put 'upcase-region 'disabled nil)
(global-set-key [f4] 'ff-find-other-file)

;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)

(setq x-select-enable-clipboard t)
(setq-default tab-width 4)

(require 'ido)
(ido-mode t)

(require 'smex)
(autoload 'smex "smex"
  "Smex is a M-x enhancement for Emacs, it provides a convenient interface to
your recently and most frequently used commands.")

(global-set-key (kbd "M-x") 'smex)

(setq vc-follow-symlinks t)
(put 'downcase-region 'disabled nil)
