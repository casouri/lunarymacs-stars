;;; config.el-- Emacs navigation      -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Yuan Fu

;; Author: Yuan Fu <casouri@gmail.com>

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;; 

;;; Code:
;;

(defsubst next-of (charset &optional stop-charset)
  "Forward until hit char from CHARSET. Or before a char from STOP-CHARSET."
  (when stop-charset
    (while (member (char-after) stop-charset)
      (forward-char)))
  (while (member (char-after) charset)
    (forward-char))
  (unless (member (char-after) stop-charset)
    (while (not (member (char-after) charset))
      (forward-char))))

(defsubst last-of (charset &optional stop-charset)
  "Backward until hit char from CHARSET. Or before a char from STOP-CHARSET."
  (when stop-charset
    (while (member (char-before) stop-charset)
      (backward-char)))
  (while (member (char-before) charset)
    (backward-char))
  (unless (member (char-before) stop-charset)
    (while (not (member (char-before) charset))
      (backward-char))))

(defun next-space ()
  "Go to next space."
  (interactive)
  (next-of '(?\s ?\n ?\t) '(?\( ?\))))

(defun last-space ()
  "Go to last space."
  (interactive)
  (last-of '(?\s ?\n ?\t) '(?\( ?\))))

(defun next-space-char ()
  "Go to next char after space."
  (interactive)
  (next-of '(?\s ?\n ?\t))
  (forward-char))

(defun last-space-char ()
  "Go to last char before space."
  (interactive)
  (last-of '(?\s ?\n ?\t))
  (backward-char))


(defvar punc-list '(?` ?` ?! ?@ ?# ?$ ?% ?^ ?& ?* ?\( ?\)
                       ?- ?_ ?= ?+ ?\[ ?\] ?{ ?} ?\\ ?| ?\;
                       ?: ?' ?\" ?, ?< ?. ?> ?/ ??))

(defun next-punc ()
  "Go to next punctuation."
  (interactive)
  (next-of punc-list))

(defun last-punc ()
  "Go to next punctuation. Do ARG times."
  (interactive)
  (last-of punc-list))

(defvar char-list '(?Q ?q ?W ?w ?E ?e ?R ?r ?T ?t ?Y ?y
                       ?U ?u ?I ?i ?O ?o ?P ?p ?A ?a ?S
                       ?s ?D ?d ?F ?f ?G ?g ?H ?h ?J ?j
                       ?K ?k ?L ?l ?Z ?z ?X ?x ?C ?c ?V
                       ?v ?B ?b ?N ?n ?M ?m ?1 ?2 ?3 ?4
                       ?5 ?6 ?7 ?8 ?9 ?0))

(defun next-char (&optional arg)
  "Go to next character. Do ARG times."
  (interactive "p")
  (next-of char-list '(?\( ?\))))

(defun last-char (&optional arg)
  "Go to next character. Do ARG times."
  (interactive "p")
  (last-of char-list '(?\( ?\))))

(defun select-line ()
  "Select whole line."
  (interactive)
  (beginning-of-line)
  (set-mark-command nil)
  (end-of-line))

(post-config| general
  (general-define-key
   "M-n"   #'moon/scroll-down-reserve-point
   "M-p"   #'moon/scroll-up-reserve-point)

  (general-define-key
   :keymas minibuffer-local-map
   "C-<return>" #'newline)
  
  (general-define-key
   :keymaps 'override
   "C-,"   #'switch-to-buffer
   "C-'"   #'avy-goto-char
   "C-M-f" #'next-space
   "M-f"   #'next-char
   "C-M-b" #'last-space
   "M-b"   #'last-char
   "s-g"   #'end-of-buffer
   "C-M-g" #'beginning-of-buffer

   "C-y"   #'kill-region
   "M-y"   #'kill-ring-save
   "s-y"   #'yank

   "C-."   #'undo-tree-redo
   
   "M-v"   #'select-line
   "C-="   #'er/expand-region
   "C-M-p" #'backward-up-list
   "C-M-n" #'down-list
   "C-M-0" #'forward-sexp ; \)
   "C-M-9" #'backward-sexp ; ;\(
   
   "C-v"   #'set-mark-command

   ;; "C-h" (general-simulate-key "C-b")
   ;; "C-l" (general-simulate-key "C-f")
   ;; "C-j" (general-simulate-key "C-n")
   ;; "C-k" (general-simulate-key "C-p")
   ;; "M-h" (general-simulate-key "M-b")
   ;; "M-l" (general-simulate-key "M-f")
   ;; "M-j" (general-simulate-key "M-n")
   ;; "M-k" (general-simulate-key "M-p")
   )
  
  (moon-cx-leader
    "C-v" #'cua-rectangle-mark-mode
    "0"   #'quit-window
    "C-," #'beginning-of-buffer ; as of <
    "C-." #'end-of-buffer ; as of >
    "M-h" #'mark-whole-buffer
    "C-q" #'smart-query-edit-mode
    "C-b" #'switch-to-buffer
    "M-b" (lambda (arg)
            (interactive "p")
            (if (>= arg 0)
                (kill-buffer (current-buffer))
              (kill-buffer-and-window (current-buffer)))))
  
  (moon-default-leader
    "C-c" #'evilnc-comment-operator
    "M-c" #'evilnc-comment-and-kill-ring-save))


(use-package| evil-nerd-commenter
  :commands (evilnc-comment-and-key-ring-save
             evilnc-comment-operator))


(defvar smart-query-edit-mode-overlay nil
  "Overlay of region to be replaced.")

(define-minor-mode smart-query-edit-mode
  "Edit region and query replace."
  :lighter "QUERY"
  (if smart-query-edit-mode
      (if (not mark-active)
          (setq smart-query-edit-mode nil)
        (overlay-put
         (setq smart-query-edit-mode-from-string
               (buffer-substring
                (region-beginning)
                (region-end))
               smart-query-edit-mode-overlay
               (make-overlay (region-beginning)
                             (region-end)
                             nil
                             nil
                             t))
         'face '(:inherit highlight)))
    (overlay-put smart-query-edit-mode-overlay
                 'face '(:inherit region))
    (goto-char (overlay-end
                smart-query-edit-mode-overlay))
    (query-replace smart-query-edit-mode-from-string
                   (buffer-substring-no-properties
                    (overlay-start
                     smart-query-edit-mode-overlay)
                    (overlay-end
                     smart-query-edit-mode-overlay)))
    (delete-overlay
     smart-query-edit-mode-overlay)))

;; https://stackoverflow.com/questions/202803/searching-for-marked-selected-text-in-emacs
(defun moon-isearch-with-region ()
  "Use region as the isearch text."
  (when mark-active
    (let ((region (funcall region-extract-function nil)))
      (deactivate-mark)
      (isearch-push-state)
      (isearch-yank-string region))))

(add-hook 'isearch-mode-hook #'moon-isearch-with-region)

;;;; transient map in region
(defun activate-mark-hook@set-transient-map ()
  (set-transient-map
   (let ((map (make-sparse-keymap)))
     (define-key map "p" (lambda (b e) (interactive "r") (delete-region b e) (yank)))
     (define-key map "C-p" #'counsel-yank-pop)
     (define-key map "q" #'keyboard-quit)
     (define-key map ";" #'evilnc-comment-operator)
     (define-key map "M-;" #'evilnc-comment-and-kill-ring-save)
     (define-key map "y" #'kill-ring-save)
     (define-key map "s" #'isolate-quick-add)
     (define-key map "S" #'isolate-long-add)
     (define-key map "d" #'isolate-quick-delete)
     (define-key map "D" #'isolate-long-delete)
     (define-key map "c" #'isolate-quick-change)
     (define-key map "C" #'isolate-long-change)
     (define-key map "Y" (lambda (b e)
                           (interactive "r")
                           (kill-new (buffer-substring b e))
                           (message "Region saved")))
     map)
   #'region-active-p))

(add-hook 'activate-mark-hook #'activate-mark-hook@set-transient-map)

;;; config.el ends here
