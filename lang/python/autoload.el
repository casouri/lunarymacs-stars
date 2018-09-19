;; -*- lexical-binding: t -*-

;;;###autoload
(defun moon/kill-python-interpreter ()
  (interactive)
  (when (member "#<buffer *Python*>" (buffer-list))
    (kill-buffer "*Python*"))
  )
