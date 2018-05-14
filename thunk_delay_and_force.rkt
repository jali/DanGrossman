#lang racket

; thunks let you skip expensive computatinos if they are not needed
; great if you take the true-branch
; but worse if you end up using the thunk more than once

; silly slow addition example that runs slow for demonstration purposes
(define (slow-add x y)
  (letrec ([slow-id (lambda (y z)
                      (if (= 0 z)
                          y
                          (slow-id y (- z 1))))])
    (+ (slow-id x 50000000) y)))

; multiplies x and result of y-thunk, calling y-thunk x times
(define (my-mult x y-thunk) ; assumes x is >=0
  (cond [(= x 0) 0]
        [(= x 1) (y-thunk)]
        [#t (+ (y-thunk) (my-mult (- x 1) y-thunk))]))
; even though slow-add is slow
; when I call my-mult like this, it's fast
; (my-mult 0 (lambda () (slow-add 3 4)))
; but if I multiply by 1, then the speed is slow just as slow-add
; and when I multiply by 2 then the speed slows down by factor 2 etc...
; in fact if I create a thunk for x and compute the slow add as local value shown below
; (my-mult 0 (let ([x (slow-add 3 4)]) (lambda () x)))
; then all multiplications will take almost the same speed as slow-add
; (my-mult 20 (let ([x (slow-add 3 4)]) (lambda () x)))

; ideally not compute untill needed
; remember answer so future uses complete immediately (also called lazy evaluation)
; lazy evaluation e.g. - haskell

; racket predefines support for promises, but we can make our own
; - thunks and mutable pairs are enough

;DELAY & FORCE
; An ADT represented by a mutable pair
; - #f in car means cdr is unevaluated thunk
;   > Really a one-of type: thunk or result-of-thunk
; - Ideally hide representation in a module
(define (my-delay th) ; call thunk that is not being evaluated yet
  (mcons #f th))      ; and then let's return mutable pair of false and a thunk
; so we never called the thunk [ there's no parenthesis around th ]
; so that's going to be happen very fast
; we haven't done any expensive computation yet
; then when you want to use thunk
; we call my force on the thing above and we get a promise

(define (my-force promise)
  (if (mcar promise)
      (mcdr promise)
      (begin (set-mcar! promise #t)
             (set-mcdr! promise ((mcdr promise)))
             (mcdr promise))))
; in the false branch, we do the following
; 1- we change the car of the promise to be true
; 2- then we're going to change the cdr of the promise that it doesn't hold what it use to hold -
;    instead it holds the result of calling the thunk
;    (( the first one gets out of the thunk, the next paren calling the thunk ))
;    we take that result and put it in the cdr. we don't save it anywhere else
; 3- we look up (mcdr p) have the result of calling the thunk and we return it
;
; if anyone calls my-force again, mcar will be true, therefore we won't evaluate the thunk, because we don't have to
; we just return the mcdr


      