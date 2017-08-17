;; erlang configuration

(setq load-path (cons  "/usr/lib/erlang/lib/tools-2.8.1/emacs"
                       load-path))
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(require 'erlang-start)
