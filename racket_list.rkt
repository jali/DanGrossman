#lang racket

(define alist (list 1 2 4))

; summ all numbers in a list
(define (sumlist xs)
  (if (null? xs)
      0
      (+ (car xs) (sumlist(cdr xs)))))
; (sumlist '(3 4 5 6)) will return 18

; append
(define (appnd xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (appnd (cdr xs) ys))))

; map (higher order function)
; map takes two arguments: f and xs
; f should apply to every element of xs
; and return a list of the same length with the result of those calls
(define (mapme f xs)
  (if (null? xs)
      null
      (cons (f (car xs))
            (mapme f (cdr xs)))))
  