;;;###autoload
(defun moon/create-star-readme ()
  "Create a REAME file for a star."
  (interactive)
  (let ((dir (read-directory-name "Star directory: ")))
    (find-file (concat dir "README.org"))
    (insert
     (format "#+TITLE: %s


* Package list


* Commands

| key | command |
|-----+---------|
|     |         |" (file-name-nondirectory
                      (directory-file-name dir))))))


;;;###autoload
(defun moon/org-insert-title ()
  "Insert filename as title attribute."
  (interactive)
  (insert (format "#+TITLE: %s" (buffer-file-name))))
