;; -*- lexical-binding: t -*-


;;;###autoload
(defun moon/smart-swiper ()
  "Use region as swiper input if region is active."
  (interactive)
  (let ((pattern (if mark-active
                     (buffer-substring-no-properties
                      (region-beginning)
                      (region-end)) nil)))
    (when pattern (deactivate-mark))
    (swiper pattern)))
