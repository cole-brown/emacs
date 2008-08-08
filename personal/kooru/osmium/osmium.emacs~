;; -*- emacs-lisp -*-

;; global vars needed in personal files and bootstrapping
(defvar kooru/comp-domain "harris")
(defvar kooru/comp-name   "SC298562")
(defvar kooru/emacs-root  "h:/emacs/")
(defvar kooru/emacs-libs (concat kooru/emacs-root "libs/"))
(defvar kooru/emacs-personal (concat kooru/emacs-root "personal/"))
(defvar kooru/emacs-comp-specific (concat kooru/emacs-personal kooru/comp-domain "/" kooru/comp-name "/"))

;; bootstrapping
(load-file (concat kooru/emacs-libs "bootstrap.el"))
(bootstrap-init kooru/comp-domain kooru/comp-name)
