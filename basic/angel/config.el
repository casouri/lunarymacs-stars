;;; config.el-- Emacs navigation      -*- lexical-binding: t; -*-


;;; Commentary:
;; 

;;; Code:
;;

;;; Navigation

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

;;; Keys

(post-config| general
  (general-define-key
   "M-n"   #'moon/scroll-down-reserve-point
   "M-p"   #'moon/scroll-up-reserve-point)

  (general-define-key
   :keymas minibuffer-local-map
   "C-<return>" #'newline)
  
  (general-define-key
   :keymaps 'override
   "C-'"   #'jump-char-forward
   "M-'"   #'avy-goto-char
   "C-M-f" #'next-space
   "M-f"   #'next-char
   "C-M-b" #'last-space
   "M-b"   #'last-char

   "M-y"   #'kill-region
   "C-y"   #'kill-ring-save
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
    "C-u" #'undo-tree-visualize
    "C-v" #'cua-rectangle-mark-mode
    "0"   #'quit-window
    "C-," #'beginning-of-buffer ; as of <
    "C-." #'end-of-buffer ; as of >
    "C-q" #'smart-query-edit-mode
    "C-b" #'switch-to-buffer
    "M-b" (lambda (arg)
            (interactive "p")
            (if (>= arg 0)
                (kill-buffer (current-buffer))
              (kill-buffer-and-window (current-buffer))))
    "C-;" #'goto-last-change
    "M-;" #'goto-last-change-reverse))


(use-package| evil-nerd-commenter
  :commands (evilnc-comment-and-key-ring-save
             evilnc-comment-operator))


;;; Improvement

;;;; Smart query replace

(defvar smart-query-edit-mode-overlay nil
  "Overlay of region to be replaced.")

(defvar smart-query-edit-mode-from-string nil
  "The from-string for `query-replace'.")

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

;;;; Better isearch

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

(defvar transient-map-exit-func nil
  "Function used to exit transient map.")

(defmacro transient-eval-and-exit (arg &rest body)
  "Return a function that takes ARG and eval BODY and call `transient-map-exit-func'."
  `(lambda ,arg ,@body (funcall transient-map-exit-func)))

(defun activate-mark-hook@set-transient-map ()
  (setq transient-map-exit-func
        (set-transient-map
         (let ((map (make-sparse-keymap))
               (inner-map (make-sparse-keymap))
               (outer-map (make-sparse-keymap)))
           ;; operations
           (define-key map "p" (transient-eval-and-exit (b e) (interactive "r") (delete-region b e) (yank)))
           (define-key map (kbd "M-p") (transient-eval-and-exit (interactive) (counsel-yank-pop)))
           (define-key map "x" #'exchange-point-and-mark)
           (define-key map ";" (transient-eval-and-exit () (interactive) (evilnc-comment-operator)))
           (define-key map (kbd "M-;") #'evilnc-comment-and-kill-ring-save)
           (define-key map "y" (transient-eval-and-exit (beg end) (interactive "r") (kill-ring-save beg end)))
           (define-key map (kbd "C-y") (transient-eval-and-exit kill-ring-save))
           (define-key map "Y" (transient-eval-and-exit
                                (b e)
                                (interactive "r")
                                (kill-new (buffer-substring b e))
                                (message "Region saved")))
           ;; isolate
           (define-key map "s" #'isolate-quick-add)
           (define-key map "S" #'isolate-long-add)
           (define-key map "d" #'isolate-quick-delete)
           (define-key map "D" #'isolate-long-delete)
           (define-key map "c" #'isolate-quick-change)
           (define-key map "C" #'isolate-long-change)
           ;; mark things
           (define-key map "f" #'er/mark-defun)
           (define-key map "w" #'er/mark-word)
           (define-key map "W" #'er/mark-symbol)
           (define-key map "P" #'mark-paragraph)
           ;; inner & outer
           (define-key map "i" inner-map)
           (define-key map "a" outer-map)
           (define-key inner-map "q" #'er/mark-inside-quotes)
           (define-key outer-map "q" #'er/mark-outside-quotes)
           (define-key inner-map "b" #'er/mark-inside-pairs)
           (define-key outer-map "b" #'er/mark-outside-pairs)
           ;; expand-region
           (define-key map (kbd "C--") #'er/contract-region)
           (define-key map (kbd "C-=") #'er/expand-region)
           map)
         #'region-active-p)))

(add-hook 'activate-mark-hook #'activate-mark-hook@set-transient-map)

;;;; jump char

(use-package| (jump-char :fetcher github :repo lewang/jump-char)
  :commands jump-char-forward)


;;; config.el ends here
