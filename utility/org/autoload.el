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

Refer to source file

* External dependencies" (file-name-nondirectory
                      (directory-file-name dir))))))


;;;###autoload
(defun moon/org-insert-title ()
  "Insert filename as title attribute."
  (interactive)
  (insert (format "#+TITLE: %s" (buffer-file-name))))

;;;###autoload
(defun moon/insert-heading (heading)
  "Insert a Org Mode heading with appropriate id."
  (interactive "M")
  ;; (let ((level (length (progn (string-match "\\(\\*+?\\) " heading)
  ;;                             (match-string 1 heading))))))
  (insert (format "%s
::PROPERTIES:
:CUSTOM_ID: #%s
:END:"
                  heading
                  (downcase (replace-regexp-in-string "[ ;/?:@=&<>#%{}|\\\\^~\[\]`]" "-" heading)))))
