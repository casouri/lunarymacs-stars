;; -*- lexical-binding: t -*-

;;;
;;; Config
;;;

(global-hl-line-mode 1)

(add-hook 'prog-mode-hook #'hs-minor-mode)

(global-set-key (kbd "C-c C-h") #'hs-hide-block)
(global-set-key (kbd "C-c M-h") #'hs-show-block)


;;;
;;; Package
;;;

(use-package| atom-one-dark-theme
  :defer t
  :config
  ;; (set-face-attribute 'company-tooltip-common nil :foreground "#C678DD")
  (set-face-attribute 'company-tooltip-common-selection nil :foreground "#C678DD")
  ;; (set-face-attribute 'company-preview-common nil :foreground "#C678DD")
  )

(use-package| doom-themes
  :config
  (add-to-list 'moon-toggle-theme-list 'doom-one)
  (customize|
   (set-face-attribute 'mode-line nil :background "#603D8E")
   (set-face-attribute 'lazy-highlight nil :inherit 'default :background nil :foreground "#CFD7E5" :distant-foreground nil)
   (set-face-attribute 'company-tooltip-common-selection nil :foreground "#C678DD")))

(use-package| spacemacs-theme
  :defer t
  :config
  (add-to-list 'custom-theme-load-path (car (directory-files moon-package-dir "spacemacs-theme.+")) t)
  (custom-set-variables '(spacemacs-theme-custom-colors ;                              GUI       TER                           GUI       TER
                        '((bg1        . (if (eq variant 'dark) (if (true-color-p) "#222226" "#262626") (if (true-color-p) "#fbf8ef" "#ffffff")))
                          (bg2        . (if (eq variant 'dark) (if (true-color-p) "#17181B" "#1c1c1c") (if (true-color-p) "#efeae9" "#e4e4e4")))
                          (comment-bg . (if (eq variant 'dark) (if (true-color-p) "#23282A" "#262626") (if (true-color-p) "#ecf3ec" "#ffffff")))
                          (highlight  . (if (eq variant 'dark) (if (true-color-p) "#61526E" "#444444") (if (true-color-p) "#d3d3e7" "#d7d7ff")))
                          (act2       . (if (eq variant 'dark) (if (true-color-p) "#603D8E" "#444444") (if (true-color-p) "#d3d3e7" "#d7d7ff")))
                          (border     . (if (eq variant 'dark) (if (true-color-p) "#603D8E" "#444444") (if (true-color-p) "#d3d3e7" "#d7d7ff")))
                          ))))

(use-package| rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package| rainbow-mode
  :commands rainbow-mode)

(use-package| highlight-parentheses
  :init
  :config
  (set-face-attribute 'hl-paren-face nil :weight 'bold)
  (global-highlight-parentheses-mode 1)
  ;;highlight only the most inner pair
  (setq hl-paren-colors '("green"))
  ;; red in light theme, green in dark
  (change-by-theme '((spacemacs-dark . (progn (setq hl-paren-colors '("green")) (hl-paren-color-update)))
                     (spacemacs-light . (progn (setq hl-paren-colors '("red")) (hl-paren-color-update))))))


;;;;
;;;; Mode-line

(post-config| moody
  (use-package minions
    ;; minions need to override mode-line-format
    ;; setted by moon/setup-moody
    :config
    ;; patch minions-mode
    ;; so it applyies change to opended buffers too
    (define-minor-mode minions-mode
      "Display a minor-mode menu in the mode line.

This replaces the likely incomplete and possibly cut off list of
minor-modes that is usually displayed directly in the mode line."
      :group 'minions
      :global t
      (if minions-mode
          (let ((banana (cl-subst 'minions-mode-line-modes
                                  'mode-line-modes
                                  (default-value 'mode-line-format)
                                  :test #'equal)))
            (if (eq banana (default-value 'mode-line-format))
                (progn (setq minions-mode nil)
                       (error "Cannot turn on Minions mode"))
              (setq-default mode-line-format banana)
              ;; apply change to opended buffers
              (save-excursion
                (mapc (lambda (buffer)
                        (with-current-buffer buffer
                          (setq mode-line-format banana)))
                      (buffer-list)))))
        (cl-nsubst 'mode-line-modes
                   'minions-mode-line-modes
                   mode-line-format)))

   (minions-mode 1)))

(use-package| moody
  :config
  (setq moody-slant-function #'moody-slant-apple-rgb)
  (setq x-underline-at-descent-line t)
  (moon/setup-moody))

;;;;
;;;; Line number

(defvar moon-enable-nlinum-relative nil
  "Whether to enable relative line number.")

(use-package| nlinum
  :init 
  (add-hook 'moon-load-theme-hook #'moon/sync-nlinum-face)
  (add-hook 'moon-load-theme-hook #'moon/sync-nlinum-highlight-face)
  (setq nlinum-highlight-current-line t)
  :config
  (when moon-enable-nlinum-relative
    (global-nlinum-mode)
    (moon/sync-nlinum-face)
    (moon/sync-nlinum-highlight-face))
  )

(use-package| nlinum-relative
  :config
  (add-hook 'moon-load-theme-hook #'moon/sync-nlinum-relative-current-line-face)
  (add-hook 'nlinum-relative-mode-hook #'moon/sync-nlinum-relative-current-line-face)
  (when moon-enable-nlinum-relative
    (nlinum-relative-setup-evil)
    (global-nlinum-relative-mode 1)
    (moon/sync-nlinum-relative-current-line-face)
    ;; minimun delay makes sure
    ;; line number doesn't update when scrolling
    (setq nlinum-relative-redisplay-delay 0.1)))

;;;;
;;;; Misc

(use-package| nyan-mode
  :init (setq nyan-wavy-trail t
              nyan-bar-length 12))

(use-package| hl-todo
  :defer 3
  :config
  (add-to-list 'hl-todo-keyword-faces
               '("TOTEST" . "#d0bf8f"))
  (global-hl-todo-mode))

(post-config| general
  (moon-default-leader
    "tl" #'nlinum-mode ; toggle relative linum
    "tL" #'global-display-line-numbers-mode))

;; form feed
(use-package| form-feed
  :defer 3
  :config
  (defface form-feed-line
    `((((type graphic)
        (background light)) :strike-through ,spacemacs-light-purple)
      (((type graphic)
        (background dark)) :strike-through ,doom-blue)
      (((type tty)) :inherit font-lock-comment-face :underline t))
    "Face for form-feed-mode lines."
    :group 'form-feed))


;; I don't show minor mode
;; in modeline anymore

;; (use-package| dim
;;   :after powerline
;;   :config
;;   (dim-minor-names
;;    '((eldoc-mode "" eldoc)
;;      (auto-revert-mode "" autorevert)
;;      (visual-line-mode "" simple)
;;      (evil-escape-mode "" evil-escape)
;;      (undo-tree-mode "" undo-tree)
;;      (which-key-mode "" which-key)
;;      (company-mode " Ⓒ" company)
;;      (flycheck-mode " ⓕ" flycheck)
;;      (ivy-mode " ⓘ" ivy)
;;      (lsp-mode " Ⓛ" lsp)
;;      (lispyville-mode " ⓟ" lispyville)
;;      (highlight-parentheses-mode "")
;;      (counsel-mode "" counsel)
;;      (flyspell-mode " Ⓢ" flyspell)
;;      ))
;;   )


;;;;
;;;; Desktop, Windows & buffer

(use-package| buffer-move
  :commands
  (buf-move-up
   buf-move-dowan
   buf-move-left
   buf-move-right))

(global-set-key (kbd "C-x C-h") #'buf-move-left)
(global-set-key (kbd "C-x C-l") #'buf-move-right)
(global-set-key (kbd "C-x C-j") #'buf-move-down)
(global-set-key (kbd "C-x C-k") #'buf-move-up)

(use-package| eyebrowse
  :commands
  (
   eyebrowse-switch-to-window-config-1
   eyebrowse-switch-to-window-config-2
   eyebrowse-switch-to-window-config-3
   eyebrowse-switch-to-window-config-4
   eyebrowse-switch-to-window-config-5
   eyebrowse-switch-to-window-config-6
   )
  :config
  (eyebrowse-mode 1)
  ;; default was ", "
  (setq eyebrowse-mode-line-separator " ")
  )


(use-package| winum
  :init (setq winum-auto-setup-mode-line nil)
  :config (winum-mode 1))

(post-config| general
  (moon-default-leader
    ;; eyebrowse
    "ww"  #'delete-other-windows
    "w1"  #'eyebrowse-switch-to-window-config-1
    "w2"  #'eyebrowse-switch-to-window-config-2
    "w3"  #'eyebrowse-switch-to-window-config-3
    "w4"  #'eyebrowse-switch-to-window-config-4
    "w5"  #'eyebrowse-switch-to-window-config-5
    "w6"  #'eyebrowse-switch-to-window-config-6
    "wD"  #'eyebrowse-close-window-config
    ;; winum
    "w0"   #'delete-window
    "1"   #'moon/switch-to-window-1
    "2"   #'moon/switch-to-window-2
    "3"   #'moon/switch-to-window-3
    "4"   #'moon/switch-to-window-4
    "5"   #'moon/switch-to-window-5
    "6"   #'moon/switch-to-window-6
    "7"   #'moon/switch-to-window-7
    "8"   #'moon/switch-to-window-8
    "9"   #'moon/switch-to-window-9
    "wk"  '(:ignore t :which-key "kill buffer in window")
    "wk1" #'moon/kill-buffer-in-window-1
    "wk2" #'moon/kill-buffer-in-window-2
    "wk3" #'moon/kill-buffer-in-window-3
    "wk4" #'moon/kill-buffer-in-window-4
    "wk5" #'moon/kill-buffer-in-window-5
    "wk6" #'moon/kill-buffer-in-window-6
    "wk7" #'moon/kill-buffer-in-window-7
    "wk8" #'moon/kill-buffer-in-window-8
    "wk9" #'moon/kill-buffer-in-window-9
    "wd"  '(:ignore t :which-key "delete window")
    "wd1" (lambda () (interactive) (winum-select-window-1 -1))
    "wd2" (lambda () (interactive) (winum-select-window-2 -1))
    "wd3" (lambda () (interactive) (winum-select-window-3 -1))
    "wd4" (lambda () (interactive) (winum-select-window-4 -1))
    "wd5" (lambda () (interactive) (winum-select-window-5 -1))
    "wd6" (lambda () (interactive) (winum-select-window-6 -1))
    "wd7" (lambda () (interactive) (winum-select-window-7 -1))
    "wd8" (lambda () (interactive) (winum-select-window-8 -1))
    "wd9" (lambda () (interactive) (winum-select-window-9 -1))
    ))


(post-config| which-key
  ;; create a fake key to represent all ten winum function
  (push '(("\\(.*\\) 1" . "moon/switch-to-window-1") . ("\\1 1..9" . "window 1..9")) which-key-replacement-alist)
  ;; hide other keys
  (push '((nil . "moon/switch-to-window-[2-9]") . t) which-key-replacement-alist)

  ;; create a fake key to represent all ten eyebrowse function
  (push '(("\\(.*\\) 1" . "eyebrowse-switch-to-window-config-1") . ("\\1 1..9" . "workspace 1..9")) which-key-replacement-alist)
  ;; hide other keys
  (push '((nil . "eyebrowse-switch-to-window-config-[2-9]") . t) which-key-replacement-alist)

  ;; create a fake key to represent all ten eyebrowse function
  (push '(("\\(.*\\) 1" . "moon/kill-buffer-in-window-[1-9]") . ("\\1 1..9" . "kill buffer in window 1..9")) which-key-replacement-alist)
  ;; hide other keys
  (push '((nil . "moon/kill-buffer-in-window-[2-9]") . t) which-key-replacement-alist)
  )


;;;;
;;;; Desktop resume

(post-config| general
  (moon-default-leader
    "wr" #'moon/desktop-read))

(add-hook 'moon-post-init-hook #'moon-setup-save-session)

;; copied from
;; https://gist.github.com/syl20bnr/4425094
(defun moon-setup-save-session ()
  "Setup desktop-save-mode.

Don't bother me with annoying prompts when reading
and saveing desktop."
  ;; (when (not (eq (emacs-pid) (desktop-owner))) ; Check that emacs did not load a desktop yet

    (desktop-save-mode 1) ; activate desktop mode
    (setq desktop-save t) ; always save
    ;; The default desktop is loaded anyway if it is locked
    (setq desktop-load-locked-desktop t)
    ;; Set the location to save/load default desktop
    (setq desktop-dirname moon-local-dir)

    ;; Make sure that even if emacs or OS crashed, emacs
    ;; still have last opened files.
    (add-hook 'find-file-hook
     (lambda ()
       (run-with-timer 5 nil
          (lambda ()
            ;; Reset desktop modification time so the user is not bothered
            (setq desktop-file-modtime (nth 5 (file-attributes (desktop-full-file-name))))
            (desktop-save moon-local-dir)))))

    ;; Add a hook when emacs is closed to we reset the desktop
    ;; modification time (in this way the user does not get a warning
    ;; message about desktop modifications)
    (add-hook 'kill-emacs-hook
              (lambda ()
                ;; Reset desktop modification time so the user is not bothered
                (setq desktop-file-modtime (nth 5 (file-attributes (desktop-full-file-name))))))
    ;; )
)


;;;;
;;;; Tab

(use-package| nerdtab
  :defer 2
  :config
  (setq nerdtab-window-position 'top)
  (dolist (index (number-sequence 0 9))
    (global-set-key (kbd (format "s-%d" index)) (intern (format "nerdtab-jump-%d" index))))
  (dolist (index (number-sequence 0 9))
    (global-set-key (kbd (format "C-s-%d" index)) (intern (format "nerdtab-kill-%d" index)))))

(post-config| general
  (moon-default-leader
    "tb" #'nerdtab-mode
    "bj" #'nerdtab-jump
    "bM" '(:ignore t :which-key "move tab to ")
    "bM0" #'nerdtab-move-to-0
    "bM1" #'nerdtab-move-to-1
    "bM2" #'nerdtab-move-to-2
    "bM3" #'nerdtab-move-to-3
    "bM4" #'nerdtab-move-to-4
    "bM5" #'nerdtab-move-to-5
    "bM6" #'nerdtab-move-to-6
    "bM7" #'nerdtab-move-to-7
    "bM8" #'nerdtab-move-to-8
    "bM9" #'nerdtab-move-to-9))


;;;;
;;;; Syntax

(defun moon-highlight-symbol ()
  "Hightlight symbol at point."
  (interactive)
  (evil-ex-search-activate-highlight `(,(thing-at-point 'symbol) t t)))

(post-config| general
  (moon-default-leader
    "ah" #'moon-highlight-symbol))

;;
;; auto highlight
;;

(defvar moon-auto-highlight nil
  "Wehther to highlight symbol at point after a delay.")

(defun moon-auto-highlight ()
  "Hightlight thing at point."
  (evil-ex-search-activate-highlight `(,(thing-at-point 'symbol) t t))
  (add-hook 'pre-command-hook #'moon-auto-highlight-hook))


(defun moon-auto-highlight-hook ()
  "Clean hightlight and remove self from `pre-command-hook'."
    (evil-ex-nohighlight)
    (remove-hook 'pre-command-hook #'moon-auto-highlight-hook))

(defvar moon-auto-highlight-timer nil
  "Idle timer of moon-auto-hightlight-mode.")

(define-minor-mode moon-auto-highlight-mode
  "Highlight symbol at point automatically after a delay."
  :global
  :lighter "AutoH"
  (if moon-auto-highlight-mode
      (setq moon-auto-highlight-timer (run-with-idle-timer 1 t #'moon-auto-highlight))
    (cancel-timer moon-auto-highlight-timer)))
