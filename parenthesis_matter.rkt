#lang racket
; [first big difference from ML and Java (parenthesis matter!!

; factorial n = n * (n - 1)
; works
(define (fac n)
  (if (= n 0)
      1
      (* n (fac (- n 1)))))

; doesn't work
(define (fact4 n)
  (if (= n 0)
      1
      (* n fact4 (- n 1))))
; (fact4 0) ==> 1
; (fact4 5) ==> contract violation
; expected 2. arg is a procedure not a number

; the same below when adding extra parentheses
(define (fact5 n)
  (if (= n 0)
      1
      (* n ((fact5) (- n 1)))))
; the expected number of arguments does not match the given number
; expected: 1
; given: 0