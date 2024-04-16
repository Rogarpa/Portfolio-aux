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

; ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA 
; ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA 
; '(program 
;     (main {(= (decl i int) (= zzzz (+ zzzz 1))) (= zzzz (+ zzzz 1)) (= (decl r int) ( gdc (i zzz)))})
;     (
;         (gdc 
;             ((var1 int) (var2 int))
;             int
;             {(while (!= var1 0) {(if-stn (< var1 var2) {(= var2 (- var2 var1))} else {(= var1 (- var1 var2))})}) (return b)}) 
;         (sort 
;             ((a (arrType int)))
;             (
;                 (= (decl i int) 0)
;                 (= (decl n int) ( length (a)))
;                 (while 
;                     (< i n)
;                     {
;                         (= (decl j int) i)
;                         (while 
;                             (> j 0)
;                             {
;                                 (if-stn 
;                                     (> (arrElement a (arrIndex (- j 1))) (arrElement a (arrIndex j)))
;                                     {
;                                         (= (decl swap int) (arrElement a (arrIndex j)))
;                                         (= (arrElement a (arrIndex j)) (arrElement a (arrIndex (- j 1))))
;                                         (= (arrElement a (arrIndex (- j 1))) swap)})
;                                 (= j (+ j 1))})
;                         (= i (+ i 1))})))))
; SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA
; Usando:
; La tabla de renombrado (generada tomando las variables de main y de cada funcion (los diferentes scopes) por separado (con un nanopass-case), generando una tabla por cada subset y uniendo las tablas):
; i var_0
; zzzz var_1
; r var_2
; var_1 var_3
; var_2 var_4
; b var_5
; a var_6
; i var_7
; n var_8
; j var_9
; swap var_10
; SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA
; SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA
; '(program 
;     (main {(= (decl var_0 int) (= var_1 (+ var_1 1))) (= var_1 (+ var_1 1)) (= (decl var_2 int) ( gdc (var_0 var_1)))})
;     (
;         (gdc 
;             ((var_3 int) (var_4 int))
;             int
;             {(while (!= var_3 0) {(if-stn (< var_3 var_4) {(= var_4 (- var_4 var_3))} else {(= var_3 (- var_3 var_4))})}) (return var_5)}) 
;         (sort 
;             ((var_6 (arrType int)))
;             (
;                 (= (decl var_7 int) 0)
;                 (= (decl var_8 int) ( length (var_6)))
;                 (while 
;                     (< var_7 var_8)
;                     {
;                         (= (decl var_9 int) var_7)
;                         (while 
;                             (> var_9 0)
;                             {
;                                 (if-stn 
;                                     (> (arrElement var_6 (arrIndex (- var_9 1))) (arrElement var_6 (arrIndex var_9)))
;                                     {
;                                         (= (decl var_10 int) (arrElement var_6 (arrIndex var_9)))
;                                         (= (arrElement var_6 (arrIndex var_9)) (arrElement var_6 (arrIndex (- var_9 1))))
;                                         (= (arrElement var_6 (arrIndex (- var_9 1))) var_10)})
;                                 (= var_9 (+ var_9 1))})
;                         (= var_7 (+ var_7 1))})))))
(define (rename-var ir) '())
; ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA 
; ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA \\ENTRADA 
; '(program 
;     (main {(= (decl var_0 int) (= var_1 (+ var_1 1))) (= var_1 (+ var_1 1)) (= (decl var_2 int) ( gdc (var_0 var_1)))})
;     (
;         (gdc 
;             ((var_3 int) (var_4 int))
;             int
;             {(while (!= var_3 0) {(if-stn (< var_3 var_4) {(= var_4 (- var_4 var_3))} else {(= var_3 (- var_3 var_4))})}) (return var_5)}) 
;         (sort 
;             ((var_6 (arrType int)))
;             (
;                 (= (decl var_7 int) 0)
;                 (= (decl var_8 int) ( length (var_6)))
;                 (while 
;                     (< var_7 var_8)
;                     {
;                         (= (decl var_9 int) var_7)
;                         (while 
;                             (> var_9 0)
;                             {
;                                 (if-stn 
;                                     (> (arrElement var_6 (arrIndex (- var_9 1))) (arrElement var_6 (arrIndex var_9)))
;                                     {
;                                         (= (decl var_10 int) (arrElement var_6 (arrIndex var_9)))
;                                         (= (arrElement var_6 (arrIndex var_9)) (arrElement var_6 (arrIndex (- var_9 1))))
;                                         (= (arrElement var_6 (arrIndex (- var_9 1))) var_10)})
;                                 (= var_9 (+ var_9 1))})
;                         (= var_7 (+ var_7 1))})))))
; SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA
; SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA\\SALIDA ESPERADA
; hash(
; var_0 int
; var_1 DUDA PENDIENTE PUES NO SE DECLARA
; var_2 int
; var_3 int
; var_4 int
; var_5 DUDA PENDIENTE PUES NO SE DECLARA
; var_6 (arrType int)
; var_7 int
; var_8 int
; var_9 int
; var_10 int
; )
(define (symbol-table ir) '())

(define (parse-complete s) (parser-jelly (read (open-input-string (syntax-tree (parsea s))))))
(define (parser-input s) (read (open-input-string (syntax-tree (parsea s)))))

(define input
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
                        (= i (+ i 1))}))))))

(define parsed-input (parser-jelly input))
(define symbol-table-input
        '(program 
        (main {(= (decl var_0 int) (= var_1 (+ var_1 1))) (= var_1 (+ var_1 1)) (= (decl var_2 int) ( gdc (var_0 var_1)))})
        (
                (gdc 
                ((var_3 int) (var_4 int))
                int
                {(while (!= var_3 0) {(if-stn (< var_3 var_4) {(= var_4 (- var_4 var_3))} else {(= var_3 (- var_3 var_4))})}) (return var_5)}) 
                (sort 
                ((var_6 (arrType int)))
                (
                        (= (decl var_7 int) 0)
                        (= (decl var_8 int) ( length (var_6)))
                        (while 
                        (< var_7 var_8)
                        {
                                (= (decl var_9 int) var_7)
                                (while 
                                (> var_9 0)
                                {
                                        (if-stn 
                                        (> (arrElement var_6 (arrIndex (- var_9 1))) (arrElement var_6 (arrIndex var_9)))
                                        {
                                                (= (decl var_10 int) (arrElement var_6 (arrIndex var_9)))
                                                (= (arrElement var_6 (arrIndex var_9)) (arrElement var_6 (arrIndex (- var_9 1))))
                                                (= (arrElement var_6 (arrIndex (- var_9 1))) var_10)})
                                        (= var_9 (+ var_9 1))})
                                (= var_7 (+ var_7 1))}))))))