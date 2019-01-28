;;; config.el --- Helm completion      -*- lexical-binding: t; -*-

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs


;;; Commentary:
;;

;;; Code:
;;

;;; Keys

(post-config| general
  (moon-default-leader
    "fr" #'helm-recentf
    "ss" #'helm-swoop
    "si" #'helm-imenu
    "sI" #'helm-imenu-in-all-buffers
    "C-s" #'helm-swoop
    "ip" #'helm-yas-complete)
  (moon-cx-leader
    "C-r" #'helm-resume)
  (general-define-key
   :keymaps 'override
   ;; "M-x" #'helm-smex
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
   helm-display-header-line nil ; don't display extraineous helm UI elements
   ;; helm-ff-auto-update-initial-value nil
   ;; helm-find-files-doc-header nil
   ;; helm-mode-handle-completion-in-region nil ; don't override evil-ex's completion
   ;; helm-candidate-number-limit 50
   ;; helm-move-to-line-cycle-in-source t ; don't wrap item cycling
   helm-ff-file-name-history-use-recentf t
   helm-autoresize-max-height 30
   helm-autoresize-min-height 30
   helm-buffer-max-length 55
   helm-split-window-inside-p t
   helm-split-window-preferred-function #'helm-split-window-my-fn
   helm-M-x-always-save-history t)
  (helm-autoresize-mode)
  (helm-mode)
  (define-key helm-map (kbd "C-i") #'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-j") #'helm-select-action)
  (define-key helm-find-files-map (kbd "<RET>") #'helm-maybe-exit-minibuffer)
  (define-key helm-find-files-map (kbd "M-<backspace>") #'helm-find-files-up-one-level)
  ;; (helm-ido-like-hide-modelines)
  (helm-ido-like-hide-helm-modeline)
  )

;; (use-package| helm-smex
;;   :commands helm-smex)

(use-package| helm-swoop
  :commands helm-swoop)

(use-package| helm-c-yasnippet
  :config
  (require 'yasnippet) ; yas configs turns yas-mode on
  (setq helm-yas-space-match-any-greedy t)
  :commands helm-yas-complete)

(use-package| helm-xref
  :commands helm-xref-show-xrefs
  :init (setq xref-show-xrefs-function 'helm-xref-show-xrefs))

;;; Functions

(defun helm-split-window-my-fn (window)
  "Replace `helm-split-window-preferred-function'.
WINDOW."
  (display-buffer-in-side-window "*scratch*" '((side . bottom))))

(defun moon-helm-sort-buffer (old-func &rest args)
  "Push all starred buffers and aweshell buffers and magit buffers to the bottom and keep original sort order."
  (let ((buffer-list (apply old-func args))
        star-buffer-list
        other-buffer-list)
    (dolist (buffer buffer-list)
      (if (and (or (string-prefix-p "*" buffer)
                   (string-prefix-p "Aweshell: " buffer)
                   (string-prefix-p "magit" buffer))
               (not (string= buffer "*scratch*")))
          (push buffer star-buffer-list)
        (push buffer other-buffer-list)))
    (nreverse (append star-buffer-list other-buffer-list))))

;; (advice-add 'helm-buffers-sort-transformer :around #'moon-helm-sort-buffer)

;;;; helm-better-default
;; https://github.com/clemera/helm-ido-like-guide

;;;;; Hide mode line when using helm

(defvar helm-ido-like-bottom-buffers nil
  "List of bottom buffers before helm session started.
Its element is a pair of `buffer-name' and `mode-line-format'.")


(defun helm-ido-like-bottom-buffers-init ()
  (setq-local mode-line-format (default-value 'mode-line-format))
  (setq helm-ido-like-bottom-buffers
        (cl-loop for w in (window-list)
                 when (window-at-side-p w 'bottom)
                 collect (with-current-buffer (window-buffer w)
                           (cons (buffer-name) mode-line-format)))))


(defun helm-ido-like-bottom-buffers-hide-mode-line ()
  (mapc (lambda (elt)
          (with-current-buffer (car elt)
            ;; modified by me: nil -> " "
            ;; (setq-local mode-line-format nil)
            ;; (setq-local mode-line-format (make-string (window-width) ?<))
            (setq-local mode-line-format (propertize " " 'display '(height 1.3)))
            ))
        helm-ido-like-bottom-buffers))


(defun helm-ido-like-bottom-buffers-show-mode-line ()
  (when helm-ido-like-bottom-buffers
    (mapc (lambda (elt)
            (with-current-buffer (car elt)
              (setq-local mode-line-format (cdr elt))))
          helm-ido-like-bottom-buffers)
    (setq helm-ido-like-bottom-buffers nil)))


(defun helm-ido-like-helm-keyboard-quit-advice (orig-func &rest args)
  (helm-ido-like-bottom-buffers-show-mode-line)
  (apply orig-func args))

(defun helm-ido-like-hide-modelines ()
  ;; hide The Modelines while Helm is active
  (add-hook 'helm-before-initialize-hook #'helm-ido-like-bottom-buffers-init)
  (add-hook 'helm-after-initialize-hook #'helm-ido-like-bottom-buffers-hide-mode-line)
  (add-hook 'helm-exit-minibuffer-hook #'helm-ido-like-bottom-buffers-show-mode-line)
  (add-hook 'helm-cleanup-hook #'helm-ido-like-bottom-buffers-show-mode-line)
  (advice-add 'helm-keyboard-quit :around #'helm-ido-like-helm-keyboard-quit-advice))

;;;;; Hide helm's mode line

(defun helm-ido-like-hide-helm-modeline-1 ()
  "Hide mode line in `helm-buffer'."
  (with-helm-buffer
    (setq-local mode-line-format nil)))


(defun helm-ido-like-hide-helm-modeline ()
  (fset 'helm-display-mode-line #'ignore)
  (add-hook 'helm-after-initialize-hook 'helm-ido-like-hide-helm-modeline-1))

;;; config.el ends here
