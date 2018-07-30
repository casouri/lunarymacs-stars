;; -*- lexical-binding: t -*-

(setq moon-evil nil)

;;; Key remap for macOS

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)
(setq mac-function-modifier 'hyper)

;;; Leader key

(global-set-key (kbd "C-v") #'set-mark-command)
(cua-selection-mode)
(global-set-key (kbd "M-v") #'cua-set-rectangle-mark)

(defun moon/line-select ()
  "Select whole line."
  (interactive)
  (beginning-of-line)
  (set-mark-command nil)
  (forward-line))

(global-set-key (kbd "C-M-v") #'moon/line-select)
