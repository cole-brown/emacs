
;;;; Macros ;;;;
;; Are we running XEmacs or Emacs?
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))

;; Some simple macros to more easily tell if we're running GNUEmacs or XEmacs
;; taken from the .emacs of sukria@online.fr | http://sukria.online.fr
(defmacro GNUEmacs (&rest x)
  (list 'if (not running-xemacs) (cons 'progn x)))
(defmacro XEmacs (&rest x)
  (list 'if running-xemacs (cons 'progn x)))
(defmacro Xlaunch (&rest x)
  (list 'if (eq window-system 'x) (cons 'progn x)))
;;;; /Macros ;;;;

;###
;# Differing OS stuff
;###
(defvar my-load-path-prefix "~/.emacs.d/")
(cond
 ((eq system-type 'gnu/linux) 
  (setq my-load-path-prefix "~/.emacs.d/"))
 ((eq system-type 'windows-nt)
  (setq my-load-path-prefix "h:/.emacs.d/")))

; Add my-load-path-prefix as a load-path...
(add-to-list 'load-path my-load-path-prefix)

;; New load paths will be loaded like this:
;(add-to-list 'load-path (concat my-load-path-prefix "color-theme-6.6.0"))

;;; Clearcase VC plugin
;;; from: http://vc-clearcase.wiki.sourceforge.net/
;;; Comment out if Clearcase isn't used - it takes a bit of time to load up.
;;;(add-to-list 'load-path (concat my-load-path-prefix "vc-clearcase-1.139"))
;;;(load "vc-clearcase-auto")

;;; Change default font
;;; from: http://blog.oscarbonilla.com/2008/01/04/beautiful-emacs-windows-edition/
;;; the "13" is the font size, and it's not 13pt. '13' == 10ish pt font.
;(set-default-font "-outline-Consolas-normal-r-normal-normal-13-97-96-96-c-*-iso8859-1")
;(set-default-font "-outline-inconsolata-normal-r-normal-normal-13-97-96-96-c-*-iso8859-1")

;;; Excellent package for better scrolling in emacs
;;; should be default package. But now it can be downloaded
;;; from: http://user.it.uu.se/~mic/pager.el
(require 'pager)
(global-set-key "\C-v"	   'pager-page-down)
(global-set-key [next] 	   'pager-page-down)
(global-set-key "\ev"	   'pager-page-up)
(global-set-key [prior]	   'pager-page-up)
(global-set-key '[M-up]    'pager-row-up)
(global-set-key '[M-kp-8]  'pager-row-up)
(global-set-key '[M-down]  'pager-row-down)
(global-set-key '[M-kp-2]  'pager-row-down)

;;;; Parens ;;;;
;;; Excellent package for paren matching, also at: 
;;; http://user.it.uu.se/~mic/mic-paren.el
;(when (or (string-match "XEmacs\\|Lucid" emacs-version) window-system)
;  (require 'mic-paren) ; loading
;  (paren-activate)     ; activating
;  ;;; set here any of the customizable variables of mic-paren, e.g.:
;  ;;; ...
;)
(Xlaunch (require 'mic-paren) (paren-activate))
;;; cparen.el is available at:
;;; http://www.hut.fi/u/rsaikkon/software/elisp/cparen.el
(require 'cparen)
(cparen-activate)
(show-paren-mode t)
;;;; /Parens ;;;;

;;; Source code browser for Emacs. Supports source-code 
;;; parsing for Java, C, C++, Elisp, Scheme etc.
;;; Project site with packages, docs and all other stuff:
;;; http://ecb.sourceforge.net/
;//! use this?
;(add-to-list 'load-path (concat my-load-path-prefix "ecb"))
;(require 'ecb)

;;; Last found version of htmlize.el 
;;; http://fly.srk.fer.hr/~hniksic/emacs/htmlize.el
(require 'htmlize)

;; Yet Another Snippets extension
;; http://code.google.com/p/yasnippet/
;; For defining custom snippets, see here: http://code.google.com/p/yasnippet/wiki/HowtoDefineSnippet
(add-to-list 'load-path (concat my-load-path-prefix "yasnippet-0.5.5"))
(require 'yasnippet) 
(yas/initialize)
(yas/load-directory (concat my-load-path-prefix "yasnippet-0.5.5/snippets"))


;###
;# Tab settings!
;###
(setq my-tab-width 3)
(setq-default indent-tabs-mode nil)   ; always replace tabs with spaces
(setq-default tab-width my-tab-width) ; set tab width for all buffers
;(setq-default tab-stop-list '(3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 114, 117))
;;;(setq tab-stop-list '(0 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
;;;(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74 76 78 80 82 84 86 88 90 92 94 96 98 100 102 104 106 108 110 112 114 116 118 120)

;This will make spaces the indent character, and use my-tab-width spaces per indent level, for C, C++, and Objective C:
(defun my-c++-mode-hook ()
  ;; Style parameters
  (c-set-style "bsd")
  (setq c-basic-offset my-tab-width)
  (c-set-offset 'innamespace my-tab-width)
  (setq indent-tabs-mode nil)
  (setq c-indent-level my-tab-width))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(defun my-c-mode-hook ()
  ;; Style parameters
  (c-set-style "bsd")
  (setq c-basic-offset my-tab-width)
  (c-set-offset 'innamespace my-tab-width)
  (setq indent-tabs-mode nil)
  (setq c-indent-level my-tab-width))
(add-hook 'c-mode-hook 'my-c-mode-hook)
(defun my-objc-mode-hook ()
  ;; Style parameters
  (c-set-style "bsd")
  (setq c-basic-offset my-tab-width)
  (c-set-offset 'innamespace my-tab-width)
  (setq indent-tabs-mode nil)
  (setq c-indent-level my-tab-width))
(add-hook 'objc-mode-hook 'my-objc-mode-hook)

; Delete selected text on insert instead of just bumping it over.
; aka: turn on pending delete (when a region is selected, typing replaces it)
(delete-selection-mode 1) 

; add '.tcc' files (and others) as c++-mode
(setq auto-mode-alist 
      (append '(("\\.tcc$"  . c++-mode) 
        ("\\.C$"  . c++-mode) 
		("\\.cc$" . c++-mode) 
		("\\.cxx$" . c++-mode) 
		("\\.cpp$" . c++-mode) 
		("\\.h$"  . c++-mode) 
		("\\.H$"  . c++-mode) 
		("\\.hpp$"  . c++-mode) 
		("\\.hh$"  . c++-mode) 
		("\\.c$"  . c-mode) 
		("\\.m$"  . objc-mode) 
		("\\.pm$"  . perl-mode) 
		) auto-mode-alist)) 

;;; It works only if you manualy set CYGWIN_ROOT environment
;;; variable for your Windows system 
;;; (MyComputer->Properties->Advanced->Environment Varibles)
;;; Configures some parameters for CygWin specific environment
;//! When I get CYGWIN, enable...
;(if (not (null (getenv "CYGWIN_ROOT")))
;    (progn
;      (setq-default
;       cygwin-root (getenv "CYGWIN_ROOT")
;       exec-path (cons (concat cygwin-root "/bin") exec-path)
;       process-coding-system-alist '(("bash" . undecided-unix))
;       shell-file-name "bash"
;       explicit-shell-file-name shell-file-name)
;      (setenv "PATH" (concat cygwin-root "/bin;" 
;			     cygwin-root "/usr/local/bin;" 
;			     (getenv "PATH")))
;      (setenv "SHELL" shell-file-name) 
;      (add-hook 'comint-output-filter-functions
;		'comint-strip-ctrl-m)))

;;;###
;;;# colors!.. Until I figure out what I like, anyways.
;;;###
;;; If you have own color scheme and don't like to use emacs default
;;; I recommend to use this package:
;;; http://www.emacswiki.org/cgi-bin/wiki.pl?ColorTheme
(add-to-list 'load-path (concat my-load-path-prefix "color-theme-6.6.0"))
(require 'color-theme)
;;; Zenburn theme from: http://www.brockman.se/software/zenburn/zenburn.el
;;; Zenburn for various other programs: http://www.brockman.se/software/zenburn/
;;; Zenburn for VS 05: http://www.codinghorror.com/blog/archives/000682.html
(require 'zenburn)
(color-theme-initialize)
(setq my-color-themes '(zenburn 
                        color-theme-subtle-hacker 
                        color-theme-charcoal-black 
                        color-theme-late-night 
                        color-theme-emacs-21))

(defun my-theme-set-default () ; Set the first row
  (interactive)
  (setq theme-current my-color-themes)
  (funcall (car theme-current)))
     
(defun my-describe-theme () ; Show the current theme
  (interactive)
  (message "%s" (car theme-current)))
     
; Set the next theme (fixed by Chris Webber - tanks)
(defun my-theme-cycle ()		
  (interactive)
  (setq theme-current (cdr theme-current))
  (if (null theme-current)
  (setq theme-current my-color-themes))
  (funcall (car theme-current))
  (message "%S" (car theme-current)))
    
(setq theme-current my-color-themes)
(setq color-theme-is-global nil) ; Initialization
(if window-system
    (my-theme-set-default)
	(color-theme-snapshot)) ; be nice to `emacs -nw`, which'll prolly be in a low-color env.
(my-theme-set-default) ; set theme to first in list
(global-set-key [f12] 'my-theme-cycle)
;;; /colors


;;; It is always better to know current line and column number
(column-number-mode t)
(line-number-mode t)

;;; Make all yes-or-no questions as y-or-n
(fset 'yes-or-no-p 'y-or-n-p)

;;; Some basic keybindings
;(global-set-key [delete] 'delete-char)
;(global-set-key [backspace] 'delete-backward-char)
;(global-set-key [(meta backspace)] 'undo)
;(global-set-key [(control backspace)] 'backward-kill-word)
;(global-set-key [(control delete)] 'kill-word)
;(global-set-key [f1] 'man-follow)
;(global-set-key [f4] 'speedbar-get-focus)
;(global-set-key [f6] 'buffer-menu)
;(global-set-key [M-return] 'expand-abbrev)
(global-set-key [end] 'end-of-line)
(global-set-key [home] 'beginning-of-line)
(global-set-key [(control z)] 'undo) ; Switch C-z to undo, instead of hide emacs window.
;;; Key binding for sqitching to next and previous buffer
(global-set-key '[C-tab] 'bs-cycle-next)
(global-set-key [S-tab] 'bs-cycle-previous) 

(defun delete-word (arg)
  "Kill characters forward until encountering the end of a word. With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Kill characters backward until encountering the beginning of a word. With argument, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

(global-set-key [(control backspace)] 'backward-delete-word)

;;; Make sure case is preserved when using M-/
;(setq dabbrev-case-replace nil)

; Make emacs get along with Firefox for copy/paste...
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;; Some basic and common parameters
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil)
 '(undo-limit 80000)
 '(undo-strong-limit 160000))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
