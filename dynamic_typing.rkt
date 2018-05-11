#lang racket

; dynamic typing: can use values of any type anywhere
(define xs '(4 5 6))
(define ys (list '(4 5) 6 7 '(8) 9 2 3 (list 0 1)))

; append two lists
(define (appnd lst1 lst2)
  (if (null? lst1)
      lst2
      (cons (car lst1) (appnd (cdr lst1) lst2))))

; sum of list
(define (sum1 xs)
  (if (null? xs)
      0
      (if (number? (car xs))
          (+ (car xs) (sum1 (cdr xs))) ; first element is a number
          (+ (sum1 (car xs)) (sum1 (cdr xs)))))) ; otherwise first element is a list