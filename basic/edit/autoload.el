;;; -*- lexical-binding: t -*-

;;;###autoload
(defun moon/open-log () (interactive) (find-file "~/log.org"))

;;;###autoload
(defun moon/insert-current-date ()
  "insert date for blog composing"
  (interactive)
  (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)"))
  )

;;;###autoload
(defun moon/insert-semi-at-eol ()
  "Insert semicolon at end of line."
  (interactive)
  (save-excursion
    (end-of-line)
    (insert ";")
    ))

;;;###autoload
(defun moon/jump-newline-below ()
  "create new line above/below without breaking current line"
  (interactive)
  (end-of-line)
  (newline-and-indent))

;;;###autoload
(defun moon/jump-newline-above ()
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (previous-line))

;;;###autoload
(defun moon/scroll-down-reserve-point ()
  (interactive)
  (scroll-up 2)
  (next-line)
  (next-line)
  )

;;;###autoload
(defun moon/scroll-up-reserve-point ()
  (interactive)
  (scroll-down 2)
  (previous-line)
  (previous-line)
  )

;;;###autoload
(defun moon/sudo-edit (&optional arg)
  "Edit currently visited file as root.

With a prefix ARG prompt for a file to visit.
Will also prompt for a file to visit if current
buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))
