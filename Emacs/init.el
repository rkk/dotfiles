;;
;; Master Emacs customization file
;;

;;
;; PATHS
;;
(add-to-list 'load-path "~/.emacs.d")
;(add-to-list 'load-path "~/.emacs.d/vendor")


;;
;; LIBRARIES
;;

;(load-library "~/.emacs.d/rkk-functions.el")
(load-library "rkk-functions.el")
;(load-library "~/.emacs.d/rkk-preferences.el")
(load-library "rkk-preferences.el")


;; ERC settings
(setq erc-hide-list '("JOIN" "PART" "QUIT"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wombat))))
