;; (use-package| ob-ipython
;;   :defer t
;;   :init
;;   (add-hook
;;    'org-mode-hook
;;    (lambda ()
;;      (org-babel-do-load-languages
;;       'org-babel-load-languages
;;       '((ipython . t)))
;;      )))

;; (add-hook
;;  'org-mode-hook
;;  (lambda ()
;;    (org-babel-do-load-languages
;;     'org-babel-load-languages
;;     '((shell . t)))
;;    ))

(add-hook 'org-mode-hook #'flyspell-mode)

;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (setq buffer-face-mode-face '(:family "Courier New" :height 150))
;;             (buffer-face-mode)))

;;; Keys

(post-config| general
  (moon-default-leader
    "ot" '((lambda () (interactive)
             (find-file moon-todo-file)) :which-key "jump todo")
    "oc" #'org-capture
    "oa" #'org-agenda))

(defvar moon-todo-file "~/note/todo.org")

;;; Packages

(use-package| toc-org
  :commands (toc-org-enable
             toc-org-insert-toc))

(use-package| htmlize
  :commands
  org-html-export-to-html
  org-html-export-as-html)

(use-package| olivetti
  :init
  (setq olivetti-body-width 110)
  (add-hook 'org-mode-hook #'olivetti-mode)
  :commands olivetti-mode)

;;; Function

(defun moon/new-blog (title)
  "Make a new blog post with TITLE."
  (interactive "M")
  (let* ((year (shell-command-to-string "echo -n $(date +%Y)"))
         (dir-file-name (downcase (replace-regexp-in-string " " "-" title)))
         (dir-path (concat (format  "~/p/casouri/note/%s/"
                                    year)
                           dir-file-name))
         (file-path (concat dir-path
                            "/index.org")))
    (mkdir dir-path)
    (find-file file-path)
    (insert (format "#+OPTIONS: html-style:nil
#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"/note/style.css\"/>
#+HTML_HEAD_EXTRA: <script type=\"text/javascript\" src=\"/note/script.js\"></script>
#+HTML_LINK_UP: /note
#+HTML_LINK_HOME: /note
#+TITLE: %s
#+DATE:
"
                    title))
    (kill-new (format "- [[./%s/%s/][%s]]"
                      year
                      dir-file-name
                      title))
    (save-buffer)
    (find-file "~/p/casouri/note/index.org")))

;;; Config

;;;; Org Agenda

(setq org-agenda-files (list moon-todo-file))

;;;; Org Capture

(with-eval-after-load 'org-capture
  (setq org-default-notes-file "~/note/index.org")
  (setq org-capture-templates
        (append org-capture-templates
                `(("t" "TODOs")
                  ("te" "Emacs" entry (file+olp "~/note/todo.org" "Emacs") "** TODO %?")
                  ("to" "Other" entry (file+olp "~/note/todo.org" "Other") "** TODO %?")
                  ("ts" "School" entry (file+olp "~/note/todo.org" "School") "** TODO %?")
                  ))))
