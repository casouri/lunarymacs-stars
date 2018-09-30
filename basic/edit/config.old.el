;;; color-occur

(use-package| (color-moccur :fetcher url :url "http://www.emacswiki.org/emacs/download/color-moccur.el")
  :commands moccur)
(use-package| (moccur-edit :fetcher url :url "https://www.emacswiki.org/emacs/download/moccur-edit.el")
  :after color-moccur)


;;; switch input (doesn't work well)

;; (defun switch-input-minibuffer-hook ()
;;   "Switch to EN_US when minibuffer setup."

;;   (add-hook 'minibuffer-exit-hook #'switch-input-switch-back t t))

;; (defun switch-input-switch-back ()
;;   "Switch to ZH_CN when minibuffer exits."
;;   (remove-hook 'minibuffer-exit-hook #'switch-input-switch-back t)
;;   )

;; (define-minor-mode switch-input-mode
;;   "Switch input by prefix key and in minibuffer."
;;   :lighter "SIM"
;;   :global t
;;   (if switch-input-mode
;;       (add-hook 'minibuffer-setup-hook #'switch-input-minibuffer-hook)
;;     (remove-hook 'minibuffer-setup-hook #'switch-input-minibuffer-hook)))

;; (defvar switch-input-switch-script "tell application \"Hammerspoon\"
;; execute lua code \"switchInputMethod()\"
;; end tell"
;;   "The applescript to switch input method.")

;; (defvar switch-input-switch-back-script "tell application \"Hammerspoon\"
;; execute lua code \"switchInputMethodBack()\"
;; end tell"
;;   "The applescript to switch input method back.")
