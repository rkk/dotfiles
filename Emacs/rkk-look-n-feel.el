;; Defines look'n'feel, complimentary settings to the theme settings - run AFTER theme
;; Best used with a dark theme
;; (custom-set-faces
;;  '(mumamo-background-chunk-major ((((class color) (min-colors 88) (background dark)) nil)))
;;  '(mumamo-border-face-in ((t (:inherit font-lock-preprocessor-face :underline t :weight bold))))
;;  '(font-lock-comment-delimiter ((t (:foreground "#5F5A60"))))
;;  '(font-lock-comment-delimiter-face ((t (:foreground "#5F5A60"))))
;;  '(font-lock-comment-face ((t (:foreground "#5F5A60")))))

;; Font hacking (still having problems with bolded text in Mac OS X)
;; Try running "defaults delete org.gnu.Emacs AppleAntiAliasingThreshold" in the terminal
;; before starting Emacs, as this (sometimes) helps.
(set-frame-font  "-apple-Monaco-normal-normal-normal-mono-14-*-*-*-c-*-iso8859-1")


;; Eshell prompt and directory listings (PS1 in sh-terms)
;; (custom-set-faces  '(eshell-prompt ((t (:foreground "#5F5A60")))))
;; (custom-set-faces  '(eshell-ls-directory ((t (:foreground "#CCDD55")))))


;; Term terminal prompt and directory listings
;; (custom-set-faces  '(term-prompt ((t (:foreground "#5F5A60" :background "#000000")))))
;; (custom-set-faces  '(term-ls-directory ((t (:foreground "#CCDD55")))))
;; This resets the color to white
(setq ansi-term-color-vector [unspecified “black” “red3” “lime green” “yellow3” “DeepSkyBlue?3” “magenta3” “cyan3” “white”])


;; Ugly highlight bar in Lisp-mode, no thanks
(custom-set-faces '(highlight ((t nil))))


;; Set the font
;; (set-face-font 'default "-apple-monaco-normal-r-normal--13-0-72-72-m-0-iso10646-1")
(setq-default line-spacing 0.1)


;; PHP-mode background
;; (custom-set-faces  '(mumamo-background-chunk-submode1 ((t (:background nil)))))


;; PHP-mode function name, more fancy hook
;; (eval-after-load 'php-mode
;;   '(progn
;;      (set-face-foreground 'font-lock-function-name-face "#CCDD55")))


;; Strings need more attention
;; (eval-after-load 'php-mode
;;   '(progn
;;      (set-face-foreground 'font-lock-string-face "#58A473")))


;; No underline or italics
;; (custom-set-faces '(underline ((nil (:underline nil)))))
;; (custom-set-faces '(italic ((nil (:italic nil)))))


;; Paren matching
;; (custom-set-faces '(show-paren-match-face ((t (:foreground "#2e3436" :background "#73d216")))))
;; (custom-set-faces '(show-paren-mismatch-face ((t (:foreground "#2e3436" :background "#ef2929")))))


;; Search highlighting
;; (custom-set-faces '(isearch ((t (:foreground "#080808" :background "#edd400")))))
;; (custom-set-faces '(isearch-lazy-highlight-face ((t (:foreground "#080808" :background "#edd400")))))


;; Diff
;; (custom-set-faces '(diff-removed ((t (:background "firebrick")))))
;; (custom-set-faces '(diff-added ((t (:background "DarkOliveGreen4")))))


;; Set margin
(setq left-margin-width 1)
(setq right-margin-width 1)
