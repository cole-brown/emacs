
;; for infix notation: http://www.informatimago.com/develop/emacs/index.html


(defun sasta/number-list-to-string (list)
  (if (< 1 (length list))
      (concat "(" (mapconcat 'number-to-string list " ") ")")
    (concat (mapconcat 'number-to-string list " "))))

(sasta/number-list-to-string '(1))
(sasta/number-list-to-string '(1 2 3))

(defun sasta/trim-whitespace (str)
  (when (string-match "[ \t]*$" str)
    (replace-match "" nil nil str)))

(sasta/trim-whitespace "mne   ")

;; return: ("3d6" (3 6 1))
(defun sasta/dice-roll (word)
  (if (equal nil (string-match "\\([[:digit:]]*\\)d\\([[:digit:]]+\\)" word))
      `(,word nil)
    (let ((dice-str (match-string 0 word))
          (num-dice (string-to-number (if (string< "" (match-string 1 word))
                                          (match-string 1 word)
                                        "1")))
          (dice-sides (string-to-number (match-string 2 word)))
          (rolled))
      (dotimes (number num-dice rolled)
        (setq rolled (cons (+ (random dice-sides) 1) rolled)))
      `(,dice-str ,rolled))))

(sasta/dice-roll "1d6")
(sasta/dice-roll "d6")
(sasta/dice-roll "10d6")
(sasta/dice-roll "")
(sasta/dice-roll "-")

(defun sasta/dice (words-list)
  (let ((roll-str '("" ""))
        (roll-alist (mapcar 'sasta/dice-roll words-list)))
    (dolist (element roll-alist roll-str)
      (setq roll-str `(,(concat (car roll-str) (car element) " ")
                       ,(concat (cadr roll-str) (if (equal nil (cadr element))
                                                    (car element)
                                                  (sasta/number-list-to-string (cadr element))) " "))))
    (concat (sasta/trim-whitespace (car  roll-str))
            ": "
            (sasta/trim-whitespace (cadr roll-str)))
    ;... now do the stupid infix math.
))

(sasta/dice '("1d6" "-" "d100" "+" "5d3" "*" "foo"))

;;------------------------------------------------------------------------------
;; ERC integration
;;------------------------------------------------------------------------------
(defun erc-cmd-DICE (&rest words)
  (if words
      (erc-send-action (erc-default-target) (concat "rolls " (sasta/dice words)))
    (erc-display-message nil 'notice 'active "usage: /dice 2d6 + 4 + d10")))

(defun erc-cmd-ROLL (&rest words)
  (if words
      (erc-send-action (erc-default-target) (concat "rolls " (sasta/dice words)))
    (erc-display-message nil 'notice 'active "usage: /roll str + 4 + sneak")))
