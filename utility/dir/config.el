;; -*- lexical-binding: t -*-

;;; Key

(post-config| general
  (general-define-key
   :keymaps 'dired-mode-map
   "b" #'dired-up-directory
   "q" #'moon-quit-window
   "C-c C-s" #'dired-narrow
   "C-c C-o" #'moon-dired-open-file-at-point)
  (mve
   (general-define-key
    "j" #'next-line
    "k" #'previous-line
    "h" #'dired-up-directory
    "l" #'dired-find-file)
   nil))

;; (post-config| general
;;   (moon-default-leader
;;     "tn" #'neotree-toggle
;;     "tr" #'ranger
;;     "th" #'moon/toggle-hidden-file)
;;   (general-define-key
;;    :states 'normal
;;    :keymaps 'neotree-mode-map
;;    "TAB" #'neotree-enter
;;    "SPC" #'neotree-quick-look
;;    "q" #'neotree-hide
;;    "RET" #'neotree-enter))

;;; Package

;; (use-package| neotree
;;   :commands neotree-toggle
;;   :init
;;   (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;;   (setq neo-smart-open t)
;;   (setq projectile-switch-project-action 'neotree-projectile-action)
;;   (setq neo-show-hidden-files t)
;;   :config
;;   (require 'all-the-icons))


;; (use-package| ranger
;;   :init (setq ranger-show-hidden t
;;               ;; otherwise ranger binds ranger-key (C-p)
;;               ;; to `deer-from-dired' in dired mode
;;               ranger-key nil)
;;   :commands ranger)

(use-package| dired-narrow
  :commands dired-narrow)

;;; Config

(add-hook 'dired-mode-hook #'auto-revert-mode)

;;; Function
;; TODO
(defun moon-dired-copy-file (file)
  (shell-command (format "pbcopy < " file)))

(defun moon-dired-past-file ()
  )

(defun moon-dired-open-file-at-point ()
  (interactive)
  (if-let ((file (dired-file-name-at-point)))
      (shell-command (format "open %s" file))
    (message "Not file found at point")))

;;
