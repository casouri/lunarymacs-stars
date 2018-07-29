;; -*- lexical-binding: t -*-


;;;###autoload
(defun moon/smart-swiper ()
  "Use region as swiper input if region is active."
  (interactive)
  (swiper (if mark-active
              (buffer-substring-no-properties
               (region-beginning)
               (region-end))
            nil)))
