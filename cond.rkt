#lang racket

;(cond [el1 el2]
;      [ela elb]
;      ...
;      [eNa eNb])

(define xs (list 1 (list 3 4 5) 2 4))

(define (sum3 xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs) (sum3 (cdr xs)))]
        [#t (+ (sum3 (car xs)) (sum3 (cdr xs)))]))