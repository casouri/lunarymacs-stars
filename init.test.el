;;(package-initialize t)

(defvar moon-setup nil)

(if moon-setup
    (load (concat (expand-file-name user-emacs-directory) "core/core-setup.el"))
  (load (concat (expand-file-name user-emacs-directory) "core/core-startup.el")))

(moon| :basic
       ;; non-evil
       homepage
       key
       ;; evil
       angel
       ui
       other
       edit
       project
       :completion
       ;; ivy
       helm
       company
       snippet
       :os
       mac
       :utility
       ;; email
       markdown
       ;; eshell
       shell
       tex
       dir
       git
       org
       pdf
       ;; imagemagick
       :checker
       syntax
       spell
       :lang
       lsp
       general
       assembly
       ;; arduino
       matlab
       java
       common-lisp
       cc
       python
       elisp
       ;; rust
       javascript
       web
       lua
       yaml
       )
