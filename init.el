;;(package-initialize t)

(defvar moon-setup nil)

(if moon-setup
    (load (concat (expand-file-name user-emacs-directory) "core/core-setup.el"))
  (load (concat (expand-file-name user-emacs-directory) "core/core-startup.el")))

(moon| :basic
       ;; non-evil
       homepage
       key
       ;; evil
       angel
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



  ;; (when window-system
  ;;   (setq evil-insert-state-cursor `(box ,lunary-white)))
  ;; (setq evil-normal-state-cursor lunary-yellow)

  ;;;; server
  (run-with-idle-timer 3 nil #'server-start)

  ;;;; Cursor shape
  ;; (setq-default cursor-type 'bar)

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
 ;; (moon-set-font| :family "Roboto Mono" :weight 'light :size 13)

 ;;;; nyan
 (nyan-mode)
 ;; enabling this makes highlight on buttons blink
 ;; (nyan-start-animation)

 ;;
 ;;; customize ends here
 )
