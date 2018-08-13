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

(use-package| esh-autosuggest
  :hook (eshell-mode . esh-autosuggest-mode))

;;; Config

(setq eshell-directory-name (concat moon-star-dir "utility/eshell/"))

(defun eshell-sync-dir-buffer-name ()
  "Change eshell buffer name by directory change."
  (when (equal major-mode 'eshell-mode)
    (rename-buffer (format "Esh: %s"
                           (let ((dir (abbreviate-file-name default-directory)))
                             (put-text-property 0 (length dir) 'face `(:foreground ,lunary-pink) dir)
                             dir))
                   t)))

(add-hook 'eshell-directory-change-hook #'eshell-sync-dir-buffer-name)

(post-config| general
  (moon-default-leader
   "us" #'eshell))
