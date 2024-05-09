#lang nanopass

(require "symbol-table.rkt")


; Receive a expression of jelly language and returns if types system is consistent inside it.
(define (type-check ir table) (type-check-Program ir table))

(define (type-check-Program ir table)
        (nanopass-case (jelly Program) ir
                [(program ,m) (begin
                                (type-check-Main m table)
                                'unit)]
                [(program ,m [,f* ... ,f]) (begin
                                                (type-check-Main m table)
                                                (map (lambda (f) (type-check-Function f table)) f*)
                                                (type-check-Function f table)
                                                'unit)]
                [else (begin (display "caso Program \n"))]))

(define (type-check-Main ir table)
        (nanopass-case (jelly Main) ir
                [(main [,e* ... ,e]) (begin
                                        (map (lambda (e) (type-check-Expr e table)) e*)
                                        (type-check-Expr e table)
                                        'unit)]
                [else (begin 
                        (display "caso Main \n")
                        'unit)]))

(define (type-check-Function ir table) 
        (nanopass-case (jelly Function) ir
        [(,i ([,i* ,dt*] ...) ,t ,e) (begin
                                        (type-check-Expr e table)
                                        'unit)]
        [(,i ([,i* ,dt*] ...) ,e) (begin
                                        (type-check-Expr e table)
                                        'unit)]
                [else (begin 
                        (display "caso Function \n"))
                        'unit]))

(define (type-check-DeclarationType ir table) 
        (nanopass-case (jelly DeclarationType) ir
                ; Primitive type
                [,t t]
                ; Array type
                [(arrType ,t) `(arrType ,t)]
                [else (begin 
                        (display "caso DeclarationType \n"))
                        'unit]))

(define (type-check-Expr ir table) 
        (nanopass-case (jelly Expr) ir
                [,c (cond 
                        [(integer? c) 'int]
                        [(boolean? c) 'bool]
                        [else (error "Do not exist type for this constant" c)])]
                ; Declaration type
                [,dt (begin
                            (type-check-DeclarationType dt table))]
                [,pr 'unit]
                [,i (let ([id-type (hash-ref table i)])
                        (if (eq? id-type 'undefined)
                            (error "Id type declaration missing" i)
                            id-type))]
                [(arrIndex ,e) (begin
                                (type-check-Expr e table))]
                
                [(length ,e) (begin
                                (if (arrayType? (type-check-Expr e table))
                                    'int
                                    (error "Do not exist type for length of this array" (type-check-Expr e table))))]

                [(return ,e) (begin
                                (type-check-Expr e table))]
                [(while ,e0 ,e1) (begin
                                    (if (and (eq? (type-check-Expr e0 table) 'bool)
                                            (type-check-Expr e1 table))
                                        'unit
                                        (error "While type structure incorrect")))]
                [(if-stn ,e0 ,e1) (begin
                                    (if (and (eq? (type-check-Expr e0 table) 'bool)
                                            (type-check-Expr e1 table))
                                        'unit
                                        (error "If type structure incorrect")))]
                [(if-stn ,e0 ,e1 ,e2) (begin
                                        (if (and (eq? (type-check-Expr e0 table) 'bool)
                                                (type-check-Expr e1 table)
                                                (type-check-Expr e2 table))
                                            'unit
                                            (error "If-Else type structure incorrect")))]
                ; Accesing to an element of an array of the shape (array[<number>])
                [(arrElement ,e1 ,e2) (begin
                                        (let ([e1-type (type-check-Expr e1 table)])
                                            (if (and 
                                                (arrayType? e1-type)
                                                (eq? (type-check-Expr e2 table) 'int))
                                                (car (cdr e1-type))
                                                (error "Do not exist type for arrElement" e2 "of" e1))))]
                [(decl ,i ,dt) (type-check-Expr dt table)]
                
                [(,pr ,e0 ,e1) (let*
                                ([e0-type (type-check-Expr e0 table)]
                                [e1-type (type-check-Expr e1 table)])
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
                                                        [(equal? e0-type e1-type) e0-type]
                                                        [else (error "Do not exist type for assignation of distinct types" e0 e0-type e1 e1-type)])]))]
                ; Function call case
                [(,i [,e* ...]) (let* ([args-types (map (lambda (e) (type-check-Expr e table)) e*)]
                                        [function-type (type-check-Expr i table)]
                                        [pars-types (if (eq? function-type 'undefined) 'noargs (function-pars function-type))]
                                        [return-type (if (eq? function-type 'undefined) 'unit (function-return-type function-type))]
                                        [args-types (map (lambda (e) (type-check-Expr e table)) e*)])
                                    (if (equal? pars-types args-types)
                                        return-type
                                        (error "Function call" i "has wrong arguments types" args-types pars-types)))]
                [(,e* ...) (let*
                                ([expressions-types-list (map (lambda (e) (type-check-Expr e table)) e*)]
                                    [same-type? (foldl (lambda (t1 t2) (if (eq? t1 t2) t1 #f)) (car expressions-types-list) expressions-types-list)])
                                ; If all the expressions are of the same type return arrType <type> to enable typechecking of array initialization of the shape 
                                ; (= (decl a (arrType int)) {1,2,3})
                                (if (= (length e*) 1) (type-check-Expr (car e*) table) (if same-type? `(arrType ,(car expressions-types-list)) 'unit)))]
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

; Input used for test type-checking (input-get variable after renaming)
(define input-type-check (parser-jelly
    '(program
        (main
            ((decl var_8 int)
            (decl var_9 int)
            (= (decl var_4 (arrType int)) (1 2))
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

; Symbol table for type-checking of input-type-check program
(define input-type-check-symbol-table
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