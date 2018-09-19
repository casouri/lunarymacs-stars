;; -*- lexical-binding: t -*-

;;; Package


;;;; Edit

(use-package| (camelsnake-mode :fetcher github :repo "casouri/camelsnake-mode")
  :commands camelsnake-mode)

(use-package| expand-region
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

(post-config| general
  (moon-g-leader
    "v" #'er/expand-region)
  (moon-default-leader
    "v" #'er/expand-region))

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
        undo-tree-visualizer-diff t))

(use-package| hungry-delete
  :commands hungry-delete-backward
  :init
  (global-set-key (kbd "<S-backspace>") #'hungry-delete-backward))

;;;; Navigation


(use-package| recentf-ext
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


;;;; code structure

(use-package| outshine
  :defer t
  :init
  (add-hook 'outline-minor-mode-hook 'outshine-hook-function)
  (add-hook 'prog-mode-hook 'outline-minor-mode)
  (defvar outline-minor-mode-prefix (kbd "C-c o")))

(post-config| general
  (moon-default-leader
    "o" '(:ignore t :which-key "outline")
    "o <tab>" #'outline-toggle-children
    "os" #'outline-show-all
    "oh" #'outline-hide-body))

;; (use-package| (color-moccur :fetcher url :url "http://www.emacswiki.org/emacs/download/color-moccur.el")
;;   :commands moccur)
;; (use-package| (moccur-edit :fetcher url :url "https://www.emacswiki.org/emacs/download/moccur-edit.el")
;;   :after color-moccur)

(use-package| (color-rg :fetcher github :repo "manateelazycat/color-rg")
  :init
  (define-key isearch-mode-map (kbd "M-s M-s") 'isearch-toggle-color-rg)
  :commands (isearch-toggle-color-rg
             color-rg-search-input
             color-rg-search-symbol
             color-rg-search-project
             color-rg-search-project-rails))


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




;;;; Fix

(defun moon/return-cancel-completion ()
  "Cancel completion and return."
  (interactive)
  (company-abort)
  (newline nil t))

(global-set-key (kbd (mve "<C-return>" "<S-return>")) #'moon/return-cancel-completion)

;; never tested
;; http://emacsredux.com/blog/2013/04/21/edit-files-as-root/
(defadvice ivy-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;;;; switch input


;; (defun switch-input-minibuffer-hook ()
;;   "Switch to EN_US when minibuffer setup."

;;   (add-hook 'minibuffer-exit-hook #'switch-input-switch-back t t))

;; (defun switch-input-switch-back ()
;;   "Switch to ZH_CN when minibuffer exits."
;;   (remove-hook 'minibuffer-exit-hook #'switch-input-switch-back t)
;;   )

;; (define-minor-mode switch-input-mode
;;   "Switch input by prefix key and in minibuffer."
;;   :lighter "SIM"
;;   :global t
;;   (if switch-input-mode
;;       (add-hook 'minibuffer-setup-hook #'switch-input-minibuffer-hook)
;;     (remove-hook 'minibuffer-setup-hook #'switch-input-minibuffer-hook)))

;; (defvar switch-input-switch-script "tell application \"Hammerspoon\"
;; execute lua code \"switchInputMethod()\"
;; end tell"
;;   "The applescript to switch input method.")

;; (defvar switch-input-switch-back-script "tell application \"Hammerspoon\"
;; execute lua code \"switchInputMethodBack()\"
;; end tell"
;;   "The applescript to switch input method back.")

;;; config.el ends here
