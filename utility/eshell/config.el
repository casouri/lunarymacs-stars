(post-config| general
  (moon-default-leader
    "C-o e" '((lambda ()
                "Open in eshell."
                (interactive)
                (eshell default-directory))
              :which-key "open-in-eshell")
    "y" '(:ignore t :which-key "Eshell")
    "ys" #'counsel-switch-to-eshell-buffer
    "yn" #'aweshell-next
    "yp" #'aweshell-prev
    "yN" #'aweshell-new)
  (general-define-key
   "s-e" #'aweshell-toggle))

(use-package| (aweshell :fetcher github :repo "manateelazycat/aweshell")
  :commands (aweshell-new aweshell-next aweshell-prev aweshell-toggle)
  :init (setq aweshell-use-exec-path-from-shell nil)
  (custom-set-faces
   '(epe-dir-face ((t (:foreground "#51afef"))))
   '(epe-git-face ((t (:foreground "#bbc2cf"))))
   '(epe-pipeline-delimiter-face ((t (:foreground "#98be65"))))
   '(epe-pipeline-host-face ((t (:foreground "#bbc2cf"))))
   '(epe-pipeline-time-face ((t (:foreground "#bbc2cf"))))
   '(epe-pipeline-user-face ((t (:foreground "#bbc2cf")))))
  (require 'em-hist)
  (add-hook
   'eshell-mode-hook
   (lambda ()
     (mve
      (with-eval-after-load 'general
        (with-eval-after-load 'evil
          (general-define-key
           :states 'insert
           :keymaps 'eshell-mode-map
           "C-p" #'eshell-previous-matching-input-from-input
           "C-n" #'eshell-next-matching-input-from-input)))
      (define-key eshell-mode-map
        (kbd "<tab>") #'helm-esh-pcomplete)))))

;;; Config

(setq eshell-directory-name (concat moon-star-dir "utility/eshell/"))
(setq eshell-last-dir-ring-size 500)
(setq eshell-cp-interactive-query t
      eshell-ln-interactive-query t
      eshell-mv-interactive-query t
      eshell-rm-interactive-query t
      eshell-mv-overwrite-files nil)

;; /ssh:/10.52.224.67:blah
;; to: /10.52.224.67:blah
(setq tramp-default-method "ssh")
