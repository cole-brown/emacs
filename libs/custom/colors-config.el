;; Currently only using Zenburn, but the color theme page [1] on emacs wiki has 
;; info about how to cycle between a couple themes if that is desired.
;; [1] http://www.emacswiki.org/cgi-bin/wiki.pl?ColorTheme

(require 'color-theme)

;; Zenburn theme from: http://www.brockman.se/software/zenburn/zenburn.el
;; Zenburn for various other programs: http://www.brockman.se/software/zenburn/
;; Zenburn for VS 05: http://www.codinghorror.com/blog/archives/000682.html
(require 'zenburn)
(if window-system ;; be nice to `emacs -nw`, don't theme it.
   (progn
     (color-theme-initialize)
     (zenburn))) ; use zenburn color scheme
