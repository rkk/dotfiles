;;
;; Various handy functions
;;

(defun rkk-term-local ()
  (interactive)
  (ansi-term "bash" "localhost"))


;; Make selected window dedicated
(defun rkk-toggle-window-sticky ()
  "Set the current window dedicated, e.g. the current buffer will not change"
  (interactive)
  (set-window-dedicated-p (selected-window) (not (window-dedicated-p (selected-window)))))

;; Copy and paste the previous line (handy as M-p and M-n)
(defalias 'copy-prev-line 'copy-from-above-command)
(defun copy-one-from-prev-line (&optional arg)
  (interactive "P")
  (copy-prev-line (or arg 1)))

(defun copy-one-from-next-line (&optional arg)
  (interactive "P")
  (copy-next-line (or arg 1)))

(defun copy-next-line (&optional arg)
  "Copy characters from next nonblank line, starting just above point.
Copy ARG characters, but not past the end of that line.
If no argument given, copy the entire rest of the line.
The characters copied are inserted in the buffer before point."
  (interactive "P")
  (let ((cc (current-column))
    n (string ""))
    (save-excursion
      (end-of-line)
      (forward-char 1)
      (skip-chars-forward "\ \t\n")
      (move-to-column cc)
      ;; Default is enough to copy the whole rest of the line.
      (setq n (if arg (prefix-numeric-value arg) (point-max)))
      ;; If current column winds up in middle of a tab,
      ;; copy appropriate number of "virtual" space chars.
      (if (< cc (current-column))
      (if (= (preceding-char) ?\t)
          (progn
        (setq string (make-string (min n (- (current-column) cc)) ?\s))
        (setq n (- n (min n (- (current-column) cc)))))
        ;; In middle of ctl char => copy that whole char.
        (backward-char 1)))
      (setq string (concat string
               (buffer-substring
                (point)
                (min (save-excursion (end-of-line) (point))
                 (+ n (point)))))))
    (insert string)))


