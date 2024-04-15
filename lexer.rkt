#lang nanopass
;; Equipo The Synters:
;;   Rodrigo García Padilla 420003894
;;   Gabriel Orta Zarco     314214395
;;   Ricardo Moreno Jaimes  314072027
;;   Andrea Rojas Fuentes   317243705 
        
(require parser-tools/lex
         (prefix-in : parser-tools/lex-sre))

(provide (all-defined-out))

(define-tokens contenedores (ID NUM BOOL))
(define-empty-tokens vacios (INTEGER-TYPE BOOL-TYPE IF ELSE WHILE RETURN LENGTH MAIN EOF AUTOINCREMENT AUTODECREMENT DECREMENT INCREMENT COMPARATION NOTEQUAL LESSEQUALTHAN LESSTHAN GREATEREQUALTHAN GREATERTHAN AMPERSAND PIPE QUOTATIONMARK QUESTIONMARK EQUAL ADD MINUS ASTERISK SLASH PERCENTAGE LEFTPARENTHESIS RIGTHPARENTHESIS LEFTCURLYBRACKET RIGHTCURLYBRACKET LEFTBRACKET RIGTHBRACKET COMMA COLON))

(define (lex s) (lex-file (open-input-file s)))

(define (lex-file file-stream) 
  (let ([next (jelly-lexer file-stream)])
   (if (equal? next 'eof) 
      '() 
      (cons next (lex-file file-stream)))))

(define jelly-lexer
  (lexer
    ; Expresión regular de comentarios
    [whitespace (jelly-lexer input-port)]
    ; (complement (:: any-string "\n"))
    [(:: (:: #\/) (:: #\/) (complement (:: any-string "\n" any-string)) #\newline) (jelly-lexer input-port)]
    [(:: "{-" (complement (:: any-string "-}" any-string)) "-}") (jelly-lexer input-port)]
    ["int"  (token-INTEGER-TYPE)]
    ["bool" (token-BOOL-TYPE)]
    ["True" (token-BOOL lexeme)]
    ["False" (token-BOOL lexeme)]
    ["if" (token-IF)]
    ["else" (token-ELSE)]
    ["while" (token-WHILE)]
    ["return" (token-RETURN)]
    ["length" (token-LENGTH)]
    ["main" (token-MAIN)]
    ["+=" (token-AUTOINCREMENT)]
    ["-=" (token-AUTODECREMENT)]
    ["--" (token-DECREMENT)]
    ["++" (token-INCREMENT)]
    ["==" (token-COMPARATION)]
    ["!=" (token-NOTEQUAL)]
    ["<=" (token-LESSEQUALTHAN)]
    ["<" (token-LESSTHAN)]
    [">=" (token-GREATEREQUALTHAN)]
    [">" (token-GREATERTHAN)]
    ["&" (token-AMPERSAND)]
    ["|" (token-PIPE)]
    ["!" (token-QUOTATIONMARK)]
    ["?" (token-QUESTIONMARK)]
    ["=" (token-EQUAL)]
    ["+" (token-ADD)]
    ["-" (token-MINUS)]
    ["*" (token-ASTERISK)]
    ["/" (token-SLASH)]
    ["%" (token-PERCENTAGE)]
    ["(" (token-LEFTPARENTHESIS)]
    [")" (token-RIGTHPARENTHESIS)]
    ["{" (token-LEFTCURLYBRACKET)]
    ["}" (token-RIGHTCURLYBRACKET)]
    ["[" (token-LEFTBRACKET)]
    ["]" (token-RIGTHBRACKET)]
    ["," (token-COMMA)]
    [":" (token-COLON)]
    [(:: (:+ numeric)) (token-NUM (string->number lexeme))]
    [(:: lower-case (:* (:or lower-case upper-case numeric (:: #\_ )))) (token-ID lexeme)]
    [(eof) (token-EOF)]
    [any-char (error "Token no reconocido:" lexeme)]))







