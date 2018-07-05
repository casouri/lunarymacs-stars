;;
;;; Var
;;

(defvar moon-do-draw-footer nil
  "Whether to draw footer.")

(defvar moon-do-draw-image-moon nil
  "Whether to draw image moon.")

(defvar moon-image-moon (create-image (expand-file-name "moon-300.xpm" (concat moon-star-dir "basic/homepage")))
  "Image moon.")



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
   █████████         █
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

(defvar moon-footer-1 "
                                                            ██████████████████
                                                        ██████████████████████████
                                                    ████████████████████████████████
                                                  ██████████████████████████████████████                          ██████
                      ██████████████          ████████████████████████████████████████████                    ██████████████            ████████████
                ██████████████████████████      ████████████████████████████████████████████                ██████████████████      ██████████████████████
            ██████████████████████████████████    ██████████████████████████████████████████████        ████████████████████    ████████████████████████████
        ██████████████████████████████████████████    ████████████████████████████████████████████    ████████████████████    ████████████████████████████████
    ████████████████████████████████████████████████      ██████████████████████████████████████    ██████████████████    ██████████████████████████████████████
████████████████████████████████████████████████████████      ██████████████████████████████      ████████████████      ██████████████████████████████████████████ ")

(defvar moon-footer-2 "
                    ████████████
                ████████████████████
            ██████████████████████████
          ██████████████████    ██████
      ████████████████████        ████
    ██████████████████████      ██████
    ██████████████████████        ██
  ████████████████████████
████████████████████████████
████████████████████████████
██████████████████████████████                                                                                                ██████
████████████████████████████████                                        ████████████                                    ████████████████
██████████████████████████████████                                ████████████████████                                ████████████████████
██████████████████████████████████████                          ████████████████████████                            ██████████████████████
████████████████████████████████████████                      ██████████████████    ████                        ██████████████████    ████
████████████████████████████████████████████                ████████████████      ██████                      ██████████████████    ██████
██████████████████████      ██████████████████████        ██████████████████        ██                      ████████████████████      ██
████████████████████    ██    ████████████████████████  ████████████████████                              ████████████████████████
████████████████      ██████      ██████████████████    ██████████████████████                          ████████████████████████████
████████████      ██████████████      ████████████    ██████████████████████████████      ██████      ████████████████████████████████                      ████
████████      ██████████████████████      ██████    ██████████████████████████████      ██████████    ████████████████████████████████████            ██████████
██        ██████████████████████████████          ██████████████████████████████    ████████████████      ████████████████████████████████████      ████████████
  ██████████████████████████████████████████    ██████████████████████████████    ██████████████████████        ██████████████████████████████████      ████████
██████████████████████████████████████████    ████████████████████████████      ██████████████████████████████        ████████████████████████████████        ██
██████████████████████████████████████      ████████████████████████        ████████████████████████████████████████          ██████████████████████████████
██████████████████████████████████      ████████████████████████      ██████████████████████████████████████████████████████      ██████████████████████████████
")

(defvar moon-long-banner moon-moon-banner-1
  "The longer banner.")

(defvar moon-short-banner moon-moon-banner-1
  "The short banner.")

(defvar moon-homepage-footer moon-footer-1
  "Footer for homepage.")

;;
;;; Func
;;


;; deprecate
(defun moon-draw-star (num)
  "Draw NUM stars randomly"
  (interactive))

(defun moon-draw-footer (footer &optional shift)
  "Draw the FOOTER at the bottom of buffer and shift up SHIFT lines."
  (interactive)
  (let* ((height (window-height))
         (current-eof (string-to-number
                       (replace-regexp-in-string "^Line " "" (what-line))))
         (footer-list (split-string footer "\n"))
         (footer-height (length footer-list))
         (width (window-width)))
    (insert (make-string (- height current-eof footer-height (or shift 0)) ?\n))
    (dolist (line footer-list)
      (insert (if (> (length line) width)
                  (substring line 0 width)
                line))
      (insert ?\n))))

(defun moon-draw-image-moon (beg end)
  "Put an image moon as overlay from BEG to END."
  (overlay-put (make-overlay beg end) 'display moon-image-moon))

(defun moon-draw-moon (banner short-banner)
  "Draw moon."
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

;;;; Final function

(defun moon/draw-homepage ()
  "Draw MOON EMACS or MOON on the middle of current buffer.

MOON is used when buffer's width is less than 86."
  (interactive)
  (unless noninteractive
    (insert (make-string 5 ?\n))
    
    (if (and window-system moon-do-draw-image-moon)
        (progn
          (insert (make-string (/ (- (window-width) 50) 2) ?\s))
          (moon-draw-image-moon (1- (point)) (point)))
      (insert (make-string 5 ?\n))
      (moon-draw-moon `(,moon-long-banner 40) `(,moon-short-banner 20)))
    (goto-char (point-max))
    (when moon-do-draw-footer
      (moon-draw-footer moon-footer (if (and moon-do-draw-image-moon window-system) 20 0)))
    (moon/log-news))
  (goto-char (point-min)))

;;
;;; Config
;;


;; Homepage
(add-hook 'moon-init-hook #'moon/draw-homepage t)
(add-hook 'moon-post-init-hook #'moon-display-benchmark t)

;; splash screen
