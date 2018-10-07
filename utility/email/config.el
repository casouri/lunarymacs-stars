;;; config.el --- Email client      -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Yuan Fu

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs


;;; Commentary:
;;

;;; Code:
;;

;;; Keys

(post-config| general
  (moon-default-leader
    "uw" #'wl))


;;; MUA

(use-package| wanderlust
  :commands wl)

;;; Contacts

(use-package| bbdb
  :defer t
  ;; http://emacs-fu.blogspot.com/2009/08/managing-e-mail-addresses-with-bbdb.html
  :init
  (setq bbdb-file (concat moon-star-dir "utility/email/bbdb"))
  :config
  (require 'bbdb-wl)
  (bbdb-initialize 'wl)
  (setq
   bbdb-wl-folder-regexp    ;; get addresses only from these folders
   "^\.inbox$\\|^.sent")
  (setq
   bbdb-offer-save 1                        ;; 1 means save-without-asking

   bbdb-use-pop-up t                        ;; allow popups for addresses
   bbdb-electric-p t                        ;; be disposable with SPC
   bbdb-popup-target-lines  1               ;; very small

   bbdb-dwim-net-address-allow-redundancy t ;; always use full name
   bbdb-quiet-about-name-mismatches 2       ;; show name-mismatches 2 secs

   bbdb-always-add-address t                ;; add new addresses to existing...
   ;; ...contacts automatically
   bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx

   bbdb-completion-type nil                 ;; complete on anything

   bbdb-complete-name-allow-cycling t       ;; cycle through matches
   ;; this only works partially

   bbbd-message-caching-enabled t           ;; be fast
   bbdb-use-alternate-names t               ;; use AKA


   bbdb-elided-display t                    ;; single-line addresses

   ;; auto-create addresses from mail
   bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook

   ;; don't ask about fake addresses
   ;; NOTE: there can be only one entry per header (such as To, From)
   ;; http://flex.ee.uec.ac.jp/texi/bbdb/bbdb_11.html
   bbdb-ignore-some-messages-alist
   '(( "From" . "no.?reply\\|DAEMON\\|daemon\\|facebookmail\\|twitter")))
  )

;;; config.el ends here
