;;------------------------------------------------------------------------------
;; dos2unix type functions
;;------------------------------------------------------------------------------

(defun kooru/to-unix-auto ()
  "Change the current buffer's line-ends to Unix, preserving the coding system."
  (interactive)
  (let ((coding-str (symbol-name buffer-file-coding-system)))
    (when (string-match "-\\(?:dos\\|mac\\)$" coding-str)
      (setq coding-str
            (concat (substring coding-str 0 (match-beginning 0)) "-unix"))
      (message "CODING: %s" coding-str)
      (set-buffer-file-coding-system (intern coding-str)) )))

(defun kooru/to-unix-utf8 ()
  "Change the current buffer to UTF-8 with Unix line-ends."
  (interactive)
  (set-buffer-file-coding-system 'utf-8-unix t))

;;------------------------------------------------------------------------------
;; Misc utility functions
;;------------------------------------------------------------------------------

(defun kooru/range (start count &optional step-size)
  (let ((step (if (integerp step-size) step-size 1)))
    (loop repeat count for i from start by step collect i)))

(defun kooru/auto-open-files () 
  (if (and window-system (boundp 'kooru/auto-open-list))
      (dolist (file kooru/auto-open-list)
        (find-file file))))

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
