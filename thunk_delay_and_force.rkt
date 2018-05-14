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

