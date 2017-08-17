(setq c-basic-offset 4)
(require 'cpputils-cmake)

(add-hook 'c-mode-common-hook
          (lambda ()
            (if (derived-mode-p 'c-mode 'c++-mode)
                (cppcm-reload-all)
              )))

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

