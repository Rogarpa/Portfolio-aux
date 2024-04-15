#lang nanopass

(require "syntax-tree.rkt")
(require racket/hash)


(define-language jelly
        (terminals
                (constante (c)))
        (Expr (e)
                c)
)

(define (id? i) (string? i))
(define (type? t) (memq t '(int bool)))
(define (primitivo? p) (memq p '(+ - * / %  = == < > <= >= != & #\|)))
(define (constante? c) (or (number? c) (boolean? c)))

(define-parser parser-jelly jelly)

; Contador global
(define c 0)

; Genera symbolos de la forma var_i
(define (nueva)
        (let* ([str-num (number->string c)]
               [str-sim (string-append "var_" str-num)]) 
               (set! c (add1 c))
               (string->symbol str-sim)))
; Recibe una lista de ids (symbol) y regresa un hash-set en donde cada id será la llave de un
; symbol de la forma var_i con i creciente a partir de 1/0.
(define (asigna vars)
        (let ([tabla (make-hash)])
             (set-for-each vars
                           (lambda (v) (hash-set! tabla v (nueva))))
             tabla))

(define (rename-var ir) '())
(define (symbol-table ir) '())