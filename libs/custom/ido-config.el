;; ido-mode settings
(setq 
 ido-ignore-buffers '("\\` " "^\*" ".*Completion" "^irc\.") ; ignore buffers like these
 ido-everywhere t                       ; use for many file dialogs
 ido-case-fold  t                       ; be case-insensitive
 ido-use-filename-at-point t            ; try to use filename...
 ido-use-url-at-point t                 ; ... or url at point
 ido-enable-flex-matching t             ; be flexible
; ido-max-prospects 5                    ; don't spam my minibuffer
; ido-confirm-unique-completion t ; wait for RET, even with unique completion
 )

(ido-mode t)

;; ido-related functions
(defun kooru/ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (ido-completing-read "Project file: "
                         (tags-table-files)
                         nil t)))

(global-set-key "\C-cf" 'kooru/ido-find-file-in-tag-files)

