 (post-config| general
  (moon-default-leader
    "C-o s" (lambda () "Open in eshell." (interactive) (eshell default-directory))
    "y" '(:ignore t :which-key "Eshell")
    "ys" #'counsel-switch-to-eshell-buffer
    "yn" #'aweshell-next
    "yp" #'aweshell-prev
    "yN" #'aweshell-new)
  (moon-cc-leader
    "y" #'moon/toggle-eshell))

(defun moon/toggle-eshell ()
  "Toggle eshell"
  (interactive)
  (if (equal major-mode 'eshell-mode)
      (switch-to-prev-buffer)
    (aweshell-next)))

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


(use-package| (aweshell :fetcher github :repo "manateelazycat/aweshell")
  :commands (aweshell-new aweshell-next aweshell-prev)
  :config
  (custom-set-faces
   '(epe-dir-face ((t (:foreground "#51afef"))))
   '(epe-git-face ((t (:foreground "#bbc2cf"))))
   '(epe-pipeline-delimiter-face ((t (:foreground "#98be65"))))
   '(epe-pipeline-host-face ((t (:foreground "#bbc2cf"))))
   '(epe-pipeline-time-face ((t (:foreground "#bbc2cf"))))
   '(epe-pipeline-user-face ((t (:foreground "#bbc2cf"))))
   )
  (require 'em-hist)
  (add-hook
   'eshell-mode-hook
   (with-eval-after-load 'general
     (with-eval-after-load 'evil
       (lambda ()
         (general-define-key
          :states 'insert
          :keymaps 'eshell-mode-map
          "C-p" #'eshell-previous-matching-input-from-input
          "C-n" #'eshell-next-matching-input-from-input)
         )))))

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

(defun counsel-switch-to-eshell-buffer ()
    "Switch to a shell buffer, or create one."
    (interactive)
    (require 'counsel)
    (ivy-read "Eshell buffer: " (counsel--buffers-with-mode #'eshell-mode)
              :action #'counsel--switch-to-shell
              :caller 'counsel-switch-to-shell-buffer))

