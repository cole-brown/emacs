;; -*- emacs-lisp -*-

;;------------------------------------------------------------------------------
;; global vars needed in personal files and bootstrapping
;;------------------------------------------------------------------------------
(defvar kooru/comp-domain "goblinworks")
(defvar kooru/comp-name   "cole-PC")
(defvar kooru/emacs-root  "c:/home/emacs/")
(defvar kooru/emacs-libs (concat kooru/emacs-root "libs/"))
(defvar kooru/emacs-personal (concat kooru/emacs-root "personal/"))
(defvar kooru/emacs-comp-specific (concat kooru/emacs-personal kooru/comp-domain "/" kooru/comp-name "/"))

;; auto-open file list
(defvar kooru/auto-open-list
      '("c:/home/documents/work.org"))

;;------------------------------------------------------------------------------
;; bootstrapping
;;------------------------------------------------------------------------------
(load-file (concat kooru/emacs-libs "bootstrap.el"))
(bootstrap-init kooru/comp-domain kooru/comp-name)
