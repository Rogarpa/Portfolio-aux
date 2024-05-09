# Practice 6
- Rodrigo Garcia Padilla 420003894

The practice consist of function:
type-check

And variables:
- __input-get__
- __input-type-check__
- __input-type-check-symbol-table__

This due that we cannot get a program renamed and its symbol table at the same time due to count variable provoking non pure functions, I prefered to fix the excercise input with the program thath have been used for testing all the practices with the following modifications:

- Definition of variables used and never declarated.
- Adding of array example of the shape (= (decl array (arrType int)) (1 2 3 4))

So, a succesfull type checking is run with:

```bash
(enter! "practica6.rkt")
```

```bash
(type-check input-type-check input-type-check-symbol-table)
```

## __Observations__:

- As we throw an error when occurs a type error in a subexpression of the program, we only call check-type recursive for subexpressions if needed (e* for example with map), and return 'unit at the end. So if an error occurs 'unit is never returned, and if none error interrupted the program flow, 'unit return value confirms it.