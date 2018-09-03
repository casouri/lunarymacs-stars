;;(package-initialize t)

(defvar moon-setup nil)

(if moon-setup
    (load (concat (expand-file-name user-emacs-directory) "core/core-setup.el"))
  (load (concat (expand-file-name user-emacs-directory) "core/core-startup.el")))

(moon| :basic
       ;; non-evil
       homepage
       key
       evil
       ui
       other
       edit
       project
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

(unless moon-setup
;;;; max
 (toggle-frame-maximized)

;;;; Python interpreter
 (setq python-shell-interpreter "/usr/local/bin/python3")

;;;; shell
 (setq explicit-shell-file-name "/bin/zsh")
 (setq explicit-zsh-args '("--login"))
 (setenv "SHELL" "zsh")


;;;; cursor

 (defun moon-ensure-cursor-color ()
   "Sometimes cursor color \"run around\". This function fixes it."
   (set-cursor-color
    (if (or (bound-and-true-p evil-local-mode)
            (bound-and-true-p evil-mode))
        (if (equal evil-state 'insert)
            lunary-white
          lunary-yellow)
      doom-blue)))

 (setq evil-insert-state-cursor (list (if window-system 'box 'bar) lunary-white)
       evil-normal-state-cursor lunary-yellow)

 ;; (add-hook 'post-command-hook #'moon-ensure-cursor-color)
 (add-hook 'window-configuration-change-hook (lambda () (run-at-time 0.1 nil #'moon-ensure-cursor-color)))
 (advice-add 'evil-local-mode :after (lambda (&rest _) "Ensure cursor color is correct." (moon-ensure-cursor-color)))

 ;; (when window-system
 ;;   (setq evil-insert-state-cursor `(box ,lunary-white)))
 ;; (setq evil-normal-state-cursor lunary-yellow)

;;;; server
 (run-with-idle-timer 2 nil #'server-start)

;;;; Homepage
 (setq moon-image-moon "moon-200.xpm")
 ;; (setq moon-log-news t)
 ;; (setq moon-do-draw-footer t)
 ;; (setq moon-do-draw-image-moon t)

 ;; (setq use-package-verbose t)
)


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

 ;;;; Font
 ;; (moon-set-font| :family "Source Code Pro" :weight 'light :size 14)
 (moon-set-font| :family "SF Mono" :weight 'light :size 13)

 ;;;; nyan
 (nyan-mode)
 ;; enabling this makes highlight on buttons blink
 ;; (nyan-start-animation)

 ;;
 ;;; customize ends here
 )
