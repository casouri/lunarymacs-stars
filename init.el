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
       ;; ivy
       helm
       company
       snippet
       :os
       mac
       :utility
       ;; email
       markdown
       ;; eshell
       shell
       tex
       dir
       git
       org
       pdf
       ;; imagemagick
       :checker
       syntax
       spell
       :lang
       lsp
       general
       assembly
       ;; arduino
       matlab
       java
       common-lisp
       cc
       python
       elisp
       ;; rust
       javascript
       web
       lua
       yaml
       )


;;
;;; Settings evaluate befor loading any stars i.e. user-init
;;

;; here are all the settings that I might change depends on mood.
;; I put them here so I can change them easily

(unless moon-setup

  ;;;; Lsp backend
  (setq moon-lsp 'eglot)

  ;;;; speed up for long lines
  (setq bidi-display-reordering nil)

  ;;;; email
  (setq user-mail-address "casouri@gmail.com")
  ;;;; max
  (toggle-frame-maximized)

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

  ;;;; Cursor shape
  ;; (setq-default cursor-type 'bar)

  ;; (setq use-package-verbose t)

  ;;;; Window margin
  ;; (setq-default left-margin-width 3)
  )


;;
;;; Settings to overwrite configs in stars i.e. user-config
;;

(customize| 

 ;;;; theme
 (setq doom-cyberpunk-dark-mode-line nil)
 (if moon-theme
     (moon-load-theme moon-theme t)
   (moon-load-theme 'doom-cyberpunk t))
 
 ;;;; Faster long lines
 (setq-default bidi-display-reordering nil)

 ;;;; format on save
 (setq moon-format-on-save t)

 ;;;; scroll margin
 (setq scroll-margin 4)

 ;;;; Font
 (moon/load-font)

 ;;;;; Chinese

 ;; 馬
 ;; WenYue GuDianMingChaoTi (Non-Commercial Use) W5
 ;; WenYue XHGuYaSong (Non-Commercial Use)
 ;; WenyueType GutiFangsong (Non-Commercial Use)
 ;; SiaoyiWangMingBold
 ;; FZQingKeBenYueSongS-R-GB
 ;; FZSongKeBenXiuKaiS-R-GB

 ;; | 对齐 |
 ;; | good |

 (moon/load-cjk-font)

 (when moon-font
   (add-to-list 'face-font-rescale-alist
                (cons (plist-get (alist-get (intern moon-cjk-font)
                                            moon-cjk-font-alist)
                                 :family)
                      1.3)))

 ;;;;; Emoji
 ;; (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji")
 ;;                   nil 'prepend)

 ;;;; nyan
 ;; (nyan-lite-mode)
 ;; (setq nyan-wavy-trail t)
 ;; enabling this makes highlight on buttons blink
 ;; (nyan-start-animation)

 ;; (awesome-tab-mode)

 (run-with-idle-timer 2 nil (lambda () (winner-mode)))
 ;;
 ;;; customize ends here
 )
(put 'erase-buffer 'disabled nil)
