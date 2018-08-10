;; -*- lexical-binding: t -*-


;;
;; Package
;;

(use-package| general
  :after which-key
  :config
  (general-override-mode)

  (mve
   (general-create-definer moon--default-leader
    :states '(normal visual insert emacs jpnb)
    :keymaps 'override
    :prefix "SPC"
    :non-normal-prefix "S-SPC")
   
  (general-create-definer moon--default-leader
    :keymaps 'override
    :prefix "C-SPC"))

  (general-create-definer moon-global-leader
    :prefix "S-SPC"
    :keymaps 'override)

  (general-create-definer moon-g-leader
    :states '(normal visual)
    :keymaps 'override
    :prefix "g")

  (general-create-definer moon-cc-leader
    :state '(normal visual insert emacs jpnb)
    :keymaps 'override
    :prefix "C-c")

  (defmacro moon-default-leader (&rest args)
    "Define for both default leader and global leader."
    (declare (indent defun))
    `(progn
       (moon--default-leader
        ,@args)
       (moon-global-leader
        ,@args)))

  (moon-default-leader
   "f" '(:ignore t :which-key "file")
   "F" '(:ignore t :which-key "Frame")
   "i" '(:ignore t :which-key "insert")
   "h" '(:ignore t :which-key "help")
   "j" '(:ignore t :which-key "jump")
   "r" '(:ignore t :which-key "register")
   "s" '(:ignore t :which-key "search")
   "T" '(:ignore t :which-key "Theme")
   "p" '(:ignore t :which-key "project")
   "w" '(:ignore t :which-key "window")
   "b" '(:ignore t :which-key "buffer")
   "w" '(:ignore t :which-key "workspace")
   "q" '(:ignore t :which-key "quit")
   "m" '(:ignore t :which-key "major-mode")
   "e" '(:ignore t :which-key "error")
   "a" '(:ignore t :which-key "action")
   "t" '(:ignore t :which-key "toggle")
   "g" '(:ignore t :which-key "git")
   "p" '(:ignore t :which-key "project")
   "u" '(:ignore t :which-key "utility")
   "o" '(:ignore t :which-key "outline")
   "C-o" '(:ignore t :which-key "open")
   ;; Frame
   "Fd" #'delete-frame
   ;; align
   "="  #'align-regexp
   ;; open
   "C-o t"  #'moon/open-in-iterm
   "C-o f"  #'moon/open-in-finder
   ;; file
   "fR"  #'moon/rename-file
   "fs"  #'save-buffer
   "fed" #'moon/open-init-file
   "feD" #'moon/compare-init-to-example
   "fD"  '(:ignore t :which-key "delete file")
   "fDD" #'moon/delete-file-and-buffer
   ;; quit
   "qq"  #'save-buffers-kill-emacs
   ;; buffer
   "bm"  '((lambda () (interactive) (switch-to-buffer "*Messages*"))
           :which-key "goto message buffer")
   "bd"  #'kill-buffer-and-window
   "bh"  #'moon/close-help
   "bo"  #'moon/kill-other-buffer
   "bh"  #'moon/kill-helper
   "bb"  #'list-buffers
   "bs"  '((lambda () (interactive) (switch-to-buffer "*scratch*"))
           :which-key "goto scratch buffer")
   ;; eval
   "`"   #'eval-expression
   ;; toggle
   "tt"  #'moon/switch-theme
   "tM"  #'toggle-frame-maximized
   "tf"  #'moon/toggle-format-on-save
   ;; error
   "ej"  #'hydra-error/next-error
   "ek"  #'hydra-error/previous-error
   "eh"  #'hydra-error/first-error
   ;; utilities
   ;; jump
   "jmc" #'moon/jump-to-config
   "jmp" #'moon/jump-to-package
   "jma" #'moon/jump-to-autoload
   "jmd" #'moon/jump-to-autoload-dir
   "jmr" #'moon/jump-to-readme
  )

  (general-define-key :states '(normal visual)
                      "TAB" #'indent-for-tab-command
                      "C-e" #'end-of-line
                      "C-a" #'beginning-of-line)
  (general-define-key
   :keymaps 'override
   "s-h" #'windmove-left
   "s-j" #'windmove-down
   "s-k" #'windmove-up
   "s-l" #'windmove-right)

  (general-define-key
   :keymaps 'override
   "<escape>" #'moon/quit-maybe-normal)
  )

(defun moon/quit-maybe-normal ()
  "Perform `keyboard-escape-quit', if in evil-mode, enter normal state."
  (interactive)
  (keyboard-escape-quit)
  (when (or (bound-and-true-p evil-mode)
            (bound-and-true-p evil-local-mode))
      (evil-force-normal-state)))


(use-package| which-key
  :config (which-key-mode 1))

(use-package| hydra
  :after general
  :config
  (defhydra hydra-error ()
    "goto-error"
    ("h" first-error "first")
    ("j" next-error "next")
    ("k" previous-error "prev")
    ("v" recenter-top-bottom "recenter")
    ("q" nil "quit")))