;; Easily called like:
;; (global-set-key (kbd "<f1>") (lambda () (interactive) (call-interactively 'google)))
(defun google (query)
  "Performs a search on Google."
  (interactive "sGoogle: ")
  (browse-url (concat "http://google.com/search?q=" query)))


;; Google the selected region
(defun google-region (beg end)
  "Google the selected region."
  (interactive "r")
  (browse-url (concat "http://www.google.com/search?q=" (buffer-substring beg end))))


;; Search the entire Drupal site for the word at point
(defun drupallookup ()
  "Searches the Drupal site for the word at point."
  (interactive)
  (let ((w (word-at-point)))
    (if w
	(browse-url
	 (concat "http://drupal.org/search/apachesolr_multisitesearch/"
		 (url-hexify-string w)
		 "?filters=ss_meta_type:documentation"))
      (error "no word at point"))))


;; Search only the Drupal API site for word at point.
(defun drupalapilookup ()
  "Searches the Drupal API for the word at point."
  (interactive)
  (let (myword myurl)
	(setq myword
		  (if (and transient-mark-mode mark-active)
			  (buffer-substring-no-properties (region-beginning) (region-end))
			(thing-at-point 'symbol)))

	(setq myurl (concat "http://api.drupal.org/api/search/6/" myword))
	(browse-url myurl)
	))


;; Search the entire Drupal site for the word at point
(defun symfonylookup ()
  "Searches the Symfony site for the word at point."
  (interactive)
  (let ((w (word-at-point)))
    (if w
	(browse-url
	 (concat "http://www.symfony-project.com/"
		 (url-hexify-string w)
		 "?filters=ss_meta_type:documentation"))
      (error "no word at point"))))


;; Search only the Symfony API site for word at point.
(defun symfonyapilookup ()
  "Searches the Symfony API for the word at point."
  (interactive)
  (let ((w (word-at-point)))
    (if w
	(browse-url
	 (concat "http://www.symfony-project.org/api/search/1_4?search="
		 (url-hexify-string w)
		 ))
      (error "no word at point"))))


;; CSS color values colored by themselves
;; http://xahlee.org/emacs/emacs_html.html
(defvar hexcolour-keywords
'(("#[abcdef[:digit:]]\\{6\\}"
   (0 (put-text-property
       (match-beginning 0)
       (match-end 0)
       'face (list :background 
                   (match-string-no-properties 0)))))))

(defun hexcolour-add-to-font-lock ()
(font-lock-add-keywords nil hexcolour-keywords))
(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)


;; Kill all Dired buffers
;; Thanks, http://github.com/chrislo/emacs-config/blob/master/crl-defuns.el
(defun kill-all-dired-buffers()
      "Kill all dired buffers."
      (interactive)
      (save-excursion
        (let((count 0))
          (dolist(buffer (buffer-list))
            (set-buffer buffer)
            (when (equal major-mode 'dired-mode)
              (setq count (1+ count))
              (kill-buffer buffer)))
          (message "Killed %i dired buffer(s)." count ))))


;; Mass kill buffers
;; Thanks, https://github.com/defunkt/emacs/blob/master/defunkt/defuns.el
 (defun rkk-kill-all-buffers ()
    "Kills all buffers except *scratch*"
    (interactive)
    (let ((buffers (buffer-list)) (safe '("*scratch*" "*Semantic Context Analysis*" "*ECB Methods*" "*Compile-Log*")))
      (while buffers
        (when (not (member (car buffers) safe))
          (kill-buffer (car buffers))
          (setq buffers (cdr buffers))))))


(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))


(defun unfill-region (start end)
  (interactive "r")
  (let ((fill-column (point-max)))
    (fill-region start end nil)))


;; Duplicate the current line or region
;; Thanks, https://github.com/openist/drupal-emacs/blob/master/.emacs.d/drupal-emacs-functions.el
(defun rkk-duplicate-line (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))


;; I-search with initial contents
;; Thanks, http://platypope.org/blog/2007/8/5/a-compendium-of-awesomeness
;; I-search with initial contents
(defvar isearch-initial-string nil)
(defun isearch-set-initial-string ()
  (remove-hook 'isearch-mode-hook 'isearch-set-initial-string)
  (setq isearch-string isearch-initial-string)
  (isearch-search-and-update))


;; Search forwards for the current word
(defun isearch-forward-at-point (&optional regexp-p no-recursive-edit)
  "Interactive search forward for the symbol at point."
  (interactive "P\np")
  (if regexp-p (isearch-forward regexp-p no-recursive-edit)
    (let* ((end (progn (skip-syntax-forward "w_") (point)))
           (begin (progn (skip-syntax-backward "w_") (point))))
      (if (eq begin end)
          (isearch-forward regexp-p no-recursive-edit)
        (setq isearch-initial-string (buffer-substring begin end))
        (add-hook 'isearch-mode-hook 'isearch-set-initial-string)
        (isearch-forward regexp-p no-recursive-edit)))))


;; Toggle PHP/HTML mode
;; Thanks, https://github.com/troelskn/troelskn-emacs/blob/master/.emacs
(defun toggle-php-html-mode ()
  (interactive)
  "Toggle mode between PHP & HTML modes"
  (cond ((or (equal mode-name "XHTML") (equal mode-name '(sgml-xml-mode "XHTML" "HTML")))
         (php-mode))
        ((equal mode-name "PHP")
         (html-mode))))


(defun camelize (s)
  "Convert under_score string S to CamelCase string."
  (mapconcat 'identity (mapcar
                        '(lambda (word) (capitalize (downcase word)))
                        (split-string s "_")) ""))


(defun camelize-method (s)
  "Convert under_score string S to camelCase string."
      (mapconcat 'identity (mapcar-head
                            '(lambda (word) (downcase word))
                            '(lambda (word) (capitalize (downcase word)))
                            (split-string s "_")) ""))


(defun underscore (s &optional sep start)
  "Convert CamelCase string S to lower case with word separator SEP.
    Default for SEP is an underscore \"_\".

    If third argument START is non-nil, convert words after that
    index in STRING."
  (let ((case-fold-search nil))
    (while (string-match "[A-Z]" s (or start 1))
      (setq s (replace-match (concat (or sep "_")
                                     (downcase (match-string 0 s)))
                             t nil s)))
    (downcase s)))

(defun dasherize (s &optional start)
  (underscore s "-" start))


(defun camelize-buffer-or-region-method ()
  (interactive)
  (replace-regexp-in-buffer-or-region
   "\\b\\([a-z]+_[a-z]+[a-z_]*\\|[a-z]+-[a-z]+[a-z-]*\\)\\b"
   '(replace-eval-replacement replace-quote (camelize-method (match-string 0)))))


(defun camelize-buffer-or-region-class ()
  (interactive)
  (replace-regexp-in-buffer-or-region
   "\\b\\([a-z]+_[a-z]+[a-z_]*\\|[a-z]+-[a-z]+[a-z-]*\\)\\b"
   '(replace-eval-replacement replace-quote (camelize (match-string 0)))))


(defun camelize-buffer-or-region ()
  (interactive)
  (if (y-or-n-p "Select 'y' for methodStyle or 'n' for ClassStyle ")
      (camelize-buffer-or-region-method)
    (camelize-buffer-or-region-class)))


(defun underscore-buffer-or-region ()
  (interactive)
  (replace-regexp-in-buffer-or-region
    "\\b\\([a-z]*[A-Z][a-z]+\\)+\\b"
    '(replace-eval-replacement replace-quote (underscore (match-string 0)))))


(defun dasherize-buffer-or-region ()
  (interactive)
  (replace-regexp-in-buffer-or-region
    "\\b\\([a-z]*[A-Z][a-z]+\\)+\\b"
    '(replace-eval-replacement replace-quote (dasherize (match-string 0)))))


;; Handy input-less buffer switching
(defun rkk-switch-to-previous-buffer ()
      (interactive)
      (switch-to-buffer (other-buffer)))


(require 'term)
(defun visit-ansi-term ()
  "If the current buffer is:
     1) a running ansi-term named *ansi-term*, rename it.
     2) a stopped ansi-term, kill it and create a new one.
     3) a non ansi-term, go to an already running ansi-term
        or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd "/bin/bash")
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                (call-interactively 'rename-buffer)
              (if anon-term
                  (switch-to-buffer "*ansi-term*")
                (ansi-term term-cmd)))
          (kill-buffer (buffer-name))
          (ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (switch-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (ansi-term term-cmd))
        (ansi-term term-cmd)))))


;; Configure for laptop usage
(defun rkk-laptop ()
  "Configures Emacs for laptop usage,
   - Decrease font size one step
   - Change the font (if needed)
   - Close all other frames than the current"
  (interactive)
  (set-face-font 'default "-apple-Monaco-medium-normal-normal-*-12-*-*-*-m-0-iso10646-1")
  (set-face-attribute 'default nil :height 120))


;; Configure for office usage
(defun rkk-office ()
  "Configures Emacs for office usage,
   - Increase font size one step
   - Change the font (if needed)"
  (interactive)
  ;; (set-face-font 'default "-apple-inconsolatadz-medium-r-normal--14-0-72-72-m-0-iso10646-1")
  (set-face-font 'default "-apple-Droid_Sans_Mono-medium-normal-normal-*-14-*-*-*-m-0-fontset-auto7")
  (set-face-attribute 'default nil :height 140 :bold nil))


;; Opens the files directory in Finder
(defun rkk-reveal-in-finder ()
  "Opens finder for file directory."
  (interactive)
  (let ((file (buffer-file-name)))
    (if file
        (shell-command
         (concat "open " (file-name-directory file)))
      (error "Buffer is not attached to any file."))))


;; Navigates to the faulty line and display the error message
(defun rkk-jump-and-show-flymake-error ()
  "Uses Flymake to navigate to a faulty line and display the error message."
    (interactive)
    (flymake-goto-next-error)
    (flymake-display-err-menu-for-current-line))
	

;; Navigates to a symbol using IDO
;; Thanks, http://www.emacswiki.org/emacs/ImenuMode#toc10 and
;; http://www.masteringemacs.org/articles/2011/01/14/effective-editing-movement/
(defun rkk-ido-goto-symbol (&optional symbol-list)
      "Refresh imenu and jump to a place in the buffer using Ido."
      (interactive)
      (unless (featurep 'imenu)
        (require 'imenu nil t))
      (cond
       ((not symbol-list)
        (let ((ido-mode ido-mode)
              (ido-enable-flex-matching
               (if (boundp 'ido-enable-flex-matching)
                   ido-enable-flex-matching t))
              name-and-pos symbol-names position)
          (unless ido-mode
            (ido-mode 1)
            (setq ido-enable-flex-matching t))
          (while (progn
                   (imenu--cleanup)
                   (setq imenu--index-alist nil)
                   (rkk-ido-goto-symbol (imenu--make-index-alist))
                   (setq selected-symbol
                         (ido-completing-read "Symbol? " symbol-names))
                   (string= (car imenu--rescan-item) selected-symbol)))
          (unless (and (boundp 'mark-active) mark-active)
            (push-mark nil t nil))
          (setq position (cdr (assoc selected-symbol name-and-pos)))
          (cond
           ((overlayp position)
            (goto-char (overlay-start position)))
           (t
            (goto-char position)))))
       ((listp symbol-list)
        (dolist (symbol symbol-list)
          (let (name position)
            (cond
             ((and (listp symbol) (imenu--subalist-p symbol))
              (rkk-ido-goto-symbol symbol))
             ((listp symbol)
              (setq name (car symbol))
              (setq position (cdr symbol)))
             ((stringp symbol)
              (setq name symbol)
              (setq position
                    (get-text-property 1 'org-imenu-marker symbol))))
            (unless (or (null position) (null name)
                        (string= (car imenu--rescan-item) name))
              (add-to-list 'symbol-names name)
              (add-to-list 'name-and-pos (cons name position))))))))


;; Generate sample text
(defun rkk-print-lorem ()
  (interactive)
  (insert "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Praesent libero orci, auctor sed, faucibus vestibulum, gravida vitae, arcu. Nunc posuere. Suspendisse potenti. Praesent in arcu ac nisl ultricies ultricies. Fusce eros. Sed pulvinar vehicula ante. Maecenas urna dolor, egestas vel, tristique et, porta eu, leo. Curabitur vitae sem eget arcu laoreet vulputate. Cras orci neque, faucibus et, rhoncus ac, venenatis ac, magna. Aenean eu lacus. Aliquam luctus facilisis augue. Nullam fringilla consectetuer sapien. Aenean neque augue, bibendum a, feugiat id, lobortis vel, nunc. Suspendisse in nibh quis erat condimentum pretium. Vestibulum tempor odio et leo. Sed sodales vestibulum justo. Cras convallis pellentesque augue. In eu magna. In pede turpis, feugiat pulvinar, sodales eget, bibendum consectetuer, magna. Pellentesque vitae augue."))


;; Open file as root
;; Thanks, http://atomized.org/2011/01/toggle-between-root-non-root-in-emacs-with-tramp/
(defun rkk-find-file-as-root ()
  "Find a file as root."
  (interactive)
  (let* ((parsed (when (tramp-tramp-file-p default-directory)
                   (coerce (tramp-dissect-file-name default-directory)
                           'list)))
         (default-directory
           (if parsed
               (apply 'tramp-make-tramp-file-name
                      (append '("sudo" "root") (cddr parsed)))
             (tramp-make-tramp-file-name "sudo" "root" "localhost"
                                         default-directory))))
    (call-interactively 'find-file)))


;; Toggle current file as root
;; Thanks, http://atomized.org/2011/01/toggle-between-root-non-root-in-emacs-with-tramp/
(defun rkk-toggle-alternate-file-as-root (&optional filename)
  "Toggle between the current file as the default user and as root."
  (interactive)
  (let* ((filename (or filename (buffer-file-name)))
         (parsed (when (tramp-tramp-file-p filename)
                   (coerce (tramp-dissect-file-name filename)
                           'list))))
    (unless filename
      (error "No file in this buffer."))

    (find-alternate-file
     (if (equal '("sudo" "root") (butlast parsed 2))
         ;; As non-root
         (if (or
              (string= "localhost" (nth 2 parsed))
              (string= (system-name) (nth 2 parsed)))
             (nth -1 parsed)
           (apply 'tramp-make-tramp-file-name
                  (append (list tramp-default-method nil) (cddr parsed))))

       ;; As root
       (if parsed
           (apply 'tramp-make-tramp-file-name
                  (append '("sudo" "root") (cddr parsed)))
         (tramp-make-tramp-file-name "sudo" "root" "localhost" filename))))))


;; Cycle fonts
(defun rkk-cycle-font ()
  "Change font in current frame.
When called repeatedly, cycle thru a predefined set of fonts."
  (interactive)
  (if (not (eq last-command this-command))
      (progn
        (set-frame-parameter nil 'font "Droid Sans Mono-14")
        (put this-command 'state "1")
		(message "Droid Sans Mono 13"))
    (cond
     ((string= (get this-command 'state) "1")
      (set-frame-parameter nil 'font "Monaco-12")
	  (put this-command 'state "2")
	  (message "Monaco 12"))
	 
	 ((string= (get this-command 'state) "2" )
      (set-frame-parameter nil 'font "CPMono_v07-14")
	  (put this-command 'state "3")
	  (message "CPMono_v07 14"))

	 ((string= (get this-command 'state) "3" )
      (set-frame-parameter nil 'font "DejaVu Sans Mono-14")
	  (put this-command 'state "1")
	  (message "DejaVu Sans Mono 14"))

     )))


;; Indent the whole buffer
(defun rkk-indent-whole-buffer () 
  "Indent the whole buffer according to the current mode."
   (interactive) 
   (delete-trailing-whitespace) 
   (indent-region (point-min) (point-max) nil) 
   (untabify (point-min) (point-max))
   )


;; Super-charged recent files
;; Thanks, http://www.masteringemacs.org/articles/2011/01/27/find-files-faster-recent-files-package/
(defun rkk-ido-recentf-open-short ()
"Use ido to select a recently opened file from the `recentf-list'"
(interactive)
(let ((home (expand-file-name (getenv "HOME"))))
  (find-file
   (ido-completing-read "Find recent file: "
						(mapcar (lambda (path)
								  (replace-regexp-in-string home "~" path))
								recentf-list)
						nil t))))


;; Open the Drupal debug log
(defun rkk-drupal-debug-log ()
  (interactive)
  (find-file-other-window "/tmp/drupal_debug.txt")
  (auto-revert-tail-mode))


;; Go to the matching parenthesis, either forward or backward
(defun rkk-goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc.
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)))


;; Hide modeline
;; Thanks, http://stackoverflow.com/questions/5079466/hide-the-emacs-echo-area-when-not-in-use
(defun rkk-toggle-mode-line ()
  "toggles the modeline on and off"
  (interactive) 
  (setq mode-line-format
		(if (equal mode-line-format nil)
			(default-value 'mode-line-format)) )
  (redraw-display))


;; Kill the current buffer and file
(defun delete-file-and-buffer ()
  "Kills the current buffer and deletes the file it is visiting"
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (delete-file filename)
      (message "Deleted file %s" filename)))
  (kill-buffer))


;; Increase and decrease environment text size, not just the buffer contents text.
(defun rkk-increase-font-size ()
  (interactive)
  (set-face-attribute 'default nil :height (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun rkk-decrease-font-size ()
  (interactive)
  (set-face-attribute 'default nil :height (floor (* 0.9
                                  (face-attribute 'default :height)))))


(defun rkk-annotate-todo ()
  "put fringe marker on TODO: lines in the curent buffer"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "TODO:" nil t)
      (let ((overlay (make-overlay (- (point) 5) (point))))
        (overlay-put overlay
                     'before-string
                     (propertize (format "A")
                                 'display '(left-fringe right-triangle)))))))


;; move line up
(defun rkk-move-line-up ()
  (interactive)
  (transpose-lines 1)
  (previous-line 2))


;; move line down
(defun rkk-move-line-down ()
  (interactive)
  (next-line 1)
  (transpose-lines 1)
  (previous-line 1))


(defun flymake-php-init ()
  "Use php to check the syntax of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
	 (local (file-relative-name temp (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local "-l"))))


;; Logview mode
;; Thanks, http://stackoverflow.com/questions/133821/the-best-tail-gui
(defvar angry-fruit-salad-log-view-mode-map
  (make-sparse-keymap))

(define-minor-mode angry-fruit-salad-log-view-mode
  "View logs with colors.

Angry colors."
  nil " AngryLog" nil
  
  (cond (angry-fruit-salad-log-view-mode
         (auto-revert-tail-mode 1)
         (highlight-changes-mode 1)
         (define-key angry-fruit-salad-log-view-mode-map
           (kbd "C-c C-r")
           'highlight-changes-rotate-faces)
         (if (current-local-map)
             (set-keymap-parent angry-fruit-salad-log-view-mode-map
                                (current-local-map)))
         ;; set the keymap
         (use-local-map angry-fruit-salad-log-view-mode-map))

        (t
         (auto-revert-tail-mode -1)
         (highlight-changes-mode -1)
         (use-local-map (keymap-parent angry-fruit-salad-log-view-mode-map)))))


(defun semnav-up (arg)
  (interactive "p")
  (when (nth 3 (syntax-ppss))
    (if (> arg 0)
        (progn
          (skip-syntax-forward "^\"")
          (goto-char (1+ (point)))
          (decf arg))
      (skip-syntax-backward "^\"")
      (goto-char (1- (point)))
      (incf arg)))
  (up-list arg))


(defun my-php-symbol-lookup ()
  (interactive)
  (let ((symbol (symbol-at-point)))
    (if (not symbol)
        (message "No symbol at point.")

      (browse-url (concat "http://php.net/manual-lookup.php?pattern="
                          (symbol-name symbol))))))


(defun my-php-function-lookup ()
  (interactive)
  (let* ((function (symbol-name (or (symbol-at-point)
                                    (error "No function at point."))))
         (buf (url-retrieve-synchronously (concat "http://php.net/manual-lookup.php?pattern=" function))))
    (with-current-buffer buf
      (goto-char (point-min))
        (let (desc)
          (when (re-search-forward "<div class=\"methodsynopsis dc-description\">\\(\\(.\\|\n\\)*?\\)</div>" nil t)
            (setq desc
              (replace-regexp-in-string
                " +" " "
                (replace-regexp-in-string
                  "\n" ""
                  (replace-regexp-in-string "<.*?>" "" (match-string-no-properties 1)))))
                    
            (when (re-search-forward "<p class=\"para rdfs-comment\">\\(\\(.\\|\n\\)*?\\)</p>" nil t)
              (setq desc
                    (concat desc "\n\n"
                            (replace-regexp-in-string
                             " +" " "
                             (replace-regexp-in-string
                              "\n" ""
                              (replace-regexp-in-string "<.*?>" "" (match-string-no-properties 1))))))))

          (if desc
              (message desc)
            (message "Could not extract function info. Press C-F1 to go the description."))))
    (kill-buffer buf)))

