#lang racket
; MEMOIZATION

; if a function has no side effects and does not read mutable memory, no point in computing it twice for the same arguments
; - can keep a cache of previous results
; - net win if (1) maintaining cache is cheaper than recomputing and (2) cached results are reused

; similar to promises, but if the function takes arguments, then there are multiple "previous results"

; for recursive functions, this memoization can lead to exponentially faster programs
; - related to alorithmic technique of dynamic programming

(define (fibonacci1 x) ; inefficient
  (if (or (= x 1) (= x 2))
      1
      (+ (fibonacci1 (- x 1))
         (fibonacci1 (- x 2)))))

(define (fibonacci2 x)
  (letrec ([f (lambda (acc1 acc2 y)
                (if (= y x)
                    (+ acc1 acc2)
                    (f (+ acc1 acc2) acc1 (+ y 1))))])
    (if (or (= x 1) (= x 2))
        1
        (f 1 1 3))))

(define fibonacci3
         (letrec ([memo null] ; list of pairs ( arg . result)
                  [f (lambda (x)
                       (let ([ans (assoc x memo)])
                         (if ans
                             (cdr ans)
                             (let ([new-ans (if (or (= x 1) (= x 2))
                                                1
                                                (+ (f (- x 1))
                                                   (f (- x 2))))])
                               (begin
                                 (set! memo (cons (cons x new-ans) memo))
                                 new-ans)))))])
           f))


  
  

  ; what is assoc
  ; standard helper function to check if element exists in a list of pairs
  ; it checks the car field of the pairs
  (define xs (list (cons 1 2) (cons 3 4)))