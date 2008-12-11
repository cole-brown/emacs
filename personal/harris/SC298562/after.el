
;; some setup for org-agenda
(setq org-agenda-files (list "h:/documents/todo/work.org"))

;; etags support
(defvar harris/denali.tags "h:/etags/denali.TAGS" "*Path to tags for Denali baseline.")

(require 'etags)
(setq tags-table-list `(,harris/denali.tags))

