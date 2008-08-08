;; -*- emacs-lisp -*-

;; these vars must be defined:
;;    kooru/tab-width

;;------------------------------------------------------------------------------
;; various other modes settings
;;------------------------------------------------------------------------------

; Delete selected text on insert instead of just bumping it over.
; aka: turn on pending delete (when a region is selected, typing replaces it)
(delete-selection-mode 1) 

;; turn on column and line numbering
(column-number-mode t)
(line-number-mode   t)

;;------------------------------------------------------------------------------
;; org mode
;;------------------------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t) ; auto-timestamp when TODOs are turned to DONE state
(setq org-hide-leading-stars t) ; make outline a bit cleaner
(setq org-odd-levels-only t)    ; make outline a bit cleaner


;;------------------------------------------------------------------------------
;; C/C++/Obj-C modes
;;------------------------------------------------------------------------------

;; This will make spaces the indent character, and use kooru/tab-width spaces per 
;; indent level, for C, C++, and Objective C:
(defun kooru/c++-mode-hook ()
  ;; Style parameters
  (c-set-style "bsd")
  (setq c-basic-offset kooru/tab-width)
  (c-set-offset 'innamespace kooru/tab-width)
  (setq indent-tabs-mode nil)
  (setq c-indent-level kooru/tab-width))
(add-hook 'c++-mode-hook 'kooru/c++-mode-hook)

(defun kooru/c-mode-hook ()
  ;; Style parameters
  (c-set-style "bsd")
  (setq c-basic-offset kooru/tab-width)
  (c-set-offset 'innamespace kooru/tab-width)
  (setq indent-tabs-mode nil)
  (setq c-indent-level kooru/tab-width))
(add-hook 'c-mode-hook 'kooru/c-mode-hook)

(defun kooru/objc-mode-hook ()
  ;; Style parameters
  (c-set-style "bsd")
  (setq c-basic-offset kooru/tab-width)
  (c-set-offset 'innamespace kooru/tab-width)
  (setq indent-tabs-mode nil)
  (setq c-indent-level kooru/tab-width))
(add-hook 'objc-mode-hook 'kooru/objc-mode-hook)

;; add '.tcc' files (and others) to auto-mode-list
(add-to-list 'auto-mode-alist '("\\.tcc$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.C$"   . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc$"  . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cxx$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h$"   . c++-mode))
(add-to-list 'auto-mode-alist '("\\.H$"   . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hh$"  . c++-mode))
(add-to-list 'auto-mode-alist '("\\.c$"   . c-mode))
(add-to-list 'auto-mode-alist '("\\.m$"   . objc-mode))
(add-to-list 'auto-mode-alist '("\\.pm$"  . perl-mode))
