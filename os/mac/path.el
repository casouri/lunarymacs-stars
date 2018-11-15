;;; PATH

(defun add-path (path)
  "Add PATH to path."
  (setenv "PATH" (concat path ":" (getenv "PATH"))))

;; ;; python
;; (add-path "/usr/local/lib/python3.6:/usr/local/lib/python3.6/site-packages:/System/Library/Frameworks/Python.framework/Versions/2.7:/Users/yuan/bin")

;; let make point to gmake
;; If you need to use these commands with their normal names, you
;; can add a "gnubin" directory to your PATH from your bashrc like:
(add-path "/usr/local/opt/make/libexec/gnubin")

;; ;; rust
;; (add-path "$HOME/.cargo/bin")

;; ;; tex support
;; (add-path "/Library/TeX/texbin/")

;; ;; node
;; (add-path "$PATH:/usr/local/Cellar/node/10.10.0/")

;;; ENV
;; Additionally, you can access their man pages with normal names if you add
;; the "gnuman" directory to your MANPATH from your bashrc as well:
(setenv "MANPATH" "/usr/local/opt/make/libexec/gnuman:$MANPATH")

;; pipenv shell now create .venv under project dir
(setenv "PIPENV_VENV_IN_PROJECT" "true")

;; just print everthing and use Emacs as pager
(setenv "PAGER" "cat")

;;syntax highlighting for cheat
(setenv "CHEATCOLORS" "true")

;;; RC

;; default editor
(setenv "VISUAL" "emacsclient")
(setenv "EDITOR" "$VISUAL")


;; fix python error about locale
(setenv "LC_ALL" "en_US.UTF-8")
(setenv "LANG" "en_US.UTF-8")

(setq exec-path '("/usr/local/opt/make/libexec/gnubin" "/usr/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "~/bin" "/Library/TeX/texbin" "/usr/local/aria2/bin" "/usr/local/MacGPG2/bin" "/opt/X11/bin" "/Library/Frameworks/Mono.framework/Versions/Current/Commands" "/Applications/Wireshark.app/Contents/MacOS" "/Library/TeX/texbin/" "/Users/yuan/.cargo/bin" "/usr/local/opt/make/libexec/gnubin" "/usr/local/lib/python3.6" "/usr/local/lib/python3.6/site-packages" "/System/Library/Frameworks/Python.framework/Versions/2.7" "/usr/local/sbin" "/Users/yuan/bin"))
