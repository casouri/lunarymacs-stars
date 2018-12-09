;; -*- lexical-binding: t -*-

;;;###autoload
(defun moon/desktop-read ()
  "Recover desktop, i.e. recover last session."
  (interactive)
  (desktop-read moon-local-dir))

(defun moon/split-to (direction)
  "Split window and switch to it according to DIRECTION.
Accept one character for DIRECTION.
  k     ^
h   l <   >
  j     v
"
  (interactive "cswitch to window: h/j/k/l")
  (pcase direction
    (?k (split-window-below))                 ; up
    (?j (select-window (split-window-below))) ; down
    (?h (split-window-right))                 ; left
    (?l (select-window (split-window-right))) ; right
    ))

;;
;; Moody
;;

;;;###autoload
(defun flycheck-lighter (state bullet)
  "Return flycheck information for the given error type STATE."
  (when (bound-and-true-p flycheck-mode)
    (let* ((counts (flycheck-count-errors flycheck-current-errors))
           (errorp (flycheck-has-current-errors-p state))
           (err (or (cdr (assq state counts)) "?"))
           (running (eq 'running flycheck-last-status-change)))
      (if (or errorp running) (format bullet err) ""))))

;;;###autoload
(defun moon-edit-lighter ()
  (if (buffer-modified-p)
      "* "
    ""))

;;;###autoload
(defun moon-root-lighter ()
  (if (equal user-login-name "root")
      "ROOT "
    ""))

(defmacro make-lighter| (form empty-value empty-return)
  "Make a ligher for mode-line.

If FORM return EMPTY-VALUE(nil, \"\"), return EMPTY-RETURN,
else just return the form's return."
  `(let ((result ,form))
     (if (equal result ,empty-value)
         ,empty-return
       result)))
