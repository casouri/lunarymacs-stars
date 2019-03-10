;;; config.el --- Shell      -*- lexical-binding: t; -*-

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs

;;; Commentary:
;;

;;; Code:
;;

(post-config| general
  (moon-default-leader
    "y" '(:ignore t :which-key "fshell")
    "ys" #'fshell-switch-buffer
    "yn" #'fshell-next
    "yp" #'fshell-prev
    "yN" #'fshell-new)
  (general-define-key
   "s-e" #'fshell-toggle))

(use-package| fshell
  :commands (fshell-switch-buffer
             fshell-next
             fshell-prev
             fshell-new
             fshell
             fshell-toggle))

;; (use-package| vterm
;;   :init
;;   (add-hook 'load-path "~/attic/emacs-libvterm")
;;   (setq vterm-shell "zsh")
;;   :commands vterm
;;   :config
;;   (define-key vterm-mode-map (kbd "C-p") nil)
;;   (define-key vterm-mode-map (kbd "C-n") nil)
;;   (define-key vterm-mode-map (kbd "C-e") nil)
;;   (define-key vterm-mode-map (kbd "<backspace>") #'vterm--self-insert))


;; (defun toggle-vterm ()
;;   (interactive)
;;   (if (eql major-mode 'vterm-mode)
;;       (while (eql major-mode 'vterm-mode)
;;         (switch-to-prev-buffer))
;;     (let ((buf-lst (buffer-list))
;;           found)
;;       (if (dolist (buf buf-lst found)
;;             (when (eql (buffer-local-value 'major-mode buf)
;;                        'vterm-mode)
;;               (switch-to-buffer buf)
;;               (setq found t)))
;;           nil
;;         (vterm)))))


;;; config.el ends here
