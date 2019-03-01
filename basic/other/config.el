;; -*- lexical-binding: t -*-


;;
;; Config
;;

(fset #'yes-or-no-p #'y-or-n-p) ; y/n instead of yes/no

(setq-default
 ad-redefinition-action              'accept                               ; silence advised function warnings
 apropos-do-all                      t                                     ; make `apropos' more useful
 compilation-always-kill             t                                     ; kill compilation process before starting another
 compilation-ask-about-save          nil                                   ; save all buffers on `compile'
 confirm-nonexistent-file-or-buffer  t
 enable-recursive-minibuffers        nil
 idle-update-delay                   2                                     ; update ui less often

 ;; keep the point out of the minibuffer
 minibuffer-prompt-properties        '(read-only
                                       t
                                       point-entered
                                       minibuffer-avoid-prompt
                                       face
                                       minibuffer-prompt)

 create-lockfiles                    nil
 history-length                      500
 make-backup-files                   t
 auto-save-default                   t
 backup-directory-alist              `((".*" . ,moon-cache-dir))
 auto-save-file-name-transforms      `((".*" ,moon-cache-dir t))
 auto-save-list-file-name            (concat moon-cache-dir "autosave")
 auto-save-timeout                   5

 ;; files
 abbrev-file-name                    (concat moon-local-dir "abbrev.el")
 recentf-save-file                   (concat moon-local-dir "recentf")
 recentf-max-saved-items             300
 tramp-persistency-file-name         (concat moon-local-dir "tramp")
 bookmark-default-file               (concat moon-local-dir "bookmarks")
 delete-by-moving-to-trash           t
 savehist-file                       (concat moon-local-dir "history")
 
 ;; edit
 indent-tabs-mode                    nil
 backup-inhibited                    t
 sentence-end-double-space           nil
 kill-ring-max                       200

 ;; ui
 use-dialog-box                      nil
 visible-cursor                      nil
 use-dialog-box                      nil
 ring-bell-function                  #'ignore
 visible-bell                        nil
 frame-title-format                  '("%f")                                 ; current file name
 display-line-numbers-width          3
 ;; Popup window to right!
 split-height-threshold              nil
 ;; split-width-threshold               200
 ns-use-proxy-icon                   nil

 ;; minibuffer
 enable-recursive-minibuffers        t
 )

(blink-cursor-mode                   -1)

;;;; natural title bar
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))

;;;; don't open new frame
(setq ns-pop-up-frames nil)

;;;; "Dangerous Commands"
(put 'narrow-to-page 'disabled nil)

;;;; Cowboy recipe
(this-dir| this-dir
           (when moon-setup
             (moon-safe-load (expand-file-name "cowboy-recipe.el" this-dir))))

(this-dir| this-dir
           (defun moon-load-cowboy ()
             "Get cowboy ready."
             (interactive)
             (require 'cowboy)
             (moon-safe-load (expand-file-name "cowboy-recipe.el" this-dir))))

;;;; Save history
(savehist-mode)
(add-to-list 'savehist-additional-variables 'extended-command-history)
