;;; config.el --- Helm completion      -*- lexical-binding: t; -*-

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs


;;; Commentary:
;;

;;; Code:
;;

;;; Keys

(post-config| gerneral
  (moon-default-leader
    "fr" #'helm-recentf
    "ss" #'helm-swoop
    "ip" #'helm-yas-complete)
  (general-define-key
   :keymaps 'override
   [remap moon/kill-ring-select]     #'helm-show-kill-ring
   [remap switch-to-buffer]          #'helm-mini
   [remap apropos]                   #'helm-apropos
   [remap find-file]                 #'helm-find-files
   [remap recentf-open-files]        #'helm-recentf
   [remap projectile-switch-to-buffer] #'helm-projectile-switch-to-buffer
   [remap projectile-recentf]        #'helm-projectile-recentf
   [remap projectile-find-file]      #'helm-projectile-find-file
   [remap imenu]                     #'helm-semantic-or-imenu
   [remap bookmark-jump]             #'helm-bookmarks
   [remap noop-show-kill-ring]       #'helm-show-kill-ring
   [remap projectile-switch-project] #'helm-projectile-switch-project
   [remap projectile-find-file]      #'helm-projectile-find-file
   [remap imenu-anywhere]            #'helm-imenu-anywhere
   [remap execute-extended-command]  #'helm-M-x
   ))

;;; Packages

(use-package| helm
  :config
  (setq
   ;; Speedier without fuzzy matching
   helm-mode-fuzzy-match nil
   helm-buffers-fuzzy-matching nil
   helm-apropos-fuzzy-match nil
   helm-M-x-fuzzy-match nil
   helm-recentf-fuzzy-match nil
   helm-projectile-fuzzy-match nil
   ;; Display extraineous helm UI elements
   ;; helm-display-header-line nil
   ;; helm-ff-auto-update-initial-value nil
   ;; helm-find-files-doc-header nil
   ;; Don't override evil-ex's completion
   ;; helm-mode-handle-completion-in-region nil
   ;; helm-candidate-number-limit 50
   ;; Don't wrap item cycling
   ;; helm-move-to-line-cycle-in-source t
   ;; helm-split-window-in-side-p t
   helm-ff-file-name-history-use-recentf t
   helm-autoresize-max-height 30
   helm-autoresize-min-height 30
   helm-buffer-max-length 55
   ;; although unintuitive, setting this to t makes helm's window
   ;; stay OUTSIDE of the selected window
   ;; when there are two windows side by side,
   ;; helm doesn't hide the right window when splitting
   helm-split-window-inside-p t)
  (helm-autoresize-mode)
  (helm-mode)
  (define-key helm-find-files-map (kbd "C-i") #'helm-execute-persistent-action)
  (define-key helm-find-files-map (kbd "C-j") #'helm-select-action)
  (define-key helm-find-files-map (kbd "<RET>") #'helm-maybe-exit-minibuffer)
  (define-key helm-find-files-map (kbd "M-<backspace>") #'helm-find-files-up-one-level))

(use-package| helm-swoop
  :commands helm-swoop)

(use-package| helm-c-yasnippet
  :config
  (require 'yasnippet) ; yas configs turns yas-mode on
  (setq helm-yas-space-match-any-greedy t)
  :commands helm-yas-complete)

;;; config.el ends here
