;; -*- lexical-binding: t -*-



;;; Config

;; switch to eglot

;; this config must run after eglot star
(if moon-use-eglot
    (add-hook 'python-mode-hook 'eglot-ensure)
  (use-package| lsp-python
    :defer t
    :init
    (add-hook 'python-mode-hook
              (lambda ()
                (require 'lsp-mode)
                (require 'lsp-python)
                (lsp-python-enable)))))


(use-package| pyvenv
  :commands pyvenv-activate)
