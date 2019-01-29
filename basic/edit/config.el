;; -*- lexical-binding: t -*-

;;; Key

(post-config| general
  ;;;; Outshine
  (moon-default-leader
    "tl" #'moon/toggle-left-margin
    "iu" #'insert-char
    "sr" #'moon-color-rg-search-input
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
   "C-<mouse-1>" #'mc/add-cursor-on-click
   ;;;; Move up/down
   "M-P" #'moon/move-up
   "M-N" #'moon/move-down
   ;;;; Hippie
   "M-/" #'hippie-expand)
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
   "C-h k" #'helpful-key)
  (general-define-key
   :keymaps 'helpful-mode-map
   "b" #'helpful-previous-helpful-buffer
   "f" #'helpful-next-helpful-buffer
   "q" #'delete-window)
  ;;;; Kill Ring Select
  (moon-cx-leader
    ;; C-y is too uncomfortable to reach
    ;; so C-p here we go
    "C-p" #'moon/kill-ring-select
    "<C-i>" #'moon/insert-special-symbol)
  ;;;; Minimap
  (moon-default-leader "tm" #'minimap-mode)
  ;;;; avy
  (moon-default-leader
    "k" #'avy-goto-char-timer))


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

;; used for chinese editiing on macOS
;; TODO autoload this
;; (load| switch-input-mode)


;;;; Code Structure

(use-package| outshine
  :commands outshine-cycle-buffer
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
             color-rg-search-project-rails
             moon-color-rg-search-input)
  :config
  (defun moon-color-rg-search-input (&optional keyword directory files)
    ;; Save window configuration before do search.
    ;; Just save when `color-rg-window-configuration-before-search' is nil
    ;; Or current buffer is not `color-rg-buffer' (that mean user not quit color-rg and search again in other place).
    (interactive)
    (when (or (not color-rg-window-configuration-before-search)
              (not (string-equal (buffer-name) color-rg-buffer)))
      (setq color-rg-window-configuration-before-search (current-window-configuration))
      (setq color-rg-buffer-point-before-search (point)))
    ;; Set `enable-local-variables' to :safe, avoid emacs ask annoyingly question when open file by color-rg.
    (setq enable-local-variables :safe)
    ;; Search.
    (let* ((search-keyboard
            (or keyword
                (color-rg-read-input)))
           (search-directory
            (read-directory-name "Dir: " default-directory))
           (search-files
            (or files
                "everything")))
      (color-rg-search search-keyboard search-directory search-files))))



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
             helpful-at-point)
  :config
  (setq helpful-max-buffers 5)
  ;; don't pop new window
  (require 'subr-x)
  (setq helpful-switch-buffer-function
        (lambda (buf) (if-let ((window (display-buffer-reuse-mode-window buf '((mode . helpful-mode)))))
                          ;; ensure the helpful window is selected for `helpful-update'.
                          (select-window window)
                        ;; line above returns nil if no available window is found
                        (pop-to-buffer buf))))
  (defvar moon-helpful-history () "History of helpful, a list of buffers.")
  (advice-add #'helpful-update :around #'moon-helpful@helpful-update)
  (advice-add #'helpful--buffer :around (lambda (oldfunc &rest _)
                                          (let ((buf (apply oldfunc _)))
                                            (push buf moon-helpful-history)
                                            buf))))

(defun moon-helpful@helpful-update (oldfunc)
  "Insert back/forward buttons."
  (funcall oldfunc)
  (let ((inhibit-read-only t))
    (goto-char (point-min))
    (insert-text-button "Back"
                        'action #'helpful-previous-helpful-buffer)
    (insert " / ")
    (insert-text-button "Forward"
                        'action #'helpful-next-helpful-buffer)
    (insert "\n\n")))

(defun helpful-previous-helpful-buffer ()
  (interactive)
  (let ((buf (current-buffer)))
    (previous-buffer)
    (while (and (not (eq major-mode 'helpful-mode))
                (not (eq (current-buffer) buf)))
      (previous-buffer))))

(defun helpful-next-helpful-buffer ()
  (interactive)
  (let ((buf (current-buffer)))
    (next-buffer)
    (while (and (not (eq major-mode 'helpful-mode))
                (not (eq (current-buffer) buf)))
      (next-buffer))))

;;; Config

;;;; Default

(electric-pair-mode 1)
;; (push '(?< . ?>) electric-pair-pairs)
(add-hook 'emacs-lisp-mode-hook
          (lambda () (setq-local electric-pair-text-pairs
                                 (append '((?` . ?'))
                                         electric-pair-text-pairs))))


(minibuffer-electric-default-mode 1)

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
;;;; Xref
(setq xref-prompt-for-identifier
      '(not xref-find-references xref-find-definitions xref-find-definitions-other-window xref-find-definitions-other-frame))

;;;; Hippie
(add-to-list 'hippie-expand-try-functions-list #'dabbrev-expand)

;;; Functions

(defvar moon-left-margin-window nil
  "Left margin window")

(defvar moon-left-margin-buffer (get-buffer-create " moon-left-margin")
  "Empty buffer used by `moon-left-margin-mode'.")

(define-minor-mode moon-left-margin-mode
  "Create a empty window to the left that act as a margin."
  :lighter ""
  :global t
  (if moon-left-margin-mode
      (unless moon-left-margin-window
        (setq moon-left-margin-window
              (display-buffer-in-side-window moon-left-margin-buffer '((side . left)))))
    (when (and moon-left-margin-window (window-live-p moon-left-margin-window))
      (delete-window moon-left-margin-window)
      (setq moon-left-margin-window nil))))

(defun moon/toggle-left-margin ()
  "Toggle left margin side window."
  (interactive)
  (if moon-left-margin-window
      (window-toggle-side-windows)
    (moon-left-margin-mode)))

(defun moon--line-beg (point)
  "Return the line beginning of POINT."
  (save-excursion
    (goto-char point)
    (line-beginning-position)))

(defun moon--line-end (point)
  "Return the line end of POINT."
  (save-excursion
    (goto-char point)
    (line-end-position)))

(defun moon/transpose-region/line (count)
  "Transpose region or current line with the line COUNT from current line.
negative COUNT means go up.

Transpose down one line means COUNT = 0, look at source for the reason."
  ;; if the cursor is at end of a line, move to the beginning of
  ;; the next line to include the trailing newline
  (let* ((region-active (region-active-p))
         (region1 (if (region-active-p)
                      (cons (moon--line-beg (region-beginning))
                            ;; include the trailing newline
                            (1+ (moon--line-end (region-end))))
                    ;; include the trailing newline
                    (cons (line-beginning-position) (1+ (line-end-position)))))
         (region2 (save-excursion
                    ;; normalize starting point
                    ;; go to the beginning of beg/end of region1
                    (if (< count 0)
                        (goto-char (car region1))
                      (goto-char (cdr region1)))
                    ;; go up/down to beg of line of region2
                    (forward-line count)
                    ;; include the trailing newline
                    (cons (line-beginning-position) (1+ (line-end-position))))))
    (transpose-regions (car region1) (cdr region1) (car region2) (cdr region2))
    ;; TODO keep region
    (when region-active (activate-mark))))

(defun moon/move-down ()
  "Move region or current line down one line."
  (interactive)
  (moon/transpose-region/line 0))

(defun moon/move-up ()
  "Move region or current line down one line."
  (interactive)
  (moon/transpose-region/line -1))

;;; config.el ends here
