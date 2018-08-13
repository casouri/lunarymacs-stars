;; -*- lexical-binding: t -*-

(defvar moon-after-change-buffer-hook ()
  "Hook run after buffer changed.")

(defvar moon-last-buffer nil
  "Last buffer used by `moon-after-change-buffer-hook'.")

(defun moon-run-buffer-change-hook ()
  "Run `moon-after-change-buffer-hook'."
  (let (current-buffer (current-buffer))
    (unless (eq current-buffer moon-last-buffer)
    (run-hook-with-args 'moon-after-change-buffer-hook)
    (setq moon-last-buffer current-buffer))))

(add-hook 'post-command-hook #'moon-run-buffer-change-hook)
