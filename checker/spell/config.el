;; -*- lexical-binding: t -*-

(use-package| (flyspell :system t)
  :hook ((fundamenta-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode))
  :config
  (setq flyspell-issue-message-flag nil)
  ;; (when (executable-find "hunspell")
  ;;   (setq-default ispell-program-name "hunspell")
  ;;   (setq ispell-really-hunspell t)
  ;;   (setq ispell-dictionary "en_US"))
  )


(post-config| general
  (moon-default-leader
    "ts" #'moon/toggle-spell-check))


(use-package| flyspell-correct-ivy
  :after (flyspell ivy)
  :config
  ;; https://www.emacswiki.org/emacs/FlySpell
  (setq flyspell-issue-message-flag nil))

(post-config| general
  (moon-default-leader
    "ef" #'flyspell-correct-previous
    "eg" #'langtool-check
    "ec" #'langtool-correct-buffer
    "is" #'synonyms))

;; (use-package| langtool
;;   :commands langtool-check
;;   :config
;;   (setq langtool-language-tool-server-jar "/usr/local/Cellar/languagetool/4.1/libexec/languagetool-server.jar")
;;   (setq langtool-java-bin "/usr/bin/java"))

(use-package| (writegood-mode :fetcher github :repo "bnbeckwith/writegood-mode")
  :hook ((fundamental-mode org-mode) . writegood-mode))

;; (use-package| (synonyms :fetcher url :url "https://www.emacswiki.org/emacs/download/synonyms.el")
;;   :commands synonyms)
