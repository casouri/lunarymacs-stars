;;; config.el-- Emacs navigation      -*- lexical-binding: t; -*-


;;; Commentary:
;;

;;; Code:
;;


;;; Keys

(post-config| general
  (general-define-key
   "s-n"   #'moon/scroll-down-reserve-point
   "s-p"   #'moon/scroll-up-reserve-point)

  (general-define-key
   :keymas minibuffer-local-map
   "C-<return>" #'newline)

  (general-define-key
   :keymaps 'override
   "C-'"   #'jump-char-forward
   "M-'"   #'avy-goto-char
   "C-M-;" #'inline-replace
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
    "C-q" #'query-replace+-mode
    "C-b" #'switch-to-buffer
    "M-b" (lambda (arg)
            (interactive "p")
            (if (>= arg 0)
                (kill-buffer (current-buffer))
              (kill-buffer-and-window (current-buffer))))
    "C-;" #'goto-last-change
    "M-;" #'goto-last-change-reverse))

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

;;; Query Replace +

(defvar query-replace+-mode-overlay nil
  "Overlay of region to be replaced.")

(defvar query-replace+-mode-from-string nil
  "The from-string for `query-replace'.")

(define-minor-mode query-replace+-mode
  "Edit region and query replace."
  :lighter "QUERY"
  (if query-replace+-mode
      (if (not mark-active)
          (setq query-replace+-mode nil)
        (overlay-put
         (setq query-replace+-mode-from-string
               (buffer-substring
                (region-beginning)
                (region-end))
               query-replace+-mode-overlay
               (make-overlay (region-beginning)
                             (region-end)
                             nil
                             nil
                             t))
         'face '(:inherit region)))
    (overlay-put query-replace+-mode-overlay
                 'face '(:inherit region))
    (goto-char (overlay-end
                query-replace+-mode-overlay))
    (query-replace query-replace+-mode-from-string
                   (buffer-substring-no-properties
                    (overlay-start
                     query-replace+-mode-overlay)
                    (overlay-end
                     query-replace+-mode-overlay)))
    (delete-overlay
     query-replace+-mode-overlay)))

;;; Better isearch

;; https://stackoverflow.com/questions/202803/searching-for-marked-selected-text-in-emacs
(defun moon-isearch-with-region ()
  "Use region as the isearch text."
  (when mark-active
    (let ((region (funcall region-extract-function nil)))
      (deactivate-mark)
      (isearch-push-state)
      (isearch-yank-string region))))

(add-hook 'isearch-mode-hook #'moon-isearch-with-region)

;;; Transient map in region

(defvar transient-map-exit-func nil
  "Function used to exit transient map.")

(defun activate-mark-hook@set-transient-map ()
  (setq transient-map-exit-func
        (set-transient-map
         (let ((map (make-sparse-keymap))
               (inner-map (make-sparse-keymap))
               (outer-map (make-sparse-keymap)))
           ;; operations
           (define-key map "p" (lambda (b e)
                                 (interactive "r") (delete-region b e) (yank)))
           (define-key map (kbd "M-p") #'counsel-yank-pop)
           (define-key map "x" #'exchange-point-and-mark)
           (define-key map ";" #'comment-dwim)
           (define-key map "y" #'kill-ring-save)
           (define-key map (kbd "C-y") #'kill-ring-save)
           (define-key map "Y" (lambda
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
(add-hook 'deactivate-mark-hook (lambda ()
                                  (funcall transient-map-exit-func)))

;;; Jump char

(use-package| (jump-char :fetcher github :repo lewang/jump-char)
  :commands jump-char-forward
  :init (setq jump-char-forward-key "'"
              jump-char-backward-key ";"))

;;; Inline replace


(defvar inline-replace-last-input "")
(defvar inline-replace-history nil)
(defvar inline-replace-count 1)
(defvar inline-replace-original-buffer nil)
(defvar inline-replace-overlay nil)
(defvar inline-replace-beg nil)

(defvar inline-replace-minibuffer-map (let ((map minibuffer-local-map))
                                        (define-key map (kbd "C-p") #'inline-replace-previous)
                                        (define-key map (kbd "C-n") #'inline-replace-next)
                                        map))

(defun inline-replace-previous ()
  "Previous match."
  (interactive)
  (when (> inline-replace-count 1)
    (decf inline-replace-count)))

(defun inline-replace-next ()
  "Next match."
  (interactive)
  (incf inline-replace-count))

(defun inline-replace ()
  "Search for the matching REGEXP COUNT times before END.
You can use \\&, \\N to refer matched text."
  (interactive)
  (condition-case nil
      (save-excursion
        (setq inline-replace-beg (line-beginning-position))
        (setq inline-replace-original-buffer (current-buffer))
        (add-hook 'post-command-hook #'inline-replace-highlight)

        (let* ((minibuffer-local-map inline-replace-minibuffer-map)
               (input (read-string "regexp/replacement: " nil 'inline-replace-history))
               (replace (or (nth 1 (split-string input "/")) "")))
          (goto-char inline-replace-beg)
          (re-search-forward (car (split-string input "/")) (line-end-position) t inline-replace-count)

          (unless (equal input inline-replace-last-input)
            (push input inline-replace-history)
            (setq inline-replace-last-input input))
          (remove-hook 'post-command-hook #'inline-replace-highlight)
          (delete-overlay inline-replace-overlay)
          (replace-match replace)
          (setq inline-replace-count 0)))
    ((quit error)
     (delete-overlay inline-replace-overlay)
     (remove-hook 'post-command-hook #'inline-replace-highlight)
     (setq inline-replace-count 0))))

(defun inline-replace-highlight ()
  "Highlight matched text and replacement."
  (when inline-replace-overlay
    (delete-overlay inline-replace-overlay))
  (when (>= (point-max) (length "regexp/replacement: "))
    (let* ((input (buffer-substring-no-properties (1+ (length "regexp/replacement: ")) (point-max)))
           (replace (or (nth 1 (split-string input "/")) "")))
      (with-current-buffer inline-replace-original-buffer
        (goto-char inline-replace-beg)
        (when (and (re-search-forward (car (split-string input "/")) (line-end-position) t inline-replace-count)
                   (> inline-replace-count 1))
          (decf inline-replace-count))
        (setq inline-replace-overlay (make-overlay (match-beginning 0) (match-end 0)))
        (overlay-put inline-replace-overlay 'face '(:strike-through t :background "#75000F"))
        (overlay-put inline-replace-overlay 'after-string (propertize replace 'face '(:background "#078A00")))))))




;;; config.el ends here
