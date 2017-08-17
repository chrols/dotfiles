;; configuration applicable for multiple programming modes

(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(setq whitespace-style '(face lines-tail tab-mark lines trailing))
(add-hook 'prog-mode-hook 'whitespace-mode)

(global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
