
;; Possibly move to a linux.el?

;; Make emacs get along with Firefox for copy/paste...
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
