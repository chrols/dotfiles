(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Workaround for bug, see:
;; https://lists.gnu.org/archive/html/bug-gnu-emacs/2014-10/msg01175.html

;; Not fixed in 24.5 it would appear

(eval-when-compile
  (if (and (= emacs-major-version 24)
           (or (= emacs-minor-version 4)
               (= emacs-minor-version 5)))
      (require 'cl)))

(defvar required-packages '(arduino-mode
                            auctex
                            cmake-mode
                            company
                            color-theme
                            cpputils-cmake
                            dockerfile-mode
                            flycheck
                            ggtags
                            go-autocomplete
                            go-mode
                            haskell-mode
                            magit
                            markdown-mode
                            molokai-theme
                            nasm-mode
                            powerline
                            smex
                            yaml-mode
)
  "A list of packages to ensure are installed at launch.")

(let ((missing-packages nil))
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (setq missing-packages t)))
  (if missing-packages
      (progn
        (package-refresh-contents)
        (dolist (p required-packages)
          (when (not (package-installed-p p))
            (package-install p))))))
