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
        (Expr (e)
                c
                dt
                pr
                i
                (arrIndex e)
                (length e)
                (return e)
                (while e0 e1)
                (if-stn e0 e1)
                (if-stn e0 e1 e2)
                (arrElement e1 e2)
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
(define (check-case ir)
        (nanopass-case (jelly Program) ir
                [(program ,m) (begin
                                        (display "program-main-case: \n")
                                        (print ir)
                                        (display "\n")
                                        (check-case-Main m)
                                        (display "\n"))]
                [(program ,m [,f* ... ,f]) (begin
                                                (display "program-main-fun-case: \n")
                                                (print ir)
                                                (display "\n")
                                                (check-case-Main m m)
                                                (map (lambda (f) (check-case-Function f f)) f*)
                                                (check-case-Function f f)
                                                (display "\n"))]
                [else (begin (display "caso Program \n")
                        (print ir)
                        (display "\n"))]))


(define (check-case-Main ir st)
        (nanopass-case (jelly Main) ir
                [(main [,e* ... ,e]) (begin
                                        (display "main-case: \n")
                                        (print ir)
                                        (display "\n")
                                        (map (lambda (e) (check-case-Expr e e)) e*)
                                        (check-case-Expr e e)
                                        (display "\n"))]
                [else (begin 
                        (display "caso Main \n")
                        (print ir)
                        (display "\n"))]))
(define (check-case-Function ir st) 
        (nanopass-case (jelly Function) ir
        [(,i ([,i* ,dt*] ...) ,t ,e) (begin
                                        (display "function-type-case \n")
                                        (print ir)
                                        (display "\n")
                                        (check-case-Expr i i)
                                        (map (lambda (i) (check-case-Expr i i)) i*)
                                        (map (lambda (dt) (check-case-Expr dt dt)) dt*)
                                        (check-case-Expr t t)
                                        (check-case-Expr e e)
                                        (display "\n"))]
        [(,i ([,i* ,dt*] ...) ,e) (begin
                                        (display "function-notype-case \n")
                                        (print ir)
                                        (display "\n")
                                        (check-case-Expr i i)
                                        (map (lambda (i) (check-case-Expr i i)) i*)
                                        (map (lambda (dt) (check-case-Expr dt dt)) dt*)
                                        (check-case-Expr e e)
                                        (display "\n"))]
                [else (begin 
                        (display "caso Function \n")
                        (print ir)
                        (display "\n"))]))
(define (check-case-DeclarationType ir st) 
        (nanopass-case (jelly DeclarationType) ir
                [,t (begin
                        (display "type-case \n")
                        (print ir)
                        (display "\n"))]
                [(arrType ,t) (begin
                                (display "arr-type-case \n")
                                (print ir)
                                (display "\n"))]
                [else (begin 
                        (display "caso DeclarationType \n")
                        (print ir)
                        (display "\n"))]))
(define (check-case-Expr ir st) 
        (nanopass-case (jelly Expr) ir
                [,c (begin
                                (display "expr-c-case \n")
                                (print ir)
                                (display "\n")
                                (display "\n"))]
                [,dt (begin
                                (display "expr-dt-case \n")
                                (print ir)
                                (display "\n")
                                (check-case-DeclarationType dt dt)
                                (display "\n"))]
                [,pr (begin
                                (display "expr-pr-case \n")
                                (print ir)
                                (display "\n")
                                (display "\n"))]
                [,i (begin
                                (display "expr-i-case \n")
                                (print ir)
                                (display "\n")
                                (display "\n"))]
                [(arrIndex ,e) (begin
                                (display "expr-(arrIndex e)-case \n")
                                (print ir)
                                (display "\n")
                                (check-case-Expr e e)
                                (display "\n"))]
                [(length ,e) (begin
                                (display "expr-(length e)-case \n")
                                (print ir)
                                (display "\n")
                                (check-case-Expr e e)
                                (display "\n"))]
                [(return ,e) (begin
                                (display "expr-(return e)-case \n")
                                (print ir)
                                (display "\n")
                                (check-case-Expr e e)
                                (display "\n"))]
                [(while ,e0 ,e1) (begin
                                (display "expr-(while e0 e1)-case \n")
                                (print ir)
                                (display "\n")
                                (check-case-Expr e0 e0)
                                (check-case-Expr e1 e1)
                                (display "\n"))]
                [(if-stn ,e0 ,e1) (begin
                                (display "expr-(if-stn e0 e1)-case \n")
                                (print ir)
                                (display "\n")
                                (check-case-Expr e0 e0)
                                (check-case-Expr e1 e1)
                                (display "\n"))]
                [(if-stn ,e0 ,e1 ,e2) (begin
                                (display "expr-(if-stn e0 e1 e2)-case \n")
                                (print ir)
                                (display "\n")
                                (check-case-Expr e0 e0)
                                (check-case-Expr e1 e1)
                                (check-case-Expr e2 e2)
                                (display "\n"))]
                [(arrElement ,e1 ,e2) (begin
                                (display "expr-(arrElement e1 e2)-case \n")
                                (print ir)
                                (display "\n")
                                (check-case-Expr e1 e1)
                                (check-case-Expr e2 e2)
                                (display "\n"))]
                [(decl ,i ,dt) (begin
                                (display "expr-(decl i dt)-case \n")
                                (print ir)
                                (display "\n")
                                (check-case-Expr i i)
                                (check-case-Expr dt dt)
                                (display "\n"))]
                [(,e* ...) (begin
                                (display "expr-(e* ...)-case \n")
                                (print ir)
                                (display "\n")
                                (map (lambda (e) (check-case-Expr e e)) e*)
                                (display "\n"))]
                [(,pr ,e0 ,e1) (begin
                                (display "expr-(pr e0 e1)-case \n")
                                (print ir)
                                (display "\n")
                                (check-case-Expr pr pr)
                                (check-case-Expr e0 e0)
                                (check-case-Expr e1 e1)
                                (display "\n"))]
                [(,i [,e* ...]) (begin
                                (display "expr-(i [e* ...])-case \n")
                                (print ir)
                                (display "\n")
                                (check-case-Expr i i)
                                (map (lambda (e) (check-case-Expr e e)) e*)
                                (display "\n"))]
                [else (begin 
                        (display "caso Expr \n")
                        (print ir)
                        (display "\n"))]))



(define (get-vars ir)
        (nanopass-case (jelly Program) ir
                [(program ,m) (let ([variables (mutable-set)])
                                        (begin
                                                (display "program-main-case: \n")
                                                (print ir)
                                                (display "\n")
                                                (get-vars-Main m variables)
                                                (display "\n")
                                                variables))]
                [(program ,m [,f* ... ,f]) (let ([variables (mutable-set)])
                                                (begin
                                                        (display "program-main-fun-case: \n")
                                                        (print ir)
                                                        (display "\n")
                                                        (get-vars-Main m variables)
                                                        (map (lambda (f) (get-vars-Function f variables)) f*)
                                                        (get-vars-Function f variables)
                                                        (display "\n")
                                                        variables))]
                [else (begin (display "caso Program \n")
                        (print ir)
                        (display "\n"))]))

(define (get-vars-Main ir variables)
        (nanopass-case (jelly Main) ir
                [(main [,e* ... ,e]) (begin
                                        (display "main-case: \n")
                                        (print ir)
                                        (display "\n")
                                        (map (lambda (e) (get-vars-Expr e variables)) e*)
                                        (get-vars-Expr e variables)
                                        (display "\n"))]
                [else (begin 
                        (display "caso Main \n")
                        (print ir)
                        (display "\n"))]))

(define (get-vars-Function ir variables) 
        (nanopass-case (jelly Function) ir
        [(,i ([,i* ,dt*] ...) ,t ,e) (begin
                                        (display "function-type-case \n")
                                        (print ir)
                                        (display "\n")
                                        (get-vars-Expr i variables)
                                        (map (lambda (i) (get-vars-Expr i variables)) i*)
                                        (map (lambda (dt) (get-vars-Expr dt variables)) dt*)
                                        (get-vars-Expr t variables)
                                        (get-vars-Expr e variables)
                                        (display "\n"))]
        [(,i ([,i* ,dt*] ...) ,e) (begin
                                        (display "function-notype-case \n")
                                        (print ir)
                                        (display "\n")
                                        (get-vars-Expr i variables)
                                        (map (lambda (i) (get-vars-Expr i variables)) i*)
                                        (map (lambda (dt) (get-vars-Expr dt variables)) dt*)
                                        (get-vars-Expr e variables)
                                        (display "\n"))]
                [else (begin 
                        (display "caso Function \n")
                        (print ir)
                        (display "\n"))]))

(define (get-vars-DeclarationType ir variables) 
        (nanopass-case (jelly DeclarationType) ir
                [,t (begin
                        (display "type-case \n")
                        (print ir)
                        (display "\n"))]
                [(arrType ,t) (begin
                                (display "arr-type-case \n")
                                (print ir)
                                (display "\n"))]
                [else (begin 
                        (display "caso DeclarationType \n")
                        (print ir)
                        (display "\n"))]))

(define (get-vars-Expr ir variables) 
        (nanopass-case (jelly Expr) ir
                [,c (begin
                                (display "expr-c-case \n")
                                (print ir)
                                (display "\n")
                                (display "\n"))]
                [,dt (begin
                                (display "expr-dt-case \n")
                                (print ir)
                                (display "\n")
                                (get-vars-DeclarationType dt variables)
                                (display "\n"))]
                [,pr (begin
                                (display "expr-pr-case \n")
                                (print ir)
                                (display "\n")
                                (display "\n"))]
                [,i (begin
                                (display "expr-i-case \n")
                                (print ir)
                                (set-add! variables i)
                                (display "\n")
                                (display "\n"))]
                [(arrIndex ,e) (begin
                                (display "expr-(arrIndex e)-case \n")
                                (print ir)
                                (display "\n")
                                (get-vars-Expr e variables)
                                (display "\n"))]
                [(length ,e) (begin
                                (display "expr-(length e)-case \n")
                                (print ir)
                                (display "\n")
                                (get-vars-Expr e variables)
                                (display "\n"))]
                [(return ,e) (begin
                                (display "expr-(return e)-case \n")
                                (print ir)
                                (display "\n")
                                (get-vars-Expr e variables)
                                (display "\n"))]
                [(while ,e0 ,e1) (begin
                                (display "expr-(while e0 e1)-case \n")
                                (print ir)
                                (display "\n")
                                (get-vars-Expr e0 variables)
                                (get-vars-Expr e1 variables)
                                (display "\n"))]
                [(if-stn ,e0 ,e1) (begin
                                (display "expr-(if-stn e0 e1)-case \n")
                                (print ir)
                                (display "\n")
                                (get-vars-Expr e0 variables)
                                (get-vars-Expr e1 variables)
                                (display "\n"))]
                [(if-stn ,e0 ,e1 ,e2) (begin
                                (display "expr-(if-stn e0 e1 e2)-case \n")
                                (print ir)
                                (display "\n")
                                (get-vars-Expr e0 variables)
                                (get-vars-Expr e1 variables)
                                (get-vars-Expr e2 variables)
                                (display "\n"))]
                [(arrElement ,e1 ,e2) (begin
                                (display "expr-(arrElement e1 e2)-case \n")
                                (print ir)
                                (display "\n")
                                (get-vars-Expr e1 variables)
                                (get-vars-Expr e2 variables)
                                (display "\n"))]
                [(decl ,i ,dt) (begin
                                (display "expr-(decl i dt)-case \n")
                                (print ir)
                                (display "\n")
                                (get-vars-Expr i variables)
                                (get-vars-Expr dt variables)
                                (display "\n"))]
                [(,e* ...) (begin
                                (display "expr-(e* ...)-case \n")
                                (print ir)
                                (display "\n")
                                (map (lambda (e) (get-vars-Expr e variables)) e*)
                                (display "\n"))]
                [(,pr ,e0 ,e1) (begin
                                (display "expr-(pr e0 e1)-case \n")
                                (print ir)
                                (display "\n")
                                (get-vars-Expr pr variables)
                                (get-vars-Expr e0 variables)
                                (get-vars-Expr e1 variables)
                                (display "\n"))]
                [(,i [,e* ...]) (begin
                                (display "expr-(i [e* ...])-case \n")
                                (print ir)
                                (display "\n")
                                (get-vars-Expr i i)
                                (map (lambda (e) (get-vars-Expr e variables)) e*)
                                (display "\n"))]
                [else (begin 
                        (display "caso Expr \n")
                        (print ir)
                        (display "\n"))]))



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