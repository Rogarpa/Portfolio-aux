#lang nanopass

(require "symbol-table.rkt")


; Receive a expression of jelly language and returns a dictionary with his variables and his types, undefined if has no type
; Receive a expression of jelly language and returns a dictionary with his variables and his types, undefined if has no type
(define (get-type ir) (let*([symbol-table (symbol-table ir)])
                            (get-type-Program ir symbol-table)))
(define (get-type-Program ir table)
        (nanopass-case (jelly Program) ir
                [(program ,m) (begin
                                (get-type-Main m table)
                                'unit)]
                [(program ,m [,f* ... ,f]) (begin
                                                (get-type-Main m table)
                                                (map (lambda (f) (get-type-Function f table)) f*)
                                                (get-type-Function f table)
                                                'unit)]
                [else (begin (display "caso Program \n"))]))

(define (get-type-Main ir table)
        (nanopass-case (jelly Main) ir
                [(main [,e* ... ,e]) (begin
                                        (map (lambda (e) (get-type-Expr e table)) e*)
                                        (get-type-Expr e table)
                                        'unit)]
                [else (begin 
                        (display "caso Main \n")
                        'unit)]))

(define (get-type-Function ir table) 
        (nanopass-case (jelly Function) ir
        [(,i ([,i* ,dt*] ...) ,t ,e) (begin
                                        (get-type-Expr e table)
                                        'unit)]
        [(,i ([,i* ,dt*] ...) ,e) (begin
                                        (get-type-Expr e table)
                                        'unit)]
                [else (begin 
                        (display "caso Function \n"))
                        'unit]))

(define (get-type-DeclarationType ir table) 
        (nanopass-case (jelly DeclarationType) ir
                [,t t]
                [(arrType ,t) `(arrType ,t)]
                [else (begin 
                        (display "caso DeclarationType \n"))
                        'unit]))

(define (get-type-Expr ir table) 
        (nanopass-case (jelly Expr) ir
                [,c (cond 
                        [(integer? c) 'int]
                        [(boolean? c) 'bool]
                        [else (error "Do not exist type for this constant" c)])]
                [,dt (begin
                            (get-type-DeclarationType dt table))]
                [,pr 'unit]
                [,i (let ([id-type (hash-ref table i)])
                        (if (eq? id-type 'undefined)
                            (error "Id type declaration missing" i)
                            id-type))]
                [(arrIndex ,e) (begin
                                (get-type-Expr e table))]
                
                [(length ,e) (begin
                                (if (arrayType? (get-type-Expr e table))
                                    'int
                                    (error "Do not exist type for length of this array" (get-type-Expr e table))))]

                [(return ,e) (begin
                                (get-type-Expr e table))]
                [(while ,e0 ,e1) (begin
                                    (if (and (eq? (get-type-Expr e0 table) 'bool)
                                            ; (eq? (get-type-Expr e1 table) 'unit))
                                            (get-type-Expr e1 table))
                                        'unit
                                        (error "While type structure incorrect")))]
                [(if-stn ,e0 ,e1) (begin
                                    (if (and (eq? (get-type-Expr e0 table) 'bool)
                                            ; (eq? (get-type-Expr e1 table) 'unit))
                                            (get-type-Expr e1 table))
                                        'unit
                                        (error "If type structure incorrect")))]
                [(if-stn ,e0 ,e1 ,e2) (begin
                                        (if (and (eq? (get-type-Expr e0 table) 'bool)
                                                ; (eq? (get-type-Expr e1 table) 'unit)
                                                (get-type-Expr e1 table)
                                                ; (eq? (get-type-Expr e2 table) 'unit))
                                                (get-type-Expr e2 table))
                                            'unit
                                            (error "If-Else type structure incorrect")))]
                
                
                
                
                [(arrElement ,e1 ,e2) (begin
                                        (let ([e1-type (get-type-Expr e1 table)])
                                            (if (and 
                                                (arrayType? e1-type)
                                                (eq? (get-type-Expr e2 table) 'int))
                                                (car (cdr e1-type))
                                                (error "Do not exist type for arrElement" e2 "of" e1))))]
                [(decl ,i ,dt) (get-type-Expr dt table)]
                
                [(,pr ,e0 ,e1) (let*
                                ([e0-type (get-type-Expr e0 table)]
                                [e1-type (get-type-Expr e1 table)])
                                (cond 
                                    [(memq pr '(+ - * / %)) (if (and (eq? e0-type 'int) (eq? e1-type 'int))
                                                                    'int
                                                                    (error "Do not exist type for arithmetic operation of non integer expressions" e0 e1))]
                                    [(memq pr '(== != < > <= >= )) (if (and (eq? e0-type 'int) (eq? e1-type 'int))
                                                                    'bool
                                                                    (error "Do not exist type for comparation operation of non integer expressions" e0-type e1-type))]
                                    [(memq pr '(== != && pipe)) (if (and (eq? e0-type 'bool) (eq? e1-type 'bool))
                                                                    'bool
                                                                    (error "Do not exist type for boolean operation of non boolean expressions" e0 e1))]
                                    [(memq pr '(=)) (cond 
                                                        [(eq? e0-type e1-type) e0-type]
                                                        [else (error "Do not exist type for assignation of distinct types" e0 e0-type e1 e1-type)])]))]
                [(,i [,e* ...]) (let* ([args-types (map (lambda (e) (get-type-Expr e table)) e*)]
                                        [function-type (get-type-Expr i table)]
                                        [pars-types (if (eq? function-type 'undefined) 'noargs (function-pars function-type))]
                                        [return-type (if (eq? function-type 'undefined) 'unit (function-return-type function-type))]
                                        [args-types (map (lambda (e) (get-type-Expr e table)) e*)])
                                    (if (equal? pars-types args-types)
                                        return-type
                                        (error "Function call" i "has wrong arguments types" args-types pars-types)))]
                [(,e* ...) (begin
                                (map (lambda (e) (get-type-Expr e table)) e*)
                                (if (= (length e*) 1) (get-type-Expr (car e*) table)
                                'unit))]
                [else (begin 
                        (display "caso Expr \n")
                        (display ir)
                        'unit)]))

(define (arrayType? type)
    (match type
        [(list arrayType t) (and (eq? arrayType 'arrType) (not (eq? (type? t) '())))]
        [else false]))

(define (function-pars f-type) 
    (cdr f-type))

(define (function-return-type f-type) 
    (car f-type))

; Modification of original input for all excersises due to missing declaration of variables used in other variables assignation
(define input-get (parser-jelly
    '(program 
    (main {(decl zzzz int) (decl zzz int) (= (decl i int) (= zzzz (+ zzzz 1))) (= zzzz (+ zzzz 1)) (= (decl r int) ( gdc (i zzz)))})
    (
        (gdc 
            ((var1 int) (var2 int))
            int
            {(while (!= var1 0) {(if-stn (< var1 var2) {(= var2 (- var2 var1))} {(= var1 (- var1 var2))})}) (return b)})
        (sort 
            ((a (arrType int)))
            (
                (decl var_5 int)
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
)))

; Input used for test type-checking 
; (define input-get-type (rename-var input-get))
(define input-get-type-fixed (parser-jelly
    '(program
        (main
            ((decl var_8 int)
            (decl var_9 int)
            (= (decl var_11 int) (= var_8 (+ var_8 (1))))
            (= var_8 (+ var_8 (1)))
            (= (decl var_10 int) (gdc (var_11 var_9)))))
        ((gdc
            ((var_7 int) (var_6 int))
            int
            ((decl var_5 int)
            (while
            (!= var_7 (0))
            ((if-stn (< var_7 var_6) ((= var_6 (- var_6 var_7))))))
            (return var_5)))
        (sort
            ((var_4 (arrType int)))
            ((= (decl var_3 int) (0))
                (= (decl var_2 int) (length (var_4)))
                (while
                    (< var_3 var_2)
                    ((= (decl var_0 int) var_3)
                        (while
                        (> var_0 (0))
                        ((if-stn
            (>
                (arrElement var_4 (arrIndex (- var_0 (1))))
                (arrElement var_4 (arrIndex var_0)))
            ((= (decl var_1 int) (arrElement var_4 (arrIndex var_0)))
                (=
                (arrElement var_4 (arrIndex var_0))
                (arrElement var_4 (arrIndex (- var_0 (1)))))
                (= (arrElement var_4 (arrIndex (- var_0 (1)))) var_1)))
                (= var_0 (+ var_0 (1)))))
                (= var_3 (+ var_3 (1))))))))))
)

; Symbol table for type-checking of input-get-type variable
(define input-get-type-symbol-table
(make-hash
        '((gdc . (int int int))
       (var_0 . int)
       (var_1 . int)
       (var_10 . int)
       (var_11 . int)
       (var_12 . undefined)
       (var_2 . int)
       (var_3 . int)
       (var_4 . (arrType int))
       (var_5 . int)
       (var_6 . int)
       (var_7 . int)
       (var_8 . int)
       (var_9 . int))))