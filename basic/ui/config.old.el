
;;; atom-one-dark-theme

(use-package| atom-one-dark-theme
  :defer t
  :config
  ;; (set-face-attribute 'company-tooltip-common nil :foreground "#C678DD")
  (with-eval-after-load 'company (set-face-attribute 'company-tooltip-common-selection nil :foreground "#C678DD"))
  ;; (set-face-attribute 'company-preview-common nil :foreground "#C678DD")
  )



;;; doom-themes

(add-hook 'moon-load-theme-hook
          (lambda ()
            (when (equal moon-current-theme
                         "doom-one")
              (set-face-attribute 'mode-line nil :background "#6F349C")
              (set-face-attribute 'lazy-highlight nil :inherit 'default :background nil :foreground "#CFD7E5" :distant-foreground nil)
              ))
          ;; (set-face-attribute 'company-tooltip-common-selection nil :foreground "#C678DD")
          )

;;; spacemacs-theme

(use-package| spacemacs-theme
  :defer t
  :config
  (add-to-list 'custom-theme-load-path (car (directory-files moon-package-dir "spacemacs-theme.+")) t)
  (custom-set-variables '(spacemacs-theme-custom-colors ;                          ~~GUI~~   ~~TER~~                       ~~GUI~~   ~~TER~~
                          '((bg1        . (if (eq variant 'dark) (if (true-color-p) "#222226" "#262626") (if (true-color-p) "#fbf8ef" "#ffffff")))
                            (bg2        . (if (eq variant 'dark) (if (true-color-p) "#17181B" "#1c1c1c") (if (true-color-p) "#efeae9" "#e4e4e4")))
                            (comment-bg . (if (eq variant 'dark) (if (true-color-p) "#23282A" "#262626") (if (true-color-p) "#ecf3ec" "#ffffff")))
                            (highlight  . (if (eq variant 'dark) (if (true-color-p) "#61526E" "#444444") (if (true-color-p) "#d3d3e7" "#d7d7ff")))
                            (act2       . (if (eq variant 'dark) (if (true-color-p) "#603D8E" "#444444") (if (true-color-p) "#d3d3e7" "#d7d7ff")))
                            (border     . (if (eq variant 'dark) (if (true-color-p) "#603D8E" "#444444") (if (true-color-p) "#d3d3e7" "#d7d7ff")))
                            ))))
