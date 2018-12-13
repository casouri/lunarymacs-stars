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
