;; -*- lexical-binding: t -*-

;;
;;; Package
;;

    
;;;; Edit

(use-package| expand-region
  :commands er/expand-region)

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
(post-config| general
  (moon-default-leader
    "C-s"     '(:ignore t :which-key "surround")
    "C-s C-s" #'isolate-quick-add
    "C-s M-s" #'isolate-quick-add
    "C-s C-d" #'isolate-quick-delete
    "C-s M-d" #'isolate-long-delete
    "C-s C-c" #'isolate-quick-change
    "C-s M-c" #'isolate-long-change))

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
    :keymaps 'outline-minor-mode-map
    "o" '(:ignore t :which-key "outline")
    "o<tab>" #'outline-toggle-children
    "o s" #'outline-show-all
    "o h" #'outline-hide-body))

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


;;;
;;; Config
;;;

;;;;
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



;;;;
;;;; Fix

(defun moon/return-cancel-completion ()
  "Cancel completion and return."
  (interactive)
  (company-abort)
  (newline nil t))

(global-set-key (kbd "<C-return>") #'moon/return-cancel-completion)

;; never tested
;; http://emacsredux.com/blog/2013/04/21/edit-files-as-root/
(defadvice ivy-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (unless (and buffer-file-name
               (file-writable-p buffer-file-name))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

