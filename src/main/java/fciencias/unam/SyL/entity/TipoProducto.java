package fciencias.unam.tdi.demo.entity;

import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
// @Entity
public class TipoProducto{
    
    private int idTipoProducto;
    private String tipo;
    private String medida;
    
}
