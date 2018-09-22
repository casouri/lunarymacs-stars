;; -*- lexical-binding: t -*-

;;; Key

(post-config| general
  (general-define-key
   :keymaps 'dired-mode-map
   "C-c C-f" #'dired-narrow-fuzzy
   "b" #'dired-up-directory
   "q" #'quit-window
   "j" #'next-line
   "k" #'previous-line
   "h" #'dired-up-directory
   "l" #'dired-find-file))

(post-config| general
  (moon-default-leader
    "tn" #'neotree-toggle
    "tr" #'ranger
    "th" #'moon/toggle-hidden-file)
  (general-define-key
   :states 'normal
   :keymaps 'neotree-mode-map
   "TAB" #'neotree-enter
   "SPC" #'neotree-quick-look
   "q" #'neotree-hide
   "RET" #'neotree-enter))

;;; Package

(use-package| neotree
  :commands neotree-toggle
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-smart-open t)
  (setq projectile-switch-project-action 'neotree-projectile-action)
  (setq neo-show-hidden-files t)
  :config
  (require 'all-the-icons))


(use-package| ranger
  :init (setq ranger-show-hidden t)
  :commands ranger)

(use-package| dired-narrow
  :commands dired-narrow)

;;; Config

(add-hook 'dired-mode-hook #'auto-revert-mode)
