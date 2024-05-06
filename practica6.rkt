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
                                                ; (map (lambda (f) (get-type-Function f table)) f*)
                                                ; (get-type-Function f table)
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
                                        ; (hash-set! table i (cons t (map declarationType->symbol dt*)))
                                        ; (map (lambda (id ty) (hash-set! table id (declarationType->symbol ty))) i* dt*)
                                        ; (get-type-Expr t table)
                                        (get-type-Expr e table)
                                        'unit)]
        ; [(,i ([,i* ,dt*] ...) ,e) (begin
        ;                                 ; (map (lambda (id ty) (hash-set! table id (declarationType->symbol ty))) i* dt*)
        ;                                 (display (get-type-Expr e table))
        ;                                 'unit)]
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
                [,i (hash-ref table i)]
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
                                                (cdr e1-type)
                                                (error "Do not exist type for arrElement" e2 "of" e1))))]
                [(decl ,i ,dt) (hash-ref table i)]
                
                [(,pr ,e0 ,e1) (let*
                                ([e0-type (get-type-Expr e0 table)]
                                [e1-type (get-type-Expr e1 table)])
                                (cond 
                                    [(memq pr '(+ - * / %)) (if (and (eq? e0-type 'int) (eq? e1-type 'int))
                                                                    'int
                                                                    (error "Do not exist type for arithmetic operation of non integer expressions"))]
                                    [(memq pr '(== != < > <= >= )) (if (and (eq? e0-type 'int) (eq? e1-type 'int))
                                                                    'bool
                                                                    (error "Do not exist type for comparation operation of non integer expressions"))]
                                    [(memq pr '(== != && pipe)) (if (and (eq? e0-type 'bool) (eq? e1-type 'bool))
                                                                    'bool
                                                                    (error "Do not exist type for boolean operation of non boolean expressions"))]
                                    [(memq pr '(=)) (cond 
                                                        [(eq? e0-type e1-type) e0-type]
                                                        [else (error "Do not exist type for assignation of distinct types")])]))]
                ; [(,i [,e* ...]) (begin
                ;                 (get-type-Expr i i)
                ;                 (map (lambda (e) (get-type-Expr e table)) e*)
                ;                 table)]
                
                ;                 ([types-list (map (lambda (e) (get-type-Expr e table)) e*)]
                ;                 [is-same-type-list (foldr eq? (car types-list) (cdr types-list))])
                ;                 (if is-same-type-list
                ;                     (car types-list)
                ;                     (error "Do not exist type for a heterogeneus list")))]
                [(,e* ...) (begin
                                (map (lambda (e) (get-type-Expr e table)) e*)
                                'unit)]
                [else (begin 
                        (display "caso Expr \n")
                        (display ir)
                        'unit)]))

(define (arrayType? type)
    (match type
        [(list arrayType t) (and (eq? arrayType 'arrType) (not (eq? (type? t) '())))]
        [else false]))
(define input-get-type (parser-jelly
    '(program
        (main
            ((= (decl var_11 int) (= var_8 (+ var_8 (1))))
            (= var_8 (+ var_8 (1)))
            (= (decl var_10 int) (var_9 (var_11 var_12)))))
        ((gdc
            ((var_7 int) (var_6 int))
            int
            ((while
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
                (= var_3 (+ var_3 (1)))))))))))

(define input-get-type2 (parser-jelly
    '(program
        (main
                    (   (arrElement var_4 #t)
                    )))))

(define input-get-type2-table
    (make-hash '((var_0 . int)
        (var_1 . undefined)
        (var_2 . int)
        (var_3 . undefined)
        (var_4 . (arrType int)))))