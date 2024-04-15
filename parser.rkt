#lang nanopass
(require 
        "lexer.rkt"
          parser-tools/yacc)
(provide (all-defined-out))

(define-struct num (v) #:transparent)
(define-struct id (v) #:transparent)
(define-struct struct_const (const) #:transparent)
(define-struct struct_int_const (const) #:transparent)
(define-struct struct_bool_const (const) #:transparent)
(define-struct struct_type (type) #:transparent)
(define-struct struct_arraytype (type) #:transparent)
(define-struct bool (v) #:transparent)

(define-struct struct_main_no_functions (compound_statement) #:transparent)
(define-struct struct_main_functions (compound_statement function_list) #:transparent)
(define-struct struct_statement_list (single_statement statement_list) #:transparent)
(define-struct struct_empty_statement () #:transparent)
(define-struct struct_var_declaration (variable type) #:transparent)
(define-struct struct_multi_var_declaration (type id_list) #:transparent)
(define-struct struct_var_initialization (variable type assignment_operator value) #:transparent)
(define-struct struct_arrray_initializer_list (body) #:transparent)
(define-struct struct_initializer_operator (operator) #:transparent)
(define-struct struct_assignment_operator (operator) #:transparent)
(define-struct struct_assignment (var assignment_operator assignment) #:transparent)
(define-struct struct_var_expression (var) #:transparent)
(define-struct struct_array_element (var array_index) #:transparent)
(define-struct struct_array_index (e) #:transparent)
(define-struct struct_incremental_var (id postfix_operator) #:transparent)
(define-struct struct_postfix_operator (operator) #:transparent)
(define-struct struct_ternal (conditional if-return else-return) #:transparent)
(define-struct struct_infix_integer_operator (operator) #:transparent)
(define-struct struct_binary_operation (operand1 operator operand2) #:transparent)
(define-struct struct_binary_operator (operator) #:transparent)
(define-struct struct_infix_equality_operator(operator) #:transparent)
(define-struct struct_infix_boolean_operator(operator) #:transparent)
(define-struct struct_order_operator(operator) #:transparent)
(define-struct struct_if_simple (conditional if-statement) #:transparent)
(define-struct struct_if_else (conditional if-statement else-statemten) #:transparent)
(define-struct struct_while (conditional statement) #:transparent)
(define-struct struct_function_no_return (id parameter_list compound_statement) #:transparent)
(define-struct struct_function_return (id parameter_list return_type statement_list return_expression) #:transparent)
(define-struct struct_return_statement (statement) #:transparent)
(define-struct struct_id_typer(id type) #:transparent)
(define-struct struct_function_call(id argument_list) #:transparent)

(define jelly-parser
    (parser
        [start s]
        [end EOF]
        [tokens contenedores vacios]
        
        [error (lambda (tok-ok? tok-name tok-value)
           (raise-syntax-error 'jelly_parser_error
                               "Not possible to process token"
                               (if tok-value (list 'Token-value: tok-value) (list 'Token-name: tok-name ))))]

        [precs 
            (nonassoc LEFTPARENTHESIS RIGTHPARENTHESIS LEFTCURLYBRACKET RIGHTCURLYBRACKET LEFTBRACKET RIGTHBRACKET)
            (nonassoc QUESTIONMARK COLON)
            (left PIPE)
            (left AMPERSAND)
            (left COMPARATION NOTEQUAL)
            (left LESSEQUALTHAN GREATEREQUALTHAN LESSTHAN GREATERTHAN)
            (left ADD MINUS)
            (left ASTERISK SLASH PERCENTAGE)
            (nonassoc QUOTATIONMARK)
        ]
        [grammar
            [s
                [(MAIN compound_statement) (struct_main_no_functions $2)]
                [(MAIN compound_statement function_list) (struct_main_functions $2 $3)]]
            [function_list
                [(function)(list $1)]
                [(function function_list)(list $1 $2)]]
            [statement
                [(single_statement) $1]
                [(compound_statement) $1]]
            [single_statement
                [(function_call) $1]
                [(var_initialization) $1]
                [(var_declaration) $1]
                [(if-statement) $1]
                [(while-statement) $1]
                [(function) $1]
                [(assignment) $1]]
            [compound_statement
                [(LEFTCURLYBRACKET statement_list RIGHTCURLYBRACKET) $2]]
            [statement_list
                [(single_statement) (list $1)]
                [(single_statement statement_list) (list $1 $2)]]
            [id 
                [(ID) (id $1)]]
            [const
                [(int_const) (struct_const $1)]
                [(bool_const) (struct_const $1)]]
            [int_const
                [(NUM) (struct_int_const (num $1))]]
            [bool_const
                [(BOOL) (struct_bool_const(bool $1))]]
            [type 
                [(primitive_type) $1]
                [(arraytype) $1]]
            [primitive_type
                [(INTEGER-TYPE) (struct_type "int")]
                [(BOOL-TYPE) (struct_type "bool")]]
            [arraytype 
                [(primitive_type LEFTBRACKET RIGTHBRACKET) (struct_arraytype $1)]]
            [var_declaration
                [(id COLON type) (struct_var_declaration $1 $3)]
                [(type id_list) (struct_multi_var_declaration $1 $2)]]
            [id_list
                [(id) (list $1)]
                [(id COMMA id_list) (list $1 $3)]]
            [var_initialization
                [(id COLON primitive_type assignment_operator expression) (struct_var_initialization $1 $3 $4 $5)]
                [(id COLON arraytype assignment_operator array_initializer) (struct_var_initialization $1 $3 $4 $5)]]
            [array_initializer
                [(id) $1]
                [(array_initializer_list) $1]]
            [array_initializer_list
                [(LEFTCURLYBRACKET const_list RIGHTCURLYBRACKET) (struct_arrray_initializer_list $2)]]
            [const_list
                [(const) (list $1)]
                [(const COMMA const_list) (list $1 $3)]]
            [initializer_operator
                [(EQUAL) (struct_initializer_operator '=)]]
            [assignment_operator
                [(initializer_operator) $1]
                [(AUTOINCREMENT) (struct_assignment_operator '+=)]
                [(AUTODECREMENT) (struct_assignment_operator '-+)]]
            [assignment 
                [(var_expression assignment_operator expression) (struct_assignment $1 $2 $3)]
                [(incremental_var) $1]]
            [var_expression 
                [(id) $1]
                [(id array_index) (struct_array_element $1 $2)]
                [(incremental_var) (struct_var_expression $1)]]
            [array_index 
                [(LEFTBRACKET expression RIGTHBRACKET) (struct_array_index $2)]]
            [incremental_var
                [(id postfix_operator) (struct_incremental_var $1 $2)]]
            [postfix_operator 
                [(INCREMENT) (struct_postfix_operator '++)]
                [(DECREMENT) (struct_postfix_operator '--)]]
            [parentised_expression
                [(LEFTPARENTHESIS expression RIGTHPARENTHESIS) $2]]
            [expression
                [(const) $1]
                [(var_expression) $1]
                [(function_call) $1]
                [(expression QUESTIONMARK expression COLON expression) (struct_ternal $1 $3 $5)]
                [(length_expression) $1]
                [(expression ADD expression) (struct_binary_operation $1 (struct_binary_operator '+) $3)]
                [(expression MINUS expression) (struct_binary_operation $1 (struct_binary_operator '-) $3)]
                [(expression ASTERISK expression) (struct_binary_operation $1 (struct_binary_operator '*) $3)]
                [(expression SLASH expression) (struct_binary_operation $1 (struct_binary_operator '/) $3)]
                [(expression PERCENTAGE expression) (struct_binary_operation $1 (struct_binary_operator '%) $3)]
                [(expression COMPARATION expression) (struct_binary_operation $1 (struct_binary_operator '?) $3)]
                [(expression NOTEQUAL expression) (struct_binary_operation $1 (struct_binary_operator '!=) $3)]
                [(expression PIPE expression) (struct_binary_operation $1 (struct_binary_operator 'pipe) $3)]
                [(expression AMPERSAND expression) (struct_binary_operation $1 (struct_binary_operator '&&) $3)]
                [(expression LESSTHAN expression) (struct_binary_operation $1 (struct_binary_operator '<) $3)]
                [(expression GREATERTHAN expression) (struct_binary_operation $1 (struct_binary_operator '>) $3)]
                [(expression LESSEQUALTHAN expression) (struct_binary_operation $1 (struct_binary_operator '<=) $3)]
                [(expression GREATEREQUALTHAN expression) (struct_binary_operation $1 (struct_binary_operator '>=) $3)]
                [(LEFTPARENTHESIS expression RIGTHPARENTHESIS) $2]]
            [length_expression
                [(LENGTH LEFTPARENTHESIS expression RIGTHPARENTHESIS) (struct_function_call (id "length") (list $3))]]
            [integer_expression
                [(int_const) $1]]
            [bool_expression
                [(bool_const) $1]]
            [if-statement 
                [(IF expression statement) (struct_if_simple $2 $3)]
                [(IF expression statement
                    ELSE statement) (struct_if_else $2 $3 $5)]]
            [while-statement 
                [(WHILE expression statement) (struct_while $2 $3)]]
            [function
                [(id LEFTPARENTHESIS parameter_list RIGTHPARENTHESIS
                    COLON type LEFTCURLYBRACKET return_statement RIGHTCURLYBRACKET) (struct_function_return $1 $3 $6 (struct_empty_statement) $8)]
                [(id LEFTPARENTHESIS parameter_list RIGTHPARENTHESIS compound_statement) (struct_function_no_return $1 $3 $5)]
                [(id LEFTPARENTHESIS parameter_list RIGTHPARENTHESIS
                    COLON type LEFTCURLYBRACKET statement_list return_statement RIGHTCURLYBRACKET) (struct_function_return $1 $3 $6 $8 $9)]]
            [return_statement
                [(RETURN expression) (struct_return_statement $2)]]
            [parameter_list
                [(id_typer) (list $1)]
                [(id_typer COMMA parameter_list) (list $1 $3)]]
            [id_typer
                [(id COLON type) (struct_id_typer $1 $3)]]
            [function_call
                [(id LEFTPARENTHESIS argument_list RIGTHPARENTHESIS) (struct_function_call $1 $3)]]
            [argument_list
                [(expression) (list $1)]
                [(expression COMMA argument_list) (list $1 $3)]]]))
        



(define (lex-this lexer input) (lambda () (lexer input)))

(define (parsea in)
        (let ([in-s (open-input-string in)])
        (jelly-parser (lex-this jelly-lexer in-s))))

(define a 
"
//Comentario 1

main{
    i:int = zzzz++
    zzzz += 1
    r:int = gdc(i,zzz)
}

{- Comentario 2
   Comentario 2 -}


gdc(var1:int, var2:int): int{
    while var1 != 0 {
        if (var1 < var2) var2 = var2 - var1
        else var1 = var1 - var2
    }
    return b
}

sort(a:int []){
    i:int = 0
    n:int = length(a)

    while i < n {
        j:int = i
        while j > 0 {
            if a[j-1] > a [j] {
                swap:int = a[j]
                a[j] = a[j-1]
                a[j-1] = swap
            }
            j--
        }
        i++
    }
}
"
)
(define b
"
//Comentario 1

main{
    int a, b, c
}

"
)