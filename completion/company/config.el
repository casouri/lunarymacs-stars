;; -*- lexical-binding: t -*-

(use-package| company
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 2
        company-dabbrev-downcase nil
        company-tooltip-limit 15)
  (setq-default company-search-filtering t)
  (global-company-mode 1))

(post-config| general
  (general-define-key
   :keymaps '(company-active-map
              company-search-map)
   "<escape>" #'company-search-abort
   "C-j"      #'company-search-candidates
   "C-p"      #'company-select-previous
   "C-n"      #'company-select-next))

;; (use-package| company-box
;;   ;; TODO common face
;;   :init
;;   ;; (defface company-box-candidates
;;   ;;   '((t (:inherit company-tooltip)))
;;   ;;   "Override face of company-box.")
;;   ;; (defface company-box-selection
;;   ;;   '((t (:inherit company-tooltip-selection)))
;;   ;;   "Override face of company-box.")
;;   ;; (defface company-box-annotation
;;   ;;   '((t (:inherit company-tooltip-annotation)))
;;   ;;   "Override face of company-box.")
;;   :config
;;   (setq company-box-enable-icon nil)
;;   (setq company-box-doc-delay 0.3)
;;   :hook (company-mode . company-box-mode))
