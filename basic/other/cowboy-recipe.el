(setq cowboy-recipe-alist
      (append
       '((isolate . (:repo "casouri/isolate"))
         (smex . (:repo "nonsequitur/smex"))
         (aweshell . (:repo "casouri/aweshell"))
         (olivetti . (:repo "rnkn/olivetti"))
         (ws-butler . (:repo "lewang/ws-butler"))
         (use-package . (:repo "jwiegley/use-package"))
         (bind-key . (:pseudo t :dependency (use-package)))
         (general . (:repo "noctuid/general.el"))
         (which-key . (:repo "justbur/emacs-which-key"))
         (hydra . (:repo "abo-abo/hydra"))
         (rainbow-delimiters . (:repo "Fanael/rainbow-delimiters"))
         (highlight-parentheses . (:repo "tsdh/highlight-parentheses.el"))
         (minions . (:repo "tarsius/minions" :dependency (dash)))
         (magit . (:repo "magit/magit" :dependency (with-editor magit-popup ghub async)))
         (ghub . (:repo "magit/ghub" :dependency (graphql treepy)))
         (treepy . (:repo "volrath/treepy.el"))
         (graphql . (:repo "vermiculus/graphql.el"))
         (async . (:repo "jwiegley/emacs-async"))
         (magit-popup . (:repo "magit/magit-popup"))
         (with-editor . (:repo "magit/with-editor"))
         (moody . (:repo "tarsius/moody"))
         (nyan-mode . (:repo "TeMPOraL/nyan-mode"))
         (hl-todo . (:repo "tarsius/hl-todo"))
         (form-feed . (:repo "wasamasa/form-feed"))
         (buffer-move . (:repo "lukhas/buffer-move"))
         (eyebrowse . (:repo "wasamasa/eyebrowse"))
         (diff-hl . (:repo "dgutov/diff-hl"))
         (expand-region . (:repo "magnars/expand-region.el"))
         (avy . (:repo "abo-abo/avy"))
         (minimap . (:repo "dengste/minimap"))
         (outshine . (:repo "tj64/outshine" :dependency (outorg)))
         (outorg . (:repo "alphapapa/outorg"))
         (projectile . (:repo "bbatsov/projectile"))
         (counsel-projectile . (:repo "ericdanan/counsel-projectile"))
         (ivy . (:repo "abo-abo/swiper"))
         (counsel . (:pseudo t :dependency (ivy)))
         (swiper . (:pseudo t :depedec (ivy)))
         (company . (:repo "company-mode/company-mode"))
         (yasnippet . (:repo "joaotavora/yasnippet"))
         (auto-yasnippet . (:repo "abo-abo/auto-yasnippet"))
         (latex-preview-pane . (:repo "jsinglet/latex-preview-pane"))
         (neotree . (:repo "jaypei/emacs-neotree"))
         (awesome-tab . (:repo "manateelazycat/awesome-tab" :dependency (tabbar)))
         (tabbar . (:repo "dholm/tabbar"))
         (ranger . (:repo "ralesi/ranger.el"))
         (dired-narrow . (:repo "Fuco1/dired-hacks"))
         (toc-org . (:repo "snosov1/toc-org"))
         (htmlize . (:repo "hniksic/emacs-htmlize"))
         (flycheck . (:repo "flycheck/flycheck" :dependency (dash)))
         (flyspell-correct-ivy . (:repo "d12frosted/flyspell-correct"))
         (langtool . (:repo "mhayashi1120/Emacs-langtool"))
         (sly . (:repo "joaotavora/sly"))
         (lsp . (:repo "emacs-lsp/lsp-mode" :dependency (ht f spinner)))
         (company-lsp . (:repo "tigersoldier/company-lsp"))
         (company-box . (:repo "sebastiencs/company-box"))
         (lsp-ui . (:repo "emacs-lsp/lsp-ui"))
         (spinner . (:repo "Malabarba/spinner.el"))
         (dash . (:repo "magnars/dash.el"))
         (f . (:repo "rejeep/f.el" :dependency (dash s)))
         (s . (:repo "magnars/s.el"))
         (ht . (:repo "Wilfred/ht.el" :dependency (dash)))
         (lsp-python . (:repo "emacs-lsp/lsp-python"))
         (pyvenv . (:repo "jorgenschaefer/pyvenv"))
         (aggressive-indent . (:repo "Malabarba/aggressive-indent-mode"))
         (lsp-typescript . (:repo "emacs-lsp/lsp-javascript"))
         (dap-mode . (:repo "yyoncho/dap-mode" . :dependency (lsp-mode dash f tree-mode bui s)))
         (bui . (:repo "alezost/bui.el"))
         (tree-mode . (:repo "emacsorphanage/tree-mode"))
         (web-mode . (:repo "fxbois/web-mode"))
         (lua-mode . (:repo "immerrr/lua-mode"))
         (doom-themes . (:repo "hlissner/emacs-doom-themes"))
         (atom-one-dark-theme . (:repo "jonathanchu/atom-one-dark-theme"))
         (markdown-mode . (:repo "jrblevin/markdown-mode"))
         (ivy-filthy-rich . (:repo "casouri/ivy-filthy-rich"))
         (hungry-delete . (:repo "nflath/hungry-delete"))
         (magit-todos . (:repo "alphapapa/magit-todos" :dependency (pcre2el)))
         (pcre2el . (:repo "joddie/pcre2el"))
         (jump-char . (:repo "lewang/jump-char"))
         (typescript-mode . (:repo "ananthakumaran/typescript.el"))
         (wanderlust . (:repo "wanderlust/wanderlust" :dependency (semi flim apel)))
         (semi . (:repo "wanderlust/semi"))
         (flim . (:repo "wanderlust/flim"))
         (apel . (:repo "wanderlust/apel"))
         (quickrun . (:repo "syohex/emacs-quickrun"))
         (visual-regexp . (:repo "benma/visual-regexp.el"))
         (multiple-cursors . (:repo "magnars/multiple-cursors.el"))
         (eglot . (:repo "joaotavora/eglot" :dependency (jsonrpc)))
         (nyan-lite . (:repo "casouri/nyan-lite"))
         (zone-nyan . (:repo "wasamasa/zone-nyan" :dependency (esxml)))
         (esxml . (:repo "tali713/esxml"))
         (helpful . (:repo "Wilfred/helpful" :dependency (elisp-refs shut-up)))
         (elisp-refs . (:repo "Wilfred/elisp-refs" :dependency (loop)))
         (loop . (:repo "Wilfred/loop.el"))
         (shut-up . (:repo "cask/shut-up"))
         (pp+ . (:fetcher url :url "https://www.emacswiki.org/emacs/download/pp%2b.el"))
         (rainbow-mode . (:fetcher url :url "https://raw.githubusercontent.com/emacsmirror/rainbow-mode/master/rainbow-mode.el"))
         (jsonrpc . (:fetcher url :url "http://git.savannah.gnu.org/cgit/emacs.git/plain/lisp/jsonrpc.el"))
         (undo-tree . (:fetcher url :url "http://git.savannah.gnu.org/cgit/emacs/elpa.git/plain/packages/undo-tree/undo-tree.el"))
         (objed . (:repo "clemera/objed"))
         (helm . (:repo "emacs-helm/helm" :dependency (async popup-el)))
         (popup-el . (:repo "auto-complete/popup-el"))
         (helm-swoop . (:repo "ShingoFukuyama/helm-swoop" :dependency (helm)))
         (ox-rss . (:pseudo t))
         (dired+ . (:fetcher url :url "https://www.emacswiki.org/emacs/download/dired%2b.el"))
         (dired-explore . (:repo "zk-phi/dired-explore"))
         (org-download . (:repo "abo-abo/org-download" :dependency (async)))
         (chinese-word-at-point . (:repo "xuchunyang/chinese-word-at-point.el"))
         (helm-c-yasnippet . (:repo "emacs-jp/helm-c-yasnippet"))
         (color-rg . (:repo "manateelazycat/color-rg"))
         (ccls . (:repo "MaskRay/emacs-ccls"))
         (writegood-mode . (:repo "bnbeckwith/writegood-mode"))
         (eldoc-box . (:repo "casouri/eldoc-box"))
         (realgud . (:repo "realgud/realgud" :dependency (test-simple loc-changes load-relative)))
         (test-simple . (:repo "rocky/emacs-test-simple"))
         (loc-changes . (:repo "rocky/emacs-loc-changes"))
         (load-relative . (:repo "rocky/emacs-load-relative"))
         (package-lint . (:repo "purcell/package-lint"))
         (flymake-diagnostic-at-point . (:repo "meqif/flymake-diagnostic-at-point")))
       cowboy-recipe-alist))
