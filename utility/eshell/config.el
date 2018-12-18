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

(use-package| aweshell
  :commands (aweshell-new aweshell-next aweshell-prev aweshell-toggle)
  :init
  (setq aweshell-use-exec-path-from-shell nil)
  (add-hook
   'eshell-mode-hook
   (lambda ()
     (company-mode)
     (setq-local company-auto-complete nil)
     (setq-local company-idle-delay 9999)
     (esh-autosuggest-companyless-mode)
     (mve
      (with-eval-after-load 'general
        (with-eval-after-load 'evil
          (general-define-key
           :states 'insert
           :keymaps 'eshell-mode-map
           "C-p" #'eshell-previous-matching-input-from-input
           "C-n" #'eshell-next-matching-input-from-input)))
      (define-key eshell-mode-map
        (kbd "<tab>") #'company-complete)))))

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
