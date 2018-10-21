;; -*- lexical-binding: t -*-



;;; Config

;; switch to eglot

;; (use-package| lsp-python
;;   :defer t
;;   :init
;;   (add-hook 'python-mode-hook
;;             (lambda ()
;;               (require 'lsp-mode)
;;               (require 'lsp-python)
;;               (lsp-python-enable)))
;;   (add-to-list 'moon-smart-format-alist '(python-mode . lsp-format-buffer)))

(add-hook 'python-mode-hook 'eglot-ensure)

(use-package| pyvenv
  :commands pyvenv-activate)
