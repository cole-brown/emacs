
;; Denali program requires a tab-width of 3
(setq kooru/tab-width 3)

;; AIP-IRAD requires a tab-width of 4
;(setq kooru/tab-width 4)

;; Add gnuwin utils to PATH.
;; This is so diff and find can work.
(setenv "PATH" (concat "C:/util/gnuwin/bin;"
                       "C:/msys/1.0/bin;"
                       (getenv "PATH")))
