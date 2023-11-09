package fciencias.unam.tdi.demo.entity;

import lombok.*;

@Data
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
// @Entity
public class Usuario{

    private int idUsuario;
    private String nombre;
    private String apellidoMaterno;
    private String apellidoPaterno;
    private int telefono;
    private String correo;
    private String contrasena;
    
}
