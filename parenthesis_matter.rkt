#lang racket
; [first big difference from ML and Java (parenthesis matter!!

; factorial n = n + (n - 1)
(define (fac n)
  (if (= n 0)
      1
      (* n (fac (- n 1)))))
