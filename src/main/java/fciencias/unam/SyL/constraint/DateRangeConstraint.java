package fciencias.unam.SyL.constraint;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

@Documented
@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = DateRangeValidator.class)
public @interface DateRangeConstraint {

    String message() default "La fecha de caducidad debe ser posterior a la fecha de adquisicion";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}