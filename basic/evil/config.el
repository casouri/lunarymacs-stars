;; -*- lexical-binding: t -*-

(setq moon-evil t)

(defvar moon-evil-mode-list
  '(lisp-interaction-mode
    text-mode
    fundamental-mode)
  "Modes in where you want evil enables.")

(defvar moon-non-evil-mode-list
  '(magit-mode)
  "Modes in where you don't want evil enables.")

(add-hook 'moon-post-init-hook (lambda () "Evilfy Messages and Scratch buffer."
                                 (switch-to-buffer "*Messages*")
                                 (evil-local-mode)
                                 (switch-to-buffer "*scratch*")
                                 (evil-local-mode)
                                 (switch-to-buffer (or moon-homepage-buffer "*scratch*"))))

(use-package| evil
  :config
  (evil-local-mode)
  ;; enabled evil when editing text
  (add-hook 'after-change-major-mode-hook #'moon-smart-evil)

  ;; fix paste issue in evil visual mode
  ;; http://emacs.stackexchange.com/questions/14940/emacs-doesnt-paste-in-evils-visual-mode-with-every-os-clipboard/15054#15054
  (fset 'evil-visual-update-x-selection 'ignore)
  ;; https://github.com/syl20bnr/spacemacs/issues/6636
  ;; setting this directly doesn't work
  ;; you have to set it through customize
  ;; (customize-set-variable evil-search-module 'evil-search)
  (setq evil-ex-substitute-global t))

(defun moon-smart-evil ()
  "Enable evil when major mode complies."
  (when (and (or (derived-mode-p 'prog-mode 'special-mode)
                 (member major-mode moon-evil-mode-list))
             (not (member major-mode moon-non-evil-mode-list)))
    (evil-local-mode)))

;;;; smart selection for evil search motions

;; + in visual mode
;; binded below by general.el
(defun moon/make-region-search-history ()
  "Make region a histroy so I can use cgn."
  (interactive)
  (let ((region (strip-text-properties (funcall region-extract-function nil))))
    (push region evil-ex-search-history)
    (setq evil-ex-search-pattern (evil-ex-make-search-pattern region))
    (evil-ex-search-activate-highlight evil-ex-search-pattern)
    (deactivate-mark))
  (goto-char (1- (point))))

(defun moon/pop-kill-ring-to-search-history ()
  "Pop text in kill ring to search history."
  (interactive)
  (let ((text (car kill-ring)))
    (push text evil-ex-search-history)
    (setq evil-ex-search-pattern (evil-ex-make-search-pattern text))
    (evil-ex-search-activate-highlight evil-ex-search-pattern)))


;; / in visual mode will start search immediatly
(defun moon-evil-ex-start-search-with-region-string ()
  (let ((selection (with-current-buffer (other-buffer (current-buffer) 1)
                     (when (evil-visual-state-p)
                       (let ((selection (buffer-substring-no-properties (region-beginning)
                                                                        (1+ (region-end)))))
                         (evil-normal-state)
                         selection)))))
    (when selection
      (evil-ex-remove-default)
      (insert selection)
      (evil-ex-search-activate-highlight (list selection
                                               evil-ex-search-count
                                               evil-ex-search-direction)))))

(advice-add #'evil-ex-search-setup :after #'moon-evil-ex-start-search-with-region-string)

;; # in visual mode
(defun moon-evil-ex-search-word-backward-advice (old-func count &optional symbol)
  (if (evil-visual-state-p)
      (let ((region (buffer-substring-no-properties
                     (region-beginning) (1+ (region-end)))))
        (setq evil-ex-search-pattern region)
        (deactivate-mark)
        (evil-ex-search-full-pattern region count 'backward))
    (apply old-func count symbol)))

;; \* in visual mode
(defun moon-evil-ex-search-word-forward-advice (old-func count &optional symbol)
  (if (evil-visual-state-p)
      (let ((region (buffer-substring-no-properties
                     (region-beginning) (1+ (region-end)))))
        (setq evil-ex-search-pattern region)
        (deactivate-mark)
        (evil-ex-search-full-pattern region count 'forward))
    (apply old-func count symbol)))

(advice-add #'evil-ex-search-word-backward :around #'moon-evil-ex-search-word-backward-advice)
(advice-add #'evil-ex-search-word-forward :around #'moon-evil-ex-search-word-forward-advice)

(use-package| evil-matchit
  :after evil
  :defer 2
  :config (evil-matchit-mode))

;; (use-package| evil-surround
;;   :after evil
;;   :config (global-evil-surround-mode 1)
;;   (evil-define-key 'visual 'global "s" 'evil-surround-region))

(use-package| evil-nerd-commenter
  :commands evilnc-comment-operator)

(post-config| general
  (general-define-key
   :keymaps 'visual
   :prefix "g"
   "c" #'evilnc-comment-operator
   "C-c" #'evilnc-comment-and-kill-ring-save))

;; (use-package| evil-escape
;;   :config (evil-escape-mode 1)
;;   (setq-default evil-escape-key-sequence "<escape>"))

(use-package| evil-ediff
  :after evil
  :defer 2
  :hook (ediff-mode . (lambda () (require 'evil-ediff))))

(use-package| evil-vimish-fold
  :after evil
  :defer 2
  :init (setq vimish-fold-dir (concat moon-local-dir "vimish-fold")))


;;
;;; Config
;;

;;
;; Replace some keys

(post-config| general
  (after-load| evil
    (general-define-key
     :states 'normal
     "c" (general-key-dispatch 'evil-change
           "s" #'isolate-quick-change
           "S" #'isolate-long-change)
     "d" (general-key-dispatch 'evil-delete
           "s" #'isolate-quick-delete
           "S" #'isolate-long-delete))
    
    (general-define-key
     :states 'visual
     ;; `evil-change' is not bound in `evil-visual-state-map' by default but
     ;; inherited from `evil-normal-state-map'
     ;; if you don't want "c" to be affected in visual state, you should add this
     "c" #'evil-change
     "d" #'evil-delete
     "s" #'isolate-quick-add
     "S" #'isolate-long-add
     "x" #'exchange-point-and-mark ; for expand-region
     "+" #'moon/make-region-search-history
     )

    (general-define-key
     :states 'insert
     "M-n" #'next-line
     "M-p" #'previous-line
     "C-a" #'beginning-of-line
     "C-e" #'end-of-line)

    (general-define-key
     :states '(normal visual)
     "H"   #'evil-beginning-of-line
     "L"   #'evil-end-of-line
     "P"   #'evil-paste-from-register)
    
    (moon-default-leader
      "sc" #'moon/clear-evil-search
      "ij" '((lambda () (interactive) (evil-insert-line-below)) :which-key "insert-line-below")
      "ik" '((lambda () (interactive) (evil-insert-line-above)) :which-key "insert-line-above")
      "uu" #'undo-tree-visualize
      "+" #'moon/pop-kill-ring-to-search-history)

    (moon-default-leader
      :keymaps 'term-mode-map
      "c" '((lambda ()
              (interactive)
              (term-char-mode)
              (evil-insert-state)) :which-key "char-mode")
      "l" #'term-line-mode
      "bl" #'evil-switch-to-windows-last-buffer)

    (general-define-key
     :keymaps 'override
     "s-e" #'evil-local-mode)))

;; This way "/" respects the current region
;; but not when you use 'evil-search as evil-search-module
;; https://stackoverflow.com/questions/202803/searching-for-marked-selected-text-in-emacs
(defun moon-isearch-with-region ()
  "Use region as the isearch text."
  (when mark-active
    (let ((region (funcall region-extract-function nil)))
      (deactivate-mark)
      (isearch-push-state)
      (isearch-yank-string region))))
(add-hook 'isearch-mode-hook #'moon-isearch-with-region)

