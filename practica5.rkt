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

(define-pass rename-var : jelly (ir) ->  jelly ()
        (Program : Program (ir) -> Program () 
                [(program ,m)
                                `(program ,(Main m (make-hash)))]
                [(program ,m [,f* ... ,f]) 
                                        `(program ,(Main m (make-hash))[,(map (lambda (f) (Function f (make-hash))) f*) ...
                                                                ,(Function f (make-hash))])])
        (Main : Main (ir rename-dictionary) -> Main ()
                [(main [,e* ... ,e]) (let* ([vars  (mutable-set)]
                                                [vars  (get-vars-Main ir vars)]
                                                [rename-dictionary-main (make-hash)]
                                                [rename-dictionary-main (begin 
                                                                                (display vars)
                                                                                (hash-union! rename-dictionary-main rename-dictionary)
                                                                                (hash-union! rename-dictionary-main (asigna vars))
                                                                                rename-dictionary-main)])
                                                        
                                                (print rename-dictionary-main)
                                                `(main [,(map (lambda (e) (Expr e rename-dictionary-main)) e*) ... ,(Expr e rename-dictionary-main)]))])
        (Function : Function (ir rename-dictionary) -> Function ()
                [(,i ([,i* ,dt*] ...) ,t ,e) (let* (
                                                        [vars  (mutable-set)]
                                                        [vars  (get-vars-Function ir vars)]
                                                        [rename-dictionary-function (make-hash)]
                                                        [rename-dictionary-function (begin
                                                                                (hash-union!
                                                                                rename-dictionary-function rename-dictionary)
                                                                                (hash-union! rename-dictionary-function (asigna vars))
                                                                                rename-dictionary-function)]
                                                        [i*-n  (map (lambda (v) (Expr v rename-dictionary-function)) i*)]
                                                        [e-n  (Expr e rename-dictionary-function)])

                                                (print rename-dictionary-function)
                                                `(,i   ([,i*-n ,dt*] ...) ,t ,e-n)
                                                )]
                                                        
                [(,i ([,i* ,dt*] ...) ,e) (let* (
                                                        [vars  (mutable-set)]
                                                        [vars  (get-vars-Function ir vars)]
                                                        [rename-dictionary-function (make-hash)]
                                                        [rename-dictionary-function (begin
                                                                                (hash-union!
                                                                                rename-dictionary-function rename-dictionary)
                                                                                (hash-union! rename-dictionary-function (asigna vars))
                                                                                rename-dictionary-function)]
                                                        [i*-n  (map (lambda (v) (Expr v rename-dictionary-function)) i*)]
                                                        [e-n  (Expr e rename-dictionary-function)])

                                                (print rename-dictionary-function)
                                                `(,i   ([,i*-n ,dt*] ...) ,e-n)
                                                )])
        (DeclarationType : DeclarationType (ir rename-dictionary) -> DeclarationType ()
                [,t t]
                [(arrType ,t) `(arrType ,t)])
        (Expr : Expr (ir rename-dictionary) -> Expr ()
                [,c `(,c)]
                [,dt `(,dt)]
                [,pr `(,pr)]
                [,i `,(hash-ref rename-dictionary i)]
                [(arrIndex ,[e]) `(arrIndex e)]
                [(length ,[e]) `(length ,e)]
                [(return ,[e]) `(return ,e)]
                [(while ,[e0] ,[e1]) `(while ,e0 ,e1)]
                [(if-stn ,[e0] ,[e1]) `(if-stn ,e0 ,e1)]
                [(if-stn ,[e0] ,[e1] ,[e2]) `(if-stn ,e0 ,e1)]
                [(arrElement ,[e1] ,[e2]) `(arrElement ,e1 ,e2)]
                [(decl ,i ,dt) `(decl ,(Expr i rename-dictionary) ,dt)]
                [(,[e*] ...) `(,e* ...)]
                [(,[pr] ,[e0] ,[e1]) `(,pr ,e0 ,e1)]
                [(,i [,[e*] ...]) `(,i [,e* ...])]))

(define (get-vars ir)
        (nanopass-case (jelly Program) ir
                [(program ,m) (let ([variables (mutable-set)])
                                        (begin
                                                (get-vars-Main m variables)
                                                variables))]
                [(program ,m [,f* ... ,f]) (let ([variables (mutable-set)])
                                                (begin
                                                        (get-vars-Main m variables)
                                                        (map (lambda (f) (get-vars-Function f variables)) f*)
                                                        (get-vars-Function f variables)
                                                        variables))]
                [else (begin (display "caso Program \n"))]))

(define (get-vars-Main ir variables)
        (nanopass-case (jelly Main) ir
                [(main [,e* ... ,e]) (begin
                                        (map (lambda (e) (get-vars-Expr e variables)) e*)
                                        (get-vars-Expr e variables)
                                        variables)]
                [else (begin 
                        (display "caso Main \n"))]))

(define (get-vars-Function ir variables) 
        (nanopass-case (jelly Function) ir
        [(,i ([,i* ,dt*] ...) ,t ,e) (begin
                                        (map (lambda (id) (get-vars-Expr id variables)) i*)
                                        (map (lambda (dt) (get-vars-Expr dt variables)) dt*)
                                        (get-vars-Expr t variables)
                                        (get-vars-Expr e variables)
                                        variables)]
        [(,i ([,i* ,dt*] ...) ,e) (begin
                                        (map (lambda (id) (get-vars-Expr id variables)) i*)
                                        (map (lambda (dt) (get-vars-Expr dt variables)) dt*)
                                        (get-vars-Expr e variables)
                                        variables)]
                [else (begin 
                        (display "caso Function \n"))]))

(define (get-vars-DeclarationType ir variables) 
        (nanopass-case (jelly DeclarationType) ir
                [,t variables]
                [(arrType ,t) variables]
                [else (begin 
                        (display "caso DeclarationType \n"))]))

(define (get-vars-Expr ir variables) 
        (nanopass-case (jelly Expr) ir
                [,c variables]
                [,dt (begin
                        (get-vars-DeclarationType dt variables)
                        variables)]
                [,pr variables]
                [,i (begin
                        (set-add! variables i)
                        variables)]
                [(arrIndex ,e) (begin
                                        (get-vars-Expr e variables)
                                        variables)]
                [(length ,e) (begin 
                                (get-vars-Expr e variables)
                                variables)]
                [(return ,e) (begin
                                (get-vars-Expr e variables)
                                variables)]
                [(while ,e0 ,e1) (begin
                                        (get-vars-Expr e0 variables)
                                        (get-vars-Expr e1 variables)
                                        variables)]
                [(if-stn ,e0 ,e1) (begin
                                        (get-vars-Expr e0 variables)
                                        (get-vars-Expr e1 variables)
                                        variables)]
                [(if-stn ,e0 ,e1 ,e2) (begin
                                        (get-vars-Expr e0 variables)
                                        (get-vars-Expr e1 variables)
                                        (get-vars-Expr e2 variables)
                                        variables)]
                [(arrElement ,e1 ,e2) (begin
                                        (get-vars-Expr e1 variables)
                                        (get-vars-Expr e2 variables)
                                        variables)]
                [(decl ,i ,dt) (begin
                                        (get-vars-Expr i variables)
                                        (get-vars-Expr dt variables)
                                        variables)]
                [(,e* ...) (begin
                                (map (lambda (e) (get-vars-Expr e variables)) e*)
                                variables)]
                [(,pr ,e0 ,e1) (begin
                                (get-vars-Expr pr variables)
                                (get-vars-Expr e0 variables)
                                (get-vars-Expr e1 variables)
                                variables)]
                [(,i [,e* ...]) (begin
                                (get-vars-Expr i i)
                                (map (lambda (e) (get-vars-Expr e variables)) e*)
                                variables)]
                [else (display "caso Expr \n")]))



(define (get-vars-generic function ir) (
        (let* ([vars (mutable-set)]
                [vars (function ir vars)])
                vars)
))

(define (symbol-table ir) (let*([renamed-ir (rename-var ir)]
                                        [renamed-vars-keys (get-vars renamed-ir)]
                                        [renamed-vars-table (make-hash)])
                                (for ([var renamed-vars-keys])
                                (hash-set! renamed-vars-table var 'undefined))
                                (symbol-table-Program renamed-ir renamed-vars-table)))
(define (symbol-table-Program ir table)
        (nanopass-case (jelly Program) ir
                [(program ,m) (begin
                                (symbol-table-Main m table)
                                table)]
                [(program ,m [,f* ... ,f]) (begin
                                                (symbol-table-Main m table)
                                                (map (lambda (f) (symbol-table-Function f table)) f*)
                                                (symbol-table-Function f table)
                                                table)]
                [else (begin (display "caso Program \n"))]))

(define (symbol-table-Main ir table)
        (nanopass-case (jelly Main) ir
                [(main [,e* ... ,e]) (begin
                                        (map (lambda (e) (symbol-table-Expr e table)) e*)
                                        (symbol-table-Expr e table)
                                        table)]
                [else (begin 
                        (display "caso Main \n"))]))

(define (symbol-table-Function ir table) 
        (nanopass-case (jelly Function) ir
        [(,i ([,i* ,dt*] ...) ,t ,e) (begin
                                        (hash-set! table i (cons t (map declarationType->symbol dt*)))
                                        (map (lambda (id ty) (hash-set! table id (declarationType->symbol ty))) i* dt*)
                                        (symbol-table-Expr t table)
                                        (symbol-table-Expr e table)
                                        table)]
        [(,i ([,i* ,dt*] ...) ,e) (begin
                                        (map (lambda (id ty) (hash-set! table id (declarationType->symbol ty))) i* dt*)
                                        (symbol-table-Expr e table)
                                        table)]
                [else (begin 
                        (display "caso Function \n"))]))

(define (symbol-table-DeclarationType ir table) 
        (nanopass-case (jelly DeclarationType) ir
                [,t table]
                [(arrType ,t) table]
                [else (begin 
                        (display "caso DeclarationType \n"))]))

(define (symbol-table-Expr ir table) 
        (nanopass-case (jelly Expr) ir
                [,c table]
                [,dt (begin
                                (symbol-table-DeclarationType dt table)
                                table)]
                [,pr table]
                [,i table]
                [(arrIndex ,e) (begin
                                (symbol-table-Expr e table)
                                table)]
                [(length ,e) (begin
                                (symbol-table-Expr e table)
                                table)]
                [(return ,e) (begin
                                (symbol-table-Expr e table)
                                table)]
                [(while ,e0 ,e1) (begin
                                (symbol-table-Expr e0 table)
                                (symbol-table-Expr e1 table)
                                table)]
                [(if-stn ,e0 ,e1) (begin
                                (symbol-table-Expr e0 table)
                                (symbol-table-Expr e1 table)
                                table)]
                [(if-stn ,e0 ,e1 ,e2) (begin
                                (symbol-table-Expr e0 table)
                                (symbol-table-Expr e1 table)
                                (symbol-table-Expr e2 table)
                                table)]
                [(arrElement ,e1 ,e2) (begin
                                (symbol-table-Expr e1 table)
                                (symbol-table-Expr e2 table)
                                table)]
                [(decl ,i ,dt) (begin
                                (hash-set! table i (declarationType->symbol dt))
                                table)]
                [(,e* ...) (begin
                                (map (lambda (e) (symbol-table-Expr e table)) e*)
                                table)]
                [(,pr ,e0 ,e1) (begin
                                (symbol-table-Expr pr table)
                                (symbol-table-Expr e0 table)
                                (symbol-table-Expr e1 table)
                                table)]
                [(,i [,e* ...]) (begin
                                (symbol-table-Expr i i)
                                (map (lambda (e) (symbol-table-Expr e table)) e*)
                                table)]
                [else (begin 
                        (display "caso Expr \n"))]))
(define (declarationType->symbol ir)
        (nanopass-case (jelly DeclarationType) ir
                [,t t]
                [(arrType ,t) `(arrType ,t)]
                [else (begin 
                        (display "caso DeclarationType \n"))]))
(define (parse-complete s) (parser-jelly (read (open-input-string (syntax-tree (parsea s))))))
(define (parser-input s) (read (open-input-string (syntax-tree (parsea s)))))

(define input
'(program 
    (main {(= (decl i int) (= zzzz (+ zzzz 1))) (= zzzz (+ zzzz 1)) (= (decl r int) ( gdc (i zzz)))})
    (
        (gdc 
            ((var1 int) (var2 int))
            int
            {(while (!= var1 0) {(if-stn (< var1 var2) {(= var2 (- var2 var1))} {(= var1 (- var1 var2))})}) (return b)})
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
(define input-2
'(program 
    (main {(= (decl i int) (= zzzz (+ zzzz 1))) (= zzzz (+ zzzz 1)) (= (decl r int) ( gdc (i zzz)))})
    ))

(define parsed-input (parser-jelly input))
(define symbol-table-input
        '(program 
        (main {(= (decl var_0 int) (= var_1 (+ var_1 1))) (= var_1 (+ var_1 1)) (= (decl var_2 int) ( gdc (var_0 var_1)))})
        (
                (gdc 
                ((var_3 int) (var_4 int))
                int
                {(while (!= var_3 0) {(if-stn (< var_3 var_4) {(= var_4 (- var_4 var_3))} {(= var_3 (- var_3 var_4))})}) (return var_5)}) 
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