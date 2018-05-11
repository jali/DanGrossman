#lang racket
; local bindings
; (let ([x1 e1]
;      [x2 e2]
;      ...   
;      [xn en])
;  body)

(define (max-of-list xs)
  ; assume all numbers
  (cond [(null? xs) (error "max-of-list given empty list")] ; built in error handling - program will stop here if the list is empty
        [(null? (cdr xs)) (car xs)] ; only one element
        [else (let ([as (max-of-list (cdr xs))])
                (if (> as (car xs))
                    as
                    (car xs)))]))

; let -> the expressions are all evaluated in the environment from before the let-expression
(define (let-double x)
  (let ([x (+ x 3)]  ; 13 
        [y (+ x 2)]) ; 12
    ;x is the global one
    (+ x y -5)))     ; these inside let-body are the local ones
; (let-double 10) ==> 20


; let* -> the expressions are evaluated in the environment produced from the previous bindings
(define (let-star-double x)
  (let* ([x (+ x 3)]  ; 13
         [y (+ x 2)]) ; 15
    (+ x y -8)))
; (let-star-double 10) ==> 20


; letrec -> expressions are evaluated in the environment that includes all the bindings
; all the bindings the earlier ones and the later ones
(define (silly-triple x)
  (letrec ([y (+ x 2)]  ; 12 y evaluated
           [f (lambda(z) (+ z y w x))] ; created a closure, but nothing is evaluated
           (w (+ x 7))) ; 17 w evaluated
    (f -9))) ; 30 because the evaluation happens here

; needed for mutual recursion
; remember function bodies not evauated until called

; you can also use define instead of letrec

(define (silly-mod2 x)
  (letrec
      ([even? (λ(x) (if (zero? x) #t (odd? (- x 1))))]
       [odd? (λ(x) (if (zero? x) #f (even? (- x 1))))])
    (if (even? x) 0 1)))
