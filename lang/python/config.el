;; -*- lexical-binding: t -*-



;;; Config

;;;; LSP

(moon-lsp/eglot
 (progn
   (add-hook 'python-mode-hook #'lsp t)
   (push '(python-mode . lsp-format-buffer) moon-smart-format-alist))
 (progn
   (add-hook 'python-mode-hook #'eglot-ensure)
   (push '(python-mode . eglot-format-buffer) moon-smart-format-alist)))

;;;; Virtual env

(use-package| pyvenv
  :config (setq pyvenv-mode-line-indicator
                '(pyvenv-virtual-env-name
                  (" [py: " pyvenv-virtual-env-name "]")))
  :commands pyvenv-activate)

;;;; Exec path

;; set this to a absolute path then pyvenv won't work
;; because it sets environment, but this variable
(customize-set-value 'python-shell-interpreter "python3")

;;;; Quickrun
;;
;; note this is set after setting exec path

(post-config| quickrun
  (quickrun-add-command "python"
    '((:command . (lambda () python-shell-interpreter))
      (:description . "Run python with binary in `python-shell-interpreter'."))
    :override t))

;;;; Mode line
;;
;; The mode line segment shows current python executable
;; hover text is the full path
;; clicking it opens the customize panel for `python-shell-interpreter'
;;
;; pyvenv displays the virtual env

(defvar moon-python-mode-line-map (let ((map (make-sparse-keymap)))
                                    (define-key map (vector 'mode-line 'down-mouse-1)
                                      (lambda ()
                                        (interactive)
                                        (customize-apropos "python-shell-interpreter")))
                                    map))

(defun moon-python-exec-mode-line ()
  "Return a mode line segment for python executable."
  (propertize (file-name-base python-shell-interpreter)
              'help-echo (executable-find python-shell-interpreter)
              'keymap moon-python-mode-line-map))

(add-to-list 'mode-line-misc-info
             '(:eval (if (eq major-mode 'python-mode)
                         (list "  " (moon-python-exec-mode-line) "  "))
                     ""))

(add-to-list 'mode-line-misc-info
             '(:eval (if (and (eq major-mode 'python-mode) (featurep 'pyvenv))
                         (list "  " pyvenv-mode-line-indicator "  ")
                       "")))
