;;; eglot.el --- Eglot Config      -*- lexical-binding: t; -*-


;;; Commentary:
;;

;;; Code:
;;

;;; Keys

(post-config| general
  (moon-default-leader
    "l f" #'eglot-format-buffer
    "l R" #'eglot-rename
    "l d" #'xref-find-definitions
    "l r" #'xref-find-references
    "l k" #'eldoc-box-quit-frame
    "l s" #'eldoc-box-show-frame)
  (general-define-key
   "C-h C-h" #'eldoc-box-eglot-help-at-point))

;;; Packages

(use-package| eglot
  :defer t
  :config
  ;; don't pop doc in minibuffer on hover
  (add-to-list 'eglot-ignored-server-capabilites :hoverProvider))

(use-package| eldoc-box
  :commands (eldoc-box-hover-mode
             eldoc-box-eglot-help-at-point
             eldoc-box-helpful-callable
             eldoc-box-helpful-variable
             eldoc-box-helpful-key)
  :init
  ;; (add-hook 'eglot--managed-mode-hook #'eldoc-box-hover-mode t)
  (setq eldoc-box-cleanup-interval 0.2))

;;; Function

;;;; ElDoc-Box

;;;;; Helpful

(defun eldoc-box-helpful-variable (symbol)
  "Show help for variable named SYMBOL."
  (interactive
   (list (helpful--read-symbol "Variable: " #'helpful--variable-p)))
  (let ((buffer (helpful--buffer symbol nil)))
    (with-current-buffer buffer
      (helpful-update)
      (setq mode-line-format nil))
    (eldoc-box--get-frame buffer)))

(defun eldoc-box-helpful-callable (symbol)
  "Show help for function, macro or special form named SYMBOL.

See also `helpful-macro' and `helpful-function'."
  (interactive
   (list (helpful--read-symbol "Callable: " #'fboundp)))
  (let ((buffer (helpful--buffer symbol t)))
    (with-current-buffer buffer
      (helpful-update)
      (setq mode-line-format nil))
    (eldoc-box--get-frame buffer)))

(defun eldoc-box-helpful-key (key-sequence)
  "Show help for interactive command bound to KEY-SEQUENCE."
  (interactive
   (list (read-key-sequence "Press key: ")))
  (let ((sym (key-binding key-sequence)))
    (cond
     ((null sym)
      (user-error "No command is bound to %s"
                  (key-description key-sequence)))
     ((commandp sym)
      (let ((buffer (helpful--buffer sym t)))
        (with-current-buffer buffer
          (helpful-update)
          (setq mode-line-format nil))
        (eldoc-box--get-frame buffer)))
     (t
      (user-error "%s is bound to %s which is not a command"
                  (key-description key-sequence)
                  sym)))))

(defun eldoc-box-show-frame ()
  "Show childframe."
  (interactive)
  (make-frame-visible eldoc-box--frame))

;;; eglot.el ends here
