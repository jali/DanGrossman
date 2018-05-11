#lang racket

; each racket file is a module and by default everything in it is private
; so put this line in the head, so that other test files have access to them modules
(provide (all-defined-out))
 

; this is a comment.
(define s "hello") ; another
; this is like val binding in ML. e.g. s = "hello"

(define x 3) ; val x = 3 in ML
(define y (+ x 2)) ; + is a function, call it here

(define cube1       ; define a variable OR in other word: introdce a val binding
  (lambda (x)       ; then bind it to this anonymous function that takes one argument x
    (* x (* x x)))) ; body
; in other language x * (x * x)

(define (cube x) ; you don't need to write lambda everytime
  (* x x x))
; this is syntactic sugar for defining variable cube to be
; bound to a function that takes one argument x
; and returns the result in his body
; you can also have multiple args like this (func x y z)



; recursive funtion
(define (pow1 x y) ; x to the yth power (y must not be negative)
  ;(if e1 e2 e3)
  (if (= y 0)
      1
      (* x (pow1 x (- y 1)))))

; let's define a pow version with currying
(define pow2
  (lambda (x)    ; not that common in racket because
    (lambda (y)  ; racket support multi args functions
      (pow1 x y))))
; then partially apply it
(define three-to-the (pow2 3))
(define ten-to-the (pow2 10))

