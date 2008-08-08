;;------------------------------------------------------------------------------
;; Misc utility functions
;;------------------------------------------------------------------------------

(defun kooru/range (start count &optional step-size)
  (let ((step (if (integerp step-size) step-size 1)))
    (loop repeat count for i from start by step collect i)))


;;------------------------------------------------------------------------------
;; whitespaces and deletion functions
;;------------------------------------------------------------------------------

(defun kooru/delete-word (arg)
  "Kill characters forward until encountering the end of a word. With argument, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun kooru/backward-delete-word (arg)
  "Kill characters backward until encountering the beginning of a word. With argument, do this that many times."
  (interactive "p")
  (kooru/delete-word (- arg)))

;; From: http://www.emacswiki.org/cgi-bin/wiki/DeletingWhitespace
(defun kooru/whack-whitespace (arg)
  "Delete all white space from point to the next word.  With prefix ARG
   delete across newlines as well.  The only danger in this is that you
   don't have to actually be at the end of a word to make it work.  It
   skips over to the next whitespace and then whacks it all to the next
   word."
  (interactive "P")
  (let ((regexp (if arg "[ \t\n]+" "[ \t]+")))
    (re-search-forward regexp nil t)
    (replace-match "" nil nil)))
