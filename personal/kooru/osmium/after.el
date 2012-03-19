
;; Possibly move to a linux.el?

;; Make emacs get along with Firefox for copy/paste...
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; This is the binary name of my scheme implementation
(setq scheme-program-name "mzscheme")
