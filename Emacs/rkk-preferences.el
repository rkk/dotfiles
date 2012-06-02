;;
;; Various preferences
;;

;; Use UTF-8 all over
(set-language-environment   "UTF-8")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system  'utf-8)
(setq buffer-file-coding-system 'utf-8)

;; Show line and column numbers
(column-number-mode 1)
(line-number-mode 1)

;; No scrollbar
(toggle-scroll-bar -1)

;; Scroll by one line, not several
(setq scroll-step 1)

;; No splashscreen
(setq inhibit-splash-screen t)

;; Flash matching parenthesis
(show-paren-mode 1)

;; Set the cursor to an horisontal bar
;;(setq-default cursor-type 'hbar)
;;(setq-default cursor-type 'hbar)
;;(setq-default cursor-in-non-selected-windows 'box)

;; Hide the mouse pointer when typing
(mouse-avoidance-mode 'animate)

;; Delete the selection with a keypress
(delete-selection-mode t)

;; Disable beeping and visual bell, use modeline message instead
(setq ring-bell-function (lambda () (message "*beep*")))

;; No backup files
(setq make-backup-files nil)

;; Save minibuffer history
(savehist-mode 1)

;; allow remote editing through Transmit or other FTP clients that check file modification
(setq backup-by-copying t)

;; Enable better buffer switching (neverending story)
;(iswitchb-mode t)

;; Revert buffer, if file changed on disk
(global-auto-revert-mode 1)

;; Set indent to 4 spaces, not tabs
(setq-default indent-tabs-mode t)
(setq standard-indent 4)
(setq tab-width 4)
(setq c-basic-offset 4)
(setq default-tab-width 4)

;; Get rid of yes-or-no questions - y or n is enough
(defalias 'yes-or-no-p 'y-or-n-p)

;; Make buffer names unique (handy for index.php and such)
;(setq uniquify-buffer-name-style 'forward)

;; Run for all modes (might conflict):
;; (wrap-region-global-mode t)


;; Highlight braces and parens
(font-lock-add-keywords nil '(("\\([\{\}\\[\]\(\)]+\\)" 1 font-lock-keyword-face prepend)))


;; Enable overwriting selection in various modes
(add-hook 'lisp-mode     'delete-selection-mode t)
;(add-hook 'php-mode      'delete-selection-mode t)
(add-hook 'python-mode   'delete-selection-mode t)


;; Format title bar to show full path of current file
(setq-default frame-title-format
   (list '((buffer-file-name " %f"
             (dired-directory
              dired-directory
              (revert-buffer-function " %b"
              ("%b - Dir:  " default-directory)))))))

;; Always open external files from Finder in the same window (Emacs-frame)
(setq ns-pop-up-frames nil)

;; Provide undo and redo operations for window configurations
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; Autocomplete (start manually with ac-start)
;;(require 'auto-complete)
;;
;; Autocomplete 1.3 (http://cx4a.org/software/auto-complete/manual.html#Installation)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/auto-complete/ac-dict")
;;(require 'auto-complete-config)
;;(ac-config-default)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
;(ac-config-default)
;(setq ac-auto-show-menu 0.1)

;; Use Return for completion instead of Tab if using Yasnippet
;(ac-set-trigger-key "RET")
;(define-key ac-complete-mode-map "\r" 'ac-complete)
;(define-key ac-complete-mode-map "\r" 'ac-complete)

;(global-auto-complete-mode t)


;; Use up/down arrow keys in the shell as in a normal shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(eval-after-load 'shell
  '(progn
     (define-key shell-mode-map [up] 'comint-previous-input)
     (define-key shell-mode-map [down] 'comint-next-input)
     (define-key shell-mode-map "\C-p" 'comint-previous-input)
     (define-key shell-mode-map "\C-n" 'comint-next-input)))


;; Ruby tabs
(setq ruby-indent-level 4)

;; Imported from init.el
;(add-to-list 'flymake-err-line-patterns
;  '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))
;(add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

;; Drupal-type extensions for Flymake
;(add-to-list 'flymake-allowed-file-name-masks '("\\.module$"  flymake-php-init))
;(add-to-list 'flymake-allowed-file-name-masks '("\\.install$" flymake-php-init))
;(add-to-list 'flymake-allowed-file-name-masks '("\\.inc$"     flymake-php-init))
;(add-to-list 'flymake-allowed-file-name-masks '("\\.engine$"  flymake-php-init))
;(add-to-list 'flymake-allowed-file-name-masks '("\\.view$"  flymake-php-init))
;(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))


;; Yasnippet for PHP
;;(add-hook 'php-mode-hook            'yas/minor-mode)


;; Hideshow
(add-hook 'php-mode-hook 'hs-minor-mode)
(add-hook 'css-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)
(add-hook 'ruby-mode-hook 'hs-minor-mode)

;; Add hideshow markers to the fringe (hideshowvis)
;(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")
;(dolist (hook (list 'php-mode-hook
;                    'css-mode-hook
;					'python-mode-hook
;					'ruby-mode-hook))
;  (add-hook hook 'hideshowvis-enable))


;; Highlight current function
;(setq which-func-modes t)
;(add-hook 'php-mode-hook (lambda () (which-func-mode 1)))
;(add-hook 'python-mode-hook (lambda () (which-func-mode 1)))
;(add-hook 'ruby-mode-hook (lambda () (which-func-mode 1)))


;; Proper array indention for PHP
;(add-hook 'php-mode-hook (lambda ()  (c-set-offset 'case-label '+)
;  (c-set-offset 'arglist-close 0)
;  (c-set-offset 'arglist-intro '+) ; for FAPI arrays and DBTNG
;  (c-set-offset 'arglist-cont-nonempty 'c-lineup-math)))
;
;(paren-activate)

;; Super-charged recent files
;(recentf-mode t)

; 50 files ought to be enough.
;(setq recentf-max-saved-items 50)

;; Do not prompt, when switching to non-existing buffers or files
;(setq confirm-nonexistent-file-or-buffer nil)
;(setq ido-create-new-buffer 'always)

;; Do not prompt for buffers with associated processes
(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions))

;(add-hook 'css-mode-hook (lambda () (rainbow-mode 1)))

;(put 'upcase-region 'disabled nil)


;; Yasnippet
;;(setq yas/snippet-dirs "~/.emacs.d/snippets")
;;(yas/load-directory yas/snippet-dirs)


