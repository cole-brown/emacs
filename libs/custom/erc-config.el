;; mostly gotten from various ERC-related pages on EmacsWiki:
;; http://www.emacswiki.org/cgi-bin/wiki/ERC
;(require 'erc-auto)

;; variables
(setq kooru/erc-nickserv-pass "foobarbaz")
(setq kooru/erc-nick          "spydez")

;; put private messages into separate buffers, but don't bring them to focus.
(setq erc-auto-query 'bury)

;; put notices in seperate buffer
(add-hook 'erc-after-connect
          (lambda (server nick)
            (add-hook 'erc-server-NOTICE-hook 'erc-auto-query)))

;; exclude some messages from tracking, including join messages like the nicklist and topic.
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))

;; disable auto-fill-mode for erc buffers
(add-hook 'erc-mode-hook (lambda () (auto-fill-mode 0)))

;; set erc-fill-column so that long lines wrap nicely.
;(setq erc-fill-column 78)

;; If you'd like to have the fill width be a little more dynamic and change 
;; properly when you resize a window, try this. (It might make things a little
;; ugly if you resize again later, though.) Note that only new lines will be 
;; filled to the new value.
(add-hook 'window-configuration-change-hook 
          '(lambda ()
             (setq erc-fill-column (- (window-width) 2))))

;; If you want a constant indentation, set the variable 'erc-fill-prefix' to the
;; string to use as a prefix - four spaces is pretty nice, for example.
;; If you just want all the text to line up, comment this out.
;; But we're using erc-fill-static, which is also a comment-this-out.
;(setq erc-fill-prefix "    ")

;; Set 'erc-fill-function' to 'erc-fill-static' to right-aling nicks and left align text.
(setq erc-fill-function 'erc-fill-static)

;; The default left-side (nick) column of 27 can be changed by setting the 
;; 'erc-fill-static-center' variable.
(setq erc-fill-static-center 15)

;; helper defun to unfill lines that have been cut from elsewhere
(defun kooru/erc-unfill ()
  "Unfill the region after the prompt. Intended to be called just before you
   send a line"
  (interactive)
  (save-excursion
    (end-of-buffer)
    (goto-char (previous-single-property-change (point) 'erc-prompt))
    (while (search-forward "\n" nil t)
      (delete-backward-char 1)
      (just-one-space))))

;; Replace the useless binding for fill-paragraph in ERC:
(add-hook 'erc-mode-hook '(lambda () (define-key erc-mode-map (kbd "M-q") 'kooru/erc-unfill)))

;; Keep the prompt line at the bottom of the window.
(add-hook 'erc-mode-hook 'erc-add-scroll-to-bottom)

;; Rumored Carbon Emacs bug with scroll-to-bottom, so set to something other 
;; than nil or -1. See http://www.emacswiki.org/emacs/ErcScrollToBottom
(setq erc-input-line-position -2)

;; no logging support yet... 
;; http://www.emacswiki.org/emacs/ErcLogging

;; auto-join multiple channels on multiple servers:
(setq erc-autojoin-channels-alist
      '((".*freenode.net" "#startups"); "#emacs" "#erc")
        ;(".*sorcery.net" "#pate")
        ))

;; NOTE: Freenode NickServ hostmask cloaking and auto-join don't get along.
;; Use this if/when you register your nick...
;; http://edward.oconnor.cx/2007/09/freenode-cloaking-and-erc
;(defun kooru/post-cloak-autojoin (proc parsed)
;  "Autojoin iff NickServ tells us to."
;  (with-current-buffer (process-buffer proc)
;    (when (and (string-equal "irc.freenode.net"
;                             (erc-response.sender parsed))
;               (string-match ".*NickServ set your hostname to.*"
;                             (erc-response.contents parsed)))
;      (erc-autojoin-channels erc-session-server (erc-current-nick))
;      nil)))
;(add-hook 'erc-server-NOTICE-functions 'kooru/post-cloak-autojoin)

;; auto-ident
;(add-hook 'erc-after-connect
;          '(lambda (SERVER NICK)
;             (cond
;              ((string-match "freenode\\.net" SERVER)
;               (erc-message "PRIVMSG" (concat "NickServ identify " kooru/erc-nickserv-pass)))
;    
;              ((string-match "sorcery\\.net" SERVER)
;               (erc-message "PRIVMSG" (concat "NickServ identify " kooru/erc-nickserv-pass)))
;              )))
;; OR: http://www.emacswiki.org/emacs/ErcNickserv

;; connect to servers
(defun kooru/erc ()
  "Join pre-speciifed servers and channels."
  (interactive)
  (erc :server "irc.freenode.net" :port 6667 :nick kooru/erc-nick)
  ;(erc :server "irc.sorcery.net" :port 6667 :nick kooru/erc-nick)
  )

;; to auto-connect, uncomment:
;(kooru/erc)
;; else, just do a "M-x kooru/erc" for manual.


;;-------------------------------------------------------------------------------
;; Custom ERC Functions
;;-------------------------------------------------------------------------------

;; /reverse - Reverse what you type, or reverse what other people typed.
;; Usage:
;;   14:32 ERC> /reverse somebody type something reversed!
;;   14:32 <kensanata> !desrever gnihtemos epyt ydobemos
;;   14:33 <yrk_work> yaw on
;;   14:33 ERC> /reverse
;;   14:33 *** no way
;; Via: http://www.emacswiki.org/emacs/ErcReverse
(defun erc-cmd-REVERSE (&rest words)
  (if words
      (erc-send-message (apply 'concat (reverse (split-string (mapconcat 'identity words " ") ""))))
    (let ((limit (- (point) 1000))
          (pos (point))
          text)
      (while (and pos (not (let ((data (get-text-property pos 'erc-parsed)))
                             (and data (string= (aref data 0) "PRIVMSG")))))
        (setq pos (previous-single-property-change pos 'erc-parsed nil limit)))
      (if pos
          (erc-display-message nil 'notice 'active
                               (apply 'concat (reverse (split-string (aref (get-text-property pos 'erc-parsed) 3) ""))))
        (erc-display-message nil 'notice 'active "Nothing to reverse")))))
