;; -*- lexical-binding: t -*-



;;; Config

(moon-lsp/eglot
 (progn
   (add-hook 'python-mode-hook #'lsp t)
   (push '(python-mode . lsp-format-buffer) moon-smart-format-alist))
 (progn
   (add-hook 'python-mode-hook #'eglot-ensure)
   (push '(python-mode . eglot-format-buffer) moon-smart-format-alist)))


(use-package| pyvenv
  :config (setq pyvenv-mode-line-indicator
                '(pyvenv-virtual-env-name
                  (" [py: " pyvenv-virtual-env-name "]")))
  :commands pyvenv-activate)
