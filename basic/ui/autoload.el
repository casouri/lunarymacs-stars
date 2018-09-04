;; -*- lexical-binding: t -*-

;;;###autoload
(defun moon/desktop-read ()
  "Recover desktop, i.e. recover last session."
  (interactive)
  (desktop-read moon-local-dir))


;;
;; Moody
;;

;;;###autoload
(defun flycheck-lighter (state bullet)
  "Return flycheck information for the given error type STATE."
  (let* ((counts (flycheck-count-errors flycheck-current-errors))
          (errorp (flycheck-has-current-errors-p state))
          (err (or (cdr (assq state counts)) "?"))
          (running (eq 'running flycheck-last-status-change)))
     (if (or errorp running) (format bullet err) "")))

;;;###autoload
(defun moon-edit-lighter ()
  (if (buffer-modified-p)
      "MOD "
    ""))

;;;###autoload
(defun moon-root-lighter ()
  (if (equal user-login-name "root")
      "ROOT "
    ""))

(defmacro make-lighter| (form empty-value empty-return)
  "Make a ligher for mode-line.

If FORM return EMPTY-VALUE(nil, \"\"), return EMPTY-RETURN,
else just return the form's return."
  `(let ((result ,form))
     (if (equal result ,empty-value)
         ,empty-return
       result)))

;;;###autoload
(defun moon/setup-moody ()
  "Setup mode-line using moody."
  (interactive)
  (let ((my-mode-line-format '(" "
                               (:eval (if (bound-and-true-p winum-mode) (winum-get-number-string) ""))
                               " "
                               (:eval (if (bound-and-true-p eyebrowse-mode) (eyebrowse-mode-line-indicator) ""))
                               " %I "
                               (:eval (moon-edit-lighter))
                               (:eval (moon-root-lighter))
                               ;; moody-mode-line-buffer-identification
                               (:eval (moody-tab "%b"))
                               " "
                               mode-line-modes
                               (when (bound-and-true-p 'flycheck-mode)
                                 (:eval (moody-tab (make-lighter| (concat (flycheck-lighter 'error "☠%s")
                                                                          (flycheck-lighter 'warning "⚠%s")
                                                                          (flycheck-lighter 'info "𝌆%s")) "" "OK") nil 'up)))
                               " "
                               (:eval (if (bound-and-true-p nyan-mode) (nyan-create) "%p"))
                               " "
                               ;; moody-vc-mode
                               (:eval (moody-tab (if vc-mode (substring-no-properties vc-mode 1) "NO VC")))
                               mode-line-misc-info
                               mode-line-end-spaces)))
    ;; change all current buffer's mode-line-format
    (save-excursion
      (mapc (lambda (buffer)
              (with-current-buffer buffer
                (setq mode-line-format my-mode-line-format)))
            (buffer-list)))
    ;; change default value of mode-line-format
    (setq-default mode-line-format my-mode-line-format)
    ))
