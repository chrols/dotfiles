(add-to-list 'load-path "~/.emacs.d/elisp/")

(load-library "require-packages")
(load-library "utility")
(load-library "common")
(load-library "programming")
(load-library "cpp")
(load-library "etc")

(when (string= system-name "athena.chrols.se")
  (load-library "erlang")
  (load-library "golang"))
