;;; config.el --- Tex      -*- lexical-binding: t; -*-

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs

;;; Commentary:
;;

;;; Code:
;;
;;;; Key

(post-config| general
  (moon-default-leader
    :keymaps 'tex-mode-map
    "tp" #'latex-preview-pane-mode))

;;;; Packages

(use-package| latex-preview-pane
  :commands latex-preview-pane-mode)

(use-package| company-math
  :init (add-hook 'latex-mode-hook #'moon-latex-company-setup))

(defun moon-latex-company-setup ()
  (require 'company-math)
  (setq-local company-backends
              (append '((company-math-symbols-latex company-latex-commands))
                      company-backends)))

(use-package| webkit-katex-render
  :commands webkit-katex-render-mode)

;; (post-config| eglot
;;   (add-to-list 'eglot-server-programs '(latex-mode . ("digestif"))))

(use-package| auctex
  :defer t
  :init
  (add-hook 'latex-mode-hook
            (lambda ()
              (moon-require-auctex)
              (TeX-latex-mode))))

(defun moon-require-auctex ()
  "Require necessary files from auctex."
  ;; that loads tex-site, not sure why auctex loads is this way
  ;; for "undoing things"?
  (let ((auctex-dir (save-window-excursion (with-current-buffer (find-library "latex")
                                             default-directory))))
    (load (concat auctex-dir "auctex.el") nil t t))
  (require 'latex)
  (require 'font-latex)
  (require 'texmathp))

;;;; Function
;;
;; auto {} after \

;; (defun moon-tex-post-insert (&rest _)
;;   "Insert {} after \\."
;;   (interactive)
;;   (when (eq (char-before) ?\\)
;;     (insert "{}")
;;     (backward-char 2)))

;; (add-hook 'latex-mode-hook (lambda ()
;;                              (add-hook 'post-self-insert-hook #'moon-tex-post-insert nil t)))

;;; config.el ends here
