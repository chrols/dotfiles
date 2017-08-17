;; A bunch of modes did not warrant their own files

(require 'arduino-mode)
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

(require 'nasm-mode)
(add-to-list 'auto-mode-alist '("\\.asm$" . nasm-mode))

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; Haskell configuration

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; nxml-mode configuration

(add-hook 'nxml-mode-hook
          (lambda ()
            (setq sgml-basic-offset 4)
            (setq indent-tabs-mode t)
            (setq tab-width 4)))
