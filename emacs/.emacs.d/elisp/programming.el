;; configuration applicable for multiple programming modes

(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(setq whitespace-style '(face lines-tail tab-mark lines trailing))
(add-hook 'prog-mode-hook 'whitespace-mode)

;; Require flycheck to be present
(require 'flycheck)
;; Force flycheck to always use c++11 support. We use
;; the clang language backend so this is set to clang
(add-hook 'c++-mode-hook
          (lambda () (setq flycheck-clang-language-standard "c++11")))
;; Turn flycheck on everywhere
(global-flycheck-mode)
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)

;; The default lisp-indent-function does not look good to mee
(setq lisp-indent-function 'common-lisp-indent-function)

(setq prettify-symbols-alist
      '(("lambda" . 955) ; λ
        ))

(global-prettify-symbols-mode 1)
