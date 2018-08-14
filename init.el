;;(package-initialize t)

(load (concat (expand-file-name user-emacs-directory) "core/core"))

(moon| :basic
       ;; non-evil
       homepage
       key
       evil
       ui
       other
       edit
       project
       addon
       :completion
       ivy
       company
       snippet
       :os
       mac
       :utility
       eshell
       tex
       dir
       git
       org
       ;; imagemagick
       :checker
       syntax
       spell
       :lang
       cc
       lsp
       python
       elisp
       ;; rust
       javascript
       web
       ;; lua
       )


;;
;;; Settings evaluate befor loading any stars i.e. user-init
;;

;; here are all the settings that I might change depends on mood.
;; I put them here so I can change them easily


;;;; max
(toggle-frame-maximized)


;;;; natural title bar
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;;;; Python interpreter
(setq python-shell-interpreter "/usr/local/bin/python3")

;;;; shell
(setq explicit-shell-file-name "/bin/zsh")
(setq explicit-zsh-args '("--login"))
(setenv "SHELL" "zsh")

;;;; split screen vertically in ediff
(setq ediff-split-window-function #'split-window-horizontally)

;;;; relative line number
;; (setq moon-enable-nlinum-relative t)

;;;; absolute line number
;; (global-display-line-numbers-mode)

;;;; company-yasnippet
(setq moon-enable-company-yas t)

;;;; cursor

(defun moon-ensure-cursor-color ()
  "Sometimes cursor color \"run around\". This function fix it."
  (set-cursor-color
   (if (or (bound-and-true-p evil-local-mode)
           (bound-and-true-p evil-mode))
       (if (equal evil-state 'insert)
           lunary-white
         lunary-yellow)
     doom-blue)))

(when window-system
  (setq evil-insert-state-cursor 'box))

(add-hook 'post-command-hook #'moon-ensure-cursor-color)
(add-hook 'window-configuration-change-hook (lambda () (run-at-time 0.1 nil #'moon-ensure-cursor-color)))

;; (when window-system
;;   (setq evil-insert-state-cursor `(box ,lunary-white)))
;; (setq evil-normal-state-cursor lunary-yellow)

;;;; modifier key mapping
;; (setq mac-command-modifier 'control)
;; (setq mac-control-modifier 'super)
;; (global-set-key (kbd "s-v") #'yank)
;; (global-set-key (kbd "s-c") #'kill-ring-save)

;;;; don't open new frame
(setq ns-pop-up-frames nil)

;;;; server
(run-with-idle-timer 2 nil #'server-start)

;;;; Homepage
(setq moon-image-moon "moon-200.xpm")
;; (setq moon-log-news t)
;; (setq moon-do-draw-footer t)
;; (setq moon-do-draw-image-moon t)

;;
;;; Settings to overwrite configs in stars i.e. user-config
;;

(customize| 

 ;; theme toggle
 ;; (setq moon-toggle-theme-list '(spacemacs-dark spacemacs-light))

 ;;;; theme
 (require 'atom-one-dark-theme)
 (require 'doom-themes)
 (load-theme 'doom-one t)


 ;;;; format on save
 (setq moon-format-on-save t)

 ;;;; scroll margin
 (setq scroll-margin 8)

 ;;;; hide bad title when using natural title bar in Emacs 26
 ;; (setq  frame-title-format '(" "))


 ;;;; Font
 ;; (moon-set-font| :family "Source Code Pro" :weight 'light :size 14)
 (moon-set-font| :family "SF Mono" :weight 'light :size 13)

 ;;;; nyan
 (nyan-mode)
 ;; enabling this makes highlight on buttons blink
 ;; (nyan-start-animation)

 ;; it slows down starup, disable for now
 ;;;; company-childframe
 ;; (load (concat moon-emacs-d-dir "star/completion/company/posframe/posframe"))
 ;; (load (concat moon-emacs-d-dir "star/completion/company/company-childframe/company-childframe"))
 ;; (company-childframe-mode 1)

 ;; (org-mode)

 ;;
 ;;; customize ends here
 )

;;; esup
;; (moon-finalize)
