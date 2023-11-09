package fciencias.unam.tdi.demo.entity;

import lombok.*;


import java.util.List;
import java.util.Date;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
// @Entity
public class Inventario{

    private String nombre;
    private String productType;
    private Date adquisicion;
    private Date expiracion;
    private int cantidad;
    private float medida;
    private float precio;
    private String descripcion;
    private List<String> comentarios;
    private String Provedor;

}
