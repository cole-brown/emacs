;;------------------------------------------------------------------------------
;; font vars
;;------------------------------------------------------------------------------

;; from: http://blog.oscarbonilla.com/2008/01/04/beautiful-emacs-windows-edition/
;; the "13" is the font size, and it's not 13pt. '13' == 10ish pt font.
;; Only works on Windows.
(defvar kooru/windows-consolas-font "-outline-Consolas-normal-r-normal-normal-13-97-96-96-c-*-iso8859-1")
(defvar kooru/windows-consolas-font-emacs-25 "Consolas 10")

;;------------------------------------------------------------------------------
;; Guess at default font
;;------------------------------------------------------------------------------
;; If a different font is desired, try to put it in after.el

(cond
; ((eq system-type 'gnu/linux) 
;  (set-default-font "eh?"))
 ((eq system-type 'windows-nt)
  (if (>= emacs-major-version 25)
      (set-frame-font kooru/windows-consolas-font-emacs-25 nil t)
    (set-default-font kooru/windows-consolas-font))))

