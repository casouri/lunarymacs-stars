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
  :after company)

(defun moon-latex-company-setup ()
  (setq-local company-backends
              (append '((company-math-symbols-latex company-latex-commands))
                      company-backends)))

(add-hook 'tex-mode-hook 'moon-latex-company-setup)

;; (post-config| eglot
;;   (add-to-list 'eglot-server-programs '(latex-mode . ("digestif"))))

;;;; Function
;;
;; auto {} after \

(defun moon-tex-post-insert (&rest _)
  "Insert {} after \\."
  (interactive)
  (when (eq (char-before) ?\\)
    (insert "{}")
    (backward-char 2)))

(add-hook 'latex-mode-hook (lambda ()
                             (add-hook 'post-self-insert-hook #'moon-tex-post-insert nil t)))

;;; config.el ends here
