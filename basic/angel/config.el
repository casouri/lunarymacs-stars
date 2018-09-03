;;; con-- Emacs navigation      -*- lexical-binding: t; -*-

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

(defsubst next-of (charset)
  "Forward until hit char from CHRSET."
  (while (member (char-after) charset)
    (forward-char))
  (while (not (member (char-after) charset))
    (forward-char)))

(defsubst last-of (charset)
  (while (member (char-after) charset)
    (backward-char))
  (while (not (member (char-after) charset))
    (backward-char)))

(defun next-space ()
  "Go to next space."
  (interactive)
  (next-of '(?\s ?\n ?\t)))

(defun last-space ()
  "Go to last space."
  (interactive)
  (last-of '(?\s ?\n ?\t)))

(defvar punc-list '(?` ?` ?! ?@ ?# ?$ ?% ?^ ?& ?* ?\( ?\)
                       ?- ?_ ?= ?+ ?[ ?] ?{ ?} ?\\ ?| ?\;
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
                       ?v ?B ?b ?N ?n ?M ?m))

(defun next-char (&optional arg)
  "Go to next character. Do ARG times."
  (interactive "p")
  (next-of char-list))

(defun last-char (&optional arg)
  "Go to next character. Do ARG times."
  (interactive "p")
  (last-of char-list))

(post-config| general
  (general-define-key
   "C-M-f" #'next-space
   "M-f" #'next-punc
   "C-M-b" #'last-space
   "M-b" #'last-punc

   "C-." #'undo-tree-redo
   
   "C-M-v" #'er/expand-region
   "C-M-p" #'backward-up-list
   "C-M-n" #'down-list)
  
  (moon-cx-leader
    "," #'beginning-of-buffer ; as of <
    "." #'end-of-buffer ; as of >
    )
  (moon-default-leader
    "c" #'evilnc-comment-operator
    "C-c" #'evilnc-comment-and-kill-ring-save))

(use-package| evil-nerd-commeter)


;;; config.el ends here
