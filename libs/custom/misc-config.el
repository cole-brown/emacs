;; -*- emacs-lisp -*-


;; these vars must be defined:
;;    kooru/tab-width


;;------------------------------------------------------------------------------
;; tab settings
;;------------------------------------------------------------------------------
(setq-default indent-tabs-mode nil)   ; always replace tabs with spaces
(setq-default tab-width kooru/tab-width) ; set tab width for all buffers
(setq tab-stop-list (kooru/range 0 120 kooru/tab-width))


;;------------------------------------------------------------------------------
;; various other settings
;;------------------------------------------------------------------------------

;; Make all yes-or-no questions as y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Make sure case is preserved when using M-/ completion
(setq dabbrev-case-replace nil)

;; give a larger undo buffer
(setq undo-limit 80000)
(setq undo-strong-limit 160000)

;; turn off UI crap
(if (fboundp 'tool-bar-mode) (tool-bar-mode nil))
(if (fboundp 'menu-bar-mode) (menu-bar-mode nil))
