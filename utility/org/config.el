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


;;; Config

;;;; org-capture

(post-config| general
  (moon-default-leader
    "uo" '(:ignore t :which-key "org")
    "uoc" #'org-capture
    ))



(with-eval-after-load 'org-capture
  (setq org-default-notes-file "~/note/index.org")
  (setq org-capture-templates
        (append org-capture-templates
                `(("l" "Links")
                  ("la" "Design related links." item (file+olp "~/note/index.org" "Links" "Design links") "- %? :: ")
                  ("lp" "programming related links." item (file+olp "~/note/index.org" "Links" "Programming links") "- %? :: ")
                  ("lw" "Web related links." item (file+olp "~/note/index.org" "Links" "Web links") "- %? :: ")
                  ("lb" "Blog links." item (file+olp "~/note/index.org" "Links" "Blog links") "- %? :: ")
                  ("lu" "Utility links." item (file+olp "~/note/index.org" "Links" "Utility links") "- %? :: ")
                  ("lt" "Tools" item (file+olp "~/note/index.org" "Links" "Tool links") "- %? :: ")
                  ("n" "Notes")
                  ("nr" "Random notes" entry (file+olp "~/note/index.org" "Notes" "Random notes") "*** %?")
                  ("nv" "Vim notes" entry (file+olp "~/note/index.org" "Notes" "Vim notes") "*** %? ")
                  ("ne" "Emacs notes" entry (file+olp "~/note/index.org" "Notes" "Emacs notes") "*** %?")
                  ("nt" "Tutorial notes" entry (file+olp "~/note/index.org" "Notes" "Tutorial notes") "*** %?")
                  ("t" "Tasks")
                  ("ti" "Ideas" entry (file+olp "~/note/index.org" "Tasks" "Ideas") "*** TODO %?")
                  ("tt" "Tasks" entry (file+olp "~/note/index.org" "Tasks" "Tasks") "*** TODO %?")
                  ))))
