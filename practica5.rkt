#lang nanopass

(require "syntax-tree.rkt")
(require "parser.rkt")
(require "lexer.rkt")

(require racket/hash)


(define-language jelly
        (terminals
                (constant (c))
                (primitive (pr))
                (type (t))
                (id (i)))
        (Program (p)
                (program m)
                (program m [f* ... f]))
        (Main (m)
                (main [e* ... e]))
        (Function (f)
                (i ([i* dt*] ...) t e)
                
                (i ([i* dt*] ...) e))
        (DeclarationType (dt)
                t
                (arrType t))
        (ArrayIndex (ai)
                (arrIndex e))
        (Expr (e)
                c
                dt
                i
                pr
                (length e)
                (return e)
                (while e0 e1)
                (if-stn e0 e1)
                (if-stn e0 e1 e2)
                (arrElement e ai)
                (decl i dt)
                (e* ...)
                (pr e0 e1)
                (i [e* ...])
                ))
        
(define (id? i) (symbol? i))
(define (type? t) (memq t '(int bool)))
(define (primitive? pr) (memq pr '(+ - * / % ? != pipe && =  < > <= >=)))
(define (constant? c) (or (number? c) (boolean? c)))

(define-parser parser-jelly jelly)

; Global counter
(define c 0)

; Generate consecutive variable names as "var_i"
(define (nueva)
        (let* ([str-num (number->string c)]
               [str-sim (string-append "var_" str-num)]) 
               (set! c (add1 c))
               (string->symbol str-sim)))

; Receives an id list (symbol) and returns a hash-set with the ids as keys
; and an incremental symbol of the shape of "var_i" starting in 0
(define (asigna vars)
        (let ([tabla (make-hash)])
             (set-for-each vars
                           (lambda (v) (hash-set! tabla v (nueva))))
             tabla))

(define (rename-var ir) '())
(define (symbol-table ir) '())

(define (parse-complete s) (parser-jelly (read (open-input-string (syntax-tree (parsea s))))))
(define (parser-input s) (read (open-input-string (syntax-tree (parsea s)))))

(define test
'(program 
    (main {(= (decl i int) (= zzzz (+ zzzz 1))) (= zzzz (+ zzzz 1)) (= (decl r int) ( gdc (i zzz)))})
    (
        (gdc 
            ((var1 int) (var2 int))
            int
            {(while (!= var1 0) {(if-stn (< var1 var2) {(= var2 (- var2 var1))} else {(= var1 (- var1 var2))})}) (return b)}) 
        (sort 
            ((a (arrType int)))
            (
                (= (decl i int) 0)
                (= (decl n int) ( length (a)))
                (while 
                    (< i n)
                    {
                        (= (decl j int) i)
                        (while 
                            (> j 0)
                            {
                                (if-stn 
                                    (> (arrElement a (arrIndex (- j 1))) (arrElement a (arrIndex j)))
                                    {
                                        (= (decl swap int) (arrElement a (arrIndex j)))
                                        (= (arrElement a (arrIndex j)) (arrElement a (arrIndex (- j 1))))
                                        (= (arrElement a (arrIndex (- j 1))) swap)})
                                (= j (+ j 1))})
                        (= i (+ i 1))}))))
))
