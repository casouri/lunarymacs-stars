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
       email
       markdown
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
       general
       common-lisp
       cc
       lsp
       python
       elisp
       ;; rust
       javascript
       web
       lua
       )


;;
;;; Settings evaluate befor loading any stars i.e. user-init
;;

;; here are all the settings that I might change depends on mood.
;; I put them here so I can change them easily

(unless moon-setup

  ;;;; email
  (setq user-mail-address "casouri@gmail.com")
  ;;;; max
  (toggle-frame-maximized)

  ;;;; Python interpreter
  (setq python-shell-interpreter "/usr/local/bin/python3")

  ;;;; shell
  ;; (setq explicit-shell-file-name "/bin/zsh")
  ;; (setq explicit-zsh-args '("--login"))
  ;; (setenv "SHELL" "zsh")
  
  ;; (setq mac-command-modifier 'control
  ;; mac-function-modifier 'meta
  ;; mac-control-modifier 'super)

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
 ;; (require 'atom-one-dark-theme)
 (require 'doom-themes)
 (load-theme 'doom-one t)


 ;;;; format on save
 (setq moon-format-on-save t)

 ;;;; scroll margin
 ;; (setq scroll-margin 8)

 ;;;; Font
 ;; (moon-set-font| :family "Source Code Pro" :weight 'light :size 14)
 (moon-set-font| :family "SF Mono" :weight 'light :size 13)
 ;; (moon-set-font| :family "Roboto Mono" :weight 'light :size 13)

 ;;;;; Chinese
 (dolist (charset '(kana han symbol cjk-misc bopomofo))
   (set-fontset-font (frame-parameter nil 'font)
                     charset (font-spec :family "FZQingKeBenYueSongS-R-GB"
                                        :size 16)))
 ;; WenYue GuDianMingChaoTi
 ;; WenYue XHGuYaSong (Non-Commercial Use)
 ;; WenyueType GutiFangsong (Non-Commercial Use)
 ;; SiaoyiWangMingBold
 ;; FZQingKeBenYueSongS-R-GB
 ;; FZSongKeBenXiuKaiS-R-GB
 ;; 中文中文

 ;;;;; Emoji
 ;; (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji")
 ;;                   nil 'prepend)

 ;;;; nyan
 (nyan-mode)
 ;; enabling this makes highlight on buttons blink
 ;; (nyan-start-animation)

 ;; (awesome-tab-mode)

 (winner-mode)
 ;;
 ;;; customize ends here
 )
