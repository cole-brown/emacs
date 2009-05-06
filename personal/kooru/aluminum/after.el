
;; Possibly move to a linux.el?

;; Make emacs get along with Firefox for copy/paste...
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; This is the binary name of my scheme implementation
(setq scheme-program-name "mzscheme")

;; it doesn't like my killing the toolbar til after everything else...
(load-library "misc-config")

;; mouse scroll doesn't work by default in OS X.5 for some reason...
(mwheel-install)

;; this mapping opens the file dropped on an emacs window as opposed
;; to inserting its contents at the current cursor position
(define-key global-map [ns-drag-file] 'ns-find-file)

;; if this isn't set to nil, the dragged file will open in a new frame
(setq ns-pop-up-frames nil)

;; bell ringing sucks, but may be wanted occasionally...
(setq ring-bell-function 
  (lambda ()
    (unless (memq this-command
                  '(isearch-abort abort-recursive-edit 
                    exit-minibuffer keyboard-quit mwheel-scroll
                    next-line previous-line))
      (ding))))
