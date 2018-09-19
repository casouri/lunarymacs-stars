;; -*- lexical-binding: t -*-

;;;
;;; Config
;;;

(global-hl-line-mode 1)

(add-hook 'prog-mode-hook #'hs-minor-mode)

;;;
;;; Package
;;;

(use-package| atom-one-dark-theme
  :defer t
  :config
  ;; (set-face-attribute 'company-tooltip-common nil :foreground "#C678DD")
  (with-eval-after-load 'company (set-face-attribute 'company-tooltip-common-selection nil :foreground "#C678DD"))
  ;; (set-face-attribute 'company-preview-common nil :foreground "#C678DD")
  )

(use-package| doom-themes
  :config
  (add-to-list 'moon-toggle-theme-list 'doom-one)
  (add-to-list 'moon-toggle-theme-list 'doom-one-light t)
  (add-hook 'moon-load-theme-hook
            (lambda ()
              (when (equal moon-current-theme
                           "doom-one")
                (set-face-attribute 'mode-line nil :background "#603D8E")
                (set-face-attribute 'lazy-highlight nil :inherit 'default :background nil :foreground "#CFD7E5" :distant-foreground nil)))
            ;; (set-face-attribute 'company-tooltip-common-selection nil :foreground "#C678DD")
            ))

(use-package| spacemacs-theme
  :defer t
  :config
  (add-to-list 'custom-theme-load-path (car (directory-files moon-package-dir "spacemacs-theme.+")) t)
  (custom-set-variables '(spacemacs-theme-custom-colors ;                          ~~GUI~~   ~~TER~~                       ~~GUI~~   ~~TER~~
                          '((bg1        . (if (eq variant 'dark) (if (true-color-p) "#222226" "#262626") (if (true-color-p) "#fbf8ef" "#ffffff")))
                            (bg2        . (if (eq variant 'dark) (if (true-color-p) "#17181B" "#1c1c1c") (if (true-color-p) "#efeae9" "#e4e4e4")))
                            (comment-bg . (if (eq variant 'dark) (if (true-color-p) "#23282A" "#262626") (if (true-color-p) "#ecf3ec" "#ffffff")))
                            (highlight  . (if (eq variant 'dark) (if (true-color-p) "#61526E" "#444444") (if (true-color-p) "#d3d3e7" "#d7d7ff")))
                            (act2       . (if (eq variant 'dark) (if (true-color-p) "#603D8E" "#444444") (if (true-color-p) "#d3d3e7" "#d7d7ff")))
                            (border     . (if (eq variant 'dark) (if (true-color-p) "#603D8E" "#444444") (if (true-color-p) "#d3d3e7" "#d7d7ff")))
                            ))))

(use-package| rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package| poet-theme
  :defer t)

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

(package| minions)

(use-package| moody
  :config
  (setq moody-slant-function #'moody-slant-apple-rgb)
  (setq x-underline-at-descent-line t)
  (moon/setup-moody)
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

;; form feed
(use-package| form-feed
  :commands form-feed-mode
  :config
  (defface form-feed-line
    `((((type graphic)
        (background light)) :strike-through ,spacemacs-light-purple)
      (((type graphic)
        (background dark)) :strike-through ,doom-blue)
      (((type tty)) :inherit font-lock-comment-face :underline t))
    "Face for form-feed-mode lines."
    :group 'form-feed))


;;;;
;;;; Desktop, Windows & buffer

(use-package| buffer-move
  :commands
  (buf-move-up
   buf-move-dowan
   buf-move-left
   buf-move-right))

(use-package| eyebrowse
  :commands
  (eyebrowse-switch-to-window-config-1
   eyebrowse-switch-to-window-config-2
   eyebrowse-switch-to-window-config-3
   eyebrowse-switch-to-window-config-4
   eyebrowse-switch-to-window-config-5
   eyebrowse-switch-to-window-config-6)
  :config
  (eyebrowse-mode 1)
  ;; default was ", "
  (setq eyebrowse-mode-line-separator " "))


;;;;
;;;; Desktop resume

(post-config| general
  (moon-default-leader
    "wr" #'moon/desktop-read))

(add-hook 'moon-startup-hook-2 #'moon-setup-save-session t)

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



;;;; Tab
;;

(use-package| (awesome-tab :fetcher github :repo "manateelazycat/awesome-tab")
  :defer t
  :config
  (setq tabbar-active-color "#c678dd")
  (setq tabbar-inactive-color "gray")
  (set-face-attribute 'tabbar-default nil :inheirt 'default))

(define-minor-mode awesome-tab-mode
  "Inproved tabbar mode"
  :lighter "AWT"
  (if awesome-tab-mode
      (progn
        (require 'awesome-tab)
        (tabbar-mode))
    (tabbar-mode -1)))


;;;; Syntax
;;

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

;;
;;;; VC

;; not autoloaded
(use-package| diff-hl
  :defer t
  :init
  (add-hook 'after-change-major-mode-hook
            (lambda ()
              "Enable `diff-hl-mode' or `diff-hl-margin-mode'."
              (require 'diff-hl)
              (if window-system
                  (diff-hl-mode)
                (diff-hl-margin-mode))))
  :config
  (setq diff-hl-draw-borders nil)
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))
