
;; some setup for org-agenda
(setq org-agenda-files (list "c:/home/documents/work.org"))

;; etags support
;;(defvar harris/denali.tags "h:/etags/denali.TAGS" "*Path to tags for Denali baseline.")

;;(require 'etags)
;;(setq tags-table-list `(,harris/denali.tags))

;; testing - may be good enough to pull into a common setup file
;; from: http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
(setq backup-directory-alist `(("." . "C:/home/emacs-backup-files")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)
