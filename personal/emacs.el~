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
;; add all the elisp directories in emacs-libs dir to my load path
;;------------------------------------------------------------------------------
(defun add-path (p)
  (add-to-list 'load-path (concat kooru/emacs-libs p)))

(add-path "") ;; for all libs residing in kooru/emacs-libs dir
(add-path "custom") ; all my custom written libs
(add-path "color-theme-6.6.0")
(add-path "vc-clearcase-1.139")
(add-path "yasnippet-0.5.5")

;;------------------------------------------------------------------------------
;; load libraries and setup
;;------------------------------------------------------------------------------

(load "vc-clearcase-auto") ; http://vc-clearcase.wiki.sourceforge.net/

;;; Excellent package for better scrolling in emacs
(require 'pager) ; http://user.it.uu.se/~mic/pager.el
;; keybindings in keys-config

(require 'cparen) ; http://www.hut.fi/u/rsaikkon/software/elisp/cparen.el
(cparen-activate)
(show-paren-mode t)

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

;;------------------------------------------------------------------------------
;; load settings and config from custom libs
;;------------------------------------------------------------------------------
(load-library "funcs") ; util functions. Should be first as later libs assume it.
(load-library "colors-config")
(load-library "fonts-config")
(load-library "misc-config")
(load-library "modes-config")
(load-library "keys-config")


;;------------------------------------------------------------------------------
;; load custom-set-variables and custom-set-faces
;;------------------------------------------------------------------------------
(load-file (concat kooru/emacs-personal "custom.el"))

