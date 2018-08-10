(post-config| general
  (moon-default-leader
    "C-o s" (lambda () "Open in eshell." (interactive) (eshell default-directory)))
  (general-define-key
   :prefix "C-c"
   :keymap 'eshell-mode-map
   "C-h" #'counsel-eshell))

;; https://github.com/manuel-uberti/.emacs.d/commit/d44051ef417aee2086ba05e5a514e0ce6c401ca7
(defun counsel-eshell ()
  "Browse Eshell history."
  (interactive)
  (setq ivy-completion-beg (point))
  (setq ivy-completion-end (point))
  (ivy-read "Symbol name: "
            (delete-dups
             (ring-elements eshell-history-ring))
            :action #'ivy-completion-in-region-action))

;;; Config

(setq eshell-directory-name (concat moon-star-dir "utility/eshell/"))
