(post-config| general
  (moon-default-leader
    "C-o s" (lambda () "Open in eshell." (interactive) (eshell default-directory))
    "us" #'counsel-switch-to-eshell-buffer
    "ue" #'moon/toggle-eshell)
  (general-define-key
   :prefix "C-c"
   :keymaps 'eshell-mode-map
   "C-h" #'moon/esh-history))

(defun moon/toggle-eshell ()
  "Toggle eshell"
  (interactive)
  (if (equal 'major-mode 'eshell-mode)
      (switch-to-prev-buffer)
    (eshell)))

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


(use-package| (aweshell :fetcher github :repo "manateelazycat/aweshell"))



;;; Config

(setq eshell-directory-name (concat moon-star-dir "utility/eshell/"))
(setq eshell-last-dir-ring-size 500)
(setq eshell-cp-interactive-query t
       eshell-ln-interactive-query t
       eshell-mv-interactive-query t
       eshell-rm-interactive-query t
       eshell-mv-overwrite-files nil)


;;;; History

;; https://emacs-china.org/t/topic/4579?u=samray
(defun moon/esh-history ()
  "Interactive search eshell history."
  (interactive)
  (require 'em-hist)
  (save-excursion
    (let* ((start-pos (eshell-bol))
	   (end-pos (point-at-eol))
	   (input (buffer-substring-no-properties start-pos end-pos)))
      (let* ((command (ivy-read "Command: "
				(delete-dups
				 (when (> (ring-size eshell-history-ring) 0)
				   (ring-elements eshell-history-ring)))
				:preselect input
				:action #'ivy-completion-in-region-action))
	     (cursor-move (length command)))
	(kill-region (+ start-pos cursor-move) (+ end-pos cursor-move)))))
  (end-of-line))


;;;; Swtich eshell

(after-load| counsel
  (defun counsel-switch-to-eshell-buffer ()
    "Switch to a shell buffer, or create one."
    (interactive)
    (ivy-read "Eshell buffer: " (counsel--buffers-with-mode #'eshell-mode)
              :action #'counsel--switch-to-shell
              :caller 'counsel-switch-to-shell-buffer)))

