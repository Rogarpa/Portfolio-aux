#lang nanopass

(require "parser.rkt")
(provide (all-defined-out))

(define (syntax-tree expr)
  (match expr    
    ; Terminals
    [(num v) (number->string v)]
    [(id nombre) nombre]
    [(struct_const const) (syntax-tree const)]
    [(struct_int_const const) (syntax-tree const)]
    [(struct_bool_const const) (syntax-tree const)]
    [(struct_type type) type]
    [(struct_arraytype type) (string-append "[" (syntax-tree type) "]")]
    [(bool v) (if v "true" "false")]
    
    ; Pogram structure
    [(struct_main_no_functions compound_statement) (string-append "program (main (" 
                                                      (list-syntax-tree compound_statement)
                                                      ")")]

    [(struct_main_functions compound_statement function_list) (string-append "program (main" 
                                                                (list-syntax-tree compound_statement)
                                                                ") ("
                                                                (list-syntax-tree function_list)
                                                                ")")] 
    
    ; [(struct_statement_list single_statement statement_list)
    ;   (if (empty? statement_list)
    ;     (syntax-tree single_statement)
    ;     (string-append (syntax-tree single_statement)  "\n" (syntax-tree statement_list)))]
    ; [(struct_empty_statement) ""]
    
    ; Variables manipulation
    [(struct_var_declaration variable type) (string-append "decl " (syntax-tree variable) " " (syntax-tree type) )]
    [(struct_multi_var_declaration type id_list)
    ;  (if (empty? id_list)
    ;      (string-append (syntax-tree type))
        ; (string-append (syntax-tree type) " " (foldl (lambda (s1 s2) (string-append s2 s1)) "" (map (lambda (id) (syntax-tree id)) id_list)))] 
      ; (foldl
      ;   (lambda (s1 s2) (string-append s2 s1))
      ;   ""
      ;   (map 
      ;     (lambda (id) 
      ;       (string-append 
      ;         "(" 
      ;         (syntax-tree type) 
      ;         " "
      ;         (syntax-tree id)
      ;         ")"))
      ;       id_list))]
        (list-syntax-tree (map 
                            (lambda (id) (struct_var_declaration id type))
                            id_list))]

    [(struct_var_initialization variable type assignment_k value) (string-append
                                                                    "= "
                                                                    "("
                                                                    (syntax-tree (struct_var_declaration variable type))
                                                                    ")"
                                                                    " "
                                                                    (syntax-tree value)
                                                                    )]
    [(struct_arrray_initializer_list body) (list-syntax-tree body)]
    [(struct_initializer_operator operator) (symbol->string operator)]
    [(struct_assignment var assignment_operator assignment) (string-append (syntax-tree assignment_operator) " " (syntax-tree var) " " (syntax-tree assignment))]
    [(struct_assignment_operator operator) (symbol->string operator)]
    [(struct_initializer_operator operator) (symbol->string operator)]
    [(struct_var_expression var) (syntax-tree var)]
    [(struct_array_element var array_index) (syntax-tree var) (syntax-tree array_index)]
    [(struct_array_index e) (string-append "arrIndex " (syntax-tree e))]
    [(struct_incremental_var id postfix_operator)
       (let ([operator (match (syntax-tree postfix_operator)
                        ('-- "-")
                        ('++ "+"))])
          (string-append
            "(= "
            (syntax-tree id)
            "(+ "
            (syntax-tree id)
            " 1"
            ")"))]

    [(struct_ternal conditional if-return else-return) (string-append "if " (syntax-tree conditional) " " (syntax-tree if-return) " " (syntax-tree else-return))]
    [(struct_infix_integer_operator operator) (symbol->string operator)]
    [(struct_postfix_operator operator) operator]
    [(struct_binary_operation operand1 binary_operator operand2)
     (string-append "(" (syntax-tree binary_operator) " "
                    (syntax-tree operand1) " "
                    (syntax-tree operand2)
                    ")" )]
    [(struct_binary_operator operator) (symbol->string operator)]
    [(struct_order_operator operator) operator]    
    
    ; Control Structures
    [(struct_if_simple conditional (cons h t)) (string-append 
                                                "if ("
                                                (syntax-tree conditional) 
                                                ") "
                                                (string-append "{" (foldl string-append "" (map (lambda (st) (syntax-tree st)) (cons h t))) "}"))]
    [(struct_if_simple conditional if-statement) (string-append "if (" (syntax-tree conditional) ") " (string-append "{" (syntax-tree if-statement) "}"))]
    [(struct_if_else conditional if-statement else-statement) (string-append "if (" (syntax-tree conditional) ") " (string-append "{" 
                                                                  (syntax-tree if-statement) "}") 
                                                                  " else " (string-append "{" (syntax-tree else-statement) "}"))]   
    [(struct_if_else conditional (cons h t) else-statement) (string-append "if (" (syntax-tree conditional) ") " (string-append "{" 
                                                                  (foldl string-append "" (map (lambda (st) (syntax-tree st)) (cons h t))) "}") 
                                                                  " else " (string-append "{" (syntax-tree else-statement) "}"))]
    [(struct_if_else conditional if-statement (cons h t)) (string-append "if (" (syntax-tree conditional) ") " (string-append "{" 
                                                                  (syntax-tree if-statement) "}") 
                                                                  " else " (string-append "{" (foldl string-append "" (map (lambda (st) (syntax-tree st)) (cons h t))) "}"))]
    [(struct_if_else conditional (cons h1 t1) (cons h2 t2)) (string-append "if (" (syntax-tree conditional) ") " (string-append "{" 
                                                                  (foldl string-append "" (map (lambda (st) (syntax-tree st)) (cons h1 t1))) "}") 
                                                                  " else " (string-append "{" (foldl string-append "" (map (lambda (st) (syntax-tree st)) (cons h2 t2))) "}"))]
    [(struct_while conditional statement) (string-append "while " (syntax-tree conditional) " " (string-append "{" (foldl string-append "" (map (lambda (st) (syntax-tree st)) statement)) "}"))]
    
    ; Functions 
    [(struct_function_no_return id parameter_list compound_statement) (string-append " " (syntax-tree id) " " (syntax-tree parameter_list) " " (syntax-tree compound_statement))]
    [(cons (struct_id_typer id type) t) (string-append "(" (syntax-tree id) " " (syntax-tree type) ")" (syntax-tree t))]
    [(struct_function_return id parameter_list return_type statement_list return_expression) (string-append " " (syntax-tree id) 
                                                                                                                "("(foldl (lambda (s1 s2) (string-append s2 s1)) "" (map (lambda (p) (syntax-tree p)) parameter_list)) ") " 
                                                                                                                ; (syntax-tree parameter_list) " " 
                                                                                                                (syntax-tree return_type) " {" 
                                                                                                                (foldl (lambda (s1 s2) (string-append s2 s1)) "" (map (lambda (s) (syntax-tree s)) statement_list)) " " 
                                                                                                                 " " (syntax-tree return_expression) "}")]
    [(struct_return_statement statement) (string-append "return " (syntax-tree statement))]
    [(struct_id_typer id type) (string-append "(" (syntax-tree id) " " (syntax-tree type)")")]        
    [(struct_function_call id argument_list) (string-append " " (syntax-tree id) " ("
                                                (foldl (lambda (s1 s2) (string-append s2 s1)) "" (map (lambda (p) (string-append "(" (syntax-tree p) ")")) argument_list)) ")")]
    
    ; Expressions list
    ['() ""]
    ; [(list e) (string-append 
    ;               "("
    ;               (syntax-tree h)
    ;               (syntax-tree t)
    ;               ")")]
    ;               (map 
    ;                 (lambda (exp) 
    ;                   (string-append 
    ;                     "(" 
    ;                     (syntax-tree expr) 
    ;                     ")"))
    ;                 id_list)
    [(cons h t)(list-syntax-tree (cons h t))]
  ))

  (define (list-syntax-tree l)
      (string-append "("
        (foldl
          (lambda (s1 s2)
            (string-append s2 s1))
          ""
          (map 
            (lambda (exp) 
              (string-append 
                "(" 
                (syntax-tree exp)
                ")"))
          l))
        ")"))