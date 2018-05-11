#lang racket

;(cond [el1 el2]
;      [ela elb]
;      ...
;      [eNa eNb])

(define xs (list 1 (list 3 4 5) 2 4))
(define zs '(1 '(3 4 5) "hi" 2 4 #t))

(define (sum3 xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs) (sum3 (cdr xs)))]
        [#t (+ (sum3 (car xs)) (sum3 (cdr xs)))]))

(define (sum4 xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs) (sum4 (cdr xs)))]
        [(list? (car xs)) (+ (sum4 (car xs)) (sum4 (cdr xs)))]
        [else (sum4 (cdr xs))]))
; use else or #t for the rest of conditions
; treat anything other than #f as true
; feature makes no sense in a statically typed language
; racket support dynamic typing
; examples:
; > (if 34 14 15)
; 14
; > (if #f 14 15)
; 15