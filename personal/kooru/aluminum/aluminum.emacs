;; -*- emacs-lisp -*-

;; global vars needed in personal files and bootstrapping
(defvar kooru/comp-domain "kooru")
(defvar kooru/comp-name   "aluminum")
(defvar kooru/emacs-root  "~/emacs/")
(defvar kooru/emacs-libs (concat kooru/emacs-root "libs/"))
(defvar kooru/emacs-personal (concat kooru/emacs-root "personal/"))
(defvar kooru/emacs-comp-specific (concat kooru/emacs-personal kooru/comp-domain "/" kooru/comp-name "/"))

;; bootstrapping
(load-file (concat kooru/emacs-libs "bootstrap.el"))
(bootstrap-init kooru/comp-domain kooru/comp-name)

;; auto-open files
(setq kooru/auto-open-list
      '("~/Documents/42/42.org"))

(add-hook 'emacs-startup-hook 'kooru/auto-open-files)
