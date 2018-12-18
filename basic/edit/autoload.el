;;; -*- lexical-binding: t -*-

;;;###autoload
(defun moon/open-log () (interactive) (find-file "~/log.org"))

;;;###autoload
(defun moon/insert-current-date ()
  "insert date for blog composing"
  (interactive)
  (insert (shell-command-to-string "echo -n $(date +%Y-%m-%d)")))

;;;###autoload
(defun moon/insert-semi-at-eol ()
  "Insert semicolon at end of line."
  (interactive)
  (save-excursion
    (end-of-line)
    (insert ";")))

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
  (next-line))

;;;###autoload
(defun moon/scroll-up-reserve-point ()
  (interactive)
  (scroll-down 2)
  (previous-line)
  (previous-line))

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

;;;###autoload
(defun moon/autoinsert (description)
  "Autoinsert what auto-insert inserts."
  (interactive "MDescription: ")
  (let* ((filename (file-name-nondirectory (buffer-file-name)))
         (year (format-time-string "%Y"))
         (feature (file-name-base (buffer-file-name))))
    (insert (format ";;; %s --- %s      -*- lexical-binding: t; -*-

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs

;;; Commentary:
;; 

;;; Code:
;;

(provide '%s)

;;; %s ends here"
                    filename description feature filename))))

;;;###autoload
(defun moon/autoinsert-copyright (description)
  "Autoinsert what auto-insert inserts with copyright."
  (interactive "MDescription: ")
  (let* ((filename (file-name-nondirectory (buffer-file-name)))
         (year (format-time-string "%Y"))
         (feature (file-name-base (buffer-file-name))))
    (insert (format ";;; %s --- %s      -*- lexical-binding: t; -*-

;; Copyright (C) %s Yuan Fu.

;; Author: Yuan Fu <casouri@gmail.com>
;; Maintainer: Yuan Fu <casouri@gmail.com>
;; Keywords:
;; Package-Requires: ((emacs \"\"))
;; Version:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; This file is NOT part of GNU Emacs

;;; Commentary:
;;

;;; Code:
;;

(provide '%s)

;;; %s ends here"
                    filename description feature filename))))

(defvar moon-special-symbol-alist '(("(c)" . "©")
                                    ("tm" . "™")
                                    ("p" . " ")
                                    ("s" . "§")
                                    ("---" . "—") ; em dash
                                    ("--" . "–") ; en dash
                                    ("..." . "…")
                                    ("<" . "⃖")
                                    (">" . "⃗")
                                    ("^" . "ꜛ")
                                    ("v" . "ꜜ")
                                    ("<<" . "←")
                                    (">>" . "→")
                                    ("^^" . "↑")
                                    ("vv" . "↓")
                                    ("l'" . "‘")
                                    ("l''" . "‘")
                                    ("r'" . "’")
                                    ("r''" . "’")
                                    ("l\"" . "“")
                                    ("l\"\"" . "“")
                                    ("r\"" . "”")
                                    ("r\"\"" . "”")
                                    (" " . " ") ; non-breaking spacef
                                    )
  "Alist used by `moon/insert-special-symbol'.")

;;;###autoload
(defun moon/insert-special-symbol (surname)
  "Insert special symbol at point, SURNAME is used to search for symbol.
E.g. SURNAME (c) to symbol ©."
  (interactive "MAbbrev: ")
  (insert (catch 'ret (dolist (elt moon-special-symbol-alist)
                        (when (equal (car elt) surname)
                          (throw 'ret (cdr elt)))
                        ""))))
;;;###autoload
(defvar-local moon-package-prefix nil
  "The prefix of the package you are writing in the current buffer.")

;;;###autoload
(defun moon/insert-prefix ()
  "Insert `moon-package-prefix'."
  (interactive)
  (if moon-package-prefix
      (insert moon-package-prefix)
    (message "No prefix defined.")))

;;;###autoload
(defun moon/set-prefix (prefix)
  "Set current buffer's package prefix."
  (interactive "s")
  (setq moon-package-prefix prefix))

;;; autoload.el ends here
