package fciencias.unam.SyL.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
/**
 * Clase para representar un INVENTARIO de SyL.
 */
@Entity
@Table(name="tipo_producto")
public class TipoProducto{
    
	@Id
	@Column(name = "idTipoProducto", unique=true)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idTipoProducto;
    
	@Column(name="tipo")
	@NotNull(message="El tipo es requerido")
    private String tipo;
}
