;; -*- emacs-lisp -*-

;;------------------------------------------------------------------------------
;; global vars needed in personal files and bootstrapping
;;------------------------------------------------------------------------------
(defvar kooru/comp-domain "kooru")
(defvar kooru/comp-name   "palladium_win7")
(defvar kooru/emacs-root  "c:/home/emacs/")
(defvar kooru/emacs-libs (concat kooru/emacs-root "libs/"))
(defvar kooru/emacs-personal (concat kooru/emacs-root "personal/"))
(defvar kooru/emacs-comp-specific (concat kooru/emacs-personal kooru/comp-domain "/" kooru/comp-name "/"))

;; auto-open file list
(defvar kooru/auto-open-list nil)
;;      '("~/Documents/42/42.org"))

;;------------------------------------------------------------------------------
;; bootstrapping
;;------------------------------------------------------------------------------
(load-file (concat kooru/emacs-libs "bootstrap.el"))
(bootstrap-init kooru/comp-domain kooru/comp-name)



