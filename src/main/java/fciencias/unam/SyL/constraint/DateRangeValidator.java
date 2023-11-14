package fciencias.unam.SyL.constraint;

import fciencias.unam.SyL.entity.DateRange;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class DateRangeValidator implements ConstraintValidator<DateRangeConstraint, DateRange> {

    @Override
    public void initialize(DateRangeConstraint constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(DateRange dateRange, ConstraintValidatorContext constraintValidatorContext) {

        return dateRange != null
                && dateRange.getAdquisicion() != null 
                && dateRange.getExpiracion() != null
                && dateRange.getExpiracion().isAfter(dateRange.getAdquisicion());
    }
}