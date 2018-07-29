;; -*- lexical-binding: t -*-


;;;###autoload
(defun moon/swiper-region ()
  "Use region as swiper input."
  (interactive)
  (swiper (buffer-substring-no-properties
           (region-beginning)
           (region-end))))
