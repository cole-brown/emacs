;; (c) 2008 Cole Brown
;; 
;; This work 'as-is' we provide.
;; No warranty, express or implied.
;; We've done our best,
;; to debug and test.
;; Liability for damages denied.
;; 
;; Permission is granted hereby,
;; to copy, share, and modify.
;; Use as is fit,
;; free or for profit.
;; On this notice these rights rely.
;;
;; (Lawyers, please see MIT License.)

;; Copyright (c) 2008 Cole Brown
;; 
;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use,
;; copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the
;; Software is furnished to do so, subject to the following
;; conditions:
;; 
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;; 
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
;; OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
;; OTHER DEALINGS IN THE SOFTWARE.
;;
;; (aka MIT License)


;; insert explination here

;; Operator precedence in alist. Equal precedence in same list.
(setq *sasta/operator-precedence* '((lowest  + -)
                                    (highest * /)))

;; Levels of precedence used in operator precedence alist.
;; NOTE: Must be in order, from lowest to highest.
(setq *sasta/precedence-levels* '(lowest highest))

(defun sasta/operators (precedence-level)
  "Get list of operators from precedence alist."
  (cdr (assoc precedence-level *sasta/operator-precedence*)))

;(operators 'lowest)  => (+ -)
;(operators 'mid)     => nil
;(operators 'highest) => (* /)

(defun sasta/min-of-list (list)
  "This min function takes a list as arg and ignores nils."
  (let* ((nilless (remq nil list))
        (len     (length nilless)))
    (cond ((> len 1) (eval (cons 'min nilless)))
          ((equal len 1) (car nilless))
          (t nil))))

; (sasta/min-of-list '(nil nil 8 7)) => 7

(defun sasta/find-first-op-in-precedence (expression op-prec)
  "Find the first occurrence in an expression of one of the operators
in a list of equal precedence ops."
  (min-of-list
   (mapcar (lambda (operator)
             (position operator expression))
           (operators op-prec))))

;(sasta/find-first-op-in-precedence '(2 + 3 / 7 + 2 * 1) 'lowest) => 1

(defun sasta/find-lowest-precedence-operator (expression)
  "Find the index of the lowest precedence operator in the expression."
  (catch 'found-index
    (dolist (op-prec *sasta/precedence-levels*)
      (let ((index (find-first-op-in-precedence expression op-prec)))
        (when index (throw 'found-index index))))))

;(sasta/find-lowest-precedence-operator '(2 * 3 / 7 / 2 - 1)) => 7

(defun sasta/split-expression (expression index)
  "Slices the expression list into pre-element sublist, element, and post-element sublist."
  (if (and (<= 0 index) (<= index (1- (length expression))))
      (values (subseq expression 0 index)
              (elt expression index)
              (subseq expression (1+ index)))
    (values nil nil nil)))

;(sasta/split-expression '(1 * 2 + 3 / 4) 3) => ((1 * 2) + (3 / 4))

(defun sasta/infix->prefix (expression)
  "Transforms an infix notation expression (1 * 2 + 3 / 4) into the proper prefix equivalent (+ (* 1 2) (/ 3 4)).
Operators must be symbols, not strings."
  (let ((index (find-lowest-precedence-operator expression)))
    (if index (multiple-value-bind (before operator after) (split-expression expression index)
                (list operator
                      (infix->prefix before)
                      (infix->prefix after)))
      (car expression))))

;(sasta/infix->prefix '(2 * 3 + 7 / 2 + 1)) => (+ (* 2 3) (+ (/ 7 2) 1))
;(eval (sasta/infix->prefix '(2 * 3 + 7 / 2 + 1))) => 10
;6 + 3.5 + 1 = 10.5 aka 10 in integer math









