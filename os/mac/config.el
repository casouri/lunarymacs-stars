;;
;; Var
;;

(defconst IS-MAC   (eq system-type 'darwin))

;;
;; Config
;;

(cond (IS-MAC
       (when (display-graphic-p)
	 (add-to-list 'exec-path "/usr/local/bin")
	 (add-to-list 'exec-path (expand-file-name "~/bin")))))

;; (use-package| exec-path-from-shell
;;   :config (exec-path-from-shell-initialize))

