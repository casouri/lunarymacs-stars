;; -*- lexical-binding: t -*-

;;; Key

(post-config| general
  ;;;; Outshine
  (moon-default-leader
    "iu" #'insert-char
    "sr" #'color-rg-search-input
    "o" '(:ignore t :which-key "outline")
    "o <tab>" #'outline-toggle-children
    "os" #'outline-show-all
    "oh" #'outline-hide-body)
  (global-unset-key (kbd "C-<down-mouse-1>"))
  (general-define-key
   :keymaps 'override
   ;; this is binded by default,
   ;; but flyspell mode shadows it
   "C-M-i" #'outshine-cycle-buffer
   "C-<mouse-1>" #'mc/add-cursor-on-click)
  ;;;; Expand Region
  (moon-g-leader
    "v" #'er/expand-region)
  (moon-default-leader
    "v" #'er/expand-region)
  ;;;; Helpful
  (general-define-key
   :keymaps 'override
   "C-h f" #'helpful-callable
   "C-h v" #'helpful-variable
   "C-h k" #'helpful-key
   "C-c d" #'helpful-at-point)
  ;;;; Kill Ring Select
  (moon-cx-leader
    ;; C-y is too uncomfortable to reach
    ;; so C-p here we go
    "C-p" #'moon/kill-ring-select
    "<C-i>" #'moon/insert-special-symbol))


(mve (global-set-key (kbd "<S-return>") #'moon/return-cancel-completion) nil)


;;; Package

;;;; Edit

(use-package| (camelsnake-mode :fetcher github :repo "casouri/camelsnake-mode")
  :commands camelsnake-mode)

(use-package| ws-butler
  :defer 3
  :config (ws-butler-global-mode))

(use-package| expand-region
  :config
  ;; it interferes angel.el's region transient map
  ;; specifically, the region-deactive-hook
  ;; doesn't run right after the region highlight is off
  (setq expand-region-fast-keys-enabled nil)
  :commands
  er/expand-region
  er/mark-defun
  er/mark-word
  er/mark-symbol
  er/mark-inside-quotes
  er/mark-outside-quotes
  er/mark-inside-pairs
  er/mark-outside-pairs
  er/contract-region)

(use-package| (isolate :fetcher github :repo "casouri/isolate")
  :commands (isolate-quick-add
             isolate-quick-change
             isolate-quick-delete
             isolate-long-add
             isolate-long-change
             isolate-long-delete))

(use-package| undo-tree
  :config (global-undo-tree-mode)
  (setq undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t
        undo-tree-auto-save-history t
        undo-tree-history-directory-alist `(("." . ,moon-cache-dir))))

(use-package| hungry-delete
  :commands hungry-delete-backward
  :init
  (global-set-key (kbd "<S-backspace>") #'hungry-delete-backward))

;;;; Navigation

(use-package| (recentf-ext :system t)
  :commands (recentf counsel-recentf))

(use-package| avy
  :commands (avy-goto-char
             avy-goto-char-2
             avy-goto-char-timer)
  :config
  (setq avy-background t)
  (setq avy-all-windows nil))

(post-config| general
  (moon-default-leader
    "k" #'avy-goto-char-timer))

(use-package| minimap
  :config
  (setq
   minimap-width-fraction 0.1
   minimap-window-location 'right
   minimap-update-delay 0)
  (custom-theme-set-faces 'user
                          '(minimap-active-region-background
                            ((((background dark)) (:background "#61526E"))
                             (t (:background "#d3d3e7")))))
  :commands minimap-mode)

(post-config| general
  (moon-default-leader "tm" #'minimap-mode))

;; used for chinese editiing on macOS
;; TODO autoload this
;; (load| switch-input-mode)


;;;; Code Structure

(use-package| outshine
  :defer t
  :init
  (add-hook 'outline-minor-mode-hook 'outshine-hook-function)
  (add-hook 'prog-mode-hook 'outline-minor-mode)
  (defvar outline-minor-mode-prefix (kbd "C-c o")))


(use-package| (color-rg :fetcher github :repo "manateelazycat/color-rg")
  :init
  (define-key isearch-mode-map (kbd "M-s M-s") 'isearch-toggle-color-rg)
  :commands (isearch-toggle-color-rg
             color-rg-search-input
             color-rg-search-symbol
             color-rg-search-project
             color-rg-search-project-rails))

(use-package| visual-regexp
  :commands (vr/replace
             vr/query-replace
             vr/mc-mark))

(use-package| multiple-cursors
  :commands (mc/edit-lines
             mc/add-cursor-on-click)
  :init (setq mc/list-file (concat moon-local-dir "mc-lists.el")))

;;;; Help

(use-package| helpful
  :commands (helpful-callable
             helpful-variable
             helpful-key
             helpful-at-point))

;;; Config

;;;; Default

(electric-pair-mode 1)

;; smooth scrolling
(setq scroll-conservatively 101)
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(post-config| general
  (general-define-key
   :states '(normal insert)
   "C-;" #'moon/insert-semi-at-eol
   )
  (general-define-key
   :states 'normal
   "J" #'moon/scroll-down-reserve-point
   "K" #'moon/scroll-up-reserve-point)) 

;; utf-8
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


;;;; split screen vertically in ediff
(setq ediff-split-window-function #'split-window-horizontally)

;;;; Kill Ring

(defun moon/kill-ring-select ()
  "Select from `kill-ring' and yank.
Helm and ivy starts will remap this function,
so the definition doesn't really matter."
  (interactive)
  (message "This is intended to be remapped by either Helm or ivy star."))

;;;; Fix

(defun moon/return-cancel-completion ()
  "Cancel completion and return."
  (interactive)
  (company-abort)
  (newline nil t))

;;; config.el ends here
