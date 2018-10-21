(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'wl-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'wl-user-agent
      'wl-user-agent-compose
      'wl-draft-send
      'wl-draft-kill
      'mail-send-hook))

(setq wl-quicksearch-folder "[]")
(setq elmo-search-default-engine 'notmuch)
(setq wl-summary-width 150)
;; don't ask for confirmation when there are too many mail
(setq elmo-folder-update-confirm nil)

(add-hook 'wl-folder-mode-hook (lambda () (wl-folder-sync-region (point-min) (point-max))))

;; send mail
;; default template
(setq wl-smtp-connection-type 'starttls
      wl-smtp-posting-port 587
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "casouri"
      wl-smtp-posting-server "smtp.gmail.com"
      wl-local-domain "gmail.com"
      wl-message-id-domain "smtp.gmail.com")

(setq wl-user-mail-address-list '("casouri@gmail.com" "ykf5041@psu.edu"))
(setq wl-template-alist
      '(("GMAIL"
         (wl-from . "Yuan Fu <casouri@gmail.com>")
         (wl-smtp-posting-user . "casouri")
         (wl-smtp-posting-server . "smtp.gmail.com")
         (wl-smtp-authenticate-type ."plain")
         (wl-smtp-connection-type . 'starttls)
         (wl-smtp-posting-port . 587)
         (wl-local-domain . "gmail.com")
         (wl-message-id-domain . "smtp.gmail.com")
         ("From" . wl-from))
        ("PSU"
         (wl-from . "Yuan Fu <ykf5041@psu.edu>")
         (wl-smtp-posting-user . "ykf5041@psu.edu")
         (wl-smtp-posting-server . "smtp.office365.com")
         (wl-smtp-authenticate-type . "login")
         (wl-smtp-connection-type . 'starttls)
         (wl-smtp-posting-port . 587)
         ("From" . wl-from))))

;; ignore craps in header
(setq wl-message-ignored-field-list
      '(".")
      wl-message-visible-field-list
      '("^\\(To\\|Cc\\):"
        "^Subject:"
        "^\\(From\\|Reply-To\\):"
        "^\\(Posted\\|Date\\):"
        "^Organization:"
        "^X-\\(Face\\(-[0-9]+\\)?\\|Weather\\|Fortune\\|Now-Playing\\):")
      wl-message-sort-field-list
      '("^Reply-To" "^Posted" "^Date" "^Organization"))

;; Use the same address to reply
(setq wl-draft-config-alist
      '(((string-match "psu" wl-draft-parent-folder)
         (template . "PSU"))
        ((string-match "gmail" wl-draft-parent-folder)
         (template . "GMAIL"))))

;; refile
;; (setq wl-refile-rule-alist
;;       `("From"
;;         (,(regexp-quote "@pnc.com") . ,moon-wl-trvial-folder)
;;         (,(regexp-quote "@github.com") . ,moon-wl-trvial-folder)
;;         (,(regexp-quote "noreply@emacs-china.org") . ,moon-wl-trvial-folder)
;;         (,(regexp-quote "no-reply@accounts.nintendo.com") . ,moon-wl-trvial-folder)
;;         (,(regexp-quote "ebay@ebay.com") . ,moon-wl-trvial-folder)
;;         (,(regexp-quote "no-reply@mail.newsletter.instructables.com") . ,moon-wl-trvial-folder)))

;; expire
(setq wl-expire-alist
      '(("[tag:news]" (date 30) ".~/Mail/Gmail/[Gmail]/Trash")
        ([tag:mailling-list] (date 30) ".~/Mail/Gmail/[Gmail]/Trash")
        ([tag:mailling-list] (date 30) ".~/Mail/Gmail/[Gmail]/Trash")))

;; x-face
(autoload 'x-face-decode-message-header "x-face-e21")
(setq wl-highlight-x-face-function 'x-face-decode-message-header)
(setq wl-x-face-file (concat moon-star-dir "utility/email/x-face"))

(setq elmo-imap4-use-modified-utf7 t)
(setq wl-folder-check-async t)
(setq elmo-imap4-use-modified-utf7 t)

(require 'bbdb)
