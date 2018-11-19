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
    "oa" #'org-agenda)
  (general-define-key
   :keymaps 'org-mode-map
   "C-c i" #'moon/insert-heading))

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

(defun moon/open-album-dir ()
  "Open ~/p/casouri/rock/day/album/."
  (interactive)
  (shell-command-to-string (format "open ~/p/casouri/rock/day/album/")))

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
    (insert (format "#+SETUPFILE: ../../setup.org
#+TITLE: %s
#+DATE:
"
                    title))
    (kill-new (format "{{{post(%s,%s/%s/)}}}"
                      title
                      year
                      dir-file-name))
    (save-buffer)
    (find-file "~/p/casouri/note/index.org")))

(defun moon/new-rock/day (day)
  "Make a new blog post of rock/day of DAY."
  (interactive "n")
  (mkdir (format "~/p/casouri/rock/day/day-%d" day))
  (find-file (format "~/p/casouri/rock/day/day-%d/index.org" day))
  (insert (format "#+SETUPFILE: ../setup.org
#+TITLE: Day %d
#+DATE:

#+HTML: <div style=\"display: flex; justify-content: space-between;\"><a href=\"../day-%d/index.html\"><< Yesterday <<</a><a href=\"../day-%d/index.html\">>> Tommorrow >></a></div>


[[../album/]]

* - *

#+BEGIN_SRC
#+END_SRC
" day (1- day) (1+ day)))
  (save-buffer)
  (kill-new (format "- [[./day-%d/index.html][Day %d]]" day day))
  (find-file "~/p/casouri/rock/day/index.org"))

;;; Config

;;;; Org Agenda

(setq org-agenda-files (list moon-todo-file))

;;;; Org Capture

(with-eval-after-load 'org-capture
  (setq org-default-notes-file "~/note/index.org")
  (setq org-capture-templates
        (append org-capture-templates
                `(("t" "TODOs")
                  ("te" "Emacs" entry (file+olp "~/note/todo.org" "Emacs" "Priority") "*** TODO %?")
                  ("to" "Other" entry (file+olp "~/note/todo.org" "Other" "Priority") "*** TODO %?")
                  ("ts" "School" entry (file+olp "~/note/todo.org" "School" "Priority") "*** TODO %?")
                  ))))

;;; Blog

(defvar moon-org-html-postamble-format
  '(("en" "<p class=\"author\">Written by %a <%e></p>
<p class=\"first-publish\">First Published on %d</p>
<p class-\"last-modified\">Last modified on %C</p>")))

(defvar moon-org-html-home/up-format
  "<div id=\"org-div-home-and-up-index-page\">
<div>
<a accesskey=\"h\" href=\"%s\"> UP </a> |
<a accesskey=\"H\" href=\"%s\"> HOME </a>
</div>
<div>
<a href=\"./index.xml\"> RSS </a> |
<a href=\"https://github.com/casouri/casouri.github.io\"> Source </a> |
<a href=\"https://creativecommons.org/licenses/by-sa/4.0/\"> License </a>
</div>
</div>")

(defvar moon-publish-root-dir "~/p/casouri/note/")

(require 'f)

(defun moon/publish (&optional force)
  "Publish my blog.
If FORCE is non-nil, only export when org file is newer than html file."
  (interactive)
  (dolist (dir (f-directories moon-publish-root-dir))
    (dolist (post-dir (f-directories dir))
      (moon-html-export post-dir force)))
  (require 'ox-rss)
  (moon-html-export moon-publish-root-dir force)
  (let ((buffer (find-file (expand-file-name "index.org" moon-publish-root-dir))))
    (with-current-buffer buffer
      (org-rss-export-to-rss))
    (kill-buffer buffer)))

(defun moon-html-export (dir &optional force)
  "Export index.org to index.html in DIR is the latter is older.
If FORCE is non-nil, only export when org file is newer than html file."
  (moon-load-theme 'doom-one-light)
  (let ((org-html-postamble-format moon-org-html-postamble-format)
        (org-html-postamble t)
        (org-html-home/up-format moon-org-html-home/up-format)
        (org-file (expand-file-name "index.org" dir))
        (html-file (expand-file-name "index.html" dir)))
    (when (or force (file-newer-than-file-p org-file html-file))
      (let ((buffer (find-file org-file)))
        (with-current-buffer buffer
          (org-html-export-to-html))
        (kill-buffer))))
  (moon-load-theme 'doom-cyberpunk))
