
;; Possibly move to a linux.el?

;; it doesn't like my killing the toolbar til after everything else...
(load-library "misc-config")

;; make tiny font bigger (first number is font size (pt not px))
(defvar kooru/windows-consolas-font "-outline-Consolas-normal-r-normal-normal-100-97-96-96-c-*-iso8859-1")

;; probably should update kooru/auto-open-list as it no longer works in win10/emacs25
(find-file "d:/Users/spydez/Dropbox/42/42.org")

;; testing - may be good enough to pull into a common setup file
;; from: http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq backup-directory-alist `(("." . "d:/homepath/emacs-backup-files")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
