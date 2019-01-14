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
   "s-e" #'aweshell-toggle)
  (general-define-key
   :keymaps 'aweshell-mode-map
   "<tab>" #'company-complete))

(use-package| aweshell
  :commands (aweshell-new aweshell-next aweshell-prev aweshell-toggle)
  :config
  (setq eshell-highlight-prompt nil
        eshell-prompt-function 'epe-theme-pipeline))

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
