;;; config.el --- Config specific to Mac      -*- lexical-binding: t; -*-

;;; Commentary:
;; 

;;; Code:
;;

;; (setq exec-path (append exec-path (split-string (getenv "PATH") ":")))

;; on mac, double click touch pad is considered mouse-3,
;; but most functions bound to mouse-2
(define-key input-decode-map [mouse-3] [mouse-2])

;;; config.el ends here
