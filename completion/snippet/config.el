;; -*- lexical-binding: t -*-

(use-package| yasnippet
  :commands yas-global-mode
  :init
  (setq yas-snippet-dirs (list (concat moon-emacs-d-dir "snippet/")))
  (setq yas-verbosity 0) ; don't message anything
  :config
  (yas-reload-all))

(post-config| company
  (setq company-backends
        (mapcar #'company-mode-backend-with-yas company-backends)))

(defun company-mode-backend-with-yas (backend)
  (if (and (listp backend)
           (member 'company-yasnippet backend))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(use-package| auto-yasnippet
  :commands (aya-create aya-expand aya-open-line)
  :config (require 'yasnippet))


(post-config| general
  (moon-default-leader
    "iaa" #'aya-create
    "iae" #'aya-expand))
