;;; config.el --- Languange Server Protocol       -*- lexical-binding: t; -*-

;;; This file is NOT part of GNU Emacs

;;; Commentary:
;;

;;; Code:
;;

;; please compiler
(defvar moon-lsp)

(defmacro moon-lsp/eglot (lsp eglot)
  "Run LSP or EGLOT based on `moon-lsp'."
  (pcase moon-lsp
    ('lsp `(post-config| lsp ,lsp))
    ('eglot `(post-config| eglot ,eglot))))

;;; Variales

(defvar moon-lsp 'lsp
  "'lsp or 'eglot.")

;;; Config

(moon-lsp/eglot
 (load| lsp)
 (load| eglot))

;;; config.el ends here
