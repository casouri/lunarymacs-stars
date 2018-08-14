;; -*- lexical-binding: t -*-

(use-package| yasnippet
  :init
  (setq yas-snippet-dirs (list (concat moon-emacs-d-dir "snippet/")))
  (setq yas-verbosity 0) ; don't message anything
  :config
  (yas-global-mode 1)
  (yas-reload-all))

(defun company-mode-backend-with-yas (backend)
  (if (and (listp backend)
           (member 'company-yasnippet backend))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(add-hook 'moon-post-init-hook
          (lambda ()
            (setq company-backends
                  (mapcar #'company-mode-backend-with-yas company-backends))) t)



(use-package| auto-yasnippet
  :commands (aya-create aya-expand aya-open-line)
  :config (require 'yasnippet))


(post-config| general
  (moon-default-leader
    "iaa" #'aya-create
    "iae" #'aya-expand))
