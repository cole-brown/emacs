;; -*- emacs-lisp -*-

;; emacs.el - non-computer-specific emacs init

;; these vars must be defined:
;;    kooru/comp-domain
;;    kooru/comp-name
;;    kooru/emacs-root
;;    kooru/emacs-libs
;;    kooru/emacs-personal
;;    kooru/emacs-comp-specific
;;    kooru/tab-width

;;------------------------------------------------------------------------------
;; modify defaults
;;------------------------------------------------------------------------------

(setq-default fill-column 80)

;;------------------------------------------------------------------------------
;; add all the elisp directories in emacs-libs dir to my load path
;;------------------------------------------------------------------------------
(defun add-path (p)
  (add-to-list 'load-path (concat kooru/emacs-libs p)))

(add-path "") ;; for all libs residing in kooru/emacs-libs dir
(add-path "custom") ; all my custom written libs
(add-path "color-theme-6.6.0")
(add-path "yasnippet-0.5.5")
(add-path "vc-git")
(add-path "nxml-mode-20041004")
(add-path "go-mode")

;; emacs version dependant
;(add-path "vc-clearcase-1.139") ;old
;(if (eq emacs-major-version 22)
;    (add-path "vc-clearcase-2.1"))
;(if (eq emacs-major-version 23)
;    (add-path "vc-clearcase-3.0"))


;;------------------------------------------------------------------------------
;; load libraries and setup
;;------------------------------------------------------------------------------

(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;(load "vc-clearcase-auto") ; http://vc-clearcase.wiki.sourceforge.net/
;(setq clearcase-checkout-comment-type 'none) ; no comments on checkout

(require 'vc-git) ; http://www.emacswiki.org/cgi-bin/wiki/Git
(when (featurep 'vc-git) (add-to-list 'vc-handled-backends 'git))
(require 'git)
(autoload 'git-blame-mode "git-blame"
  "Minor mode for incremental blame for Git." t)

;; PHP Mode obtained from:
;; http://php-mode.sourceforge.net/
(load "php-mode")

;; Go-mode obtained from:
;; http://code.google.com/p/go/source/browse/misc/emacs/
(require 'go-mode-load) ; Go mode

;;; Excellent package for better scrolling in emacs
(require 'pager) ; http://user.it.uu.se/~mic/pager.el
;; keybindings in keys-config

;; parenthesis matching
;; http://user.it.uu.se/~mic/emacs.shtml
(when (or (string-match "XEmacs\\|Lucid" emacs-version) window-system)
   (require 'mic-paren) ; loading
   (paren-activate)     ; activating
   ;;; set here any of the customizable variables of mic-paren:
   ;;; (customizations set in custom.el)
)

;(require 'cparen) ; http://www.hut.fi/u/rsaikkon/software/elisp/cparen.el
;(cparen-activate)

;(require 'paren)
;(show-paren-mode t)
;(setq show-paren-style 'parenthesis)
;(set-face-background 'show-paren-match-face (face-background 'default))
;(set-face-foreground 'show-paren-match-face "#def")
;(set-face-attribute 'show-paren-match-face nil :weight 'extra-bold)

;;; Source code browser for Emacs. Supports source-code 
;;; parsing for Java, C, C++, Elisp, Scheme etc.
;;; Project site with packages, docs and all other stuff:
;;; http://ecb.sourceforge.net/
;//! use this?
;(add-to-list 'load-path (concat my-load-path-prefix "ecb"))
;(require 'ecb)

;;; converts buffers to html
;;; http://fly.srk.fer.hr/~hniksic/emacs/htmlize.el
(require 'htmlize)

;; Yet Another Snippets extension
;; For defining custom snippets, see here: http://code.google.com/p/yasnippet/wiki/HowtoDefineSnippet
(require 'yasnippet) ; http://code.google.com/p/yasnippet/
(yas/initialize)
(yas/load-directory (concat kooru/emacs-libs "yasnippet-0.5.5/snippets"))

;; line numbers on left 
;; DL:   http://stud4.tuwien.ac.at/~e0225855/linum/linum.html
;; Wiki: http://www.emacswiki.org/cgi-bin/wiki/LineNumbers#toc4
(require 'linum)

;;------------------------------------------------------------------------------
;; load settings and config from custom libs
;;------------------------------------------------------------------------------
(load-library "funcs") ; util functions. Should be first as later libs assume it
(load-library "colors-config")
(load-library "erc-config")
(load-library "fonts-config")
(load-library "modes-config")
(load-library "keys-config")
(load-library "misc-config")
(load-library "ido-config")

;;------------------------------------------------------------------------------
;; load custom-set-variables and custom-set-faces
;;------------------------------------------------------------------------------
(load-file (concat kooru/emacs-personal "custom.el"))

;;------------------------------------------------------------------------------
;; add hooks
;;------------------------------------------------------------------------------

;; auto open files in kooru/auto-open-list variable.
(add-hook 'emacs-startup-hook 'kooru/auto-open-files)

