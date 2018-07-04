;;
;; Var
;;

(defvar moon-banner "
███╗   ███╗ ██████╗  ██████╗ ███╗   ██╗    ███████╗███╗   ███╗ █████╗  ██████╗███████╗
████╗ ████║██╔═══██╗██╔═══██╗████╗  ██║    ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝
██╔████╔██║██║   ██║██║   ██║██╔██╗ ██║    █████╗  ██╔████╔██║███████║██║     ███████╗
██║╚██╔╝██║██║   ██║██║   ██║██║╚██╗██║    ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║
██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██║ ╚████║    ███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║
╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝    ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
                                                                                      ")

(defvar moon-short-banner "
███╗   ███╗ ██████╗  ██████╗ ███╗   ██╗
████╗ ████║██╔═══██╗██╔═══██╗████╗  ██║
██╔████╔██║██║   ██║██║   ██║██╔██╗ ██║
██║╚██╔╝██║██║   ██║██║   ██║██║╚██╗██║
██║ ╚═╝ ██║╚██████╔╝╚██████╔╝██║ ╚████║
╚═╝     ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝
                                       ")

(defvar moon-log-news nil
  "Whether to show news on homepage.")

(defun moon-draw ()
  "draw a pixel."
  (interactive)
  (insert "██"))

(defvar moon-moon-banner-1 "
          ████████
      ██████████████
  ██████████         █
  ████████
████████
████████
████████
████████
████████
  ████████            █
  ██████████        ██
      ██████████████
          ████████
")

(defvar moon-moon-banner-2 "
           ████
      ████████████ 
   ███████         █ 
  ██████  
 █████  
██████  
██████  
██████ 
 █████   
  ██████            █
   ███████        ██
      ████████████
          █████ 
")


;;
;; Func
;;


(defun moon/draw-homepage (banner short-banner)
  "Draw MOON EMACS or MOON on the middle of current buffer.

MOON is used when buffer's width is less than 86."
  (interactive)
  (unless noninteractive
    (moon/draw-star 10)
    (moon/draw-moon banner short-banner))
  (moon/log-news)
  (goto-char (point-min)))

;; deprecate
(defun moon/draw-star (num)
  "Draw NUM stars randomly"
  (interactive))

(defun moon/draw-moon (banner short-banner)
  "Draw moon"
  (interactive)
  (let* ((banner (if (>= (window-width) 86)
                       banner
                     short-banner))
           (banner-list (split-string (car banner) "\n"))
           (banner-width (or (nth 1 banner) (length (nth 1 banner-list))))
           (pad-length (let ((total-extra (- (window-width) banner-width)))
                         (if (wholenump total-extra)
                             (/ total-extra 2)
                           0))))
      (let ((space-to-insert
	     (make-string pad-length ?\s)))
        (insert (make-string 10 ?\n))
        (dolist (line banner-list)
	  (insert space-to-insert)
	  (insert line)
	  (insert "\n")))))

(defun moon/log-news ()
  "Log core changes since last pull."
  (interactive)
  (when moon-log-news
    (insert "\n\n\n* Core changes\n\n")
    (insert (shell-command-to-string (concat "cd " moon-emacs-d-dir " ; git log --pretty=format:'** %h - %s%n%n%b' --grep ':core:'")))))

;;
;; Config
;;

;; Homepage
(add-hook 'moon-init-hook (lambda () (moon/draw-homepage `(,moon-moon-banner-1 40) '(moon-moon-banner))) t)
(add-hook 'moon-post-init-hook #'moon-display-benchmark t)


;; visual line mode
;; visual line mode makes swiper very slow
;; so I'll disable it for now
;; (global-visual-line-mode 1)
