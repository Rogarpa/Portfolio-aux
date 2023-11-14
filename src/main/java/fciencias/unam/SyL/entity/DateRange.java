package fciencias.unam.SyL.entity;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Embeddable
public class DateRange {
	
	@NotNull(message="La fecha de adquisicion es requerida")
    @Column(name="adquisicion")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate adquisicion;
    
	@NotNull(message="La fecha de expiracion es requerida")
    @Column(name="expiracion")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate expiracion;

}
