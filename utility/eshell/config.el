(post-config| general
  (moon-default-leader
    "C-o s" (lambda () "Open in eshell." (interactive) (eshell default-directory))
    "us" #'counsel-switch-to-eshell-buffer)
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
(setq eshell-last-dir-ring-size 500)
(setq eshell-cp-interactive-query t
       eshell-ln-interactive-query t
       eshell-mv-interactive-query t
       eshell-rm-interactive-query t
       eshell-mv-overwrite-files nil)

(defvar default-system-name (system-name)
  "The system name of this computer.")

(setq eshell-prompt-regexp "^[^!λ\n]*[!λ] "
      eshell-prompt-function
      (lambda ()
        (concat
	 (unless (string= (system-name) default-system-name)
           (concat (user-login-name) "@ " (system-name)))
	 (propertize (abbreviate-file-name (eshell/pwd)) 'face '(:foreground "#98C379"))
	 (if (= (user-uid) 0)
             (propertize " ! " 'face '(:forground "#FA5754"))
           (propertize " λ " 'face '(:foreground "#51afef"))))))


;;;; Sync buffer name and pwd

(defun eshell-sync-dir-buffer-name ()
  "Change eshell buffer name by directory change."
  (when (equal major-mode 'eshell-mode)
    (rename-buffer (format "Esh: %s"
                           (let ((dir (abbreviate-file-name default-directory)))
                             (put-text-property 0 (length dir) 'face `(:foreground ,lunary-pink) dir)
                             dir))
                   t)))

(add-hook 'eshell-directory-change-hook #'eshell-sync-dir-buffer-name)
(add-hook 'eshell-mode-hook #'eshell-sync-dir-buffer-name)


;;;; Validate command

(defun moon-validate-command ()
  "Validate eshell command."
  (save-excursion
    (beginning-of-line)
    (re-search-forward (format "%s\\([^ ]*\\)" eshell-prompt-regexp)
                       (line-end-position)
                       t)
    (let ((beg (match-beginning 1))
          (end (match-end 1))
          (command (match-string 1)))
      (put-text-property beg end
       'face `(:foreground ,(if (executable-find command)
                                "#98C379"
                              mac-red))))))

(add-hook 'eshell-mode-hook (lambda ()
                              "Add `moon-validate-command' to `post-command-hook'."
                              (add-hook 'post-command-hook #'moon-validate-command t t)))

;;;; Swtich eshell

(after-load| counsel
  (defun counsel-switch-to-eshell-buffer ()
    "Switch to a shell buffer, or create one."
    (interactive)
    (ivy-read "Shell buffer: " (counsel--buffers-with-mode #'eshell-mode)
              :action #'counsel--switch-to-shell
              :caller 'counsel-switch-to-shell-buffer)))

;; I have pwd buffer name, no need for this

;; (defvar ivy-filthy-rich-switch-eshell-format
;;   '(((value . (lambda (_) _)) (prop . 0.4))
;;     ((value . (lambda (cand) (list (buffer-local-value 'default-directory (get-buffer cand)))))
;;      (prop . 0.6)
;;      (face . (:foreground "#98C379")))))

(defvar ivy-filthy-rich-switch-eshell-format
  `(((value . (lambda (_) _)) (prop . 0.6) (face . (:foreground ,lunary-pink)))))


(after-load| ivy-filthy-rich
  (add-to-list 'ivy-filthy-rich-transformer-alist
               (ivy-filthy-rich-make-transformer 'counsel-switch-to-eshell-buffer 'ivy-filthy-rich-switch-eshell-format)))
