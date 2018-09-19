;;; config.el --- PATH and friends      -*- lexical-binding: t; -*-

;;; Commentary:
;; 

;;; Code:
;;

(defun get-path ()
  (let ((path-raw (shell-command-to-string "/usr/libexec/path_helper")))
    (string-match "PATH=\"\\(.+?\\)\"" path-raw)
    (match-string 1 path-raw)))

(let ((path (get-path)))
  (setenv "PATH" path)
  (setq exec-path (append exec-path (split-string path ":"))))


(load| path)

;;; config.el ends here
