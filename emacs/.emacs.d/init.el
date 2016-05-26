(require 'package)
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))

;; Add in your own as you wish:
(defvar my-packages '(
                      color-theme
                      color-theme-monokai
                      color-theme-molokai)
  "A list of packages to ensure are installed at launch.")

(package-initialize)

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;; My code below

(load "~/.emacs.d/utility.el")

(require 'color-theme)
;(color-theme-molokai)
(color-theme-monokai)

(global-set-key [f2] 'visit-ansi-term)
(global-set-key [f11] 'fullscreen)

(display-time)

(global-set-key [f2] 'visit-ansi-term)
(setq org-export-latex-tables-centered nil)

(setq-default show-trailing-whitespace t)

(global-auto-complete-mode t)

(setq load-path (cons "~/.emacs.d/git/powerline" load-path))
(require 'powerline)
(powerline-default-theme)

(add-to-list 'load-path "~/.emacs.d/git/dockerfile-mode")
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(setq initial-scratch-message nil)

(global-linum-mode 1)
;(ispell-change-dictionary "en_US")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(add-hook 'nxml-mode-hook
          (lambda ()
            (setq sgml-basic-offset 4)
            (setq indent-tabs-mode t)
            (setq tab-width 4)))

(put 'upcase-region 'disabled nil)
(global-set-key [f4] 'ff-find-other-file)

;(add-to-list 'load-path (expand-file-name "~/.emacs.d/git/ethan-wspace/lisp"))
;(require 'ethan-wspace)
;(global-ethan-wspace-mode 1)

(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))
(setq whitespace-style '(face lines-tail tab-mark lines trailing)) 
(add-hook 'prog-mode-hook 'whitespace-mode)

(setq load-path (cons  "/usr/lib/erlang/lib/tools-2.8.1/emacs"
                       load-path))
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(require 'erlang-start)
;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)

(when (fboundp 'electric-indent-mode) (electric-indent-mode -1))

(setq x-select-enable-clipboard t)

(setq load-path (cons "~/.emacs.d/git/arduino-mode" load-path))
(require 'arduino-mode)
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

(setq load-path (cons "~/.emacs.d/git/nasm-mode" load-path))
(require 'nasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm$" . nasm-mode))

(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(setq-default tab-width 4)

(setenv "GOPATH" "/home/chrols/golang")

(setq exec-path (cons "/usr/lib/go/bin" exec-path))
(add-to-list 'exec-path "/home/chrols/golang/bin")

(defun go-run-buffer()
  (interactive)
  (shell-command (concat "go run " (buffer-name))))

(defun my-go-mode-hook ()
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  (local-set-key (kbd "C-c C-c")  'go-run-buffer)
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))
  ; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump))
(add-hook 'go-mode-hook 'my-go-mode-hook)

(load "~/.emacs.d/go-autocomplete.el")
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)
(with-eval-after-load 'go-mode
  (require 'go-autocomplete))
