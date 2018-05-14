#lang racket

(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 1))))

; Streams
; A stream is an infinite sequence of values
; - So cannot make a stream by making all the values
; - Key idea is to use a thunk to delay creating mose of the sequence
; we ask when we need it (Stream consumer decides how many values to ask for)
; some examples;
; - user actions (mouse clicks, etc..)
; - unix pipes cmd1 | cmd2 <- pulls data from cmd1
; - output values from a sequential feedback circuit

; we're goign to represent a stream as a thunk
; when you call it, it gives back a pair
; '(next-answer . next-thunk)

; given (power-of-two) returns a pair (promise) '(2 . #<procedure: ..>)
; (car (power-of-two)) returns 2
; (car ((cdr (power-of-two)))) returns 4
; (car ((cdr ((cdr (power-of-two)))))) returns 8

; let's define a rec fun number-until that takes a stream and a fun
; will count until true
(define (number-until stream tester)
  (letrec ([f (lambda (stream ans)
                (let ([pr (stream)])
                  (if (tester (car pr))
                      ans
                      (f (cdr pr) (+ ans 1)))))])
    (f stream 1)))

(number-until powers-of-two (lambda (x) (= x 16)))

; defining a stream
; cons 1 to a thunk that returns ones
; returns a pair of 1 and the procedure itself
; 1 1 1 1 1 .....
(define ones (lambda () (cons 1 ones)))


; 1 2 3 4 5 ...
(define (f x) (cons x (lambda () (f (+ x 1)))))
(define nats1 (lambda () (f 1)))

; other way of writing this
(define nats
  (letrec ([f (lambda (x) (cons x (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

; how about power of two
; 2 4 8 16 ...
(define powers-of-twos
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 1))))