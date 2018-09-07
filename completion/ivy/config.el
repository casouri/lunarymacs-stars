;; -*- lexical-binding: t -*-

(use-package| ivy
  :config
  (setq
   ivy-fixed-height-minibuffer t
   ivy-use-selectable-prompt t ; so I can chose what I actually typed
   ivy-initial-inputs-alist nil ; don't use ^ as initial input
   ivy-format-function 'ivy-format-function-arrow
   ivy-use-virtual-buffers t
   ivy-virtual-abbreviate 'abbreviate)
  (ivy-mode)
  )

(post-config| general
  (mve (progn
         (general-define-key
          :states '(normal visual)
          "RET" #'ivy-switch-buffer)
         (general-define-key
          :keymaps 'override
          "<S-return>" #'ivy-switch-buffer))
       (general-define-key
        :keymaps 'override
        "<C-return>" #'ivy-switch-buffer))
  (moon-default-leader
    ;; other
    "SPC" #'counsel-M-x
    ;; files
    "ff"  #'counsel-find-file
    "fr"  #'counsel-recentf
    "fL"  #'counsel-locate
    ;; help
    "hb"  #'counsel-descbinds
    "hf"  #'counsel-describe-function
    "hF"  #'counsel-describe-face
    "hl"  #'counsel-find-library
    "hm"  #'spacemacs/describe-mode
    "hk"  #'describe-key
    "ho"  #'describe-symbol
    "hv"  #'counsel-describe-variable
    "hd"  #'apropos
    "hi"  #'counsel-info-lookup-symbol
    "hR"  #'spacemacs/counsel-search-docs
    "?"   #'counsel-apropos
    ;; insert
    "iu"  #'counsel-unicode-char
    ;; search
    "si"  #'counsel-imenu
    "ss"  #'moon/smart-swiper
    "sr"  #'counsel-rg
    ;; themes
    "Ts"  #'counsel-load-theme
    ;; buffer
    "bb"  #'ivy-switch-buffer
    "RET" #'counsel-recentf
    )
  (general-define-key
   :keymaps 'override
   "C-x C-p" #'counsel-yank-pop
   "C-x C-m" #'counsel-mark-ring
   "C-x C-r" #'ivy-resume)
  )

(use-package| swiper :commands (swiper swiper-all))
(use-package| counsel
  :config
  (counsel-mode 1)
  (with-eval-after-load 'evil
    (defun moon-override-yank-pop (&optional arg)
      "Delete the region before inserting poped string."
      (when (region-active-p)
        (kill-region (region-beginning) (region-end))))
    (advice-add 'counsel-yank-pop :before #'moon-override-yank-pop))
  :commands (counsel-ag counsel-rg counsel-pt
                        counsel-apropos counsel-bookmark
                        counsel-describe-function
                        counsel-describe-variable
                        counsel-describe-face
                        counsel-M-x counsel-file-jump
                        counsel-find-file counsel-find-library
                        counsel-info-lookup-symbol
                        counsel-imenu counsel-recentf
                        counsel-yank-pop
                        counsel-descbinds counsel-org-capture
                        counsel-grep-or-swiper))
(use-package| smex
  :commands (smex smex-major-mode-commands)
  :config (setq smex-save-file (concat moon-local-dir "smex-items")))

(use-package| (ivy-filthy-rich :repo "casouri/ivy-filthy-rich" :fetcher github)
  :after counsel
  :config (ivy-filthy-rich-mode))
