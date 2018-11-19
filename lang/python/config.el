;; -*- lexical-binding: t -*-



;;; Config

;; switch to eglot

;; this config must run after eglot star
(if moon-use-eglot
    (progn
      (add-hook 'python-mode-hook 'eglot-ensure)
      (push '(python-mode . eglot-format-buffer) moon-smart-format-alist))
  (use-package| lsp-python
    :defer t
    :init
    (add-hook 'python-mode-hook
              (lambda ()
                (require 'lsp-mode)
                (require 'lsp-python)
                (lsp-python-enable)))
    (push '(python-mode . lsp-format-buffer) moon-smart-format-alist)))


(use-package| pyvenv
  :commands pyvenv-activate)
