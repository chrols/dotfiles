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

(setq gofmt-command "goimports")
(require 'go-mode-autoloads)
(require 'go-autocomplete)

(add-hook 'before-save-hook 'gofmt-before-save)
